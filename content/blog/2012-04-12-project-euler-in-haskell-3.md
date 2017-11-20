+++
title      = "Project Euler in Haskell #3"
date       = "2012-04-12T16:03:00+02:00"
type       = "article"
tags       = [ "Programming", "Haskell", "Project Euler" ]
slug       = "project-euler-in-haskell-3"
+++

## Problem Description
[Link to Project Euler problem 3](http://projecteuler.net/problem=3)

The prime factors of 13195 are 5, 7, 13 and 29.

What is the largest prime factor of the number 600851475143?

__WARNING__
_Solution ahead. Don't read more if you want to enjoy the benefits of
Project Euler and you haven't already solved the problem._

<!--more-->
## Solution
We need a primes generator to find the prime factors of a number.
Instead of using a package from Hackage, I prefer to create a
generator from scratch.

I will use the sieve of Eratosthenes algorithm, as described by
[Melissa E. O'Neill (PDF 217KB)](http://www.cs.hmc.edu/~oneill/papers/Sieve-JFP.pdf).

The generator proposed in the article use a priority queue data structure.
A simple and effective priority queue, the `Pairing Heap`, is described
by [Louis Wasserman (PDF 396KB)](http://themonadreader.files.wordpress.com/2010/05/issue16.pdf).

Here is the code, adapted to the need of the sieve algorithm, and without
using the `Maybe` monad for min value extraction (for simplicity's sake).

{{< highlight haskell >}}
data PairingHeap a  =  Empty
                    |  PairNode a [PairingHeap a]
                       deriving (Show)

(+++)              :: Ord a => PairingHeap a -> PairingHeap a -> PairingHeap a
Empty  +++  heap   =  heap
heap   +++  Empty  =  heap
heap1@(PairNode x1 ts1)  +++  heap2@(PairNode x2 ts2)
    | x1 <= x2     =  PairNode x1 (heap2:ts1)
    | otherwise    =  PairNode x2 (heap1:ts2)

-- Construction
empty  :: PairingHeap a
empty  =  Empty

singleton    :: a -> PairingHeap a
singleton x  =  PairNode x []

-- Insertion
insert      :: Ord a => a -> PairingHeap a -> PairingHeap a
insert x q  =  (singleton x) +++ q

-- Priority Queue
minValue                 :: PairingHeap a ->  a
minValue Empty           =  error "Empty queue!"
minValue (PairNode x _)  =  x

deleteMin                  :: Ord a => PairingHeap a -> PairingHeap a
deleteMin Empty            =  error "Empty queue!"
deleteMin (PairNode _ ts)  =  meldChildren ts
    where
      meldChildren (t1:t2:ts)  =  t1 +++ t2 +++ meldChildren ts
      meldChildren [t]         =  t
      meldChildren []          =  Empty

deleteMinAndInsert      :: Ord a => a -> PairingHeap a -> PairingHeap a
deleteMinAndInsert x q  =  insert x $ deleteMin q
{{< /highlight >}}

This `Pairing Heap` implementation doesn't support a key/value node.
So I define an `Iterator` data type to manage the key/value concept
necessary to the algorithm.

{{< highlight haskell >}}
-- Iterator
data Iterator = Iterator Integer [Integer]
    deriving (Show)

instance Eq Iterator where
    (Iterator x _) == (Iterator y _) = x == y

instance Ord Iterator where
    compare (Iterator x _) (Iterator y _) = compare x y
{{< /highlight >}}

I even create a `Table` type alias and some utility functions to hide
the priority queue specific implementation from the algorithm.

{{< highlight haskell >}}
-- Table
type Table = PairingHeap Iterator

emptyTable  :: Table
emptyTable  =  empty

insertTable         :: Integer -> [Integer] -> Table -> Table
insertTable n is t  =  insert (Iterator n is) t

tableMinValue    :: Table -> Integer
tableMinValue t  =  n
    where
      (Iterator n _) = minValue t

tableMinValueIters    :: Table -> (Integer, [Integer])
tableMinValueIters t  =  (n, is)
    where
      (Iterator n is)  =  minValue t

tableDeleteMinAndInsert         :: Integer -> [Integer] -> Table -> Table
tableDeleteMinAndInsert n is t  =  deleteMinAndInsert (Iterator n is) t
{{< /highlight >}}

With the priority queue completed, we can define the sieve algorithm:

* the `sieve` function filters the input sequence and find the primes incrementally
* the `wheel` stream and the `spin` function allow to generate an input sequence
  without the composites of the primes 2,3,5,7; this optimization makes the sieve seven
  times faster than with a complete input sequence `[2..]`
* the `primes` stream is created composing the sieve and the spinned wheel

{{< highlight haskell >}}
sieve         :: [Integer] -> [Integer]
sieve []      =  []
sieve (x:xs)  =  x : sieve' xs (insertprime x xs emptyTable)
    where
      insertprime p xs table  =  insertTable (p*p) (map (*p) xs) table
      sieve' [] table  =  []
      sieve' (x:xs) table
          | nextComposite <= x  =  sieve' xs (adjust table)
          | otherwise           =  x : sieve' xs (insertprime x xs table)
          where
            nextComposite  =  tableMinValue table
            adjust table
                | n <= x     =  adjust (tableDeleteMinAndInsert n' ns table)
                | otherwise  =  table
                where
                  (n, n':ns)  =  tableMinValueIters table

wheel2357 :: [Integer]
wheel2357 = 2:4:2:4:6:2:6:4:2:4:6:6:2:6:4:2:6:4:6:8:4:2:4:2:4
            :8:6:4:6:2:4:6:2:6:6:4:2:4:6:2:6:4:2:4:2:10:2:10:wheel2357

spin           :: [Integer] -> Integer -> [Integer]
spin (x:xs) n  =  n : spin xs (n+x)

primes  :: [Integer]
primes  =  2:3:5:7: sieve (spin wheel2357 11)
{{< /highlight >}}

I use the primes generator to find the prime factors of an integer.

{{< highlight haskell >}}
primeFactors    :: Integer -> [Integer]
primeFactors n  =  factors n primes
    where
      factors 1 _                   =  []
      factors m (p:ps) | m < p*p    =  [m]
                       | r == 0     =  p : factors q (p:ps)
                       | otherwise  =  factors m ps
                       where (q,r)  =  quotRem m p
{{< /highlight >}}

And, finally, the solution:

{{< highlight haskell >}}
solution = last $ primeFactors 600851475143
{{< /highlight >}}

You can find the Literate Haskell code on [GitHub](https://github.com/maurotrb/mt-euler)
and on [Bitbucket](https://bitbucket.org/maurotrb/mt-euler).
