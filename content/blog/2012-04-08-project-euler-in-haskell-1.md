+++
title      = "Project Euler in Haskell #1"
date       = "2012-04-08T22:48:00+02:00"
type       = "article"
tags       = [ "Programming", "Haskell", "Project Euler" ]
slug       = "project-euler-in-haskell-1"
+++

## Problem Description
[Link to Project Euler problem 1](http://projecteuler.net/problem=1)

If we list all the natural numbers below 10 that are multiples of 3 or 5,
we get 3, 5, 6 and 9. The sum of these multiples is 23.

Find the sum of all the multiples of 3 or 5 below 1000.

__WARNING__
_Solution ahead. Don't read more if you want to enjoy the benefits of
Project Euler and you haven't already solved the problem._

<!--more-->
## Solution
The simple way is to go through all numbers from 1 to 999 and test whether
they are divisible by 3 or by 5. In Haskell you could use list comprehension:

{{< highlight haskell >}}
solution  =  sum [n | n <- [1..999], n `mod` 3 == 0 || n `mod` 5 == 0]
{{< /highlight >}}

Reading the solution notes from the project's site, we can see that the solution
could even be expressed as:

{{< highlight haskell >}}
solution'  =  sum [n | n <- [1..999], n `mod` 3 == 0]  +
              sum [n | n <- [1..999], n `mod` 5 == 0]  -
              sum [n | n <- [1..999], n `mod` 15 == 0]
{{< /highlight >}}

Noting that:

<div>
\[
\begin{align}
3+6+9+12+15+\dots{}+999&=3\times(1+2+3+4+\dots{}+333)\\
5+10+15+\dots{}+995&=5\times(1+2+....+199)
\end{align}
\]
</div>

where \\(333=\frac{999}{3}\\) and \\(199=\frac{995}{5}\\) but also \\(\frac{999}{5}\\)
rounded down to the nearest integer.

And that from the expression for
[arithmetic series](http://en.wikipedia.org/w/index.php?title=Arithmetic_progression&oldid=485252595):

<div>
\[S_n=\frac{n}{2}(a_1+a_n)\]
</div>

we can derive that:

<div>
\[1+2+3+\dots{}+p=\frac{p}{2}(1+p)\]
</div>

We could write an efficient solution:

{{< highlight haskell >}}
target = 999

sumDivisibleBy n = n * p * (1 + p) `div` 2
    where
      p = target `div` n

solution'' = sumDivisibleBy 3 + sumDivisibleBy 5 - sumDivisibleBy 15
{{< /highlight >}}

You can find the Literate Haskell code on [GitHub](https://github.com/maurotrb/mt-euler)
and on [Bitbucket](https://bitbucket.org/maurotrb/mt-euler).
