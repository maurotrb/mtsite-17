+++
title      = "My Personal Site in Octopress"
date       = "2012-04-05T23:32:00+02:00"
type       = "article"
tags       = [ "Programming", "Web", "Ruby", "Octopress" ]
+++

Some days ago I published this web site. Now I want to share
some information on why and how I made it.

<!--more-->
## Why I made it
I want to use a personal web site as:

* a "hub" for my social web presence
* a place to share and comment news and articles I find on the web,
  books that I'm reading, etc.
* a place to share my personal projects and study efforts (mainly on
  software and programming)
* a place where I'm forced to write in English, to improve my knowledge
  of the language (English is not my native tongue)

## How I made it
Thinking about the requisites for the site, I decided that I wanted
a web site with a simple structure, with a low update frequency,
and that could be hosted without spending much.

I concluded that the best choice would have been a static site generator.
Moreover, I could have fun learning how to use one.

I searched and evaluated some generators and I finally chose [Octopress](http://octopress.org).
The main reason? Its simplicity.

> Octopress is a framework designed by Brandon Mathis for Jekyll, the blog aware static site generator powering Github Pages. To start blogging with Jekyll, you have to write your own HTML templates, CSS, Javascripts and set up your configuration. But with Octopress All of that is already taken care of. Simply clone or fork Octopress, install dependencies and the theme, and you’re set.

With Octopress, following its excellent documentation and only by modifying
its configuration file, it's easy to create a blog with a mobile first
responsive layout and connected to the top social networking sites
(Twitter, Google Plus, etc.). And if you want to customize Octopress,
you can go a long way with only a basic knowledge of ruby, html and css.

As an example, here it is a short list of the customizations I made:

* moved blog posts in a subsection and created an "about me"
  page for the home
* changed fonts and colors
* modified twitter plug-in to add my retweet
* added bitbucket support thanks to
  [c0der78](https://github.com/c0der78/Octopress-Bitbucket-Aside)

If you want the details, you can find the source code of this site on
[GitHub](https://github.com/maurotrb/mtsite) and on
[Bitbucket](https://bitbucket.org/maurotrb/mtsite).

## I recommend Octopress
If you are searching for a static web site generator that it's simple,
but very customizable, Octopress is a valid alternative.
