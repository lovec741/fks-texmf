% fksserie.cls
%
%    Copyright 2011 Michal Koutny
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fksserie}[2011/09/11 Solution brojure]

% inherit from article class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\ProcessOptions
\LoadClass[9pt]{extarticle}


% packages
\RequirePackage{fontspec}
\RequirePackage{amssymb} 
\RequirePackage{xltxtra} % includes xunicode
\RequirePackage[xetex,
  setpagesize=false]{hyperref}  
\RequirePackage{polyglossia}
\setdefaultlanguage{czech}


% FYKOS packages
\RequirePackage{fksmeta}
\RequirePackage{fkssugar}
%\RequirePackage{fkslegacy}
\RequirePackage{fksfigures}
\RequirePackage{fkstables}


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
\section{Zadání úloh \Roman{batch}. série}%TODO termín odeslání
\setcounter{problem}{0}}

\newcommand\solutionheading{%
\setcounter{solvedbatch}{\value{batch}}%
\addtocounter{solvedbatch}{-1}%
\setcounter{problem}{0}%
\section{Řešení úloh \Roman{solvedbatch}. série}}

\newcommand\seriesheading[1]{%
\section{Seriál: #1}}

% problems
\newcommand\@tmpfilename{}
\newcommand\@LoadProblem[3]{ % batch number, problem number, expansion code
  \renewcommand\@tmpfilename{\@problemsdir/problem#1-#2.tex}
  \IfFileExists{\@tmpfilename}{
  \input{\@tmpfilename}%
  \ClassInfo{fksserie}{Loaded \@tmpfilename}
  #3
  }{\ClassWarning{fksserie}{Problem file \@tmpfilename not found.}}
}

\newcommand\problemtask{%
  \stepcounter{problem}%
  \@LoadProblem{\thebatch}{\theproblem}{%
   \problem[\arabic{problem}: \@probname]{Úloha \Roman{batch}.\arabic{problem} \ldots{} \@probname{} \hfill {\normalfont\normalsize\@probpoints~\plural{\@probpoints}{bod}{body}{bodů}}}%
   \@probtask%
  }
}

\newcommand\problemsolution{%
  \stepcounter{problem}%
  \@LoadProblem{\thesolvedbatch}{\theproblem}{%{\theproblem}{%
   \problem[\arabic{problem}: \@probname]%
    {Úloha \Roman{solvedbatch}.\arabic{problem} \ldots{} \@probname{} \hfill
      {\normalfont\normalsize\@probpoints~\plural{\@probpoints}{bod}{body}{bodů},
       průměr \@probavg,
       \plural{\@probsolvers}{řešil}{řešili}{řešilo}{} \@probsolvers{} \plural{\@probsolvers}{student}{studenti}{studentů}}}%
   \begin{textsl}
      \@probtask
   \end{textsl}
   
   \hfill \textit{\@proborigin}

   \medskip
   
   \noindent \@probsolution
  }
}



% problem attributes
\newcommand\@probbatch{N/A}
\newcommand\@probno{N/A}
\newcommand\@probname{N/A}
\newcommand\@proborigin{N/A}
\newcommand\@probpoints{N/A}
\newcommand\@probsolauthors{N/A}
\newcommand\@probsolvers{N/A}
\newcommand\@probavg{N/A}
\newcommand\@probtask{N/A}
\newcommand\@probsolution{N/A}

\newcommand\probbatch[1]{\renewcommand\@probbatch{#1}}
\newcommand\probno[1]{\renewcommand\@probno{#1}}
\newcommand\probname[1]{\renewcommand\@probname{#1}}
\newcommand\proborigin[1]{\renewcommand\@proborigin{#1}}
\newcommand\probpoints[1]{\renewcommand\@probpoints{#1}}
\newcommand\probsolauthors[1]{\renewcommand\@probsolauthors{#1}}
\newcommand\probsolvers[1]{\renewcommand\@probsolvers{#1}}
\newcommand\probavg[1]{\renewcommand\@probavg{#1}}
\newcommand\probtask[1]{\renewcommand\@probtask{#1}}
\newcommand\probsolution[1]{\renewcommand\@probsolution{#1}}

% other
\renewcommand\maketitle{}
\newcommand\makefooter{\met@address}

\newcommand\@deadline{NENÍ ZADÁNO}
\newcommand\deadline[1]{\renewcommand\@deadline{#1}}

\newcommand\@problemsdir{.}
\newcommand\problemsdir[1]{\renewcommand\@problemsdir{#1}}

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

\frenchspacing % TODO

% TODO
\newcommand\signature[1]{Karel Kolář (\href{mailto:karel@fykos.cz}{karel@fykos.cz})}
