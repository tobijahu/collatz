
#setwd("/home/your-user/path-to-your-collatz-clone-folder/") 
# Or just start R from that folder

source("basic-functions.R")

print("Running tests of functions at basic-functions.R")

print("is.even()")
print(is.even(2)==TRUE)
print(is.even(6)==TRUE)
print(is.even(1)==FALSE)
print(is.even(7)==FALSE)


print("is.odd()")
print(is.odd(1)==TRUE)
print(is.odd(9)==TRUE)
print(is.odd(2)==FALSE)
print(is.odd(8)==FALSE)

print("CollatzStep()")
print(CollatzStep(1)==4)
print(CollatzStep(2)==1)
print(CollatzStep(32)==16)
print(CollatzStep(7)==22)

print("CollatzIteration()")
print(CollatzIteration(4)$seq==c(4,2,1))
print(CollatzIteration(4)$nsteps==c(2))
print(CollatzIteration(3)$seq==c(3,10,5,16,8,4,2,1))
print(CollatzIteration(3)$nsteps==c(7))
print(CollatzIteration(1)$seq==c(1))
print(CollatzIteration(1)$nsteps==c(0))

print("CollatzIterationVector()")
print(CollatzIterationVector(4)==c(4,1,NA,2))
print(CollatzIterationVector(1)==c(4,1,NA,2))
print(CollatzIterationVector(3)==c(4,1,10,2,16,NA,NA,4,NA,5,NA,NA,NA,NA,NA,8))
print(CollatzIterationVector(c(1:2,4))==c(4,1,NA,2))

print("CollatzIterationSteps")
print(CollatzIterationSteps(c(1:5))==c(0,1,7,2,5))
print(CollatzIterationSteps(c(3:5))==c(NA,NA,7,2,5))
print(CollatzIterationSteps(c(3:5,7))==c(NA,NA,7,2,5,NA,16))

