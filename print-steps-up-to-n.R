#!/usr/bin/Rscript

# ENABLE command line arguments
args <- commandArgs(TRUE)

# include main functions
if(!exists("CollatzIteration", mode="function")) source("basic-functions.R")

# Iterate over all numbers between the given number to 1.
# To prevent that any output is printed, we will start with
# the largest number, the given one.
for(i in c(as.double(args[1]):1)){
	result <- CollatzIteration(i)
	if(is.null(result$seq)){
		break
	}
        cat(result$seq,"\n")
}
