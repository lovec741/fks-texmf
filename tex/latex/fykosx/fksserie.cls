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
\RequirePackage{optional} % ought be first
\RequirePackage{fontspec}
\RequirePackage{amssymb} 
\RequirePackage{xltxtra} % includes xunicode
\RequirePackage[xetex,
  setpagesize=false,
  linkcolor=blue,
  anchorcolor=blue,
  citecolor=blue,
  filecolor=blue,
  urlcolor=blue,
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
\RequirePackage{fksmeta} %TODO config
\RequirePackage{fkssugar}
%\RequirePackage{fkslegacy}
\RequirePackage{fksfigures}
\RequirePackage{fkstables}

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
   \problem[\metaprobletter{problem}: \@probname]{Úloha \Roman{batch}.\metaprobletter{problem} \ldots{} \@probname{} \hfill {\normalfont\normalsize\@probpoints~\plural{\@probpoints}{bod}{body}{bodů}}}%
   \@probtask%
  }
}

\newcommand\problemsolution{%
  \stepcounter{problem}%
  \@LoadProblem{\thesolvedbatch}{\theproblem}{%{\theproblem}{%
   \problem[\metaprobletter{problem}: \@probname]%
    {Úloha \Roman{solvedbatch}.\metaprobletter{problem} \ldots{} \@probname{} \hfill
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
\newcommand\makefooter{%
\begin{center}
\vfill
\met@address
\bigskip

\hrulefill

\met@licence 
\end{center}}

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

% bibliography is small and we can choose the level of heading
\renewenvironment{thebibliography}[2]
     {\expandafter#2{\refname}%\section*{\refname}%
      \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}%
      \begin{small}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
	    \itemindent\z@%
            \leftmargin\labelwidth%
            \advance\leftmargin\labelsep%
            \@openbib@code%
            \usecounter{enumiv}%
            \let\p@enumiv\@empty%
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy%
      \clubpenalty4000%
      \@clubpenalty \clubpenalty%
      \widowpenalty4000%
      \sfcode`\.\@m}%
     {\def\@noitemerr%
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist%
      \end{small}}%

\newcommand\mail[1]{\href{mailto:#1}{\nolinkurl{#1}}}
% TODO
\newcommand\signature[1]{Karel Kolář (\mail{karel@fykos.cz})}
