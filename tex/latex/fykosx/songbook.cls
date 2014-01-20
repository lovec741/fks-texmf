\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{songsbook}



\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions
\LoadClass[11pt]{book}
\@ifundefined{UseOption}{\def\UseOption{web}}{} % when no option set, we use web settings
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
\RequirePackage{optional} % ought be first
\RequirePackage{amssymb} 
\RequirePackage[no-math]{fontspec} % no-math is because of mathrm(Omega)
\RequirePackage{xltxtra} % includes xunicode, fontspec
\RequirePackage{pgffor}
\RequirePackage{lastpage}
\UndeclareUTFcharacter[\UTFencname]{x2026}{\textellipsis} % we want normal 
\opt{print}{\hypersetup{colorlinks=false}}
\RequirePackage[version=3]{mhchem}
\RequirePackage{xkeyval}
\RequirePackage{etoolbox}
\newfontfamily\cyrillicfont[Ligatures=TeX, % recommended
ItalicFont=[cmunti.ttf],
BoldFont=[cmunbx.ttf],
BoldItalicFont=[cmunbi.ttf],
SlantedFont=[cmunsl.ttf]
]{[cmunrm.ttf]}
\RequirePackage{polyglossia}
\setdefaultlanguage{czech}
\pagestyle{plain}
\RequirePackage{fkssugar}
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
\fancyhead[R]{}
\fancyfoot{}
\fancyfoot[EL]{\thepage}
\fancyfoot[OR]{\thepage}
\fancyhead[EL]{Výfučí táborový zpěvník}%}


\renewcommand\chapter{\@startsection {chapter}{-1}{\z@}%
  {-3.5ex \@plus -1ex \@minus -.2ex}%
  {3.5ex \@plus.2ex}%
  {\normalfont\sffamily\slshape\Huge}}
  \hypersetup{
    pdftitle={Vyfučí táborový zpěvník},
    pdfauthor={Mišo},
  }

\sffamily
%--------------------------------------------------------------
%      začiatok makier ako takých %% koniec deklarácie
%--------------------------------------------------------------

\newcommand\licence{
\footnotesize
Tenhle zpěvík vzniknul za pomoci korešpodenčného seminara Výfuk, jeho organizátov a studentov MFF UK.
\par
}



\newcommand\mffpress{\textsf{\textbf{MATFYZ}PRESS}}

%categoria teda o aké pesničky sa jedná (kapitola)
\newcommand{\CAT}[0]{}
\newcommand{\cat}[2]{\renewcommand{\CAT}[0]{#1}\section[#1]{\ndp{#1}}\intT{#2}}


%nadpis
\newcommand{\ndp}[1]{\textsl{\textmd{\textsf{#1}}}}

%obsah
\newcommand{\obsah}[0]{
{\small
\renewcommand{\contentsname}{
%\includegraphics[width=23mm]{plazma.eps}\hspace{20pt}\raisebox{0.6cm}
{\ndp{Obsah}}
}
\tableofcontents}
}

%predmluva
\newcommand{\predmluva}[0]{
{\footnotesize
\fancyhead[OR]{Predmluva}
\chapter[Predmluva]{\ndp{Predmluva}}
\rmfamily
\input{pages/predmluva.tex}
}\sffamily
}%

\newcommand{\ceskeP}[0]{
\fancyhead[OR]{České piesne}
\chapter[České piesne]{\ndp{České piesne}}
\rmfamily
\input{pages/ceske_piesne.tex}
\sffamily
}



\newcommand{\intT}[1]{
\input{interprets/#1.tex}
}



%----------------------------------
% makra pre pesničky ako také
%----------------------------------
\newcommand{\rok}[1]{}
\newcommand{\MFF}[0]{\textsc{MatFyz}}

\newcommand{\uv}[1]{\textit{„#1“}}

\newcommand{\NAZPES}[0]{}
\newcommand{\NAZPE}[0]{}
\newcommand{\nazpe}[3]{\renewcommand{\NAZPE}[0]{
\begin{center}
\LARGE{\textbf{#1}}  \\
\Large{#2}
\ifthenelse{\equal{#3}{}}{}{\\ \large{\ndp{album:} #3}}
\end{center}}
\renewcommand{\NAZPES}[0]{#1}%
}

% akordy možno ešte doladiť hspace 
\newcommand{\akor}[1]{
~%
\setbox0\hbox{\raisebox{.55\baselineskip}{\hspace{-0.7em}\textbf{#1}}}%
\copy0%
\hspace{-\wd0}%
\hspace{-0.7em}%
}%


\newcommand{\song}[1]{\normalsize\input{songs/#1.tex}}



\newcommand{\rfr}[1]{\item[\textbf{R:}]{#1}}

\newcommand{\rfrdva}[1]{\item[\textbf{R2:}]{#1}}

\newcommand{\rfrtri}[1]{\item[\textbf{R3:}]{#1}}

\newcommand{\rfrstyri}[1]{\item[\textbf{R4:}]{#1}}

\newcommand{\erfr}[0]{\item[\textbf{R:}]{~}}

\newcommand{\erfrdva}[0]{\item[\textbf{R:}]{~}}

\newcommand{\erfrtri}[0]{\item[\textbf{R:}]{~}}

\newcommand{\erfrstyri}[0]{\item[\textbf{R:}]{~}}

\newcommand{\str}[0]{\item}

\newcommand{\strnon}[1]{\item[~]{#1}}

\newcommand{\dodtex}[1]{\item[~]{\textit{#1}}}

\newcommand{\medz}[1]{\item[~]{#1}}

\newcommand{\intro}[1]{\item[intro:]{#1}}

\newcommand{\solo}[1]{\item[solo:]{#1}}



\newcommand{\iluV}[1]{
	\begin{figure}[b]
	\includegraphics[width=0.95\textwidth]{songs/graphics/#1}
	\end{figure}
}%
%--------------------------------------------------------------
%      sadzba autorov
%--------------------------------------------------------------

\newcommand{\@uthorname}{}
\newcommand{\@uthordesc}{}
\newcommand{\@uthorfoto}{}
\newcommand{\@uthormail}{}
\newcommand{\@uthorsocn}{}

\newcommand{\authorname}[1]{\renewcommand{\@uthorname}{#1}}
\newcommand{\authorsocn}[1]{\renewcommand{\@uthorsocn}{#1}}
\newcommand{\authordesc}[1]{\renewcommand{\@uthordesc}{#1}}
\newcommand{\authormail}[1]{\renewcommand{\@uthormail}{#1}}
\newcommand{\authorfoto}[1]{\renewcommand{\@uthorfoto}{\includegraphics[height=1.5cm]{authors/foto/#1}}}

\newcommand{\autor}[1]{
{\footnotesize
\input{authors/#1.tex}
\vspace{-1\baselineskip}
\begin{tabular}{c p{0.8\textwidth}}
\@uthorfoto & \vspace{-1.5\baselineskip} \Large{\ndp\@uthorname}  {\s@cn} \footnotesize\nolinkurl{\@uthormail} \\ 
 & \vspace{-1.3\baselineskip} \@uthordesc
\end{tabular}
\vspace{.8\baselineskip}
\hrule
}
}%

\newcommand*{\s@cn}{ \socn\@uthorsocn
}

\newcommand*{\socn}[1]{%
	\renewcommand*{\do}[1]{\includegraphics[height=.5\baselineskip]{graphics/##1_logo}}
	%\let\do##1{}
	\expandafter\docsvlist\expandafter{#1}
}



%----------------------------------------------
%       definicia sadzania spevniku
%----------------------------------------------
\newcommand{\zacspev}{
\begin{document}
\begin{flushleft}
\fontfamily{cmss}\selectfont

\sffamily
}%

\newcommand{\konspev}{
\end{flushleft}
\end{document}
}%

%----------------------------------------------
%       definicia sadzania pesnicky
%----------------------------------------------
\newcommand{\zacpe}[0]{
\addcontentsline{toc}{subsection}{\NAZPES}
\fancyhead[OR]{\CAT}
\NAZPE%
\begin{enumerate}%
}%

\newcommand{\konpe}[0]{
\end{enumerate}
}%

