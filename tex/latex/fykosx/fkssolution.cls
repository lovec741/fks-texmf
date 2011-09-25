%
% @author Michal Koutný <michal@fykos.cz>
%
% @description Provides class for solution leaflet. Based on fks.sty by Jan Houštěk.
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fkssolution}[2011/09/23 Solution leaflet]

% inherit from fksbase class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{fksbase}}
\ProcessOptions
\LoadClass{fksbase}

\fancyhead{}
\fancyhead[L]{\bfseries\small \met@headername}
\fancyhead[R]{\bfseries\small Řešení \Roman{year}.\Roman{solvedbatch}.\arabic{problem}}






