#!/usr/bin/Rscript

# ENABLE command line arguments
args <- commandArgs(TRUE)

# process arguments from the cli
if(is.na(args[1])) { given.number <- 99 } else { given.number <- as.double(args[1]) }

# include main functions
if(!exists("CollatzIteration", mode="function")) source("basic-functions.R")
if(!exists("NewDataSet", mode="function")) source("basic-functions-data.frame.R")


# create data set
dataSet <- NewDataSet(given.number)

# To each number plot the number of steps of the collatz 
# iteration
pdf(width=14,height=7,file=paste("output/number-vs-number-of-steps-",given.number,".ps",sep=""))
plot(dataSet$nsteps,type="p",pch=3,xlab="n",ylab="steps(n)")
dev.off()

# The quotients of steps and number
pdf(width=7,height=7,file=paste("output/number-vs-number-of-steps-ratio-",given.number,".ps",sep=""))
plot(dataSet$ratio,type="p",pch=3,xlab="n",ylab="ratio")
abline(0, 1)
dev.off()

pdf(width=7,height=7,file=paste("output/number-vs-number-of-steps-log2-ratio-",given.number,".ps",sep=""))
plot(log2(dataSet$nsteps),type="p",pch=3,xlab="n",ylab="steps(n)")
abline(0, 1)
dev.off()

# By the design of the algorithm, for numbers that are 
# powers of 2 the algorithm does locally take the smallest 
# number of steps. If those numbers are marked, a 
# remarkable pattern evolves
pdf(width=7,height=7,file=paste("output/number-vs-number-of-steps-classes-",given.number,".ps",sep=""))
plot(dataSet$nsteps,type="p",pch=3,xlab="n",ylab="steps(n)")
smallestBase2LogarithmGtLargestNumber <- ceiling(log(length(dataSet$nsteps),base=2))
abline(v=(2**c(1:smallestBase2LogarithmGtLargestNumber)))
dev.off()

## 
#pdf(width=14,height=7,file=paste("output/number-vs-number-of-steps-",given.number,"-connected.ps",sep=""))
#plot(dataSet$nsteps,type="p",pch=3,xlab="n",ylab="steps(n)")
#for(i in c(given.number:1)){
#	nextStep <- CollatzStep(i)
#	lines(x=c(i,nextStep),y=c(CollatzIterationSteps(i)[i],CollatzIterationSteps(nextStep)[nextStep]))
#}
#dev.off()

