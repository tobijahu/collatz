## Main functions of stuff regarding the Collatz conjecture

# The Collatz conjecture states that every natural number will
# eventually reach 1 under the iteration that each even resulting 
# number is devided by 2, while each odd is multiplied by 3 and 
# then 1 added.
# It is also known as the 3x+1 problem.

# You may find more about this at
# The Collatz conjecture found on
# http://www.youtube.com/watch?v=5mFpVDpKX70


# Calculate the maximum possible number of the system/machine. 
MACHINE_LIMIT <- .Machine$double.base**.Machine$double.digits

# Check, if basic arithmetic operations are applicable to 
# MACHINE_LIMIT. If not, stop the script.
MACHINE_LIMIT_TEST_1 <- (MACHINE_LIMIT==MACHINE_LIMIT+1)!=TRUE
MACHINE_LIMIT_TEST_2 <- (MACHINE_LIMIT==MACHINE_LIMIT-1)!=FALSE
if(MACHINE_LIMIT_TEST_1 || MACHINE_LIMIT_TEST_2){
	print(paste("Machine Limit ",MACHINE_LIMIT," is inappropriate.",sep=""))
	q(save = "no", status = 1, runLast = TRUE)
}

OUTDIR <- "output/"
DATABASEFILE <- "database.csv"


# The basic decision of how to continue in the iteration process
# is done by the following two functions.
is.even <- function(x) x %% 2 == 0
is.odd <- function(x) x %% 2 != 0


# The essential function that is basis of the Collatz conjecture
# does only devide by 2 or multiply with 3 and add 1. This is it.
# All other functions rely on this.
CollatzStep <- function(n){
	limit <- MACHINE_LIMIT/3
	if (is.even(n))
		return(n/2)
	else {
		if (n>limit)
			return(-1)
		return(3*n+1)
	}
}


# Print the result of each iteration initially starting at n into 
# a vector. The first printed number is the initial. Return NULL 
# just In case the result is too large to continue. Since it breaks
# at 1, the 1-4-2-1-loop is not processed here.
CollatzIteration <- function(n){
	if(n>MACHINE_LIMIT){
		stop(paste(n," is too large."))
		return(NULL)
	}
	v <- c(n)
	while(v[length(v)] != 1){
		nextResult <- CollatzStep(v[length(v)])
		if(nextResult == -1){
			stop(paste("Number of next step after ",v[length(v)]," is too large."))
			return(NULL)
		}
		v <- c(v,CollatzStep(v[length(v)]))
	}
	return(list(seq=v,nsteps=length(v)-1))
}
# Example:
#CollatzIteration(10)$seq
# would return the sequence of numbers of the corresponding 
# iteration process. While
#CollatzIteration(10)$nsteps
# would return the number of iterations until 1 is reached.


# To print graphs etc of several iteration processes, 
# CollatzIteration() does not do an optimal job. Additionally
# the following function allows to print the 1-4-2-1-loop.
CollatzIterationVector <- function(v){
	resultVector <- rep(NA,max(v))
	for(i in v){
		m <- resultVector[i] <- CollatzStep(i)
		while(is.na(resultVector[m])){
			m <- resultVector[m] <- CollatzStep(m)
			if(is.null(resultVector[resultVector[i]])){
				warning(paste("Cannot process ",i,". Next try after removal might be working."))
				return(NULL)
			}
		}
	}
	return(resultVector)
}
# Examples:
#CollatzIterationVector(c(8,19))
#CollatzIterationVector(c(1:100))


# Obtain the number of steps of each entry of a given vector
CollatzIterationSteps <- function(inputVector){
	result <- NULL
	for(i in inputVector){
		result[i] <- CollatzIteration(i)$nsteps
	}
	return(result)
}
#CollatzIterationSteps(c(1:1000))



################################################################
## Functions to compute large numbers of the Collatz function ##
################################################################

# Return the place of the first digit of an number string that 
# is not 0. Otherwise return NULL.
FirstNonZeroDigitInString <- function(number.string){
	if(!is.character(number.string))
		stop("Argument is not of type character.")
	i <- 1
	for (digit in strsplit(number.string,"")[[1]]){
		if(as.numeric(digit)!=0)
			return(i)
		i <- i + 1
	}
	return(NULL)
}
#FirstNonZeroDigitInString("00112263")


# Convert a string into a vector of characters. This eliminates
# leading zeros 
GetVectorOfCharacters <- function(number.string){
	if(!is.character(number.string))
		stop("Argument is not of type character.")
	first.nonzero.digit <- FirstNonZeroDigitInString(number.string)
	if(is.null(first.nonzero.digit))
		return("0")
	return(strsplit(number.string,"")[[1]][first.nonzero.digit:nchar(number.string)])
}
#GetVectorOfCharacters("0123456")


# CollatzStep function for numbers larger than MACHINE_LIMIT
# To allow larger numbers, each digit of a number is casted as
# character object.
# So basic calculations have to be taught from scratch. 
# Only numbers >0 are allowed.
CollatzStepLN <- function(number.string){
	if(!is.character(number.string))
		stop("Argument is not of type character.")
	if (is.even(as.numeric(strsplit(number.string,"")[[1]][nchar(number.string)]))){
		# process even numbers: x/2
		new.number.string <- NULL
		remainder <- 0
		# This for-loop does not processes leading zeros
		for(digit in GetVectorOfCharacters(number.string)){
			if(is.null(new.number.string) && as.numeric(digit)==1 && remainder==0) # only keep remainder of leading 1
				remainder <- as.numeric(digit)
			else { # devide digit+10*remainder by 2, save the result to the string
				new.number.string <- paste(new.number.string, as.character(floor((remainder*10+as.numeric(digit))/2)), sep="")
				#save the remainder of the operation for the next digit
				remainder <- as.numeric(digit) %% 2
			}
		}
		return(new.number.string)
	} else { # now process odd numbers: 3x+1
		new.number.string <- NULL
		remainder <- 1 # This is the "+1" in "3x+1"
		# each digit of the resulting number will be
		# larger (or equal), so we start with the 
		# smallest number in the ending
		for (digit in rev(GetVectorOfCharacters(number.string))){
			temp.number <- as.numeric(digit)*3+remainder
			new.number.string <- paste(as.character(temp.number %% 10), new.number.string, sep="")
			remainder <- (temp.number-(temp.number %% 10))/10
		}
		if(remainder!=0)
			new.number.string <- paste(as.character(remainder), new.number.string, sep="")
		return(new.number.string)
	}
}
#CollatzStepLN("00112263")


# Analog to the function CollatzIteration the result of each iteration 
# initially starting at number.string is returned as a vector. The 
# first printed number is the initial. Since it breaks at 1, the 
# 1-4-2-1-loop is not processed here.
CollatzIterationLN <- function(number.string){
	if(!is.character(number.string))
		stop("Argument is not of type character.")
	v <- NULL
	# remove leading zeros
	for (character in GetVectorOfCharacters(number.string))
		v <- paste(v,character,sep="")
	# recurse until "1" is reached
	while(v[length(v)] != "1"){
		v <- c(v,CollatzStepLN(v[length(v)]))
	}
	return(list(seq=v,nsteps=length(v)-1))
}
#CollatzIterationLN("00112263")
