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

\RequirePackage{fksserial}

% other
\let\oldfooter\makefooter
\renewcommand\makefooter{%
\null
\vfill
\begin{center}
	\fksMeta@address
\end{center}
	\oldfooter
}

\newcommand\@deadline{NENÍ ZADÁNO} % upload/receive
\newcommand\deadline[1]{\renewcommand\@deadline{#1}}

\newcommand\@deadlineS{N/A} % send
\newcommand\deadlineS[1]{\renewcommand\@deadlineS{#1}}
