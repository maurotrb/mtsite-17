+++
title      = "Photography Portfolio Site: Initial Setup"
date       = "2014-06-27T15:55:23+02:00"
type       = "article"
tags       = [ "Programming", "Haskell", "Hakyll", "Foundation", "Photography" ]
slug       = "photography-portfolio-site-initial-setup"
+++

This is the second post about the photography portfolio website project.
If you want to find out more about the project, you could read the
[first post](/blog/2014/01/30/photography-portfolio-site-a-new-project/).
In this post I will explain the initial setup of the project, and the creation
of a bare home page for the site.

<!--more-->
## First things first: a new GitHub repository

I created a new [github repository](https://github.com/maurotrb/mtphotosite) to
host the project. In this and in the following posts about the project I will
refer to specific commits of this repository, so you can see the changeset
details.

## Managing a Haskell project: cabal and sandbox

I use [Hakyll](http://jaspervdj.be/hakyll/) to generate the static web site,
so I set up a proper Haskell project:

* creating a [cabalized project](http://www.haskell.org/haskellwiki/How_to_write_a_Haskell_program#Add_a_build_system)
  with `cabal init`, setting up Hakyll as a dependency, and creating a source
  file with an empty `Main` function
* creating a [sandbox](http://chromaticleaves.com/posts/cabal-sandbox-workflow.html)
  to work in a isolated environment with `cabal sandbox init`
* installing all the dependencies in the sandbox with `cabal install --only-dependencies`
* building the project with `cabal build` to check for errors: executing the program
  `./dist/build/mtphotosite/mtphotosite` gave no errors
* [freezing](http://blog.docmunch.com/blog/2013/haskell-version-freezing) libraries
  version with `cabal-constraints dist/setup-config > .cabal.config`
  (now with Cabal 1.20 you could use `cabal freeze`)

You can browse the [code](http://github.com/maurotrb/mtphotosite/tree/0a3c884ee0f3aaa2e801bdd4bb1d7349e8d82f4d)
or see the [commit](http://github.com/maurotrb/mtphotosite/commit/0a3c884ee0f3aaa2e801bdd4bb1d7349e8d82f4d)
made after these steps.

## Creating a Hakyll site with the default template

To test the initial set up, I created a Hakyll site with the default template
using `hakyll-init`. I changed the default directories in the configuration to
keep the root of the project less cluttered: `site-src` for the original files,
`site-pub` for the generated site, and `.hakyll-cache` for Hakyll temporary files.

After compiling with `cabal build`, I tested the site with `./dist/build/mtphotosite/mtphotosite watch`
and opened `http://localhost:8000` with the web browser. All worked!

You can browse the [code](http://github.com/maurotrb/mtphotosite/tree/5b2b7d25c2d1a95ad7ce3264012b65b8252dfd59)
or see the [commit](http://github.com/maurotrb/mtphotosite/commit/5b2b7d25c2d1a95ad7ce3264012b65b8252dfd59)
made after these steps.

## Using Zurb Foundation Sass version

To use [Zurb Foundation](http://foundation.zurb.com/) I had to integrate it with Hakyll.

At the time of this writing it is available Foundation 5. You can use the straight
CSS version of Foundation or the Sass version. The latter let you made more
customization and with Sass mixins you can use semantic HTML markup. I don't know
much about Sass, but I like the promised flexibility and I take this as an occasion
to learn more about it.

Unfortunately the Sass version of Foundation requires Ruby, Node.js, Grunt, Bower.
While I want to learn about Sass, I'm not very keen to learn about the Node.js
ecosystem to use a CSS framework. The only dependencies I could accept is with Ruby,
as I have it already installed for other projects. After some research in the
Foundation forum, I found out that there is a precompiled Sass version on
[Github](https://github.com/zurb/bower-foundation) that is updated frequently
and that has tags for every Foundation release.

I created a git submodule linked to this repository and fixed it to a specific
release tag.

To integrate Foundation with Hakyll, I [deleted](https://github.com/maurotrb/mtphotosite/commit/63865dc2e190955919d0a39892bb03968bd0bbe2)
the default template files and modified the Main file adding the
[compilation](https://github.com/maurotrb/mtphotosite/commit/f8cfc42b34c43922c45dac0bfaa883dddf2379d4)
of Sass files and the [copy](https://github.com/maurotrb/mtphotosite/commit/7be089f76839bba69ad04f30492cebe10d35e710)
of Javascript files. To compile Sass files you have to install the Ruby Sass compiler.
I could probably remove this dependency switching to [libsass](http://libsass.org/).
As for the javascript files, I copy the minified version that contains all Foundation
functionality. I could combine and minify only the javascript related to the
functionalities I'm interested in, to reduce the file size.
Either of these optimization are interesting, but not essential in the first
phases of the project. I'll leave them for future implementations.

## Prototyping the home page

Finally I [created](https://github.com/maurotrb/mtphotosite/commit/77d4a6c84d291b701fbdd4c01c4433996510e5b9)
a prototype for the home page with a top bar, a footer and a grid with 12 squared images.
I created this page as a complete HTML file and then I
[converted](https://github.com/maurotrb/mtphotosite/commit/297fa792b30c7e9ecd82d42ec2d3b71453641b9b)
it in a Hakyll template page.

I tested the site with `./dist/build/mtphotosite/mtphotosite watch` and opened
`http://localhost:8000` with the web browser. All still worked!
