\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{songsbook}



\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}} % je to knižka
\ProcessOptions
\LoadClass[11pt]{book}   %book
\@ifundefined{UseOption}{\def\UseOption{web}}{} %zaital nenastavné 
\RequirePackage{amsfonts,amsmath,amssymb,graphicx,color}
\RequirePackage{fancyhdr}
\linespread{1.3}
\RequirePackage{graphicx}
\RequirePackage[xetex,
  setpagesize=false,
  linkcolor=black,
  anchorcolor=black,
  citecolor=black,
  filecolor=black,
  urlcolor=black,
  bookmarks=true,
  bookmarksdepth=subsection,
]{hyperref}
\RequirePackage{optional}
\RequirePackage{amssymb} 
\RequirePackage[no-math]{fontspec}
\RequirePackage{xltxtra}
\RequirePackage{pgffor}
\RequirePackage{lastpage}
\UndeclareUTFcharacter[\UTFencname]{x2026}{\textellipsis} % we want normal 
\opt{print}{\hypersetup{colorlinks=false}}
\RequirePackage[version=3]{mhchem} % možno sa zíde 
\RequirePackage{xkeyval}
\RequirePackage{etoolbox} %na sadzanie autorov


\newfontfamily\cyrillicfont[Ligatures=TeX, % recommended
ItalicFont=[cmunti.ttf],
BoldFont=[cmunbx.ttf],
BoldItalicFont=[cmunbi.ttf],
SlantedFont=[cmunsl.ttf]
]{[cmunrm.ttf]}
\RequirePackage{polyglossia}
\setdefaultlanguage{czech}


\RequirePackage{chords}
\RequirePackage{songbook_authors}


\pagestyle{plain}
\RequirePackage{fkssugar} % hlavne na MFF
\setcounter{secnumdepth}{-2} %číslovanie sekcí
\sffamily
\RequirePackage[includeheadfoot,
  twoside,
  a5paper,
  hmargin=1.55cm,  
  vmargin=1.0cm,
  headsep=0.5cm]{geometry}


\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhead{}
\fancyhead[OR]{}
\fancyfoot{}
\fancyfoot[EL]{\bfseries \thepage}
\fancyfoot[OR]{\bfseries \thepage}
\fancyhead[EL]{Výfučí táborový zpěvník}%}



\hypersetup{
    pdftitle={Vyfučí táborový zpěvník},
    pdfauthor={Mišo},
}

\newif\ifsongbook
\songbooktrue


\sffamily


%---------------------------------------------
%      sadzba sekcí spevníku
%---------------------------------------------



%obsah
\newcommand{\obsah}[0]{
{\small\renewcommand{\contentsname}{{\ndp{Obsah}}}\tableofcontents}
}
		%\includegraphics[width=23mm]{plazma.eps}\hspace{20pt}\raisebox{0.6cm}




%predefinovanie kapitol 
\renewcommand\chapter{\@startsection {chapter}{-1}{\z@}%
{-3.5ex \@plus -1ex \@minus -.2ex}%
{3.5ex \@plus.2ex}%
{\normalfont\sffamily\slshape\Huge}}%

%predmluva
\newcommand{\predmluva}[0]{
	{\footnotesize
		\fancyhead[OR]{Predmluva}
		\chapter[Predmluva]{\ndp{Predmluva}}
		\rmfamily
		\input{pages/predmluva.tex}
	}\sffamily
}%

% preddefinovanie CZ SK not SK or CZ
\newcommand{\ceskeP}[0]{
	\fancyhead[OR]{České piesne}
	\chapter[České piesne]{\ndp{České piesne}}
	\rmfamily
		\input{pages/ceske_piesne.tex}
	\sffamily
}

\newcommand{\sloveP}[0]{
	\fancyhead[OR]{Slovenské piesne}
	\chapter[České piesne]{\ndp{České piesne}}
	\rmfamily
		\input{pages/ceske_piesne.tex}
	\sffamily
}


\newcommand{\zahranicP}[0]{
	\fancyhead[OR]{Zahraničné piesne}
	\chapter[České piesne]{\ndp{České piesne}}
	\rmfamily
		\input{pages/ceske_piesne.tex}
	\sffamily
}

\newcommand{\koledyP}[0]{
	\fancyhead[OR]{Vianočné koledy}
	\chapter[České piesne]{\ndp{České piesne}}
	\rmfamily
		\input{pages/ceske_piesne.tex}
	\sffamily
}
% TODO dokončiť hore !!!


\newcommand{\CAT}[0]{}
\newcommand{\cat}[2]{\renewcommand{\CAT}[0]{#1}\section[#1]{\ndp{#1}}\intT{#2}}

\newcommand{\intT}[1]{
\input{interprets/#1.tex}
}


\newcommand\licence{
\footnotesize
Tenhle zpěvík vzniknul za pomoci korešpodenčného seminara Výfuk, jeho organizátov a studentov MFF UK.
\par
}



\newcommand\mffpress{\textsf{\textbf{MATFYZ}PRESS}}

