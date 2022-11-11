%
% @author Michal Koutný <michal@fykos.cz>
%
% @description Provides class for series leaflet. Based on fks.sty by Jan Houštěk.
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fksseries}[2011/10/26 Series leaflet]

% inherit from fksbase class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{fksbase}}
\ProcessOptions
\LoadClass{fksbase}

\RequirePackage{fksmeta}
\RequirePackage{fkssections}
\RequirePackage{fksserial}

\leftheader{\fksMeta@contestNameShort}
\rightheader{
	\fksMeta@serialTitle{}
	\fksMeta@formatContestYear{year}.\Roman{batch}
	\fksSections@serialName
}

% TODO not working, save serial name to aux
% https://tex.stackexchange.com/questions/313472/why-does-a-new-page-disrupt-hypersetup-and-is-there-a-workaround
\hypersetup{
	pdftitle={\fksMeta@serialTitle{} \fksMeta@formatContestYear{year}.\Roman{batch} \fksSections@serialName, \fksMeta@contestNameShort}%
}
