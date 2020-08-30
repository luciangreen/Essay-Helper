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
* Load with ['short_essay_helper.pl'].
* In swipl, run with: 
```
short_essay_helper("file.txt",5).
```
about essay "file.txt" for 5 reasons per paragraph.

* See <a href="https://github.com/luciangreen/Essay-Helper/blob/master/walk_through.txt">walk-through</a> as an example of Essay Helper.

# Installing and Running Essay Helper 2

* Essay Helper 2 outputs the essay and the essay in HTML form, with ordered references and argument traversed depth first.
* Install by downloading the prerequisites above and saving in folders next to each other or by using LPPM above.
* Run swipl
* Load with ['short_essay_helper2.pl'].

* In swipl, run with: 
```
short_essay_helper("Author's Heading",5).
```
with heading of the essay, "Author's Heading" and 5 reasons per paragraph.

* See <a href="https://github.com/luciangreen/Essay-Helper/blob/master/walk_through2.txt">walk-through2</a>, <a href="https://github.com/luciangreen/Essay-Helper/blob/master/walk_through2.html">walk_through2.html</a> and <a href="https://github.com/luciangreen/Essay-Helper/blob/master/walk_through2-output.txt">walk_through2-output.txt</a> as examples of Essay Helper 2.

# Installing and Running Essay Helper 3 - Random Essay Generator - AGPS Referencing

* Essay Helper 3 randomly outputs the essay and the essay in HTML form, with ordered references and argument traversed depth first.
* Note: Generated essays are not to be handed in, and you need to paraphrase and cite work you have referenced.  Your grade depends on whether you agree or disagree and how many breasonings you breason out.  Check the referencing style is appropriate for your class (this algorithm uses AGPS style).
* Install by downloading the prerequisites above and saving in folders next to each other or by using LPPM above.
* Run swipl

* Load with ['short_essay_helper3_agps.pl'].
* In the raw_sources folder, place text file for the essay sources with the names "*.txt", etc., and "\n\n" between pages.
* In swipl, run the sheet feeder, which prepares the sources for the algorithm, with: 
```
sheet_feeder(_).
```
* Check the new source files in the sources folder are in the format:
```
["Surname, A 2000, <i>Title: Subtitle</i>, Publisher, City.","Surname, A 2000",1,"<first page>","<second page>",...]
```
* (Insert the first item, the reference for the source, in the required referencing style in double quotes, inert the part of the in-text reference as the second item, insert the first page number of the paper from the book as the third item and check the pages are separated in double quotes as above.  You should remove headers, etc. from each page so that they are not used in the essay.  For this version, move ends of sentences over pages onto the first page.)
* In swipl, run with:
```
short_essay_helper("Author's Heading",5).
```
with heading of the essay, "Author's Heading" and 5 reasons per paragraph.

# Authors

Lucian Green - Initial programmer - <a href="https://www.lucianacademy.com/">Lucian Academy</a>

# License

I licensed this project under the BSD3 License - see the <a href="LICENSE">LICENSE.md</a> file for details



