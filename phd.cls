%Changing the headings for Chapters to remove wasted space
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{phd}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

\ProcessOptions

\LoadClass{report}
%\RequirePackage[singlespacing]{setspace}

% Redefining the chapter heading styles

% Numbered chapter heading style:

\renewcommand{\@makechapterhead}[1]{%
  \vspace*{-\topskip}
  \vspace{3\p@}%  spacing before chapter title
  \vspace{-\parskip}
  {\parindent \z@ \raggedright \normalfont %sets text allignment to alligned right
 % {\parindent \z@ \ %set text allignment to justified
 	\vspace{-1cm}
    \ifnum \c@secnumdepth >\m@ne
    	\hrule
    	\vspace{0.2cm}
        \Huge\scshape \@chapapp\space \thechapter
 %       \par\nobreak
		 :\space
    \fi
    \interlinepenalty\@M
    \Huge  #1\par\nobreak
    \vspace{0.2cm}
    \hrule
%    \vspace{10pt}
    \vskip 40\p@
  }}

% Unnumbered chapter heading style: e.g. references, abstract, contents etc.
 
\renewcommand{\@makeschapterhead}[1]{%
  \vspace*{-\topskip}
  \vspace{3\p@}%  spacing before chapter title
  \vspace{-\parskip}
  {\parindent \z@ \raggedright
 %  	\vspace*{-3em}
  \normalfont
    \interlinepenalty\@M
    \Huge \bfseries  #1\par\nobreak
    \vskip 40\p@
  }}

\endinput
