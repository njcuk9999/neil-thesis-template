# neil-thesis-template

The manual can be viewed in pdf format by opening main.pdf or compiling main.tex (using the compile file) but is reproduced below for those who like read me files

## Table of contents

* [1 Credit for this template](#1-credit-for-this-template)
  * [1.1 File structure and contents](#11-file-structure-and-contents)
* [2 Installation and running code](#2-installation-and-running-code)
  * [2.1 The compiler](#21-the-compiler)
  * [2.2 Modifying your TeX path](#22-modifying-your-tex-path)
* [3 Some useful information](#3-some-useful-information)
  * [3.1 Using table commands](#31-using-table-commmands)
    * [3.1.1 The Input table command](#3.1.1-the-input-table-command)
    * [3.1.2 Landscape table](#312-landscape-table)
  * [3.2 Cartoon footnotes (for supervisors that get bored quickly)](#32-cartoon-footnotes-for-supervisors-that-get-bored-quickly)
  * [3.3 Indexing](#33-indexing)
  * [3.4 Using the glossary](#34-using-the-glossary)
  * [3.5 Using acknowledgement citations](#35-using-acknowledgement)
  * [3.6 Referencing figures, tables and sections](#36-referencing-figures-tables-and-sections)

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
    /comment/    package from CTAN.org
    /glossary/   package from CTAN.org
    /mfirstuc/   package from CTAN.org
    /sidecap/    package from CTAN.org
    /tocloft/    package from CTAN.org
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


### 2.2 Modifying your TeX path

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
\inputtable{ref}{full caption}
\inputtableS{ref}{short caption}{full caption}
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
\begin{landscape}
\inputtable{reference and filename}{full caption}
\end{landscape}
```

#### 3.1.3 Continued table

In addition one can add a continued table as two smaller tables using the *inputtableC* command, just call the table as normal (*inputtable*) for the first page and then add the second table using the *inputtableC*, this will use the numbering of the first table on the second (see Table 1.3 in the pdf for an example).

```
\begin{landscape}
\inputtable{reference and filename}{full caption}
\end{landscape}

\begin{landscape}
\inputtableC{reference and filename}{Continued table}
\end{landscape}
```
An example of these table commands can be seen in Table 1.3 in the pdf (note landscape tables start a new page at the location the command is used and may lead to white space. One can generally just put the table later to avoid this if it is unwanted).

### 3.2 Cartoon footnotes (for supervisors that get bored quickly)

I was asked by one supervisor to add a cartoon to the bottom of every page (to make it more *enjoyable* to read), a very strange request that may not be repeated but this is a pretty cool bit of LaTeX code. It requires a folder called *./footers* in which cartoons are stored as *.jpg* files with only a number (corresponding to the page number).

```
\fancyfoot[C]{\includegraphics[height=4cm]
               {./footers/\arabic{page}.jpg}}

\setlength{\textheight}{22.5cm}

\end{lstlisting}

These lines can just be commented out to remove this from the document as it increases the size of the footers substantially. \reffig{ch1_figure_example_of_side_by_side} Shows two examples of this document with the footers in place.

\begin{figure}
\begin{center}
\begin{minipage}{.49\textwidth}
\begin{center}
\includegraphics[width=\textwidth]{./figures/phd_comics_example.jpg}
\\(a)
\end{center}
\end{minipage}
\begin{minipage}{.49\textwidth}
\begin{center}
\includegraphics[width=\textwidth]{./footers/1.jpg}
\\(b)
\end{center}
\end{minipage}
\end{center}
\caption[Short title for the list of figures]{Example side by side figure (a) The cartoon footer in the page (b) the jpg file in the \protect\url{./footers} folder. \label{ch1_figure_example_of_side_by_side}}
\end{figure}

\vspace{1cm}
\noindent {\bf \textcolor{red}{NOTE: To turn off the cartoons (enabled by default) just comment out these lines in \url{./main.tex}.}}

\begin{lstlisting}[style=base]

\fancyfoot[C]{\includegraphics[height=4cm]
               {./footers/\arabic{page}.jpg}}

\setlength{\textheight}{22.5cm}

```

### 3.3 Indexing

There are multiple ways to use the indexing. I use two commands to save on space.

```
\define{key}
```

displays the word in the text and adds it to the index. Note that keys are case sensitive and thus will appear multiple times in the index (define also auto capitalises index words so normally I just use the lowercase in the text)

```
\defineas{word}{key}
```

displays *word* in the text and adds a different word to the key. An example of when this may be useful is the case where you need a capital word in the text or a word such as *\defineas{photometric}{photometry}* where you only wish to have *\define{photometry}* in the index.

```
\index{key}
```
puts the key in the index. This requires you to put the word in the text separately.

Examples of the use are below: 

```
The \define{star} was found by using the 
\defineas{photometric}{photometry} bands, 
this was useful to judge contamination 
\index{contamination}.
```

This adds the words *\define{star}*, *\define{photometry}* and *\define{contamination}* to the index (with a page reference to this page).

### 3.4 Using the glossary

I use a glossary to define terms such as *\acro{2MASS}*, *\acro{WISE}*, *\acro{NIR}* or *\acro{SNR}*.
These words will only appear in the glossary when one of the following commands is used:
```
\acro{key}
```
displays the word in the text, and adds the key to the glossary and the index.

```
\useglosentry{key}
```

adds the key only to the glossary only.

### 3.5 Using acknowledgement citations

This can be used in any LaTeX, document, basically reduces acknowledgements down in to citing the correct survey/telescope or word (acknowledgement terms are stored in *./preamble/acknowledgement_refs.tex*)

The can then be used anywhere (i.e. at the end of a chapter) using the following command: 

```
\acknowledge{key}
```

an example of this is as follows:

```
\acknowledge{2MASS}
\acknowledge{WISE}
```

And would produce the following text:

> This thesis makes use of data products from the Two Micron All Sky Survey(Skrutskie
> et al., 2006), which is a joint project of the University of Massachusetts and the Infrared
> Processing and Analysis Center/California Institute of Technology, funded by the Na-
> tional Aeronautics and Space Administration and the National Science Foundation.
> This thesis makes use of data products from the Wide-field Infrared Survey Ex-
> plorer(Wright et al., 2010), which is a joint project of the University of California, Los
> Angeles, and the Jet Propulsion Laboratory/California Institute of Technology, funded
> by the National Aeronautics and Space Administration.

Note you can change the word `thesis' for all acknowledgements at the top of the *./preamble/acknowledgement_refs.tex* file.

#### Adding new acknowledgements

New acknowledgements are set up similar to bibtex files. In \url{./preamble/acknowledgement_refs.tex} keys are set up as follows:

```
\pgfkeys{/APLpy/.code = {This \acknowledgetype made use of 
                               APLpy, an open-source plotting 
                               package for Python hosted at 
                               \url{http://aplpy.github.com}.}}
```

where * \acknowledgetype*  is set near the start of *./preamble/acknowledgement_refs.tex*

```
\newcommand{\acknowledgetype}{thesis\,\,}
```
editing the text in red in the above will change all acknowledgements to use this instead of thesis (see above).

### 3.6 Referencing Figures, Tables and Sections

These are short cuts to writing *Figure X*, *Table Y*, *Section Z* and are edited in the *./preamble/newcommands.tex*

##### These are defined for a figure:

```
\reffig{reference}
```

the above is an alias of:

```
Figure \ref{reference}
```

##### A table:

````
\reftab{reference}
````

the above is an alias of:

```
Table \ref{reference}
```

##### And a section:

```
\refsec{reference}
```

the above is an alias of:

```
Section \ref{reference}
```
    
These aliases can be changed in *./preamble/newcommands.tex*:

```
%referencing sections, figures, tables, equations
\newcommand{\reffig}[1]{Figure \ref{#1}}
\newcommand{\reftab}[1]{Table \ref{#1}}
\newcommand{\refequ}[1]{Equation \ref{#1}}
\newcommand{\refsec}[1]{Section \ref{#1}}
```

i.e. replacing Figure with Fig. will change every instance of reffig.

An example of each is shown below:

```
\reffig{ch1_figure_1} shows x against y 
(from \refsec{ch1_section_2}) and 
is also shown in \reftab{ch1_table_3}.
```

This would give the following text:

> Figure 1 shows x against y (from Section 1.2) and is also shown in Table 3.
