+++
title      = "Personal backup strategy"
date       = "2013-02-08T00:01:00+01:00"
type       = "article"
tags       = [ "Programming", "Git", "Unison", "mr", "Robocopy", "TrueCrypt", "Backup" ]
slug       = "personal-backup-strategy"
+++

## The problem
I use a Windows desktop at work, another one at home, and a Linux laptop during commuting.
The laptop is for personal projects and the home desktop is for photo management and retouching.
Many of the files are shared, so I have to synchronize them among computers.
Moreover I want to have an up-to-date copy of the files in my home NAS,
from where I can make a backup.

<!--more-->
I started some years ago with a manual solution: moving files among computers
using a USB disk. But it was easy to overlook something or to overwrite files
with older versions.

So I searched for a better method.

By reading articles and blog posts, I evolved my requirements from a simple safe
copy to a complete synchronization and backup strategy, and I tried to develop
a more robust and automated solution.

## The requirements
To sum up the requirements, it must be possible to:

* view which files are changed on a computer and easily synchronize them
  with other computers
* configure the synchronization to specify which files must be synchronized
  and which not
* synchronize an up-to-date copy of all important files to a centralized
  location from where I can make a backup
* easily backup and restore files maintaining multiple verified copies
* use the the same procedures on Windows and Linux (where possible, see later)

These requirements are based on two core concepts:

* __synchronization and backup must be easy__: if they weren't easy,
  I won't do it that often, loosing many of the benefits of such a strategy
* __synchronization and backup are distinct tasks__: synchronization is about
  availability, backup is about insurance; maybe they can use the same tools,
  but treating them separately could help to devise a better overall strategy

## The solution (for now)

### Synchronization
The synchronization strategy is based on treating differently text files and
binary files.

Software projects, Linux dot files, Emacs configuration, text documents and notes
are all maintained in several git repositories and synchronized through a combination
of private and public Bitbucket projects. Open source projects are synchronized even
on Github.
I use [mr][] to clone and combine these repositories into my home directory.
With `mr update`, `mr status` and `mr push` I can easily manage and synchronize the
home directories of my Linux and Windows (Cygwin) systems.

Office documents, pdf files, and images are synchronized among computers using my
home NAS as a "hub". The synchronization is made with [Unison][] on Linux and with
[Allway Sync][aws] on Windows. I chose different tools because Allway Sync is more
efficient on Windows, especially if you consider that from the home
desktop I synchronize my photographic archive of more than 100 GB.

This strategy has some important limitations:

* I can synchronize text files everywhere there is an Internet connection,
  but I can synchronize binary files only at home; for me this is not
  a problem as binary files are mainly for reference and so I don't need to
  update them so often
* the system works better if you use more text file than binary files
  (see the previous point); I slowly changed my habit by switching
  from Office documents to text files, but I have no regret because I learned
  [Emacs][] and its terrific [Org mode][orgmode]

If you need to work on multiple systems and you can stand those limitations,
you will gain in flexibility and speed.

### Backup
The backup strategy is based on my home NAS, where I have two file groups:

* __irreplaceables__: if I loose these files I can't reproduce them anymore; they
  are, for the most part, the files synchronized among computers and to the
  NAS itself: projects, documents, notes, photos
* __replaceables__: if I loose these files I can reproduce them again (for example
  a copy of a photo exported in a particular format, that I can reproduce from
  the original); they are partly synchronized among computers and partly only
  present on NAS

Replaceable files are mirrored to an USB disk (500 GB) that I keep at home.

Irreplaceable files are mirrored to two USB disks (500 GB), that I rotate weekly
among home and workplace. The disks are encrypted with [TrueCrypt][], and the
copy is verified with MD5 hashes using [HaskDeep][].
So if something very bad happen, and I loose the data synchronized on all my computers
and on NAS, I have a safe copy that could be at worst one week old.

The mirroring is made on the Windows desktop using [Robocopy][].

## Reference
You can find many articles and blog posts on synchronization and backup.
For me, the most useful have been:

* [Subverting your homedir, or keeping your life in svn](http://joeyh.name/svnhome/)
* [Home Directory Synchronization](http://tratt.net/laurie/tech_articles/articles/home_directory_synchronization)
* [A basic non-cloud-based personal backup strategy](http://www.hanselman.com/blog/ABasicNoncloudbasedPersonalBackupStrategy.aspx)

[mr]: http://joeyh.name/code/mr/ "mr"
[unison]: http://www.cis.upenn.edu/~bcpierce/unison/ "Unison"
[aws]: http://allwaysync.com/ "Allway Sync"
[emacs]: http://www.gnu.org/software/emacs/ "Emacs"
[orgmode]: http://orgmode.org/ "Org mode"
[truecrypt]: http://www.truecrypt.org/ "TrueCrypt"
[haskdeep]: https://github.com/maurotrb/haskdeep "haskdeep"
[robocopy]: http://en.wikipedia.org/wiki/Robocopy "Robocopy"
