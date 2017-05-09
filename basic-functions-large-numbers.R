
## Functions to compute large numbers of the Collatz function
#
# The machine limit of a 64bit processor architecture is smaller 
# than 16 digits. So it is not possible to compute any integer 
# of that size. To check, if Collatz' conjecture does work for 
# an integer with 16 or more digits, it is necessary to implement
# algorithms which are capable of that.

source("basic-functions.R")

# Return the place of the first digit of an number string that 
# is not 0. Otherwise return NULL.
FirstNonZeroDigitInString <- function(number.string){
	if(!is.character(number.string))
		stop("Argument is not of type character.")
	i <- 1
	for (digit in strsplit(number.string,"")[[1]]){
		if(as.numeric(digit)!=0)
			return(i)
		i <- i + 1
	}
	return(NULL)
}
#FirstNonZeroDigitInString("00112263")


# Convert a string into a vector of characters. This eliminates
# leading zeros 
GetVectorOfCharacters <- function(number.string){
	if(!is.character(number.string))
		stop("Argument is not of type character.")
	first.nonzero.digit <- FirstNonZeroDigitInString(number.string)
	if(is.null(first.nonzero.digit))
		return("0")
	return(strsplit(number.string,"")[[1]][first.nonzero.digit:nchar(number.string)])
}
#GetVectorOfCharacters("0123456")


# CollatzStep function for numbers larger than MACHINE_LIMIT
# To allow larger numbers, each digit of a number is casted as
# character object.
# So basic calculations have to be taught from scratch. 
# Only numbers >0 are allowed.
CollatzStepLN <- function(number.string){
	if(!is.character(number.string))
		stop("Argument is not of type character.")
	if(number.string=="")
		stop("Argument is an empty string.")
	if (is.even(as.numeric(strsplit(number.string,"")[[1]][nchar(number.string)]))){
		# process even numbers: x/2
		new.number.string <- NULL
		remainder <- 0
		# This for-loop does not processes leading zeros
		for(digit in GetVectorOfCharacters(number.string)){
			if(is.null(new.number.string) && as.numeric(digit)==1 && remainder==0) # only keep remainder of leading 1
				remainder <- as.numeric(digit)
			else { # devide digit+10*remainder by 2, save the result to the string
				new.number.string <- paste(new.number.string, as.character(floor((remainder*10+as.numeric(digit))/2)), sep="")
				#save the remainder of the operation for the next digit
				remainder <- as.numeric(digit) %% 2
			}
		}
		return(new.number.string)
	} else { # now process odd numbers: 3x+1
		new.number.string <- NULL
		remainder <- 1 # This is the "+1" in "3x+1"
		# each digit of the resulting number will be
		# larger (or equal), so we start with the 
		# smallest number in the ending
		for (digit in rev(GetVectorOfCharacters(number.string))){
			temp.number <- as.numeric(digit)*3+remainder
			new.number.string <- paste(as.character(temp.number %% 10), new.number.string, sep="")
			remainder <- (temp.number-(temp.number %% 10))/10
		}
		if(remainder!=0)
			new.number.string <- paste(as.character(remainder), new.number.string, sep="")
		return(new.number.string)
	}
}
# Example: 
#CollatzStepLN("00112263")

# Analogue to the function CollatzIteration the result of each iteration 
# initially starting at number.string is returned as a vector. The 
# first printed number is the initial. Since it breaks at 1, the 
# 1-4-2-1-loop is not processed here.
CollatzIterationLN <- function(number.string){
	if(!is.character(number.string))
		stop("Argument is not of type character.")
	if(number.string=="")
		stop("Argument is an empty string.")
	v <- NULL
	# remove leading zeros
	for (character in GetVectorOfCharacters(number.string))
		v <- paste(v,character,sep="")
	# recurse until "1" is reached
	while(v[length(v)] != "1"){
		v <- c(v,CollatzStepLN(v[length(v)]))
	}
	return(list(seq=v,nsteps=length(v)-1))
}
#CollatzIterationLN("00112263")


# To compute the decimal representation of a large number (to compute the
# steps of the algorithm of the Collatz conjecture), there are some more 
# computing operations necessary.

CompareOrder <- function(number.string, another.number.string){
	if(!is.character(number.string) || !is.character(another.number.string))
		stop("Argument is not of type character.")
	if(another.number.string=="" || number.string=="")
		stop("One argument is an empty string.")
	
	# process the signs of both numbers
	number.string.sign <- another.number.string.sign <- 1
	if(number.string!=sub('^-','', number.string)){
		number.string.sign <- -1
		number.string <- sub('^-','', number.string)
	}
	if(another.number.string!=sub('^-','', another.number.string)){
		another.number.string.sign <- -1
		another.number.string <- sub('^-','', another.number.string)
	}
	
	# Decide based on sign
	if(number.string.sign < another.number.string.sign)
		return(-1)
	if(number.string.sign > another.number.string.sign)
		return(1)
	
	# Remove leading 0s
	number.string <- sub('^0*','', number.string)
	another.number.string <- sub('^0*','', another.number.string)
	
	# Decide based on number of characters
	if(nchar(number.string) < nchar(another.number.string))
		return(-1)
	if(nchar(number.string) > nchar(another.number.string))
		return(1)
	
	# Work with character vectors from here
	number.vector <- GetVectorOfCharacters(number.string)
	another.number.vector <- GetVectorOfCharacters(another.number.string)
	
	# Check, if GetVectorOfCharacters() works rudimentary.
	if (is.vector(number.vector) && is.vector(another.number.vector)) {
		if (nchar(number.string)!=length(number.vector) || nchar(another.number.string)!=length(another.number.vector))
			stop("GetVectorOfCharacters() returns wrong number of elements.")
	} else
		stop("GetVectorOfCharacters() does not return vectors.")
	
	# If it reaches here, the number of digits as well as the sign
	# of both numbers is equal. Now a comparison per digit is necessary
	for (digit in c(1:length(number.vector))){
		if(number.vector[digit] < another.number.vector[digit]){
			if((number.string.sign == -1) && (another.number.string.sign == -1))
				return(1)
			else
				return(-1)
		}
		if(number.vector[digit] > another.number.vector[digit]){
			if((number.string.sign == -1) && (another.number.string.sign == -1))
				return(-1)
			else
				return(1)
		}
	}
	
	# Both numbers are equal
	return(0)
}
# Example:
#CompareOrder("-3","9")
# Results:
# number.string > another.number.string : 1
# number.string = another.number.string : 0
# number.string < another.number.string : -1


# The 
AddIntStrings <- function(number.string, another.number.string){
	if(!is.character(number.string) || !is.character(another.number.string))
		stop("Argument is not of type character.")
	if(another.number.string=="" || number.string=="")
		stop("One argument is an empty string.")
	
	# process the signs of both numbers, save them to an explicit
	# sign variable and remove the sign from the string
	number.string.sign <- another.number.string.sign <- 1
	if(number.string!=sub('^-','', number.string)){
		number.string.sign <- -1
		number.string <- sub('^-','', number.string)
	}
	if(another.number.string!=sub('^-','', another.number.string)){
		another.number.string.sign <- -1
		another.number.string <- sub('^-','', another.number.string)
	}
	
	# Start adding the smallest numbers. so revert the order of digits of 
	# both vectors.
	number.string <- rev(GetVectorOfCharacters(number.string))
	another.number.string <- rev(GetVectorOfCharacters(another.number.string))
	
	# Initial definition of necessary variables
	remainder <- 0
	new.number.string <- NULL
	
	
	## Addition of either two positive integers or two negative integers
	##
	if(number.string.sign*another.number.string.sign==1){
		# All digits can be handled as positive integers. So this is the
		# easiest case of addition.
		
		# Iterate all digits of the longest number string
		for(i in c(1:max(length(number.string),length(another.number.string)))){
			if(is.na(number.string[i]) && remainder ==0)
				# Only add the non-NA digit to the string
				temp.number <- as.numeric(another.number.string[i])
			else if(is.na(another.number.string[i]) && remainder ==0)
				# Only add the non-NA digit to the string
				temp.number <- as.numeric(number.string[i])
			else {
				# do the essential addition
				if(is.na(number.string[i]))
					temp.number <- as.numeric(another.number.string[i])+remainder/10
				else if(is.na(another.number.string[i]))
					temp.number <- as.numeric(number.string[i])+remainder/10
				else
					temp.number <- as.numeric(number.string[i])+as.numeric(another.number.string[i])+remainder/10
				
				# The remainder from the last loop cycle is used,
				# so reset it to 0 
				remainder <- 0
				
				# Maybe temp.number has more than a single digit, then
				# a remainder is necessary
				if (temp.number>=10) {
					# The maximum possible value of the first remainder is 9+9=18.
					# Then the maximum of the second is 9+9+1=19. And its remainder
					# is again 1. Thus it will never exceed 19. Therefor the
					# remainder is either 0 or 1. This fact, makes the determination
					# of the remainder easier.
					temp.number <- temp.number-10
					remainder <- 10
				}
				
			}
			new.number.string <- paste(as.character(temp.number), new.number.string, sep="")
		}
		
		# In case the remainder is not 0, another digit has to be added
		if(remainder!=0)
			new.number.string <- paste(as.character(remainder/10), new.number.string, sep="")
		
		# No zeros to remove, since the number of digits is either equal 
		# or larger.
		
		# In case both integers are negative, the result will be negative 
		# as well
		if(number.string.sign==-1)
			new.number.string <- paste("-", new.number.string, sep="")
		
		return(new.number.string)
	}
	
	
	## Addition of a positive integer and a negative
	##
	
	# Is the negative (or the positive) string the larger number?
	signResultNegative <- FALSE
	
	# Which vector has more elements? 
	if (length(number.string)>length(another.number.string)){
		if(number.string.sign==-1)
			signResultNegative <- TRUE
	} else if (length(number.string)<length(another.number.string)){
		if(another.number.string.sign==-1)
			signResultNegative <- TRUE
	} else {
		# In case the length of both vectors is equal, it is necessary 
		# to take a closer look at both numbers. This is possibly time
		# consuming and should be done here as last choice.
		order <- CompareOrder(number.string,another.number.string)
		
		# There is nothing to do here, if the absolute value of the positive
		# and the negative integer are equal.
		if(order==0)
			return("0")
		
		# If the larger absolute number is negative, the result will
		# be negative, too
		if(order==1 && number.string.sign==-1)
			signResultNegative <- TRUE
		if(order==-1 && another.number.string.sign==-1)
			signResultNegative <- TRUE
	}
	
	for(i in c(1:max(length(number.string),length(another.number.string)))){
		# Do the essential addition.
		# In case one of the numbers has more digits, there will be NAs.
		if(is.na(number.string[i]))
			temp.number <- another.number.string.sign*as.numeric(another.number.string[i])+remainder/10
		else if(is.na(another.number.string[i]))
			temp.number <- number.string.sign*as.numeric(number.string[i])+remainder/10
		else
			temp.number <- number.string.sign*as.numeric(number.string[i])+another.number.string.sign*as.numeric(another.number.string[i])+remainder/10
		
		
		# The remainder from the last loop cycle is used, so reset it to 0.
		remainder <- 0
		
		# The largest possible result of temp.number for a result with 
		# positive sign is 0+9=9 for the first digit, while the smallest 
		# for the first digit (of a positive result) is -9+0=-9. To obtain 
		# a positive sign of temp.number, a negative remainder has to be 
		# produced. This is simply done by adding 10. Then -1 will be 
		# added to the next temp.number to calculate the next digit. So 
		# for the second digit it is possible to get a smaller remainder 
		# than before. This is -9+0-1=-10. In this case, to obtain a 
		# positive resulting digit, 10 will be added and thus the current 
		# digit will 0 and the remainder -10 (or in terms of the next digit 
		# -1). This is it -- as learned at school.
		if (!signResultNegative && temp.number<0) {
			temp.number <- temp.number+10
			remainder <- -10
		}
		
		# To obtain a result with a negative sign the letter process is 
		# analogue.
		if (signResultNegative && temp.number>0){
			temp.number <- temp.number-10
			remainder <- 10
		}
		new.number.string <- paste(as.character(abs(temp.number)), new.number.string, sep="")
	}
	
	# It is impossible that there is a remainder, so throw an error in such a 
	# case.
	if(remainder!=0)
		stop("Remainder is not zero.")
	
	# Remove leading 0s
	new.number.string <- sub('^0*','', new.number.string)
	
	if(signResultNegative)
		new.number.string <- paste("-", new.number.string, sep="")
	
	return(new.number.string)
}
# Example:
#AddIntStrings("559", "41")

MultiplyIntStrings <- function(number.string, another.number.string){
	if(another.number.string=="" || number.string=="" )
		stop("An argument is an empty string.")
	if(!is.character(number.string) || !is.character(another.number.string))
		stop("An argument is not of type character.")
	
	# process the signs of both numbers
	number.string.sign <- another.number.string.sign <- 1
	if(number.string!=sub('^-','', number.string)){
		number.string.sign <- -1
		number.string <- sub('^-','', number.string)
	}
	if(another.number.string!=sub('^-','', another.number.string)){
		another.number.string.sign <- -1
		another.number.string <- sub('^-','', another.number.string)
	}
	
	# Remove leading 0s
	number.string <- sub('^0*','', number.string)
	another.number.string <- sub('^0*','', another.number.string)
	
	# If a string was 0 before, it will be empty now.
	if (number.string=="" || another.number.string=="")
		return("0")
	
	# Multiply both numbers
	new.number.string <- "0"
	remainder <- 0
	# each digit of the resulting number will be larger (or 
	# equal), so we start with the smallest number in the 
	# ending. This is invoked by rev().
	k <- 0
	for (digit1 in rev(GetVectorOfCharacters(number.string))){
		l <- 0
		for (digit2 in rev(GetVectorOfCharacters(another.number.string))){
			temp.number <- as.numeric(digit1)*as.numeric(digit2)+remainder

			pre.temp.number <- NULL
			for (zero in rep("0",k+l))
				pre.temp.number <- paste(zero, pre.temp.number, sep="")
			temp.number.string <- paste(as.character(temp.number), pre.temp.number, sep="")
			new.number.string <- AddIntStrings(new.number.string, temp.number.string)
			l <- l+1 
		}
		k <- k+1
	}
	
	# Add the sign
	if (number.string.sign*another.number.string.sign==-1)
		new.number.string <- paste("-", new.number.string, sep="")
	
	return(new.number.string)
}
# Example:
#MultiplyIntStrings("10","10")
