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
% Pouziva se VOLNE ROVNOBEZNE PROMITANI.                      %
% Prvni cast: 3D souradnice ve trech polich, definovane       %
%             promenne pro zadavani a 2D vystup.              %
% Druha cast: projekce rovinnych krivek z libovolne roviny    %
%             tecne ke kouli v bodu (x,y,z)                   %
% Treti cast: rotace a translace v prostoru                   %
%                                                             %
% TODO: uhel mezi krivkami                                    %
%       transformace per                                      %
%       jine projekce (pohled zprava, axonometrie, atp.)      %
%                                                             %
% TODO pro masochisty: dodělat stínování                      %
%                      viditelnost.                           %
%                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% TODO funkce
vardef arccosd primary x = angle((x,1+-+x)) enddef;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         Prvni cast                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Pole 3D souradnic
  numeric tDx[],tDy[],tDz[];

% Promenna dD pro 2D kresleni
  vardef dD@# = 
    (tDy@# - sqrt(2)/4*tDx@#,tDz@# - sqrt(2)/4*tDx@#) enddef;
  vardef proj(expr tDa) =
    begingroup.save tDx, tDy, tDz;tD0=tDa;dD0 endgroup enddef;

% Promenna tD pro 3D nastavovani
  vardef tD@# = (tDx@#,tDy@#,tDz@#) enddef;

%%%%%%%%%%%
% norma bodu
  vardef norm_tD@# =
    sqrt(tDx@#*tDx@# + tDy@#*tDy@# + tDz@#*tDz@#) enddef;
  vardef norm(expr tDa) =
    sqrt(tDa dotprod_tD tDa) enddef;

% souradnice
  vardef xpart_tD@# = tDx@# enddef;
  vardef ypart_tD@# = tDy@# enddef;
  vardef zpart_tD@# = tDz@# enddef;

  vardef xpart(expr tDa) =
    begingroup.save tDx, tDy, tDz;tD0=tDa;tDx0 endgroup enddef;
  vardef ypart(expr tDa) =
    begingroup.save tDx, tDy, tDz;tD0=tDa;tDy0 endgroup enddef;
  vardef zpart(expr tDa) =
    begingroup.save tDx, tDy, tDz;tD0=tDa;tDz0 endgroup enddef;

% skalarni soucin
  primarydef tDa dotprod_tD tDb = 
    (xpart(tDa)*xpart(tDb) + ypart(tDa)*ypart(tDb) + zpart(tDa)*zpart(tDb))
  enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         Druha cast                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Transformace z roviny definovane tD_o, tD_x, tD_y do projektivni 
% roviny, osa X smeruje do smeru td_o->tD_x, osa Y je na ni kolma.
  def getTr(expr tD_o, tD_x, tD_y) =
    begingroup save tDx, tDy, tDz, T_;
% pocatek, vektor x', y'
      tD0 = tD_o;
      tD1 = (tD_x-tD_o);
      tD2 = (tD_y-tD_o);
% G-S OG
      tD3 = tD1;
      tD4 = tD2-tD1.dotprod_tD.tD2/(tD1.dotprod_tD.tD1)*tD1;
% ON
      tD5 = tD3/norm.(tD3);
      tD6 = tD4/norm.(tD4);
% v tD5,6 jsou normovane OG vektory; T_ vysledna transformace
      transform T_;
      (0,0) transformed T_ = dD0;
      (1,0) transformed T_ = dD0+dD5;
      (0,1) transformed T_ = dD0+dD6;
      T_
    endgroup
  enddef;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         Treti cast                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Translace ve 3D
  def shifted_dD(expr tD_s) =
    begingroup save tDx,tDy,tDz; tD0=tD_s; shifted.dD0 
  endgroup enddef;

  primarydef tD_w shifted_tD tD_t =
    begingroup save tDx,tDy,tDz; 
      tD0=tD_w;
      tD1=tD_t;
      tD1+tD0
    endgroup
  enddef;

% Rotace okolo os ve 3D
  primarydef pt SpRotateX_tD phi =
    begingroup.save tDx,tDy,tDz,x,y; tD0=pt;
    z0=(tDy0,tDz0).rotated(phi); tD1=(tDx0,x0,y0); 
    tD1 endgroup enddef;
  primarydef pt SpRotateY_tD phi =
    begingroup.save tDx,tDy,tDz,x,y; tD0=pt;
    z0=(tDz0,tDx0).rotated(phi); tD1=(y0,tDy0,x0); 
    tD1 endgroup enddef;
  primarydef pt SpRotateZ_tD phi =
    begingroup.save tDx,tDy,tDz,x,y; tD0=pt;
    z0=(tDx0,tDy0).rotated(phi); tD1=(x0,y0,tDz0); 
    tD1 endgroup enddef;

% Rotace pt okolo normaloveho vektoru nP->nK o uhel phi
  def rotate_tD(expr pt,nP,nK,phi) =
    begingroup save tDx, tDy, tDz;
% pocatek, vektor rotace
      tD0=nP;
      tD1=nK-nP;
% vypocet uhlu: precesni, nutacni
      if tDx1++tDy1=0: cz := 1;   sz := 0; 
      else: cz := tDy1/(tDx1++tDy1); sz := tDx1/(tDx1++tDy1); 
      fi;
      if (tDx1++tDy1++tDz1)=0: cx := 1;  sx := 0;
      else: cx := tDz1/(tDx1++tDy1++tDz1); sx := (tDx1++tDy1)/(tDx1++tDy1++tDz1);
      fi;

      phiZ:=arccosd(cz);
      phiX:=arccosd(cx);
show phiZ;
show phiX;
% posunuti do pocatku
      tD2=pt.shifted_tD.-tD0;
% nutace
      tDx3 = cz*tDx2 - sz*tDy2;
      tDy3 = sz*tDx2 + cz*tDy2;
      tDz3 = tDz2;
% precese
      tDx4 = tDx3;
      tDy4 = cx*tDy3 - sx*tDz3;
      tDz4 = sx*tDy3 + cx*tDz3;
% rotace okolo te spr. osy
      tDx5 = cosd(phi)*tDx4 - sind(phi)*tDy4;
      tDy5 = sind(phi)*tDx4 + cosd(phi)*tDy4;
      tDz5 = tDz4;
% precese zpet
      tDx6 = tDx5;
      tDy6 =  cx*tDy5 + sx*tDz5;
      tDz6 = -sx*tDy5 + cx*tDz5;
% nutace zpet
      tDx7 =  cz*tDx6 + sz*tDy6;
      tDy7 = -sz*tDx6 + cz*tDy6;
      tDz7 = tDz6;
% posun zpet
      tD8=tD7.shifted_tD.tD0;
      tD8
    endgroup
  enddef;
