
#setwd("/home/your-user/path-to-your-collatz-clone-folder/") 
# Or just start R from that folder

source("basic-functions-large-numbers.R")

print("Running tests of functions at basic-functions-large-numbers.R")

print("FirstNonZeroDigitInString()")
print(FirstNonZeroDigitInString("00112263")==3)
print(FirstNonZeroDigitInString("112263")==1)

print("GetVectorOfCharacters()")
print(GetVectorOfCharacters("12345")==c(1:5))
print(GetVectorOfCharacters("000")==rep(0,3))

print("CollatzStepLN()")
# Is the remainder processed correctly, if the new number is larger?
print(as.numeric(CollatzStepLN("561315"))==3*561315+1)
# Are zeros erased, if not necessary?
print(as.numeric(CollatzStepLN("00112263"))==3*112263+1)
print(as.numeric(CollatzStepLN("00112260"))==112260/2)
# Are some large numbers processed correctly?
print(CollatzStepLN("22222222222222222222")=="11111111111111111111")
print(CollatzStepLN("12222222222222222222")=="6111111111111111111")
print("CollatzStepLN(): Check arguments")
tryCatch(CollatzStepLN(""), error = function(e) print(TRUE))
tryCatch(CollatzStepLN(NULL), error = function(e) print(TRUE))
tryCatch(CollatzStepLN(5), error = function(e) print(TRUE))

print("CollatzIterationLN()")
# Does the function return correct values for as.character(1)?
print(CollatzIterationLN(as.character(1))$seq==list(seq=c("1"),nsteps=0)$seq)
print(CollatzIterationLN(as.character(1))$nsteps==list(seq=c("1"),nsteps=0)$nsteps)
# Are the results equal to those of CollatzIteration()?
print(CollatzIteration(9)$nsteps==CollatzIterationLN(as.character(9))$nsteps)
ergebnis <- NULL
for (result in CollatzIteration(9)$seq) ergebnis <- c(ergebnis, as.character(result))
print(ergebnis==CollatzIterationLN(as.character(9))$seq)
print("CollatzIterationLN(): Checking arguments")
tryCatch(CollatzIterationLN(""), error = function(e) print(TRUE))
tryCatch(CollatzIterationLN(NULL), error = function(e) print(TRUE))
tryCatch(CollatzIterationLN(5), error = function(e) print(TRUE))

print("CompareOrder()")
print(CompareOrder("0","-1")==1)
print(CompareOrder("9994","-5")==1)
print(CompareOrder("4","-5")==1)
print(CompareOrder("-1","0")==-1)
print(CompareOrder("-5","9994")==-1)
print(CompareOrder("-5","4")==-1)
print(CompareOrder("112","112")==0)
print("CompareOrder(): Checking arguments")
tryCatch(CompareOrder("", "41"), error = function(e) print(TRUE))
tryCatch(CompareOrder(NULL, "41"), error = function(e) print(TRUE))
tryCatch(CompareOrder(5, "41"), error = function(e) print(TRUE))

print("AddIntStrings()")
# Check, if it basically does what it primarily should do!
print(AddIntStrings("559", "40")==559+40)
print(AddIntStrings("559", "-99")==559-99)
# Neutral element:
print(AddIntStrings("559", "0")==559)
print(AddIntStrings("0", "9999")==9999)
# Commutativity:
print(AddIntStrings("-559", "121")==-559+121)
print(AddIntStrings("559", "-121")==559-121)
# Inverse:
print(AddIntStrings("559", "-559")==0)
# The resulting number has more digits:
print(AddIntStrings("999", "2")==999+2)
print(AddIntStrings("-999", "-2")==-999-2)
# Does it correctly compute numbers with a large abolute difference?
print(AddIntStrings("559", "10000000009")==559+10000000009)
print(AddIntStrings("-559", "-10000000009")==-559-10000000009)
print(AddIntStrings("559", "-10000000009")==559-10000000009)
print(AddIntStrings("-559", "10000000009")==-559+10000000009)
print("AddIntStrings(): Checking arguments")
# Does the function return NULL, if another result does not make any sense?
#tryCatch(AddIntStrings("", "41"), error = function(e) e)
tryCatch(AddIntStrings("", "41"), error = function(e) print(TRUE))
tryCatch(AddIntStrings(NULL, "41"), error = function(e) print(TRUE))
tryCatch(AddIntStrings(3, "41"), error = function(e) print(TRUE))
#print(is.null(AddIntStrings(NULL, "41")))


print("MultiplyIntStrings()")
# Check, if it basically does what it primarily should do!
print(MultiplyIntStrings("10","10")==as.character(10*10))
print(MultiplyIntStrings("2","-512")==as.character(2*(-512)))
# Zero element:
print(MultiplyIntStrings("0","-1")==as.character(0*(-1)))
print(MultiplyIntStrings("4","0")==as.character(4*0))
# Neutral element:
print(MultiplyIntStrings("-7","1")==as.character((-7)*1))
print(MultiplyIntStrings("1","-31")==as.character(1*(-31)))
# Inverse is not implemented
# Computing negative numbers
print(MultiplyIntStrings("-1","-9")==as.character((-1)*(-9)))
print(MultiplyIntStrings("-1111","-999")==as.character((-1111)*(-999)))
print("MultiplyIntStrings(): Checking arguments")
# Does the function throw an error, if an argument is NULL?
tryCatch(MultiplyIntStrings(NULL,"-1"), error=function(e) print(TRUE))
tryCatch(MultiplyIntStrings("8",NULL), error=function(e) print(TRUE))
# Does the function throw an error, if an argument is an empty string?
tryCatch(MultiplyIntStrings("k", "41"), error=function(e) print(TRUE))
tryCatch(MultiplyIntStrings("2", ""), error=function(e) print(TRUE))
tryCatch(MultiplyIntStrings(2, "1"), error=function(e) print(TRUE))
