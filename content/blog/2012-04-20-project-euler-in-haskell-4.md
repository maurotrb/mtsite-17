+++
title      = "Project Euler in Haskell #4"
date       = "2012-04-20T13:47:00+02:00"
type       = "article"
tags       = [ "Programming", "Haskell", "Project Euler" ]
slug       = "project-euler-in-haskell-4"
+++

## Problem Description
[Link to Project Euler problem 4](http://projecteuler.net/problem=4)

A palindromic number reads the same both ways. The largest palindrome made
from the product of two 2-digit numbers is \\(9009=91\times99\\).

Find the largest palindrome made from the product of two 3-digit numbers.

__WARNING__
_Solution ahead. Don't read more if you want to enjoy the benefits of
Project Euler and you haven't already solved the problem._

<!--more-->
## Solution
First of all, we need a function to verify if a number is palindrome.
With `isPalindrome` we simply convert the number to a string and compare
the string with its reverse.

Note that this function applies not only to numbers but to types
that implements the `Show` typeclass.

{{< highlight haskell >}}
isPalindrome    :: Show a => a -> Bool
isPalindrome x  =  x' == reverse x' where x' = show x
{{< /highlight >}}

The simple solution to the problem uses Haskell list comprehension.
We enumerate all the products of two 3-digit numbers, filter the palindromes,
and extract the largest one.

{{< highlight haskell >}}
solution  :: Integer
solution  =  maximum  [x*y | x <- [100..999], y <- [100..999]
                      , isPalindrome (x*y)]
{{< /highlight >}}

We can improve this solution, noting that the combination of the same terms
is considered two times, e.g. `x=123,y=456` and `x=456,y=123`.
We can filter the potential palindromes to only include the products
where the first term is more than or equal to the second term.

{{< highlight haskell >}}
solution'  :: Integer
solution'  =  maximum  [x*y | x <- [100..999], y <- [100..999]
                       , x >= y
                       , isPalindrome (x*y)]
{{< /highlight >}}

Moreover, if we express the palindromes as a six terms multi-variable polynomial,
after some simplifications we find out that all the palindromes of 6-digit
are divisible by 11.

<div>
\[
\begin{align*}
P&=100000x+10000y+1000z+100z+10y+x\\
P&=100001x+10010y+1100z\\
P&=11(9091x+910y+100z)
\end{align*}
\]
</div>

We can filter the potential palindromes to only include the products
where at least one of the terms is divisible by 11.

{{< highlight haskell >}}
solution''  :: Integer
solution''  =  maximum  [x*y | x <- [100..999], y <- [100..999]
                        , x >= y
                        , x `mod` 11 == 0 || y `mod` 11 == 0
                        , isPalindrome (x*y)]
{{< /highlight >}}

But, if we want to find an efficient solution, we have to change method.
Counting downwards from 999, we can find the solution earlier.

The `euler4` function recurses on a list of decreasing numerical terms
and, with the current term fixed as the first term, executes an inner recursion
using the rest of the list as the source for second terms.
The resulting product is verified to find out if it is a palindrome.
The result of the inner recursion is compared with the candidate palindrome
to choose the largest one.

The `euler4` function uses two optimization techniques:

* it exits from the inner recursion when it finds the first palindrome:
given that the first term of the product is fixed, it could not find a larger
palindrome
* it exits from the outer recursion when the candidate palindrome is larger
than the square of the first term: given that the subsequent terms are smaller,
it could not find a larger palindrome

{{< highlight haskell >}}
euler4               :: (Ord a, Num a) => [a] -> a -> a
euler4 []         p  =  p
euler4 ns@(x:xs)  p  |  x*x < p    =  p
                     |  otherwise  =  euler4 xs $ max p $ maxPalindrome ns
                     where
                       maxPalindrome []        =  0
                       maxPalindrome (x':xs')  |  isPalindrome m  =  m
                                               |  otherwise       =  maxPalindrome xs'
                                               where
                                                 m = x * x'
{{< /highlight >}}

We find the solution calling `euler4` with a list from 999 to 100 and with 0 as
the candidate palindrome.

{{< highlight haskell >}}
solution'''  :: Integer
solution'''  =  euler4 [999,998..100] 0
{{< /highlight >}}

Note that `euler4` could be used to find the largest palindrome made from
the product of number with more than 3-digit, e.g. `euler4 [9999,9998..1000] 0`.

You can find the Literate Haskell code on [GitHub](https://github.com/maurotrb/mt-euler)
and on [Bitbucket](https://bitbucket.org/maurotrb/mt-euler).
