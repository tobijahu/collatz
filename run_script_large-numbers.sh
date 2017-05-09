#!/bin/sh

# This small script calls all R scripts to produce some output like
# lists and graphs, which are related to the Collatz conjecture.

# Large numbers

PFD=$(dirname $(readlink -f "$0"))

#n=999
#[ ! -z "$1" ] \
#	&& [ -z "$(echo "$1" | sed -e 's/[0-9]//g' )" ] \
#	&& [ $1 -gt 0 ] \
#	&& n=$1

echo "Procesing large numbers..."

mkdir -p $PFD/output

## Large number functions
echo "Printing iterations steps of Mersenne prime #9"
Rscript $PFD/mersenne9-pervushin-1883.R \
	> $PFD/output/print_steps-of-mersenne-prime-9.txt
echo "Printing iterations steps of Mersenne prime #20"
Rscript $PFD/mersenne20-hurwitz-1961.R \
	> $PFD/output/print_steps-of-mersenne-prime-20.txt


exit 0
