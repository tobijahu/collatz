# include main functions
if(!exists("CollatzIterationSteps", mode="function")) source("basic-functions.R")


# The purpose of the functions on this page is to create a
# data.frame with data that might be of interest to the reader
# 

# Here are some thoughts on the topic:
# Fast neighbours. Is there a similar (lower)-limit to odd numbers? Yes, there is. 2**x=3n+1 with natural number x, which is equivalent to n=(2**x-1)/3, defines all those fastest of the odd numbers.
#todo


# What about odd numbers? Patterns may be explained a little bit, since there is a class of numbers that allways takes exactly one step more than others. Those are x=(n-1)/3. 

# Is there a relation between the number of factors and the number of steps that the algorithm requires?
#todo


# create data set

## factorize the numbers to which the iteration process is applied
factorize <- function(n){
	residual <- n
	result <- NULL
	for(i in c(2:n)){
		while(residual %% i == 0){
			residual <- residual / i
			result <- c(result,i)
		if(residual==1)
			return(result)
		}
	}
}

## This function factorizes the input numbers given as a vector and returns a vector of the number of factors
NumberOfFactors <- function(numbers){
	result <- NULL
	for(i in numbers){
		factors <- factorize(i)
		result <- c(result,length(factors))
	}
	return(result)
}

## This function factorizes the input numbers as NumberOfFactors does, but omits the factor 2. This removes the steps that are done fast. The latter is mostly a characteristic of the algorithm itself.
NumberOfFactorsNe2 <- function(numbers){
	result <- NULL
	for(i in numbers){
		factors <- factorize(i)
		result <- c(result,length(factors[factors!=2]))
	}
	return(result)
}

NewData <- function(lower.bound.number, upper.bound.number){
	range <- c(lower.bound.number:upper.bound.number)
	all.steps <- CollatzIterationSteps(c(upper.bound.number:lower.bound.number))[range]
#	factors <- NumberOfFactors(c(lower.bound.number:length(all.steps)))
	factors <- NumberOfFactors(range)
#	factorsNe2 <- NumberOfFactorsNe2(c(lower.bound.number:length(all.steps)))
	factorsNe2 <- NumberOfFactorsNe2(range)
	diffFactors <- abs(factors - factorsNe2)
	## number, nsteps, ratio, factors.ne.2
#	data <- data.frame(c(lower.bound.number:upper.bound.number),
	data <- data.frame(
				range,
				all.steps,
#				all.steps/c(lower.bound.number:length(all.steps)),
				all.steps/range,
#				factors/c(lower.bound.number:length(all.steps)),
				factors/range,
#				factorsNe2/c(lower.bound.number:length(all.steps)),
				factorsNe2/range,
#				diffFactors/c(lower.bound.number:length(all.steps)),
				diffFactors/range,
#				(all.steps - diffFactors)/c(lower.bound.number:length(all.steps)))
				(all.steps - diffFactors)/range )
	names(data) <- c("number","nsteps","ratio","factors","factorsNe2","diffFactors","cleanSteps")
	row.names(data) <- range
	return(data)
}

# Create a data set that provides possible relations between numbers
NewDataSet <- function(upper.bound.number){
	current.data.base <- GetDataFromCSV()
	nrows.current.data.base <- nrow(current.data.base)
	
	if(is.null(upper.bound.number) || is.na(upper.bound.number) || upper.bound.number < 1)
		return(NULL)
	
	if(is.null(current.data.base) || (nrows.current.data.base<=1))
		return(NewData(1, upper.bound.number))
	
	print(current.data.base)
	data <- rbind(current.data.base, NewData(nrows.current.data.base+1, upper.bound.number), deparse.level=1, make.row.names=TRUE, stringsAsFactors=default.stringsAsFactors())
	SaveNewNumbers(data)
	return(data)
}
# Example:
#dataSet <- NewDataSet(given.number)

# Outlook on further processing:
# * plot the whole data set against each column using plot(dataSet)
# * calculate covarianz or corelation of the data
# * check on special numbers



# Save new numbers to csv. It is beneficial to append newly calculated 
# data instead of writing the complete file all over again. Therefor 
# the below function is used.
SaveNewNumbers <- function(current.data.frame){
	# write directly to the file, if it does not exist
	if(!file.exists(as.character(DATABASEFILE))){
		print("Creating new database file...")
		write.csv(current.data.frame, file=as.character(DATABASEFILE))
	} else {
	# The file exists, so read it and append appropriate lines
		temp.database.data.frame <- GetDataFromCSV()
		availableNumbers <- nrow(temp.database.data.frame)
		if(nrow(current.data.frame)>=nrow(temp.database.data.frame)){
			print("Trying to write to csv...")
			data.to.be.appended <- current.data.frame[current.data.frame$number>availableNumbers,]
			print(data.to.be.appended)
			write.table(data.to.be.appended, file=as.character(DATABASEFILE), col.names=FALSE, sep=",", eol="\n", na="NA", dec=".", append=TRUE)
		}
	}
}

# Read data from csv and return it as data.frame. This allows to 
# define the access to the database
GetDataFromCSV <- function(){
	if(!file.exists(as.character(DATABASEFILE))){
		return(NULL)
	} else {
		data <- read.csv(as.character(DATABASEFILE), header=TRUE, sep=",", na="NA", dec=".", fill=TRUE)
		return(data[,c(2:length(data))])
	}
}


