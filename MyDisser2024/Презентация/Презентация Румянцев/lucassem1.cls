%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% lucassem document class for use with seminar package
% (help from cernsem.cls of M. Goossens is gratefully acknowledged)
%
% Lucas Taylor  4 Aug 1996
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Modified by H.C.Huang:
% - Set heading of Slide and Slide* environments to blue color
%
%
\typeout{ }
\typeout{*******************************************************************}
\typeout{*}
\typeout{*    Loading lucassem document class   by: Lucas Taylor }
\typeout{*}
\typeout{*    04 Aug 1996  1st version}
\typeout{*    18 Mar 1997  2nd version: arbitrary colours}
\typeout{*    08 Jul 1997  3rd version: logos, slide title style, subtitle}
\typeout{*}
\typeout{*******************************************************************}
\typeout{ }
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Identification of package
% -------------------------
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{lucassem}[1996/08/04 Lucas Taylor's seminar package extension]
%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{seminar}}% initial code
\ProcessOptions%                                               execution of options
\RequirePackage[usenames]{pstcol}
\LoadClass{seminar}%                                           package loading              
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Loading of useful style files/packages
% --------------------------------------
\input{semcolor.sty}%
\input{sem-page.sty}%
\input{slidesec.sty}%
%
\usepackage{fancybox}%                 
\usepackage{shadow}%                                          
\usepackage{epsf}%                                          
\usepackage{epsfig}%  
\usepackage{pifont}%                                     
\usepackage{ifthen}%                                     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%  Define new colours
% -------------------
%   
\definecolor{darkred}{rgb}{0.75,0.0,0.0}
\definecolor{darkgreen}{rgb}{0.0,0.6,0.0}
\definecolor{darkblue}{rgb}{0.0,0.0,0.6}
% 
\definecolor{darkcyan}{rgb}{0.0,0.6,0.6}
\definecolor{darkmagenta}{rgb}{0.6,0.0,0.6}
\definecolor{darkyellow}{rgb}{0.6,0.6,0.0}
% 
\definecolor{lightred}{rgb}{1.0,0.9,0.9}
\definecolor{lightgreen}{rgb}{0.9,1.0,0.9}
\definecolor{lightblue}{rgb}{0.9,0.9,1.0}
% 
\definecolor{lightcyan}{rgb}{0.8,1.0,1.0}
\definecolor{lightmagenta}{rgb}{1.0,0.8,1.0}
\definecolor{lightyellow}{rgb}{1.0,1.0,0.8}
% 
\definecolor{paleyellow}{rgb}{1.00,1.0,0.80}
\definecolor{amber}{rgb}{1.0,0.8,0.0}
\definecolor{darkamber}{rgb}{1.0,0.5,0.0}
%---------------------------------------------------------- 
% 
%  Make dark colours black (light ones become lighter, white, or grey scale)
% 
\newcommand{\blackandwhite}{%
% 
\definecolor{red}{rgb}{0.0,0.0,0.0}
\definecolor{green}{rgb}{0.0,0.0,0.0}
\definecolor{blue}{rgb}{0.0,0.0,0.0}
% 
\definecolor{cyan}{rgb}{0.0,0.0,0.0}
\definecolor{magenta}{rgb}{0.0,0.0,0.0}
\definecolor{yellow}{rgb}{1.0,1.0,0.6}
% 
\definecolor{darkred}{rgb}{0.0,0.0,0.0}
\definecolor{darkgreen}{rgb}{0.0,0.0,0.0}
\definecolor{darkblue}{rgb}{0.0,0.0,0.0}
% 
\definecolor{darkcyan}{rgb}{0.0,0.0,0.0}
\definecolor{darkmagenta}{rgb}{0.0,0.0,0.0}
\definecolor{darkyellow}{rgb}{0.0,0.0,0.0}
% 
\definecolor{paleyellow}{rgb}{1.00,1.0,0.85}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%  Define short aliases for colours
% ---------------------------------
%   
\renewcommand{\black}{\color{black}}
\renewcommand{\white}{\color{white}}
%   
\renewcommand{\red}{\color{red}}
\renewcommand{\green}{\color{green}}
\renewcommand{\blue}{\color{blue}}
%   
\renewcommand{\cyan}{\color{cyan}}
\renewcommand{\magenta}{\color{magenta}}
\renewcommand{\yellow}{\color{yellow}}
%   
\newcommand{\darkred}{\color{darkred}}
\newcommand{\darkgreen}{\color{darkgreen}}
\newcommand{\darkblue}{\color{darkblue}}
%   
\newcommand{\darkcyan}{\color{darkcyan}}
\newcommand{\darkmagenta}{\color{darkmagenta}}
\newcommand{\darkyellow}{\color{darkyellow}}
%   
\newcommand{\lightred}{\color{lightred}}
\newcommand{\lightgreen}{\color{lightgreen}}
\newcommand{\lightblue}{\color{lightblue}}
%   
\newcommand{\lightcyan}{\color{lightcyan}}
\newcommand{\lightmagenta}{\color{lightmagenta}}
\newcommand{\lightyellow}{\color{lightyellow}}
%   
\newcommand{\paleyellow}{\color{paleyellow}}
\newcommand{\amber}{\color{amber}}
\newcommand{\darkamber}{\color{darkamber}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Define proper length parameters for above sizes (so we can scale them later)
% -----------------------------------------------
%
\newlength{\paperheightlength}
\newlength{\paperwidthlength}
%
\setlength{\paperheightlength}{\paperheight}
\setlength{\paperwidthlength}{\paperwidth}
%
%\def\printlandscape{\special{papersize=\paperheight,\paperwidth}}
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Define dimensions for slide (limited by size colour printers can work to!)
% ---------------------------
%  
\setlength{\slideheight}{0.75\paperwidthlength}%    Slide height (landscape mode!!!)
\setlength{\slidewidth}{0.75\paperheightlength}%    Slide width  (landscape mode!!!)
%  
\setlength{\slideframesep}{5mm}%                   Seperation of frame and slide contents
\setlength{\slideframewidth}{0.9mm}%               Thickness of line of frame
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Margins of full slide with respect to paper size (N.B. including headers/footers) 
% ------------------------------------------------
%
% Height and width always in landscape for slide (but not paper size!) 
%
\newlength{\slidetotalvertmargin}
\newlength{\slidetotalhorimargin}
%
\newlength{\slidetopmarginlength}
\newlength{\slidebottommarginlength}
\newlength{\slideleftmarginlength}
\newlength{\sliderightmarginlength}
%
\setlength{\slidetotalvertmargin}{\paperwidthlength}% 
\setlength{\slidetotalhorimargin}{\paperheightlength}% 
%
\addtolength{\slidetotalvertmargin}{-1.0\slideheight}%        
\addtolength{\slidetotalhorimargin}{-1.0\slidewidth}%      
%
\setlength{\slidetopmarginlength}{0.35\slidetotalvertmargin}%  
\setlength{\slidebottommarginlength}{0.75\slidetotalvertmargin}%  
%
\setlength{\slideleftmarginlength}{0.3\slidetotalhorimargin}%  
\setlength{\sliderightmarginlength}{0.3\slidetotalhorimargin}%  
%
\renewcommand{\slidetopmargin}{\slidetopmarginlength}
\renewcommand{\slidebottommargin}{\slidebottommarginlength}
\renewcommand{\slideleftmargin}{\slideleftmarginlength}
\renewcommand{\sliderightmargin}{\sliderightmarginlength}
%
% hard wire (need to know FRAME size above, not \slideheight and \slidewidth)
%
\renewcommand{\slidetopmargin}{20mm}
\renewcommand{\slidebottommargin}{29mm}
%
\renewcommand{\slideleftmargin}{21mm}
\renewcommand{\sliderightmargin}{21mm}
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Slide spacing parameters 
% ------------------------
%
\renewcommand{\slidepartopsep}{1ex minus 0.4ex}      
\renewcommand{\slidestretch}{1.0}      
\renewcommand{\slidearraystretch}{1.0}      
\renewcommand{\slideparskip}{0.7ex plus 0.2ex minus 0.2ex}      
\renewcommand{\slideparindent}{0.0mm}      
\renewcommand{\slidefootnotesep}{1.2ex}      
\renewcommand{\slideleftmargini}{1.8em}      
\renewcommand{\slideleftmarginii}{1.4em}      
\renewcommand{\slideleftmarginii}{0.5em}      
\renewcommand{\slideitemsep}{0.1ex plus 0.1ex minus 0.1ex}      
%
%\def\slideleftmargini{1.8em}
%\def\slideleftmarginii{1.4em}
%\def\slideleftmarginiii{1em}
%\def\slidelabelsep{.5em}
%\def\slideitemsep{6.2ex minus .1ex}
%\def\slidepartopsep{1ex minus .2ex}
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Define address "command"
% -----------------------
%
\def\address#1{\gdef\@address{#1}}
\gdef\@address{}
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Define subtitle "command"
% -----------------------
%
\def\subtitle#1{\gdef\@subtitle{#1}}
\gdef\@subtitle{}
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Define conference "command"
% --------------------------
%
\def\conference#1{\gdef\@conference{#1}}
\gdef\@conference{}
%
%
% Define mainconference "command"
% --------------------------
%
\def\mainconference#1{\gdef\@mainconference{#1}}
\gdef\@mainconference{}
%
%
% Define subconference "command"
% --------------------------
%
\def\subconference#1{\gdef\@subconference{#1}}
\gdef\@subconference{}
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Define \defaultslideframe command 
% ---------------------------------
%
\def\Framedefault{scplain}
\newcommand{\defaultslideframe}[1]{\def\Framedefault{#1}}
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Define \defaultfontfamily command 
% ---------------------------------
%
\def\Fontfamily{cmss}
\newcommand{\defaultfontfamily}[1]{\def\Fontfamily{#1}}
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Define \leftlogofile command 
% ----------------------------
%
\def\leftlogofile#1{\gdef\@leftlogofile{#1}}
\gdef\@leftlogofile{}
%
\leftlogofile{dummy.eps}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Define \rightlogofile command 
% ----------------------------
%
\def\rightlogofile#1{\gdef\@rightlogofile{#1}}
\gdef\@rightlogofile{}
%
\rightlogofile{dummy.eps}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Define \defaultcolor command
% --------------------------
%
\def\thedefaultcolor{black}
\newcommand{\defaultcolor}[1]{\def\thedefaultcolor{#1}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Define \defaultbkgcolor "command"
% --------------------------------
%
\def\thedefaultbkgcolor{white}
\newcommand{\defaultbkgcolor}[1]{\def\thedefaultbkgcolor{#1}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Define \slidetitlestyle command 
% -------------------------------
%
\def\theslidetitlestyle{basic}
\newcommand{\slidetitlestyle}[1]{\def\theslidetitlestyle{#1}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Redefine the slidemaketitle command
% -----------------------------------
%
\renewcommand{\slidemaketitle}{%
  \null
  \begin{center}
    \def\baselinestretch{1.2}\large\small
%
%     \renewcommand{\sboxsep}{0pt}
%     \renewcommand{\sboxrule}{1pt}
%     \shabox{% 
%     \fcolorbox{red}{yellow}{%
%    {\Large\bfseries\@title}}}\par%
%    
    \coolbox{darkgreen}{darkgreen}{white}{\Large\bfseries\@title}\par%
%    
    {\ifx\@subtitle\@empty\else 
      \begin{tabular}[t]{c}
        {\@subtitle}
      \end{tabular}\par 
      \fi\relax
    }%
%    
    {\lineskip .8em
    \begin{tabular}[t]{c}
       {\bfseries \large\@author}
       \ifx\@address\@empty\else\\
       {\large\@address}\fi\relax
    \end{tabular}\par}%
%    
    {\lineskip .6em
    \begin{tabular}[t]{c}
       {\bfseries \large\@date}
       \ifx\@conference\@empty\else\\
       {\large\@conference}\fi\relax
    \end{tabular}\par}%
    \def\baselinestretch{1.0}
%    
  \end{center}%
  \par\vskip .5em}
%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Define the slidemakewidetitle command
% ------------------------------------
%
\newcommand{\slidemakewidetitle}{%
  \null
  \begin{center}
    \def\baselinestretch{1}\large\small
%
%     \renewcommand{\sboxsep}{0pt}
%     \renewcommand{\sboxrule}{1pt}
%     \shabox{% 
%     \fcolorbox{red}{yellow}{%
%    {\parbox{0.8\textwidth}{\begin{center}\Large\bfseries\@title\end{center}}}}}\par%
%    
    \lineskip 3em
    \coolbox{blue}{blue}{lightcyan}
    {\parbox{0.7\textwidth}{\begin{center}\LARGE\bfseries\@title\end{center}}}\par%
%    
    {\ifx\@subtitle\@empty\else 
      \begin{tabular}[t]{c}
        {\@subtitle}
      \end{tabular}\par 
      \fi\relax
    }%
%    
    {\lineskip 3em
    \begin{tabular}[t]{c}
       {\bfseries \Large\@author}
       \ifx\@address\@empty\else\\{\large\@address}\fi\relax
    \end{tabular}\par}%
%
    {\lineskip 1em
    \begin{tabular}[t]{c}
%       {representing the} \\
%       {\bfseries \large Belle Collaboration}
    \end{tabular}\par}%
%    
	\vspace{8pt}
    {\lineskip 3em \darkgreen
    \begin{tabular}[t]{c}
       \ifx\@mainconference\@empty\else{\bfseries \large\@mainconference}\\\fi\relax
       \ifx\@subconference\@empty\else{\bfseries \@subconference}
						 \vspace{6pt} \\ \fi\relax
       {\large\@date}
    \end{tabular}\par}%
%    
  \end{center}%
  \par\vskip .5em}
%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Slide headings 
%---------------
%
\newlength{\basictitleleftoffset} 
% 
\def\@@empty{} 
\renewcommand{\makeslideheading}[1]{%
  \gdef\theslideheading{#1}%
  \def\@@foo{#1}%
  \ifx\@@foo\@@empty\else
%
%
% Choose style of title
% ---------------------
%
\ifthenelse{\equal{\theslidetitlestyle}{shadow}}
{%--------------------------------------------------------------------------
  \vspace*{-11mm}% Move up a bit 
  \begin{Sbox}
    \bgroup
    \begin{Bcenter}
      {\large\bfseries{#1}}
    \end{Bcenter}
    \egroup
  \end{Sbox}
  \centerline{\setlength{\fboxrule}{0.9pt}%         thickness of line
     \renewcommand{\shadowsize}{2.0pt}%             thickness of shadow
     \colorbox{white}{\shadowbox{\TheSbox}}}
}%--------------------------------------------------------------------------
{%--------------------------------------------------------------------------
\ifthenelse{\equal{\@leftlogofile}{dummy.eps}}
{\setlength{\basictitleleftoffset}{0.02\textheight}}
{\setlength{\basictitleleftoffset}{0.05\textheight}}
  \vspace*{-9.0mm}% Move up a bit 
  \begin{Sbox}
    \bgroup
    \begin{Bcenter}
      {\large{\em{#1}}}
    \end{Bcenter}
    \egroup
  \end{Sbox}
  \hspace*{\basictitleleftoffset}{\setlength{\fboxrule}{0.9pt}%                    thickness of line
     \colorbox{white}{{\TheSbox}}}
}%--------------------------------------------------------------------------
%
%
\vspace{1.0ex minus 0.5ex}
\par
\fi
\SlideFront}
%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Define logo drawing command (used internally by slide style commands below)
% ---------------------------
%
\newlength{\droplength}
%
\newcommand{\drawlogos}%
{%
\setlength{\droplength}{-2.8mm}
\addtolength{\droplength}{-0.09\textheight}
%
\ifthenelse{\equal{\@leftlogofile}{dummy.eps}}
{%
\typeout{ }
\typeout{lucassem.cls: left  logo file is dummy or undefined. Continuing...}
\typeout{ }
}%
{\hspace*{-5mm}\raisebox{\droplength}{%           
\psframebox%
[linecolor=white,fillcolor=white,fillstyle=solid]
{\includegraphics*[height=8mm]{\@leftlogofile}}}}%
%
\hspace*{\fill}%                                           
%
%
\ifthenelse{\equal{\@rightlogofile}{dummy.eps}}
{%
\typeout{ }
\typeout{lucassem.cls: right logo file is dummy or undefined. Continuing...}
\typeout{ }
}%
{\hfill\raisebox{\droplength}{%
\psframebox%
[linecolor=white,fillcolor=white,fillstyle=solid]
{\includegraphics*[height=11mm]{\@rightlogofile}}}}%
%
}%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Slide styles
% ------------
%
%
%-------------------------------------------------------------------------------
\newpagestyle{basic}%
{\drawlogos}%                                                                                       Stuff at the top
{\color{\thedefaultcolor}\tiny{\bfseries\@author}\hfil{\bfseries\@title}\hfil{\bfseries\@date}}%    Stuff at the bottom
%
%-------------------------------------------------------------------------------
\newpagestyle{detailed}{%
%
\drawlogos%                                                Start stuff at the top
}%                                                         End stuff at the top
%
{%                                                         Start stuff at the bottom
%
\parbox[t]{0.25\textwidth}{%
{
\ifx\@date\@empty\else 
{\color{darkgreen}\tiny\bfseries\@date~\\}%
\fi\relax
}%
%    
{\ifx\@conference\@empty\else 
{\color{darkgreen}\tiny\@conference}}%
\fi\relax
}%
%
\hspace*{\fill}%
%
\parbox[t]{0.5\textwidth}{%
{\begin{center}
% {\color{blue}\tiny\bfseries\@title}
% {\color{\thedefaultcolor}\ \ (page {\thepage})}\\
{\color{blue}\tiny\bfseries\@title~\\}%   
{\color{\thedefaultcolor} (page {\thepage})}\\
{\color{\thedefaultcolor}\tiny\@subtitle}%
\end{center}}}%
%
\hspace*{\fill}%
%
\parbox[t]{0.25\textwidth}{%
\flushright%
{\color{darkamber}\tiny\bfseries\@author~\\}%
{\color{darkamber}\tiny\@address}}%
%
}%                                                         End stuff at the bottom
%
%-------------------------------------------------------------------------------
\newpagestyle{detailednopagenum}{%
{\drawlogos}%                                              Stuff at the top
%
}%                                                         End stuff at the top
%
{%                                                         Start stuff at the bottom
%
\parbox[t]{0.25\textwidth}{%
{
\ifx\@date\@empty\else 
{\color{\thedefaultcolor}\tiny\bfseries\@date~\\}%
\fi\relax
}%
%    
{\ifx\@conference\@empty\else 
{\color{\thedefaultcolor}\tiny\@conference}}%
\fi\relax
}%
%
\hspace*{\fill}%
%
\parbox[t]{0.5\textwidth}{%
{\begin{center}
{\color{\thedefaultcolor}\tiny\bfseries\@title~\\}
{\color{\thedefaultcolor}\tiny\bfseries\@subtitle}
\end{center}}}%
%
\hspace*{\fill}%
%
\parbox[t]{0.25\textwidth}{%
\flushright%
{\color{\thedefaultcolor}\tiny\bfseries\@author~}\\%
{\color{\thedefaultcolor}\tiny\@address}}%
%
}%                                                         End stuff at the bottom
%
%-------------------------------------------------------------------------------
\newpagestyle{lucas}{%
%
\drawlogos%                                                Start stuff at the top
}%                                                         End stuff at the top
%
{%                                                         Start stuff at the bottom
%
\parbox[t]{0.2\textwidth}{%
{
\ifx\@date\@empty\else 
{\color{\thedefaultcolor}\tiny\bfseries\@date~\\}%
\fi\relax
}%
%    
{\ifx\@conference\@empty\else 
{\color{\thedefaultcolor}\tiny\@conference}}%
\fi\relax
}%
%
\hspace*{\fill}%
%
\parbox[t]{0.6\textwidth}{%
{\begin{center}%
\ifx\@title\@empty\else 
{\color{\thedefaultcolor}\tiny\bfseries\@title~\\}
\fi\relax
{\color{\thedefaultcolor}\tiny\bfseries\@subtitle}
\end{center}}}%
%
\hspace*{\fill}%
%
\parbox[t]{0.2\textwidth}{%
\flushright%
{\color{\thedefaultcolor}\tiny\bfseries{Page {\thepage}}}
}%
%
}%                                                         End stuff at the bottom
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% frame styles
% ------------
%
%-------------------------------------------------------------------------------
%
% \newslideframe{cern}
% --------------------
% {{\framecolor\SlideFront
% \boxput(-0.7,-1.11){\psframebox[%
% linecolor=black,fillcolor=yellow,fillstyle=solid]{%
% \hbox{{\normalsize\sffamily\textcolor{black}{\Semlabel}}}}}{#1}%
% }}
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% make it easy to do coloured backgrounds and text
%-------------------------------------------------
%
\def\everyslide{\SlideFront}
\def\theslideheading{}
\def\thechapterheading{}
%
\def\SlideColours#1#2{%
 \gdef\SlideFront{\color{#1}}%
 \slideframe{\Framedefault}
 \slideframe[\psset{%
bordercolor=#1,%
doublecolor=#1,%
shadowcolor=#1,%
linecolor=#1,%
fillcolor=#2,%
fillstyle=solid}%
]{\Framedefault}%
}
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% shorthand for slides
%
%-------------------------------------------
%
% Landscape slide with title 
%
\newenvironment{Slide}[2][]%
{\begin{slide}%
   \slideheading[#1]{\blue #2}\raggedright}%
{\end{slide}}%
%-------------------------------------------
%
% Portrait slide with title 
%
\newenvironment{Slide*}[2][]%
{\begin{slide*}%
   \slideheading[#1]{\blue #2}\raggedright}%
{\end{slide*}}%
%
%-------------------------------------------
% needed because of xcomment.sty...
%
\addtoslidelist{Slide}%
\addtoslidelist{Slide*}%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Magnification, n, of material on slide = 1.2**n   (e.g. n=4 => factor=2.07)
% -----------------------------------------------
%  
\slidesmag{3}%     
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Define \mathbox command
% -----------------------
%
% Usage: e.g. \mathbox{green}{blue}{Some math}
%
% Will put blue "Some math" in a green box
%
\newcommand{\mathbox}[3]
{
\begin{center} \vspace{6pt}
\colorbox{#1}{\color{#2}$\displaystyle #3$}
\end{center} \vspace{6pt}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Define \coolbox command
% -----------------------
%
% Usage: e.g. \coolbox{green}{darkgreen}{white}{Some text}
%
% Will put "Some text" in a green box with a dark green shadow and a white background
%
\newcommand{\coolbox}[4]%
{%
{%
\renewcommand{\sboxsep}{0mm}%       seperation of contents of shadow box from shadow box frame
\renewcommand{\sboxrule}{0mm}%      thickness  of line   for shadow box
\renewcommand{\sdim}{0.8mm}%        thickness  of shadow for shadow box 
\color{#2}\shabox{%
{\renewcommand{\fboxrule}{0.4mm}%   thickness of line for frame box (not shadow box)
\fcolorbox{#1}{#3}{#4}}}%
}%
}%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Define \coolepsfig command (as epsfig but put's figure in a \coolbox
% -------------------------
%
\newcommand{\coolepsfig}[1]{{\coolbox{green}{darkgreen}{white}{\epsfig{#1,clip=}}}}
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Define \doublecolumn and triplecolumn commands 
% ----------------------------------------------
%
\newlength{\leftcolwidth}%
\newlength{\middlecolwidth}%
\newlength{\rightcolwidth}%
%
%---------------------------------------------------
\newcommand{\doublecolumn}[3]%
{%
\setlength{\leftcolwidth}{#1}%
%
\setlength{\rightcolwidth}{\textwidth}%
\addtolength{\rightcolwidth}{-1.0\leftcolwidth}%
\addtolength{\rightcolwidth}{-1.5ex}%
%
\begin{minipage}{\leftcolwidth}%
{#2}
\end{minipage}%
%
\begin{minipage}{1.5ex}%
\mbox{\,}
\end{minipage}%
%
\begin{minipage}{\rightcolwidth}%
{#3}
\end{minipage}%
%
}
%
%---------------------------------------------------
\newcommand{\triplecolumn}[5]%
{%
\setlength{\leftcolwidth}{#1}%
\setlength{\middlecolwidth}{#2}%
%
\setlength{\rightcolwidth}{\textwidth}%
\addtolength{\rightcolwidth}{-1.0\leftcolwidth}%
\addtolength{\rightcolwidth}{-1.0\middlecolwidth}%
\addtolength{\rightcolwidth}{-1.5ex}%
%
\begin{minipage}{\leftcolwidth}%
{#3}
\end{minipage}%
%
\begin{minipage}{1.5ex}%
\mbox{\,}
\end{minipage}%
%
\begin{minipage}{\middlecolwidth}%
{#4}
\end{minipage}%
%
\begin{minipage}{1.5ex}%
\mbox{\,}
\end{minipage}%
%
\begin{minipage}{\rightcolwidth}%
{#5}
\end{minipage}%
%
}
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% General initialisation
% ----------------------
%
\renewcommand{\sboxsep}{0pt}
\renewcommand{\sboxrule}{1pt}
%
% rotated headers for consistency of output
%
\rotateheaderstrue
\raggedright
\centerslidesfalse            % centre material vertically on slide
%
\renewcommand{\familydefault}{\Fontfamily}%   sans-serif font by default
%
\pagestyle{basic}
\slideframe{\Framedefault}
\SlideColours{\thedefaultcolor}{\thedefaultbkgcolor}
%
\title{}
\author{}
\address{}
\date{}
\conference{}
\normalsize
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\endinput












