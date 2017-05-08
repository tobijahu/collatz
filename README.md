# Collatz Conjecture visualizations

This repo ships two implementations of the algorithm that is the foundation of the Collatz conjecture. The standard implementation only supports _double_ integers and therefor can easily be used for data analysis with standard _R_ tools. The other implementation supports large integers, but is limited in applications or (easy) further processing. 

## What is the Collatz conjecture?
The Collatz conjecture states that every natural number will eventually reach 1 under the iteration that each even resulting number is devided by 2, while each odd is multiplied by 3 and then 1 added.
It is also known as the `3x+1`-problem.

You may find more introduction and references about this at the [The Collatz conjecture](http://www.youtube.com/watch?v=5mFpVDpKX70) video by David Eisenbud on Youtube.

## Content
By running for example
`sh run_script.sh 50`
the content for iterations up to 50 can be created. The output is put to the **output** folder. This includes for example the following digraph for all numbers up to 5 and plot that compares the number with the maximum number of steps that can be found among the numbers from 1 to 50.


![alt text](https://raw.githubusercontent.com/tobijahu/collatz/master/output/collatz-tree-5.png "Digraph/tree of all iteration steps for numbers from 1 to 5")

![alt text](https://raw.githubusercontent.com/tobijahu/collatz/master/output/iteration-steps-comparison-50.png "Fast vs slow converging series of algorithm steps")
