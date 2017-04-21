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
	else if (is.odd(n)){
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
		print(paste("Error: ",n," is too large."))
		return(NULL)
	}
	v <- c(n)
	while(v[length(v)] != 1){
		nextResult <- CollatzStep(v[length(v)])
		if(nextResult == -1){
			print(paste("Error: Number of next step after ",v[length(v)]," is too large."))
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
				print(paste("Cannot process ",i,". Next try after removal might be working."))
				return(NULL)
			}
		}
	}
	return(resultVector)
}
# Examples:
#CollatzIterationVector(c(8,19))
#CollatzIterationVector(c(1:100))

CollatzIterationSteps <- function(inputVector){
	result <- NULL
	for(i in inputVector){
		result[i] <- CollatzIteration(i)$nsteps
	}
	return(result)
}
#CollatzIterationSteps(c(1:1000))

