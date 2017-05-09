# Collatz Conjecture visualizations

This repo ships two implementations of the algorithm that is the foundation of the Collatz conjecture. The standard implementation only supports _double_ integers and therefor can easily be used for data analysis with standard _R_ tools. The other implementation supports large integers, but is limited in applications or (easy) further processing. 

## What is the Collatz conjecture?
The Collatz conjecture states that every natural number will eventually reach _1_ under the iteration that each even resulting number is devided by _2_, while each odd is multiplied by _3_ and then _1_ added.
It is also known as the `3x+1`-problem.

You may find more introduction and references about this at the [The Collatz conjecture](http://www.youtube.com/watch?v=5mFpVDpKX70) video by David Eisenbud on Youtube.

## Content
By running for example
`sh run_script.sh 50`
the content for iterations up to _50_ can be created. The output is put to the **output** folder. 

### .dot digraph
The following digraph includes all iterations of numbers from _1_ to _5_.
![alt text](https://raw.githubusercontent.com/tobijahu/collatz/master/output/collatz-tree-5.png "Digraph/tree of all iteration steps for numbers from 1 to 5"

### Iteration steps comparison
The algorithm on that the Collatz conjecture is founded on converges super fast for some numbers and slower for others. The following plot compares the slowest converging number among the numbers from _1_ to _50_ with the next larger power of _2_. Here _27_ has maximum steps among the numbers from _1_ to _50_ and _32_ is the first power of _2_ that is larger than _27_.
![alt text](https://raw.githubusercontent.com/tobijahu/collatz/master/output/iteration-steps-comparison-50.png "Fast vs slow converging series of algorithm steps")
Why choosing powers of _2_? For the algorithm the only way to return a number, that is smaller than the corresponding input, is by putting a number that has a factorization including factor _2_. In this sense _32_ has such a factorization, since `32=2*2*2*2*2`. In contrast to that _2_ is not a factor of _27_ since `27=3*3*3`. For _27_ the algorithm reaches _1_ after _111_ iterations. For _32_ the algorithm only takes _5_ steps to reach _1_, since in this case each iteration eliminates a factor _2_. By design of the algorithm there cannot be any number that is larger than _32_ _and_ requires fewer steps to reach _1_.
