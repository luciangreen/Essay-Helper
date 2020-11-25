# Essay Helper

* Essay Helper may not be necessary because it may need a sub-keyword (i.e. not necessarily the topic or a subject keyword), such as "science".  Also, the best sentences with the keyword may need to be hand-chosen and comments selected from just after the quote, or in one case, two sentences before the quote.

Uses KNN to help write essays.  Asks for 5 paragraphs of N reasons per paragraph of exposition and critique.  Has a positivity detector (must be positive in whole essay apart from either only positive or negative in critique comments).  Uses K-Nearest-Neighbour algorithm to check quotes, comments and connections are relevant.

* short_essay_helper.pl - the Essay Helper algorithm
* distances.pl - the KNN algorithm
* file.txt - the essay to write the essay on
* walk_through.txt - example walkthrough of the algorithm (no output)
* short_essay_helper2.pl - the Essay Helper without paraphrasing checking, and outputs an HTML essay with ordered bibliography.
* short_essay_helper3.pl - the Essay Helper generates random essays from a number of sources without paraphrasing checking, and outputs an HTML essay with ordered bibliography.
* short_essay_helper3.1_agps.pl - Like Essay Helper 3, but finds sentences containing any keywords given.
* short_essay_helper3.1_agps-mr.pl - same as short_essay_helper3.1.pl but uses mind reader.  It wasn't working last time.
* short_essay_helper3.1_chicago.pl - same as short_essay_helper3.1_agps.pl, but in Chicago style (with Ibid).
* source_tagger.pl - Helps tag and report tags similarly to nVivo.
* short_essay_helper3.1_agps-mr-tree.pl - same as short_essay_helper3.1.pl but uses mind reader.  It wasn't working last time.

# Getting Started

Please read the following instructions on how to install the project on your computer for helping write essays.

# Prerequisites

* Install <a href="https://www.swi-prolog.org/build/">SWI-Prolog</a> for your machine.

* Install List Prolog Interpreter Repository (https://github.com/luciangreen/listprologinterpreter).

* Install Mind Reader Repository (https://github.com/luciangreen/mindreader).

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
* In the sources folder, place text file for the essay sources with the names "*.txt", etc., and "\n\n" between pages.
* Use BBEdit to replace `"`,`“`,`”`,`’` and `‘` with `'`, `- ` with nothing, `\n\n` with `",\n\n"`, insert `["*","*",1,"` (see next point) at start, `"]` at end and replace `\\` with nothing in all `/sources/*` files, copied from `/raw_sources/*`.
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

* See <a href="https://github.com/luciangreen/Essay-Helper/blob/master/walk_through3.html">walk_through3.html</a> as an example of Essay Helper 3.




# Installing and Running Essay Helper 3.1 - Essay Generator with Relevance - AGPS Referencing - And Mind Reading

* Essay Helper 3 outputs the essay and the essay in HTML form, with ordered references and argument traversed depth first, with key words, any of which to search for in each sentence.  Chooses sources, pages and quotes in order (or vaguely mind read in random order).  Quotes are not repeated.
* Note: Generated essays are not to be handed in, and you need to paraphrase and cite work you have referenced.  Your grade depends on whether you agree or disagree and how many breasonings you breason out.  Check the referencing style is appropriate for your class (this algorithm uses AGPS style).
* Install by downloading the prerequisites above and saving in folders next to each other or by using LPPM above.
* Run swipl

* Load with ['short_essay_helper3.1_agps.pl']. or ['short_essay_helper3.1_agps-mr.pl'] (['short_essay_helper3.1_agps-mr-tree.pl'] - mind reads character by character). for mind reading mode (*short_essay_helper3.1_agps-mr-tree.pl is very slow.* It detects vague, not exact thoughts. Before running texttobr (in mind reader), think of two radio buttons put on recordings, put through with prayer, nut and bolt, quantum box prayer 1, 1, 0.5 cm and 1, 1, 0.5 cm.  Follow instructions in <a href="https://github.com/luciangreen/mindreader/blob/master/init.txt">Instructions for initialising Mind Reader</a> and <a href="https://github.com/luciangreen/Text-to-Breasonings/blob/master/Instructions_for_Using_texttobr(2).pl.txt">Instructions for Using texttobr(2)</a> when using texttobr, texttobr2 or mind reader to avoid medical problems.).
* In the sources folder, place text file for the essay sources with the names "*.txt", etc., and "\n\n" between pages.
* Use BBEdit to replace `"`,`“`,`”`,`’` and `‘` with `'`, `- ` with nothing, `\n\n` with `",\n\n"`, insert `["*","*",1,"` (see next point) at start, `"]` at end and replace `\\` with nothing in all `/sources/*` files, copied from `/raw_sources/*`.
* Check the new source files in the sources folder are in the format:
```
["Surname, A 2000, <i>Title: Subtitle</i>, Publisher, City.","Surname, A 2000",1,"<first page>","<second page>",...]
```
* (Insert the first item, the reference for the source, in the required referencing style in double quotes, inert the part of the in-text reference as the second item, insert the first page number of the paper from the book as the third item and check the pages are separated in double quotes as above.  You should remove headers, etc. from each page so that they are not used in the essay.  For this version, move ends of sentences over pages onto the first page.)
* In swipl, run with:
```
short_essay_helper("Author's Heading",["critical","evaluation"],5).
```
with heading of the essay, "Author's Heading", keywords "critical" and "evaluation" and 5 reasons per paragraph.

* See <a href="https://github.com/luciangreen/Essay-Helper/blob/master/walk_through3.1.html">walk_through3.1.html</a> as an example of Essay Helper 3.1.


# Installing and Running Essay Helper 3.1 - Essay Generator with Relevance - Chicago Style

* Essay Helper 3 outputs the essay and the essay in HTML form, with ordered endnotes and references and argument traversed depth first, with key words, any of which to search for in each sentence.  Chooses sources, pages and quotes in order.  Quotes are not repeated.
* Note: Generated essays are not to be handed in, and you need to paraphrase and cite work you have referenced.  Your grade depends on whether you agree or disagree and how many breasonings you breason out.  Check the referencing style is appropriate for your class (this algorithm uses Chicago style).
* Install by downloading the prerequisites above and saving in folders next to each other or by using LPPM above.
* Run swipl

* Load with ['short_essay_helper3.1_chicago.pl'].
* In the sources folder, place text file for the essay sources with the names "*.txt", etc., and "\n\n" between pages.
* Use BBEdit to replace `"`,`“`,`”`,`’` and `‘` with `'`, `- ` with nothing, `\n\n` with `",\n\n"`, insert `["*","*",1,"` (see next point) at start, `"]` at end and replace `\\` with nothing in all `/sources/*` files, copied from `/raw_sources/*`.
* Check the new source files in the sources folder are in the format:
```
["Andrew Petersen, <i>The Fundamentals of Moral Philosophy</i>, 3rd ed. (London: Oxford, 2020)","Petersen, <i>The Fundamentals</i>",1,"<first page>","<second page>",...]
```	
* (Insert the first item, the reference for the source, in the required referencing style in double quotes, inert the part of the in-text reference as the second item, insert the first page number of the paper from the book as the third item and check the pages are separated in double quotes as above.  You should remove headers, etc. from each page so that they are not used in the essay.  For this version, move ends of sentences over pages onto the first page.)
* In swipl, run with:
```
short_essay_helper("Author's Heading",["critical","evaluation"],5).
```
with heading of the essay, "Author's Heading", keywords "critical" and "evaluation" and 5 reasons per paragraph.

# Installing and Running Source Tagger

* Source Tagger tags quotes and sources with multiple tags and reports the quotes and sources for a particular tag.
* Install by downloading the prerequisites above and saving in folders next to each other or by using LPPM above.
* For a new set of tags, create a new tags.txt file in the directory containing `[]`.
* Run swipl

* Load with ['short_essay_helper3.1_chicago.pl'].
['source_tagger.pl'].
* Run with source_tagger.
```
?- source_tagger.
New tag? (y/n)
|: y
What are the tags?
|: a
What is the text?
|: abc
What is the source?
|: ref abc
New tag? (y/n)
|: n
true.
```
* Enter the tags, text and source for each set of tags.

* Print the report of a tag with print_tags.
```
?- print_tags.
a
b
e
f
Enter tag to show report of.
|: a
c
d

z
p

abc
ref abc

true.
```

* Enter the tag name to print text and source for each tag with that name.

# Authors

Lucian Green - Initial programmer - <a href="https://www.lucianacademy.com/">Lucian Academy</a>

# License

I licensed this project under the BSD3 License - see the <a href="LICENSE">LICENSE.md</a> file for details



