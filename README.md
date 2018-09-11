# Introduction

This script is used for the static generation of the web site of EuroPython.
It supports EuroPython 2015, EuroPython 2016, EuroPython 2017

# Usage

By default, the makefile will work on ep2017, but we can override this behaviour
with the EUROPYTHON environment variable as the following example:

```
make EUROPYTHON=ep2015 clean_fonts
```

## Download the site

```
make download_site
```

This command will download the site in the directory called `ep2017.europython.eu`


## Download the talks

Because the schedule of the site uses an 'ajax' call to the web site for the
description of the talks, we have to download them from the site, for that we
will use a tool [pup](https://github.com/ericchiang/pup) for the parsing of the
schedule and use this result for a massive `wget` on the running site.

**Maybe we could extract the description of the talks with a Django command**

Once download, these description will be stored in the
`ep2017.europython.eu/conference/talks`.

## Clean the fonts

With `wget` when we download all the files from the site, it keeps the
query string and sometimes it's just useless, mainly for the fonts and the
static files. For that, we have a target in the makefile. This one will remove
the querystring, only for the fonts, but we could adapt it for the other static
files.

```
make clean_fonts
```

## Remove the links

```
make remove_login remove_signup remove_links
```
