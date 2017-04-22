#!/usr/bin/Rscript

# ENABLE command line arguments
args <- commandArgs(TRUE)

# include main functions
if(!exists("CollatzIteration", mode="function")) source("basic-functions.R")
if(!exists("NewDataSet", mode="function")) source("basic-functions-data.frame.R")

#LargestExponentiationOf2Before <- function(n){
#	exponentiation <- 1
#	while(TRUE){
#		if(exponentiation * 2 > n)
#			return(exponentiation * 2)
#		exponentiation <- exponentiation * 2
#	}
#}

# Calculate the sequence of the iteration process and plot it
ergebnis <- CollatzIteration(as.double(args[1]))
#cat(sep = "\n",ergebnis$seq)
cat(sep = " ",ergebnis$seq)
#print(digits=20,width=1,sep="\n",ergebnis$seq)
#print(ergebnis$nsteps)

dataSet <- NewDataSet(as.double(args[1]))



# Plot a graph that compares number.candidate with the next exponentiation of 2
PlotNumberOfStepsGraph <- function(number.candidate){
	## Calculate the sequence of the iteration process
	steps.candidate <- CollatzIteration(number.candidate)
	
	## Obtain the number for comparison and its sequence
	#numberForComparison <- LargestExponentiationOf2Before(number.candidate)
	numberForComparison <- 2**ceiling(log(number.candidate,base=2))
	smallestNumberOfSteps <- CollatzIteration(numberForComparison)
	
	pdf(width=7,height=7,file=paste("output/iteration-steps-comparison-",as.double(args[1]),".ps",sep=""))
	plot(steps.candidate$seq,type="p",pch=3,xlab="step",ylab="number/result of iteration")
	lines(steps.candidate$seq)
	points(smallestNumberOfSteps$seq,type="p",pch=4)
	lines(smallestNumberOfSteps$seq,lty=2)
	legend("topright",max(steps.candidate$seq),c(number.candidate,numberForComparison),lty=c(1,2),pch=c(3,4))
	title(main="Iteration process of Collatz", font.main=4)
	invisible(dev.off())
}

PlotNumberOfStepsGraph(NumberWithMaxSteps(dataSet)[1])
