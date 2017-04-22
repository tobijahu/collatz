#!/usr/bin/Rscript

# ENABLE command line arguments
args <- commandArgs(TRUE)

# include main functions
if(!exists("CollatzEntscheidung", mode="function")) source("basic-functions.R")
if(!exists("Dotty", mode="function")) source("basic-functions-dot.R")

# Call the Dotty() function that prints a graph using the DOT language to
# visualize the steps of the algorithm.
Dotty(c(1:as.double(args[1])))

# Save the output of this script to a .dot file. Then open it using for
# example xdot.
