%
% @author Michal Koutný <michal@fykos.cz>
%
% @description Provides class for solution leaflet. Based on fks.sty by Jan Houštěk.
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fkssolution}[2011/09/23 Solution leaflet]

% inherit from fksbase class
\LoadClass{fksbase}

\RequirePackage{fksmeta}
\rightheader{\fksMeta@problemSolutionTitle~\fksMeta@formatContestYear{year}.\problemnum{solvedbatch}{problem}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{fksbase}}
\ProcessOptions\relax
