%
% @author Michal Koutný <michal@fykos.cz>
%
% @description Provides class for batch brojure. Based on fks.sty by Jan Houštěk.
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fksbatch}[2011/09/11 Batch brojure]

% inherit from fksbase class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{fksbase}}
\ProcessOptions
\LoadClass{fksbase}


% packages
\fancyfoot{}
\if@twoside
  \fancyfoot[EL]{\bfseries \thepage}
  \fancyfoot[OR]{\bfseries \thepage}
\else
  \fancyfoot[C]{\bfseries \thepage}
\fi

\newcommand\problemsheading{%
\section[Zadání \Roman{batch}. série]{\met@headerproblems}
\vspace{-4pt}
\centerline{\Large\slshape\sffamily Termín doručení: \@deadline}
\vspace{1.5ex}
\setcounter{problem}{0}}

\newcommand\solutionheading{%
\setcounter{solvedbatch}{\value{batch}}%
\addtocounter{solvedbatch}{-1}%
\setcounter{problem}{0}%
\section[Řešení \Roman{solvedbatch}. série]{\met@headersolutions}}

\newcommand\seriesheading[1]{%
\section[Seriál: #1]{\met@headerseries{#1}}}

\newcommand\resultsheading{%
\section[Pořadí řešitelů po \Roman{solvedbatch}. sérii]{\met@headerresults}
}


% other
\let\oldfooter\makefooter
\renewcommand\makefooter{%
\null
\vfill
\begin{center}
  \met@address
\end{center}
  \oldfooter
}

\newcommand\@deadline{NENÍ ZADÁNO}
\newcommand\deadline[1]{\renewcommand\@deadline{#1}}




