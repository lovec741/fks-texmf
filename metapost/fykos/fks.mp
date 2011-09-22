%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                             %
% newfks.mp     v1.0                                          %
%                                                             %
% makra pro sazbu obrazku Fyzikalniho                         %
% korespondencniho seminare MFF UK                            %
%                                                             %
% vzniklo obohacenim starsiho fks.mp                          %
%                                                             %
% Jan Houstek, 12. 2001                                       %
%                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% základní jednotka
  u=1mm;

% èerchovaná èára (pou¾ití: draw ... dashed cerch [scaled ...] )
  picture cerch, cark;
  cerch=dashpattern(on 2bp off 1.5bp on 0.5bp off 1.5bp on 2bp);
  cark=dashpattern(on 3bp off 3bp on 3bp);

% zvìt¹í x-krát aktuální pero (po pou¾ití je opìt nastavena pùvodní velikost)
% pou¾ití: draw ... wp x
  def wp = withpen currentpen scaled enddef;

% zvìt¹í x-krát aktuální pero (nastaví novou velikost)
  def chpen = currentpen:=currentpen scaled enddef;

% nakreslí oblouk o polomìru d se støedem v bm, výchozím smìrem bm --> bi
% a koneèným smìrem bm --> be
  def uhel(expr bi,bm,be,d)=
  begingroup
    save x,y;
    z1=unitvector(bi-bm); z2=z1 rotated 90;
    z3=unitvector(be-bm); z4=z3 rotated 90;
    draw (bm+d*z1){z2}..{z4}(bm+d*z3)
  endgroup
  enddef;

% stejné jako úhel, pouze be je dopoèítané a je pøidaná teèka pro pravý úhel
  def uhelR(expr bi,bm,d)=
    uhel(bi,bm,(bm+(bi-bm) rotated 90),d);
    drawdot 0.6d*unitvector(bi-bm) rotated 45 shifted bm wp 3
  enddef;

% nakreslí osový køí¾ se støedem v poc a rozmìry x-left/right, y-up/down,
% v¹e kladné
  def axis(expr poc,xl,xr,yd,yu)=
  begingroup
    save xp,yp;
    xp:=xpart(poc);yp:=ypart(poc);
    drawarrow(xp-xl,yp)--(xp+xr,yp);
    drawarrow(xp,yp-yd)--(xp,yp+yu)
  endgroup
  enddef;  

% srafovani
  picture sraf;
  def srafuj(expr p,smer,hust)=
  begingroup
    save x,y,i,n,uhl;
    z1=llcorner p; z2=urcorner p;
    z0=.5[z1,z2]; uhl:=abs(z0-z1);
    n:=round(uhl/hust);
    z4=uhl*unitvector(smer);
    z3=z4 rotated 90;
    sraf:=nullpicture;
    for i:=-n upto n: 
      addto sraf doublepath z0+i/n*z3+z4--z0+i/n*z3-z4 wp .5;
    endfor;
    clip sraf to p; draw sraf;
  endgroup
  enddef;

% ¹ipka s prázdnou hlavou
  def drawearrow expr p = _apth:=p; _finearr enddef;
  def drawdblearrow expr p = _apth:=p; _findearr enddef;
  def _finearr text t =
    draw _apth t;
    unfill arrowhead _apth; draw arrowhead _apth t
  enddef;
  def _findearr text t =
    draw _apth t;
    unfill arrowhead _apth; draw arrowhead _apth t;
    unfill arrowhead reverse _apth; draw arrowhead  reverse _apth t
  enddef;

% obyèejné (netroujúhelníkové) ¹ipky
  vardef varrowhead expr p =
    save q,e; path q; pair e;
    e = point length p of p;
    q = gobble(p shifted -e cutafter makepath(pencircle scaled 2ahlength))
      cuttings;
    (q rotated .5ahangle & reverse q rotated -.5ahangle)  shifted e
  enddef;
  def drawvarrow expr p = _apth:=p; _finvarr enddef;
  def drawdblvarrow expr p = _apth:=p; _findvarr enddef;
  def _finvarr text t =
    draw _apth t;
    draw varrowhead _apth t
  enddef;
  def _findvarr text t =
    draw _apth t;
    draw varrowhead _apth t;
    draw varrowhead reverse _apth t
  enddef;

% pruzina 
def pruzina(expr pocatek,konec,sirka,pocet)=
  draw((0,0) for i=1 upto (10+20*pocet):..(10+i-10*cosd(18i),sind(18i))
  endfor) xscaled(length(pocatek-konec)/(30+20*pocet)) yscaled (sirka/2)
  rotated angle(konec-pocatek) shifted pocatek;
enddef;

% prazdne kolecko
def odot(expr prumer, bod)=
  unfill fullcircle scaled 2prumer shifted bod;
  draw fullcircle scaled 2prumer shifted bod wp 2  
enddef;

% lesknoucí se kulièka
def kulicka(expr prumer,bod)=
  fill fullcircle scaled prumer shifted bod withcolor .8white;
  draw fullcircle scaled prumer shifted bod;
  fill fullcircle scaled (.6*prumer) shifted(bod+.15*prumer*dir135)
         withcolor .9white;
  fill fullcircle scaled (.4*prumer) shifted(bod+.17*prumer*dir135)
         withcolor .95white;
  erase fill fullcircle scaled (.2*prumer) shifted(bod+.19*prumer*dir135);
enddef;

