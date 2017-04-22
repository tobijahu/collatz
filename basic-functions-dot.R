
# include main functions
if(!exists("CollatzIterationVector", mode="function")) source("basic-functions.R")

# DottyTest is just the trivial plot of the first step of the iteration.
# This function expects a vector as input. The plot is not a single
# digraph, but several single ones.
DottyTest <- function(inputVector){
	string <- 'digraph G {\n'
	for(i in inputVector)
		string <- paste(string,"   ",i," -> ",CollatzEntscheidung(i),";\n",sep="")
	string <- paste(string,"}")
	return(cat(string))
}
# Use this function by calling it as follows.
#DottyTest(c(1:15))


# This function prints a digraph with all steps of the iteration that 
# is related to the collatz conjecture. It integrates all iteration 
# steps of a given vector into a digraph. Results may be viewed using 
# for example xdot.
DottySimple <- function(inputVector){
	allSteps <- CollatzIterationVector(inputVector)
	string <- 'digraph G {\n'
	k <- 1
	for(i in allSteps){
		if(!is.na(i))
			string <- paste(string,"   ",k," -> ",i,";\n",sep="")
		k <- k + 1
	}
	string <- paste(string,"}")
	return(cat(string))
}
# Use this function by calling it as follows.
#DottySimple(c(1:100))

# Same as Dotty, but prints colored edges. Blue represents the 
# operation 3x+1, while red represents x/2.
Dotty <- function(inputVector){
	allSteps <- CollatzIterationVector(inputVector)
	string <- 'digraph G {\n'
	k <- 1
	for(i in allSteps){
		if(!is.na(i)){
			string <- paste(string,"   ",k," -> ",i,sep="")
			if(is.even(k))
				string <- paste(string,' [color=red]',sep="")
			else
				string <- paste(string,' [color=blue]',sep="")
			string <- paste(string,";\n",sep="")
		}
		k <- k + 1
	}
	string <- paste(string,"}")
	return(cat(string))
}
# Use this function by calling it as follows.
#Dotty(c(1:100))
