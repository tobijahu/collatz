#!/usr/bin/Rscript

# ENABLE command line arguments
args <- commandArgs(TRUE)

# process arguments from the cli
if(is.na(args[1])) { given.number <- 99 } else { given.number <- as.double(args[1]) }

# include main functions
if(!exists("CollatzIteration", mode="function")) source("basic-functions.R")


# Iterate over all numbers between the given number to 1
# and print the number of steps.
# We will start with the largest number, the given one.
for(i in c(given.number:1)){
	result <- CollatzIteration(i)
	if(is.null(result$nsteps)){
		break
	}
        cat(result$nsteps,"\n")
}
