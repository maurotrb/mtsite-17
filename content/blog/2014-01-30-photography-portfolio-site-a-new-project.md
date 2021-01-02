+++
title      = "Photography portfolio site: a new project"
date       = "2014-01-30T14:21:36+01:00"
type       = "article"
tags       = [ "Programming", "Haskell", "Hakyll", "Foundation", "Photography" ]
slug       = "photography-portfolio-site-a-new-project"
+++

I'm starting a new project to create a photography portfolio web site and I want to
document its progress in a series of posts. I'll write them for personal reference,
but I will be glad if they will be useful for someone else.

This first post is about the rationale for the project and the initial plan.

<!--more-->
## Why a photography portfolio site?
For me photography is an hobby. But I like to share my work and eventually
receive feedback on it. This sentiment is so common that the web is flooded
with images of any kind from photographers and non-photographers.

Sharing your photos has never been so easy. You can share for free on social
media (Facebook, Google+, Flickr, Instagram, etc.) or with a low entry price
with more professional solution (SmugMug, zenfolio, etc.).

But... there's no free lunch.

If you share on social media you agree to loose control on how and with which
other contents your photos are displayed (read advertising). They could change
the rules on short notice to better meet their business goals, and you could
not like the change. See for example the recent Flickr makeover. Some users
loved it, some others resented it.

There are no such problems if you share on professional sites, given their focus
on photographers' needs. But their entry offers is usually limited in space,
in number of photos, or in other features. If you want more you have to pay more.
While this makes sense for pros or semi-pros that earn income from their photos,
it could be a problem for most amateur photographers.

I used a few of these services and I will continue to use them for the visibility
that they could give to my photos.
But I want a stable base to show my photos as I see fit. A base that is relatively
cheap to create and to maintain and that doesn't change at someone else whim.

I think that the only long term solution is to have my own web site and my own domain.
(for an in-depth analysis on photographers and the web see
[Dan Heller's article](http://www.danheller.com/photo-biz.html)).

I could have started quickly with a WordPress installation and a specialized
theme or with some kind of site builder.
I decided instead to follow a DIY way: building a static web site. In this way
I can customize the site to my needs and I can start small (less initial cost)
evolving it gradually. It's challenging, but it could be fun and I will be able
to follow my geek and my artistic interests at the same time.

## How will I build it?
When you start a project where you haven't already a good knowledge of the
technology involved, it is better to make some initial choices, build something
to test those choices, change what doesn't work, repeat the process.
Here are my initial choices.

The site will be hosted on [NearlyFreeSpeech.NET](https://www.nearlyfreespeech.net/).
The site you are reading is hosted there and I never had a problem.
Moreover their pay as you go rates are perfect for my needs.

I will use [Hakyll](http://jaspervdj.be/hakyll/) as static site generator.
I want to better learn [Haskell](http://www.haskell.org/) and I think this is a
nice way. I hope it will be flexible enough to create a portfolio site.
[Octopress](http://octopress.org/), the static site generator that I use for this site,
is more oriented toward personal blog sites. In the ruby camp, I had probably chosen
[nanoc](http://nanoc.ws/).

I want to design a mobile first site, but I'm not much into CSS. So I will use
a CSS framework and I chose [Foundation](http://foundation.zurb.com/).
I think it is an easy framework to use and its functionality to manage adaptive
images is interesting for a portfolio site.

## What are the next steps?
My plan is relatively simple. The first few steps of the project are:

* setup a basic project structure on github with Hakyll and Foundation configured to generate a bare site (only home page)
* prototype the web site with the main pages and navigation but without real photos
* choose some sample photos from my archives and add them to the prototype

At this point I hope to have clear picture of where to go with the project and
if my initial choices are valid.
