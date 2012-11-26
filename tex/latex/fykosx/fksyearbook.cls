%
% @author Lukáš Timko <luky.timko@gmail.com>
% @author Michal Koutný <michal@fykos.cz>
%
% @description Provides Year book class
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fksyearbook}[2012/11/13 Year book class]

% inherit from report class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extreport}}
\ProcessOptions
\LoadClass[9pt]{extreport}

%
% packages
\@ifundefined{UseOption}{\def\UseOption{web}}{} % when no option set, we use web settings

\RequirePackage{optional} % ought be first
\RequirePackage{amssymb} 
\RequirePackage[no-math]{fontspec} % no-math is because of mathrm(Omega)
\RequirePackage{xltxtra} % includes xunicode, fontspec
\RequirePackage{pgffor}
\RequirePackage{lastpage}
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
  twoside,
  a5paper,
  hmargin=1.6cm,  
  vmargin=1.0cm,
  headsep=0.2cm]{geometry}
\if@twoside
  \raggedbottom % twoside layout causes expanding vertical space around environments
\fi

\newcommand\chapternamehdr{}%obsahuje jmeno aktualni casti
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhead{}
\renewcommand\headrulewidth{0pt}
\renewcommand\footrulewidth{0pt}

%vertikalni centrovani horiz. cary
\newcommand\lineleft[1]{\par\noindent\raisebox{.8ex}{\makebox[\linewidth]{\hrulefill\hspace{1ex}\raisebox{-.8ex}{#1}}}}
\newcommand\lineright[1]{\par\noindent\raisebox{.8ex}{\makebox[\linewidth]{\raisebox{-.8ex}{#1}\hspace{1ex}\hrulefill}}}

\fancyhead[EL]{\lineright{\textit{{\met@shortname}, \Roman{year}. ročník}}}
\fancyhead[OR]{\lineleft{\textit{\chapternamehdr}}}

% options
\fancyfoot{}
\if@twoside
  \fancyfoot[EL]{\bfseries \thepage}
  \fancyfoot[OR]{\bfseries \thepage}
\else
  \fancyfoot[C]{\bfseries \thepage}
\fi

% Some packages rely on this condition
\newif\ifyearbook
\yearbooktrue

% FYKOS packages
\RequirePackage{fksmeta}
\RequirePackage{fkssugar}
%\RequirePackage{fkslegacy}
\RequirePackage{fksfigures}

% tabulky řešitelů (musí být před fkstables)
\renewcommand\met@resultsheader{& {\normalfont\bfseries jméno} & škola & $\Sigma$ \\}
\renewcommand\met@resultscols{\newcolumntype{T}{x{\bfseries}rA{\itshape}p{0.3\textwidth}^X% order, name, school
A{\bfseries}r}} % sum

\RequirePackage{fkstables}
\RequirePackage{fksmisc}

% counters
\newcounter{year}
\newcounter{batch}[year]
\newcounter{problem}[batch]
\newcounter{solvedbatch}
\newcounter{serieschapter}

\setcounter{serieschapter}{1}

% Snad to nezávisí na příliš interních makrech (@starttoc), ale funguje to.
\renewcommand\tableofcontents{%
    \chapter*{\met@headeryeartoc}%
    \@starttoc{toc}%
}

%
% Headings
%
\renewcommand\chapter{\@startsection {chapter}{-1}{\z@}%
  {-3.5ex \@plus -1ex \@minus -.2ex}%
  {3.5ex \@plus.2ex}%
  {\normalfont\sffamily\slshape\Huge}}
\renewcommand\section{\@startsection {section}{1}{\z@}%
  {-3.5ex \@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus.2ex}%
  {\normalfont\sffamily\slshape\LARGE}}
\renewcommand\subsection{\@startsection {subsection}{2}{\z@}%
  {-3.25ex \@plus -1ex \@minus -.2ex}%
  {0.5ex \@plus.2ex}%
  {\normalfont\sffamily\slshape\large}}
\renewcommand\subsubsection{\@startsection {subsubsection}{3}{\z@}%
  {-2.25ex \@plus -1ex \@minus -.2ex}%
  {0.5ex \@plus.2ex}%
  {\normalfont\sffamily\slshape\normalsize}}
\newcommand\problem{\@startsection {subsection}{2}{\z@}%
  {-3.25ex \@plus -1ex \@minus -.2ex}%
  {1.0ex \@plus.2ex}%
  {\normalfont\bfseries\large}}
\newcommand\varproblem{\@startsection {subsection}{2}{\z@}%
  {-3.5ex \@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus.2ex}%
  {\normalfont\sffamily\Large}}

\newenvironment{comercial}{
\normalfont\sffamily\normalsize
\renewcommand\section{\@startsection {section}{1}{\z@}%
  {-3.5ex \@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus.2ex}%
  {\normalfont\sffamily\huge}}
\renewcommand\subsection{\@startsection {subsection}{2}{\z@}%
  {-3.25ex \@plus -1ex \@minus -.2ex}%
  {1.0ex \@plus.2ex}%
  {\normalfont\sffamily\Large}}
\renewcommand\subsubsection{\@startsection {subsubsection}{3}{\z@}%
  {-3.25ex \@plus -1ex \@minus -.2ex}%
  {1.0ex \@plus.2ex}%
  {\normalfont\sffamily\normalsize}}
}{%
\normalfont\rmfamily\upshape\normalsize
\renewcommand\section{\@startsection {section}{1}{\z@}%
  {-3.5ex \@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus.2ex}%
  {\normalfont\rmfamily\upshape\huge}}
\renewcommand\subsection{\@startsection {subsection}{2}{\z@}%
  {-3.25ex \@plus -1ex \@minus -.2ex}%
  {1.0ex \@plus.2ex}%
  {\normalfont\rmfamily\upshape\Large}}
\renewcommand\subsubsection{\@startsection {subsubsection}{3}{\z@}%
  {-3.25ex \@plus -1ex \@minus -.2ex}%
  {1.0ex \@plus.2ex}%
  {\normalfont\rmfamily\upshape\normalsize}}
}

%pro vypisovani jmena sekce do zahlavi
\newcommand\newchapter[2][]{\chapter[#1]{#2}\renewcommand{\chapternamehdr}{#1}}

\setcounter{secnumdepth}{-2} % do not number headings
\setcounter{tocdepth}{1}

%
% Zadání a řešení úloh
%
\input{problems}
\problemsdir{../problems}
% bez statistik
\renewcommand\problemstats\relax
% odkaz na vzorák
\renewcommand\problemtask{%
  \tasktrue\solutionfalse\solutionsinglefalse%
  \stepcounter{problem}%
  \@LoadProblem{\thebatch}{\theproblem}{%
   \problem[\metaprobletter{problem}: \@probname]{Úloha \problemnum{batch}{problem} \,\ldots{} \@probname{} \hfill {\normalfont\normalsize\problempoints}}%
   \nopagebreak\ifthenelse{\equal{\@probfig}{N/A}}{}{\@probfig}\nopagebreak%
   \@probtask%
   \signed{\textit{(řešení str. \pageref{solution\thecountx-\thecounty})}}
  }
}
% bez autora námětu a vzoráku (jsou vzadu)
\renewcommand\pr@blemsolution{%  
   \varproblem[\metaprobletter{problem}: \@probname]%
    {Úloha \problemnum{solvedbatch}{problem} \,\ldots{} \@probname{} \hfill
      {\normalfont\normalsize\problemstats}}%
   \nopagebreak\ifthenelse{\equal{\@probfig}{N/A}}{}{\@probfig}\nopagebreak%   
   \textsl{\@probtask}
   
   \medskip
   
   \noindent \@probsolution\par   
}

\newcommand\makefooter{%
\vspace*{\fill}
\noindent\begin{minipage}{\textwidth}
\hrule
\smallskip
\begin{center}
\met@licence
\end{center}
\end{minipage}
}

\input{fkssignature}


\newcommand\problemsheading{%
\section[Zadání \Roman{batch}. série]{\met@headerproblems}
\vspace{-4pt}
\ifthenelse{\equal{\@deadlineS}{N/A}}{%
\centerline{\Large\slshape\sffamily Termín doručení: \@deadline}
}{%
\centerline{\Large\slshape\sffamily Termín uploadu: \@deadline}
\centerline{\Large\slshape\sffamily Termín odeslání: \@deadlineS}}
\vspace{1.5ex}
\setcounter{problem}{0}}

\newcommand\solutionheading{%
\ifthenelse{\equal{\thesolvedbatch}{0}}{% implicitly set solvedbatch = batch - 1
\setcounter{solvedbatch}{\value{batch}}%
\addtocounter{solvedbatch}{-1}%
}{}%
\setcounter{problem}{0}%
\section[Řešení \Roman{solvedbatch}. série]{\met@headersolutions}}

%nove TODO predelat ze section na chapter
\newcommand\introheading{%
\newchapter[Předmluva]{\met@headeryearintro}}

\newcommand\theorproblemsheading{%
\newchapter[Zadání teoretických úloh]{\met@headeryeartheorproblems}}

\newcommand\theorsolutionsheading{%
\newchapter[Řešení teoretických úloh]{\met@headeryeartheorsolutions}}

\newcommand\expproblemsheading{%
\newchapter[Zadání experimentálních úloh]{\met@headeryearexpproblems}}

\newcommand\expsolutionsheading{%
\newchapter[Řešení experimentálních úloh]{\met@headeryearexpsolutions}}

\newcommand\seriespartheading[1]{%
\newchapter[#1]{\met@headeryearseries{#1}}}

\newcommand\seriesheading[1]{%TODO mozna subsection
%\addcontentsline{toc}{section}{Kapitola \arabic{serieschapter}: {#1}}
\addtocontents{toc}{\protect\setcounter{tocdepth}{1}} % povolit section v TOC
\section[Kapitola \arabic{serieschapter}: #1]{\met@headeryearserieschapter{#1}}
\addtocontents{toc}{\protect\setcounter{tocdepth}{0}} % zakazat section v TOC
}

\newcommand\seriessolutionsheading{%
\newchapter[Řešení úloh ze seriálu]{\met@headeryearseriessolutions}}

\newcommand\eventsheading{%
\newchapter[Akce \met@shortname u]{\met@headeryearevents}}

\newcommand\resultsheading{%
\newchapter[Pořadí nejlepších řešitelů]{\met@headeryearresults}
}

\newcommand\address{
\met@address
}
%pro potreby rocenky
%\newcommand\met@headeryeartheorproblems{Zadání teoretických úloh}
%\newcommand\met@headeryeartheorsolutions{Řešení teoretických úloh}
%\newcommand\met@headeryearexpproblems{Zadání experimentálních úloh}
%\newcommand\met@headeryearexpsolutions{Řešení experimentálních úloh}
%\newcommand\met@headeryearseries[1]{Seriál o #1}
%\newcommand\met@headeryearserieschapter[1]{Kapitola \arabic{serieschapter}: #1}
%\newcommand\met@headeryearseriessolutions{Řešení úloh ze seriálu}
%\newcommand\met@headeryearresults{Pořadí nejlepších řešitelů}
%\newcommand\met@headeryearevents{Akce semináře}%FYKOSu || VYFUKu

%for loop USAGE: \forLoop[STEP]{START}{END}{COUNTERNAME}{COMMANDS}
\newcommand{\forLoop}[5][1]{%
   \setcounter{#4}{#2} %
   \ifthenelse{ \value{#4}<#3 }%
   {%
      #5 %
      \addtocounter{#4}{#1} %
      \forLoop[#1]{\value{#4}}{#3}{#4}{#5} %
   }%
   {%
      #5 %
   }%
}%

%big roman numerals in text
\newcommand{\rom}[1]{\expandafter\@slowromancap\romannumeral #1@}

\newcommand\@predmluva{}
\newcommand\predmluva[1]{
\renewcommand\@predmluva{#1}
}

\newcommand\autor@serialu{Jana Poledniková}
\newcommand\autorserialu[1]{
\renewcommand\autor@serialu{#1}
}

\newcommand\podzimni@soustredeni{}
\newcommand\podzimnisoustredeni[1]{
\renewcommand\podzimni@soustredeni{#1}
}

\newcommand\jarni@soustredeni{}
\newcommand\jarnisoustredeni[1]{
\renewcommand\jarni@soustredeni{#1}
}

\newcommand\s@zba{}
\newcommand\sazba[1]{
\renewcommand\s@zba{#1}
}

\newcommand\obr@zky{}
\newcommand\obrazky[1]{
\renewcommand\obr@zky{#1}
}

\newcommand\@korektury{}
\newcommand\korektury[1]{
\renewcommand\@korektury{#1}
}

\newcommand\@guru{Karel Kolář}
\newcommand\guru[1]{
\renewcommand\@guru{#1}
}

\newcommand\authorspage{
\newpage
\thispagestyle{empty}

\noindent{\large\rmfamily
\textsc{\@guru~a kolektiv}\\
\textbf{\met@headername\\
\Roman{year}. ročník -- \met@schoolyear}\\
}

\renewcommand{\baselinestretch}{1.5}
\noindent\textit{Předmluva:} \@predmluva\\
\textit{Náměty úloh:} \\
\indent
\begin{minipage}{12cm}
\input{authors/probauthors}
\end{minipage}\\
\textit{Autoři řešení úloh:} \\
\indent
\begin{minipage}{12cm}
\input{authors/solauthors}
\end{minipage}\\
\textit{Seriál o astrofyzice:} \autor@serialu\\
\textit{Legenda podzimního soustředění:} \podzimni@soustredeni\\
\textit{Legenda jarního soustředění:} \jarni@soustredeni\\
~\\
\textit{Sazba:} \s@zba\\
\textit{Obrázky a grafy:} \obr@zky\\
\textit{Jazykové korektury:} \@korektury\\
\renewcommand{\baselinestretch}{1}

\makefooter
}

\newcommand\cislo@publikace{381}
\newcommand\cislopublikace[1]{
\renewcommand\cislo@publikace{#1}
}

\newcommand\pocet@vytisku{350}
\newcommand\pocetvytisku[1]{
\renewcommand\pocet@vytisku{#1}
}

\newcommand\@isbn{978-80-7378-187-3}
\newcommand\isbn[1]{
\renewcommand\@isbn{#1}
}

\newcommand\@tiskarna{Akcent Třebíč}
\newcommand\tiskarna[1]{
\renewcommand\@tiskarna{#1}
}

\newcommand\closingpage{
\newpage
\begin{center}
\raisebox{-12cm}{
\begin{minipage}{10cm}
\noindent{\large\rmfamily
\textsc{\@guru~a kolektiv}\\
\textbf{\met@headername\\
\Roman{year}. ročník -- \met@schoolyear}\\
}
~\\
~\\
\noindent
Vydal \textsf{\textbf{MATFYZ}PRESS}\\
vydavatelství Matematicko-fyzikální fakulty\\
Univerzity Karlovy v Praze\\
Sokolovská 83, 186 75 Praha 8\\
jako svou \cislo@publikace. publikaci\\ %TODO
~\\
Vytiskl \@tiskarna \\
~\\
Vydáno pro vnitřní potřebu MFF UK\\
Publikace není určena k prodeji\\
~\\
\pageref{LastPage} stran, \arabic{figure} obrázků\\
Sazba písmem Computer Modern v programu \TeX \\
Vydání první\\
Náklad \pocet@vytisku~výtisků\\ %TODO
~\\
Praha 2012\\
~\\
ISBN \@isbn %TODO
\end{minipage}
}
\end{center}
}





