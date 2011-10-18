%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                             %
% fks-3d.mp     v1.0                                          %
%                                                             %
% makra pro sazbu obrazku Fyzikalniho                         %
% korespondencniho seminare MFF UK                            %
%                                                             %
% marka pro kresleni 3D obrazku                               %
%                                                             %
% Lukas Ledvina 10.2011                                       %
%                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                             %
% Pro ukladani 3D polohy se pouziva color, dale pro           %
% projektovanou hodnotu se pouziva pair.                      %
%                                                             %
% Pouziva se volne rovnobezne promitani.                      %
% Prvni cast: 3D souradnice ve trech polich, definovane       %
%             promenne pro zadavani a 2D vystup.              %
% Druha cast: projekce rovinnych krivek z libovolne roviny    %
%             tecne ke kouli v bodu (x,y,z)                   %
%                                                             %
% TODO: uhel mezi krivkami                                    %
%       translace, rotace ve 3D                               %
%       transformace uhlu                                     %
%                                                             %
% TODO pro masochisty: dodělat stínování, viditelnost.        %
%                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         Prvni cast                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Pole 3D souradnic
  numeric tDx[],tDy[],tDz[];

% Promenna dD pro 2D kresleni
  vardef dD@# = ( tDy@# - sqrt(2)/4*tDx@#, 
                  tDz@# - sqrt(2)/4*tDx@#)
  enddef;

% Promenna tD pro 3D nastavovani
  vardef tD@# = ( tDx@#,tDy@#,tDz@# ) enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         Druha cast                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Zadano:
%   path nebo picture v souradnicich x_0, y_0
%   Pocatek souradnic, dva vektory
% Algoritmus
%   Prvni vektor je normovan a polozen za x', tj obraz x_0
%   G-S ON pro ziskani vektoru y', tj. obrazu y_0
%   vypocet transformace (x_0,y_0) -> (X,Y), tj. poloh bodu v proj. 2D

