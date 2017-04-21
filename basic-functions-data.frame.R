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

# Create a data set that provides possible relations between numbers
NewDataSet <- function(upper.bound.number){
	all.steps <- CollatzIterationSteps(c(upper.bound.number:1))
	factors <- NumberOfFactors(c(1:length(all.steps)))
	factorsNe2 <- NumberOfFactorsNe2(c(1:length(all.steps)))
	diffFactors <- abs(factors - factorsNe2)
	## number, nsteps, ratio, factors.ne.2
	data.set <- data.frame(c(1:length(all.steps)),all.steps,all.steps/c(1:length(all.steps)),factors/c(1:length(all.steps)),factorsNe2/c(1:length(all.steps)),diffFactors/c(1:length(all.steps)),(all.steps - diffFactors)/c(1:length(all.steps)))
	names(data.set) <- c("number","nsteps","ratio","factors","factorsNe2","diffFactors","cleanSteps")
	return(data.set)
}
# Example:
#dataSet <- NewDataSet(given.number)

# Outlook on further processing:
# * plot the whole data set against each column using plot(dataSet)
# * calculate covarianz or corelation of the data
# * check on special numbers
