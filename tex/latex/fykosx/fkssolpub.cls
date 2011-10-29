%
% @author Michal Koutný <michal@fykos.cz>
% TODO licence
% @description Class for typesetting solutions of physical problems for participants.
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fkssolpub}[2011/10/26 FKS Solution public]

% inherit from article class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions
\LoadClass[10pt]{article}

% layout settings
\RequirePackage[
  a4paper,
  margin=2cm,  
  headsep=0.8cm,
  headheight=13pt]{geometry}

\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhead{}
\fancyhead[L]{\textbf{\'Uloha \leftmark}}
\fancyhead[R]{\sch@ol, \textbf{\@author}}
\fancyfoot{}
\fancyfoot[C]{\bfseries \thepage/\pageref{pg:\theproblem}}

% problem managing
\newcounter{problem}
\newcommand\sch@ol{N/A}
\newcommand\school[1]{
\renewcommand\sch@ol{#1}}

\newcommand\pr@blem{??}
\newenvironment{problem}[1]{%
\cleardoublepage
\markboth{#1}{}
\setcounter{page}{1}
\stepcounter{problem}
}{%
\label{pg:\theproblem}
}

% comfort macros
%\RequirePackage{fkssugar}




