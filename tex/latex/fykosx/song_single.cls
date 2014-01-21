
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}} % je to knižka
\ProcessOptions
\LoadClass[11pt]{article}   %book
\@ifundefined{UseOption}{\def\UseOption{web}}{} %zaital nenastavné 
\RequirePackage{amsfonts,amsmath,amssymb,graphicx,color}
\RequirePackage{fancyhdr}
\linespread{1.3}
\RequirePackage{graphicx}
\RequirePackage[xetex,
  setpagesize=false,
  linkcolor=black,
  anchorcolor=black,
  citecolor=black,
  filecolor=black,
  urlcolor=black,
  bookmarks=true,
  bookmarksdepth=subsection,
]{hyperref}
\RequirePackage{optional}
\RequirePackage{amssymb} 
\RequirePackage[no-math]{fontspec}
\RequirePackage{xltxtra}
\RequirePackage{pgffor}
\RequirePackage{lastpage}
\UndeclareUTFcharacter[\UTFencname]{x2026}{\textellipsis} % we want normal 
\opt{print}{\hypersetup{colorlinks=false}}
\RequirePackage[version=3]{mhchem} % možno sa zíde 
\RequirePackage{xkeyval}
\RequirePackage{etoolbox} %na sadzanie autorov


\newfontfamily\cyrillicfont[Ligatures=TeX, % recommended
ItalicFont=[cmunti.ttf],
BoldFont=[cmunbx.ttf],
BoldItalicFont=[cmunbi.ttf],
SlantedFont=[cmunsl.ttf]
]{[cmunrm.ttf]}
\RequirePackage{polyglossia}
\setdefaultlanguage{czech}
\RequirePackage{chords}
\pagestyle{plain}
\RequirePackage{fkssugar} % hlavne na MFF
\sffamily
\RequirePackage[includeheadfoot,
  twoside,
  a5paper,
  hmargin=1.55cm,  
  vmargin=1.0cm,
  headsep=0.5cm]{geometry}


\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhead{}
\fancyhead[R]{}
\fancyfoot{}
\fancyfoot[C]{\bfseries \thepage}
\fancyhead[C]{Výfučí táborový zpěvník}%}



\newif\ifsongbook
\songbookfalse



\sffamily

