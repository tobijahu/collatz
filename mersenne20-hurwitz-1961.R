if(!exists("MultiplyInt", mode="function")) source("basic-functions-large-numbers.R")

# According to primes.utm.edu https://primes.utm.edu/mersenne/index.html#known
# Hurwitz found in 1961 that 2**4423-1 is a Mersenne prime number. It is the 
# Mersenne prime number 20. In the decade number representation the total number 
# of digit of this number is 1332. So this number seems to be a good candidate 
# to test the large numbers functions for the Collatz function.

number <- "1"
remainingDigits <- 4423 %% .Machine$double.digits
multiplicationSteps <- (4423-remainingDigits)/.Machine$double.digits
for(i in c(1:multiplicationSteps)){
	number <- MultiplyIntStrings(number, as.character(2**.Machine$double.digits))
}
number <- MultiplyIntStrings(number, as.character(2**remainingDigits))
mersenne20 <- AddIntStrings(number, "-1")

cat("## Digits of the number:")
cat(mersenne20)
mersenne20Iteration <- CollatzIterationLN(mersenne20)
cat("## Number of steps until it reaches 1:")
cat(mersenne20Iteration$nsteps)
cat("## Iteration steps:")
cat(mersenne20Iteration$seq)

