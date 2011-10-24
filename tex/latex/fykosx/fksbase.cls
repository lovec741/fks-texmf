%
% @author Michal Koutný <michal@fykos.cz>
%
% @description Provides base class (margins + headings)
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fksbase}[2011/09/11 Base class]

% inherit from article class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\ProcessOptions
\LoadClass[9pt]{extarticle}


% packages
\@ifundefined{UseOption}{\def\UseOption{web}}{} % when no option set, we use web settings

\RequirePackage{optional} % ought be first
\RequirePackage{amssymb} 
\RequirePackage[no-math]{fontspec} % no-math is because of mathrm(Omega)
\RequirePackage{xltxtra} % includes xunicode, fontspec
\UndeclareUTFcharacter[\UTFencname]{x2026}{\textellipsis} % we want normal ellipsis

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
\RequirePackage{xkeyval}
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
\fancyfoot[C]{\bfseries \thepage}

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

% other
\input{problems}
\problemsdir{../problems}

\newcommand\makefooter{%
\vspace*{\fill}
\begin{minipage}{\textwidth}
\hrule
\smallskip
\begin{center}
\met@licence
\end{center}
\end{minipage}
}

\input{fkssignature}



