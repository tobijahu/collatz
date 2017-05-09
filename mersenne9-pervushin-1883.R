if(!exists("MultiplyInt", mode="function")) source("basic-functions-large-numbers.R")

# According to primes.utm.edu https://primes.utm.edu/mersenne/index.html#known
# Pervushin found in 1883 that 2**61-1 is a Mersenne prime number. It is the 
# Mersenne prime number 9. In the decade number representation the total number 
# of digit of this number is 19. So this number seems to be a good first 
# candidate to test the large numbers functions for the Collatz function.

number <- "1"
remainingDigits <- 61 %% .Machine$double.digits
multiplicationSteps <- (61-remainingDigits)/.Machine$double.digits
for(i in c(1:multiplicationSteps)){
	number <- MultiplyIntStrings(number, as.character(2**.Machine$double.digits))
}
number <- MultiplyIntStrings(number, as.character(2**remainingDigits))
mersenne9 <- AddIntStrings(number, "-1")

cat("## Digits of the number:")
cat(mersenne9)
mersenne9Iteration <- CollatzIterationLN(mersenne9)
cat("## Number of steps until it reaches 1:")
cat(mersenne9Iteration$nsteps)
cat("## Iteration steps:")
cat(mersenne9Iteration$seq)
