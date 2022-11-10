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

\leftheader{\fksMeta@contestNameShort}
\rightheader{
	\fksMeta@serialTitle
	\fksMeta@formatContestYear{year}.\Roman{batch}
	\fksSections@serialName
}

\hypersetup{
	pdftitle={%
		\fksMeta@serialTitle
		\fksMeta@formatContestYear{year}.\Roman{batch} #1,
		\fksMeta@contestNameShort
	}%
}
