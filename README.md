# Techunder Posts
This repository stores the Markdown source files for the Techunder posts, which are generated into static HTML with Hugo and published to [techunder.tech](https://techunder.tech).

## Copyright
All content in this repository is copyrighted by **Techunder (Guanhua Liu)**.  
© Techunder (Guanhua Liu) | All rights reserved | [https://techunder.tech](https://techunder.tech)

## About Techunder.tech
A tech blog focused on AI/CS paper reading, code reproduction, and software engineering tips. Follow for in-depth technical content and practical tutorials!

## How to Build
- Run `rm -rf themes/hugo-book/` to delete the hugo-book theme folder then `git submodule add -f https://github.com/alex-shpak/hugo-book.git themes/hugo-book` to add the hugo-book theme
- Run `hugo server -D -N` to debug the site.
- Run `hugo` to build the site to public/.
