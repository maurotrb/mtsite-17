+++
title      = "Trying out Shake library"
date       = "2012-05-18T00:02:00+02:00"
type       = "article"
tags       = [ "Programming", "Haskell" ]
slug       = "trying-out-shake-library"
+++

I had a little repetitive task to automate in my
[mt-euler](https://github.com/maurotrb/mt-euler) project:
creating a pdf from a series of Literate Haskell files
using `lhs2TeX` and `xelatex`.

Looking for something like make or rake, but written in Haskell,
I found [Shake](http://hackage.haskell.org/package/shake).

I used it and I was well pleased with the result.

<!--more-->
## A little task to automate
A few months ago I decided to solve some of the [Project Euler](http://projecteuler.net)
problems using Haskell language.

Since I wanted to write Haskell code and explanation together, I chose to write
in Literate Haskell with LaTeX style.

I structured the project with a main file `hs-euler.lhs`, that contains the LaTeX
preamble and the document structure, and a series of problem specific `lhs` files
included in the main file: `hs-euler-001.lhs`, `hs-euler-002.lhs`, ...

So I could easily create a nicely formatted pdf file using a sequence of `lhs2TeX`
and `xelatex` commands (I use XeTeX). But invoking those command repeatedly and
in the right sequence is a tedious and error-prone process. This task was
a perfect candidate for some sort of automation.

I was looking for something like make or rake, but written in Haskell, and I found
[Shake](http://hackage.haskell.org/package/shake).

## Using Shake library
Shake library is well described by its creator
[Neil Mitchell](http://neilmitchell.blogspot.it/):

> Shake is a Haskell library for writing build systems - designed as a replacement for make. To use Shake the user writes a Haskell program that imports the Shake library, defines some build rules, and calls shake. Thanks to do notation and infix operators, a simple Shake program is not too dissimilar from a simple Makefile. However, as build systems get more complex, Shake is able to take advantage of the excellent abstraction facilities offered by Haskell and easily support much larger projects.

After reading the documentation, looking at the source code and
searching on the web, I came out with the following build file.

{{< highlight haskell >}}
import Development.Shake
import Development.Shake.FilePath

main = shake shakeOptions $ do
         want ["hs-euler.pdf"]
         "*.pdf" *> \out -> do
           let tex = replaceExtension out "tex"
           need [tex]
           system' "xelatex" [tex]
           system' "xelatex" [tex]
         "*.tex" *> \out -> do
           let lhs = replaceExtension out "lhs"
           incl_lhs <- getDirectoryFiles "." $ dropExtension out ++ "-*.lhs"
           need $ lhs : incl_lhs
           system' "lhs2TeX" $ ["-o",out,lhs]
{{< /highlight >}}

Here are some notes:

* the `want` rule specifies `hs-euler.pdf` as the target file
* the two `*>` rules specify how to create pdf and tex files using `lhs2TeX` and `xelatex`
* the dependencies are specified using the `need` rule

The chain of dependencies could be visualized like this:
`want hs-euler.pdf → need hs-euler.tex → need [hs-euler.lhs, hs-euler-001.lhs, ...]`

When you first execute the build program with `runhaskell make.hs`,
Shake builds `hs-euler.pdf` and create the `.shake.database` file where
it saves dependencies information.
In the subsequent executions, Shake uses the information in this file
to check if some of the dependencies are changed, and eventually
it triggers a new build.

## Final thoughts
I was well pleased to use Shake for my automation problem.
The resulting build file is short and clear, and it makes its jobs well.

But there are some caveats.

I had only a little task to automate and so I haven't used the advanced
capabilities of Shake.

I used Shake to build documentation, not executables. If you have to
build Haskell libraries or executables, please take note of what Neil
Mitchell has to say:

> If ghc --make or cabal is capable of building your project, use that instead. Custom build systems are necessary for many complex projects, but many projects are not complex.

So if think that Haskell's standard build tools are not enough
for your project, or if you have to automate some other kind of task,
I think you should give Shake a try.

You can find the Literate Haskell code of mt-euler on
[GitHub](https://github.com/maurotrb/mt-euler) and on
[Bitbucket](https://bitbucket.org/maurotrb/mt-euler).
