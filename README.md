Essay Helper | <a href="https://github.com/luciangreen/Text-to-Breasonings">Text-to-Breasonings (Helps Earn High Distinctions)</a> | <a href="https://github.com/luciangreen/Algorithm-Writer-with-Lists">Grammar Logic (Helps Mind Map Details)</a>

# Essay Helper

* Uses KNN to help write essays.  Asks for 5 paragraphs of N reasons per paragraph of exposition and critique.  Has a positivity detector (must be positive in whole essay apart from either only positive or negative in critique comments).  Uses K-Nearest-Neighbour algorithm to check quotes, comments and connections are relevant.
* You should use a word frequency tool to find viable keywords.  You may need to redraft after reading to find better keywords.
* Think of the "number one way of thinking" before running any mind reading algorithm for more understandable results.

* short_essay_helper.pl - the Essay Helper algorithm
* distances.pl - the KNN algorithm
* file.txt - the essay to write the essay on
* walk_through.txt - example walkthrough of the algorithm (no output)
* short_essay_helper2.pl - the Essay Helper without paraphrasing checking, and outputs an HTML essay with ordered bibliography.
* source_tagger.pl - Helps tag and report tags similarly to nVivo.

# Getting Started

Please read the following instructions on how to install the project on your computer for helping write essays.

# Prerequisites

* Please download and install SWI-Prolog for your machine at `https://www.swi-prolog.org/build/`.

# 1. Install manually

Download <a href="http://github.com/luciangreen/Essay-Helper/">this repository</a>, <a href="http://github.com/luciangreen/listprologinterpreter/">List Prolog Interpreter Repository</a>, and <a href="https://github.com/luciangreen/mindreader">Mind Reader Repository</a>.

# 2. Or Install from List Prolog Package Manager (LPPM)

* Download the <a href="https://github.com/luciangreen/List-Prolog-Package-Manager">LPPM Repository</a>:

```
git clone https://github.com/luciangreen/List-Prolog-Package-Manager.git
cd List-Prolog-Package-Manager
swipl
['lppm'].
lppm_install("luciangreen","Essay-Helper").
halt
```

# Running Essay Helper

* In Shell:
`cd Essay-Helper`
`swipl`

* Load with `['short_essay_helper.pl'].`
* In swipl, run with: 
```
short_essay_helper("file.txt",5).
```
about essay "file.txt" for 5 reasons per paragraph.

* To change the number of paragraphs in the exposition of the essay, edit `5` in
```
length(List1,5), %% 5->1 paragraphs per exposition
```
in the correct Essay Helper algorithm file.

* To change the number of paragraphs in the critique of the essay, edit `5` in
```
length(List1,5), %% 5->1 paragraphs per critique
```
in the correct Essay Helper algorithm file.

* See <a href="https://github.com/luciangreen/Essay-Helper/blob/master/walk_through.txt">walk-through</a> as an example of Essay Helper.

# Installing and Running Essay Helper 2

* Essay Helper 2 outputs the essay and the essay in HTML form, with ordered references and argument traversed depth first.
* Install by downloading the prerequisites above and saving in folders next to each other or by using LPPM above.
* Run `swipl`
* Load with `['short_essay_helper2.pl'].`

* In swipl, run with: 
```
short_essay_helper("Author's Heading",5).
```
with heading of the essay, "Author's Heading" and 5 reasons per paragraph.


* See <a href="https://github.com/luciangreen/Essay-Helper/blob/master/walk_through2.txt">walk-through2</a>, <a href="https://htmlpreview.github.io/?https://github.com/luciangreen/Essay-Helper/blob/master/walk_through2.html">walk_through2.html</a> and <a href="https://github.com/luciangreen/Essay-Helper/blob/master/walk_through2-output.txt">walk_through2-output.txt</a> as examples of Essay Helper 2.

# Installing and Running Source Tagger

* Source Tagger tags quotes and sources with multiple tags and reports the quotes and sources for a particular tag.
* Install by downloading the prerequisites above and saving in folders next to each other or by using LPPM above.
* For a new set of tags, create a new tags.txt file in the directory containing `[]`.
* Run `swipl`

* Load with `['short_essay_helper3.1_chicago.pl'].`
`['source_tagger.pl'].`
* Run with `source_tagger.`
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

# Details for Marks and Meeting Requirements

* <a href="https://github.com/luciangreen/Text-to-Breasonings">Text to Breasonings</a> is required to breason out essays for high distinctions.
* <a href="https://github.com/luciangreen/Algorithm-Writer-with-Lists">Grammar and Logic to Algorithm, in the Algorithm Writer with Lists Repository</a> is needed to generate 30 As=2400 words in Honours from hand-written 80 philosophy breasonings (100 As in Master=8000 words, 400 As in PhD=32000 words).
* <a href="https://github.com/luciangreen/Philosophy">Phil2Alg, in the Philosophy Repository</a> is needed to generate details (20 words per sentence in an Honours thesis, 30 in Master in 50 in PhD) before using Grammar and Logic to Algorithm.



# Authors

Lucian Green - Initial programmer - <a href="https://www.lucianacademy.com/">Lucian Academy</a>

# License

I licensed this project under the BSD3 License - see the <a href="LICENSE">LICENSE.md</a> file for details



