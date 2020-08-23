# Essay Helper

Uses KNN to help write essays.  Asks for 5 paragraphs of N reasons per paragraph of exposition and critique.  Has a positivity detector (must be positive in whole essay apart from either only positive or negative in critique comments).  Uses K-Nearest-Neighbour algorithm to check quotes, comments and connections are relevant.

* short_essay_helper.pl - the Essay Helper algorithm
* distances.pl - the KNN algorithm
* file.txt - the essay to write the essay on
* walk_through.txt - example walkthrough of the algorithm (no output)
* short_essay_helper2.pl - the Essay Helper without paraphrasing checking, and outputs an HTML essay with ordered bibliography.

# Getting Started

Please read the following instructions on how to install the project on your computer for helping write essays.

# Prerequisites

* Install <a href="https://www.swi-prolog.org/build/">SWI-Prolog</a> for your machine.

Install List Prolog Interpreter Repository (https://github.com/luciangreen/listprologinterpreter).

# Installation from List Prolog Package Manager (LPPM)

* Optionally, you can install from LPPM by installing <a href="https://www.swi-prolog.org/build/">SWI-Prolog</a> for your machine, downloading the <a href="https://github.com/luciangreen/List-Prolog-Package-Manager">LPPM Repository</a>, loading LPPM with `['lppm'].` then installing the package by running `lppm_install("luciangreen","Essay-Helper").`.

# Installing and Running Essay Helper

* Install by downloading the prerequisites above and saving in folders next to each other or by using LPPM above.
* Run swipl
* In swipl, run with: 
```
short_essay_helper("file.txt",5).
```
about essay "file.txt" for 5 reasons per paragraph.

* See <a href="https://github.com/luciangreen/Essay-Helper/blob/master/walk_through.txt">walk-through</a> as an example of Essay Helper and <a href="https://github.com/luciangreen/Essay-Helper/blob/master/walk_through2.txt">walk-through2</a> and <a href="https://github.com/luciangreen/Essay-Helper/blob/master/walk_through.html">walk_through.html</a> as examples of Essay Helper 2.

# Authors

Lucian Green - Initial programmer - <a href="https://www.lucianacademy.com/">Lucian Academy</a>

# License

I licensed this project under the BSD3 License - see the <a href="LICENSE">LICENSE.md</a> file for details



