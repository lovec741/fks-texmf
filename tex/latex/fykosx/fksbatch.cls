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
\section[Pořadí řešitelů po \Roman{solvedbatch}. sérii]{\centering \includegraphics{logo7.eps}\hspace{10pt}\raisebox{0.6cm}{Pořadí řešitelů po \Roman{solvedbatch}. sérii}\hspace{10pt}\includegraphics{logo8.eps}}
}


% other
\renewcommand\maketitle{}
\renewcommand\makefooter{%
\vspace*{\fill}%
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




