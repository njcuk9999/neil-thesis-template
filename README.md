# neil-thesis-template

The manual can be viewed in pdf format by opening main.pdf or compiling main.tex (using the compile file) but is reproduced below for those who like read me files

## Table of contents

* [1 Credit for this template](#1-credit-for-this-template)
  * [1.1 File structure and contents](#1.1-file-structure-and-contents)
* [2 Installation and running code](#2-installation-and-running-code)
  * [2.1 The compiler](#2.1-the-compiler)
  * [2.2 Modifying your TeX path](#2.2-modifying-your-tex-path)
* [3 Some useful information](#3-some-useful-information)
  * [3.1 Using table commands](#3.1-using-table-commmands)
    * [3.1.1 The Input table command](#3.1.1-the-input-table-command)
    * [3.1.2 Landscape table](#3.1.2-landscape-table)
  * [3.2 Cartoon footnotes (for supervisors that get bored quickly)](#cartoon-footnotes)
  * [3.3 Indexing](#3.3-indexing)
  * [3.4 Using the glossary](#3.4-using-the-glossary)
  * [3.5 Using acknowledgement citations](#3.5-using-acknowledgement)
  * [3.6 Referencing figures, tables and sections](#3.6-referencing-figures-tables-and-sections)

## 1  Credit for this template
This template was not created by me (Neil Cook) though I added some functionality,
commands and a lot of the comments, including this “readme”. This template was
passed on to me by Dr. Federico Marocco and was originally created by Dr. Kieran
Forde (2007) and in various forms have been used by many of the astrophysics PhD
students at the University of Hertfordshire.

### 1.1 File structure and contents

The following should be found within the extracted directory.

```
./appendices/
    appendixA.tex       
    appendixB.tex
./chapters/
    ch_1.tex
    ch_2.tex
./figures/
    phd_comics_example.jpg
    phd_comics_example1.jpg
./footers/
    1.jpg
    2.jpg
    ...
    225.jpg
./latex_resources/
    /comment/    @package from CTAN.org@
    /glossary/   @package from CTAN.org@
    /mfirstuc/   @package from CTAN.org@
    /sidecap/    @package from CTAN.org@
    /tocloft/    @package from CTAN.org@
    makeindex
./preamble/
    Abstract.tex 
    acknowledgement_refs.tex 
    Acknowledgements.tex
    glossary.tex 
    newcommands.tex
    symbols.tex
    titlepage.tex
./referencing/
    article_names.tex
    astroads.bst
    Bibliography.bib 
./tables/
    ch1_table_example1.tex
    ch1_table_example2.tex
    ch1_table_example_landscape.tex
compile
main.pdf
main.tex
phd.cls
```

## 2 Installation and running code

### 2.1 The compiler

You will not be able to just run pdflatex or latex to compile this LaTeX document, thus you will need to run the compile file *./compile*

The compile file runs the following set of programs (defined below) in this specific order:

```
$LATEX "$rootPath"

$BIBTEX "$rootPath"

$MKGLOS "$rootPath"

$MKINDX "$rootPath"".idx"

$MKINDX -s "$rootPath"".ist" -t "$rootPath"".glg" 
           "$rootPath"".glo" -o "$rootPath"".gls"

$MKINDX -s "$rootPath"".ist" -t "$rootPath"".nlg" 
           "$rootPath"".not" -o "$rootPath"".ntn"

$LATEX "$rootPath"

$LATEX "$rootPath"

$MKINDX "$rootPath"".idx"

$MKINDX -s "$rootPath"".ist" -t "$rootPath"".glg" 
           "$rootPath"".glo" -o "$rootPath"".gls"

$MKINDX -s "$rootPath"".ist" -t "$rootPath"".nlg" 
           "$rootPath"".not" -o "$rootPath"".ntn"

$LATEX "$rootPath"
```

Before the first run you will need to edit some of the paths so that the compiler can use LATEX/BIBTEX/MKINDX/MKGLOS correctly (and open the file after running)

```
#!/bin/sh

### ============================================
### --->  You will need to change this stuff to 
          compile the document
### ============================================
### --->  Commands  <--- ###
LATEX=/usr/bin/pdflatex
BIBTEX=/usr/bin/bibtex
OPEN="/usr/bin/okular --unique "
### --->  Users Files  <--- ###
rootDoc=./
rootPath=main

### =============================================
### --->  _Don't_ change anything past here  
### =============================================
```

When you open *./compile* these are the only lines that may need changing. *LATEX* is the path to pdflatex or latex. To find out where this should be pointing type

```
which pdflatex
```

into a terminal. This is the same for *BIBTEX* (but with bibtex instead of pdflatex). *OPEN* defines the way to open a pdf. I use okular but you can just use 
``gnome-open`` 
instead of 
```/usr/bin/okular} --unique``` 
to open with the gnome default pdf program.

*NOTE: after compiling all temp files are moved to a `trash' folder located at ./trash/, this can be turned off (or made optional) by editing the end of the compile file.*


### 2.2 Modifying you TeX path

For this installation to work you will need to make sure LaTeX can see the *./latex_resources/* folder (or that that contents of *./latex_resources/* is copied to the LaTeX path).

This can be done by adding the *PATH/latex_resources/* to the *TEXINPUTS* and *TEXMFHOME* environment paths i.e. using tcsh in the *~/.login* one could add:

```
setenv TEXINPUTS .:{PATH TO DIR}/latex_resources/
                  :/usr/share/texmf/tex/latex//

setenv TEXMFHOME {PATH TO DIR}/latex_resources//

```

* WARNING: If TEXINPUTS and TEXMFHOME exist before using the previous two commands will override your current paths. So please check the paths before replacing them (i.e. using printenv TEXINPUTS in tsch) and then if they exist using:

```
setenv TEXMFHOME {PATH TO DIR}/latex_resources//:{$TEXMFHOME}
```

## 3 Some useful information

### 3.1 Using table commands

#### 3.1.1 The Input table command

These commands are an alternate way to add a table to your \LaTeX file (One could use the *input* command as well). The basic form of this command requires a reference (which also doubles as the file name) and a caption. i.e. the table *ch1\_table\_example1* acts both as the reference to call with the *ref* function and as the file name containing (thus tables must be placed in *./tables/* i.e. *./tables/ch1\_table\_example1.tex*). A variant of this is the _inputtableS_ which allows a short caption as well as the full caption (for the list of tables, and is equivalent to using the square brackets in caption). See Table 1.1 and Table 1.2 in the manual for example tables.

```
@\inputtable@{ref}{full caption}
@\inputtableS@{ref}{short caption}{full caption}
```

The content of the .tex file is a tabular environment i.e.:

```
\begin{tabular}{ccc}
    \hline
    Object & M & $\sigma_{M}$ \\
    \hline
    A132 & 9.06e-01 & 9.52e-01 \\
    \hline
\end{tabular}
```

#### 3.1.2 Landscape table

*inputtable* also works in landscape (as see below), this landscape command also works with native LaTeX table environments.

```
@\begin@{landscape}
@\inputtable@{reference and filename}{full caption}
@\end@{landscape}
```



