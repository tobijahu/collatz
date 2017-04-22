#!/bin/sh

# This small script calls all R scripts to produce some output like
# lists and graphs, which are related to the Collatz conjecture.

PFD=$(dirname $(readlink -f "$0"))

n=999
[ ! -z "$1" ] \
	&& [ -z "$(echo "$1" | sed -e 's/[0-9]//g' )" ] \
	&& [ $1 -gt 0 ] \
	&& n=$1

echo "Procesing $n..."

mkdir -p $PFD/output

echo "Printing steps of iteration until $n"
Rscript $PFD/print-steps-up-to-n.R $n \
	> $PFD/output/print_steps-up-to-$n.txt
echo "Creating Tree for all numbers between 1 and $n"
Rscript $PFD/collatz-tree.R $n \
	> $PFD/output/collatz-tree-$n.dot
dot -Tps $PFD/output/collatz-tree-$n.dot -o $PFD/output/collatz-tree-$n.ps
dot -Tpng $PFD/output/collatz-tree-$n.dot -o $PFD/output/collatz-tree-$n.png
echo "Printing steps of iteration of numbers from 1 to $n"
Rscript $PFD/plot-all-iteration-steps-from-n.R $n \
	> $PFD/output/plot_all-iteration-steps-from-$n.txt
convert -quality 90 $PFD/output/iteration-steps-comparison-$n.ps \
	$PFD/output/iteration-steps-comparison-$n.png
echo "Printing number of iterations of numbers from 1 to $n"
Rscript $PFD/print-nsteps-up-to-n.R $n \
	> $PFD/output/print_nsteps-up-to-$n.txt

# Which questions might be of interest to have a closer look on?
# 1. Let the number of iteration steps from a given number to 1 be 
#    its distance. Is there a relation between a number and its 
#    distance?
# 2. 

exit 0
