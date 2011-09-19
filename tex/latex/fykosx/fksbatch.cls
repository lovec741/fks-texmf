%
% @author Michal Koutný <michal@fykos.cz>
%
% @description Provides class for batch brojure. Based on fks.sty by Jan Houštěk.
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fksbatch}[2011/09/11 Batch brojure]

% inherit from article class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\ProcessOptions
\LoadClass[9pt]{extarticle}


% packages
\RequirePackage{optional} % ought be first
\RequirePackage{fontspec}
\RequirePackage{amssymb} 
\RequirePackage{xltxtra} % includes xunicode
\RequirePackage[xetex,
  setpagesize=false,
  linkcolor=black,
  anchorcolor=black,
  citecolor=black,
  filecolor=black,
  urlcolor=black,
  bookmarks=true,
]{hyperref} 
\opt{web}{\hypersetup{colorlinks=true}}
\opt{print}{\hypersetup{colorlinks=false}}  
\RequirePackage{polyglossia}
\setdefaultlanguage{czech}

% layout settings
\RequirePackage[includeheadfoot,
  a5paper,
  margin=0.7cm,
  headsep=0.2cm]{geometry}

\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhead{}
\fancyhead[L]{\bfseries\small \met@headername}
\fancyhead[R]{\bfseries\small \met@volumeid}
\fancyfoot{}
\if@twoside
  \fancyfoot[EL]{\bfseries \thepage}
  \fancyfoot[OR]{\bfseries \thepage}
\else
  \fancyfoot[C]{\bfseries \thepage}
\fi

% FYKOS packages
\RequirePackage{fksmeta}
\RequirePackage{fkssugar}
%\RequirePackage{fkslegacy}
\RequirePackage{fksfigures}
\RequirePackage{fkstables}
\RequirePackage{fksmisc}

% counters
\newcounter{year}
\newcounter{batch}[year]
\newcounter{problem}[batch]
\newcounter{solvedbatch}

% headings
\renewcommand\section{\@startsection {section}{1}{\z@}%
  {-3.5ex \@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus.2ex}%
  {\normalfont\sffamily\slshape\huge}}
\renewcommand\subsection{\@startsection {subsection}{2}{\z@}%
  {-3.25ex \@plus -1ex \@minus -.2ex}%
  {1.0ex \@plus.2ex}%
  {\normalfont\sffamily\slshape\Large}}
\renewcommand\subsubsection{\@startsection {subsubsection}{3}{\z@}%
  {-3.25ex \@plus -1ex \@minus -.2ex}%
  {1.0ex \@plus.2ex}%
  {\normalfont\sffamily\slshape\normalsize}}
\newcommand\problem{\@startsection {subsection}{2}{\z@}%
  {-3.25ex \@plus -1ex \@minus -.2ex}%
  {1.0ex \@plus.2ex}%
  {\normalfont\bfseries\large}}

\setcounter{secnumdepth}{-1} % do not number headings

\newcommand\problemsheading{%
\section[Zadání \Roman{batch}. série]{\centering \includegraphics{logo1.eps}\hspace{10pt}\raisebox{0.6cm}{Zadání \Roman{batch}. série}\hspace{10pt}\includegraphics{logo8.eps}}
\vspace{-4pt}
\centerline{\Large\slshape\sffamily Termín doručení: \@deadline}
\vspace{1.5ex}
\setcounter{problem}{0}}

\newcommand\solutionheading{%
\setcounter{solvedbatch}{\value{batch}}%
\addtocounter{solvedbatch}{-1}%
\setcounter{problem}{0}%
\section[Řešení \Roman{solvedbatch}. série]{\centering \includegraphics{logo2.eps}\hspace{10pt}\raisebox{0.6cm}{Řešení \Roman{solvedbatch}. série}}}

\newcommand\seriesheading[1]{%
\section[Seriál: #1]{\centering \includegraphics{logo3.eps}\hspace{10pt}\raisebox{0.6cm}{Seriál: #1}}}

\newcommand\resultsheading{%
\section[Pořadí řeštielů po \Roman{solvedbatch}. sérii]{\centering \includegraphics{logo7.eps}\hspace{10pt}\raisebox{0.6cm}{Pořadí řešitelů po \Roman{solvedbatch}. sérii}\hspace{10pt}\includegraphics{logo8.eps}}
}

\input{problems}

% other
\renewcommand\maketitle{}
\newcommand\makefooter{%
\vfill
\begin{samepage}
\begin{center}
\met@address
\bigskip

\hrulefill

\met@licence 
\end{center}
\end{samepage}}

\newcommand\@deadline{NENÍ ZADÁNO}
\newcommand\deadline[1]{\renewcommand\@deadline{#1}}

\newcommand\plural[4]{%
  \ifcase#1 % 0
  #4%
  \or% 1
  #2%
  \or% 2
  #3%
  \or% 3
  #3%
  \or% 4
  #3%
  \else% >4
  #4%
  \fi%
}

\input{fkssignature}


