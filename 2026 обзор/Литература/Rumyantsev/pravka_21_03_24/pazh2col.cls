%% This is pazh2col.cls, version July 10, 2023.
%% This LaTeX class is intended to emulate the layout of "Pis'ma v Astronomicheskii Zhurnal".
%% Written by Alexander Potekhin (Ioffe Institute).
%% This class file can be freely used and redistributed
%%  according to the LaTeX Project Public License (LPPL).

\NeedsTeXFormat{LaTeX2e}

\ProvidesPackage{pazh2col}[2023/07/10 LaTeX package for emulation of
"Pis'ma v Astronomicheskii Zhurnal"]

\LoadClass[a4paper,twocolumn,twoside,11pt]{article}

\DeclareOption{koi8-r}{\PassOptionsToPackage{koi8-r}{inputenc}
\AtEndOfPackage{
\makeatletter
\renewcommand{\@oddfoot}{\small \phantom{xxx} ПИСЬМА В АСТРОНОМИЧЕСКИЙ ЖУРНАЛ ~ том ?? ~ 
\textnumero~?? ~ 20??\hfill}
\renewcommand{\@evenfoot}{\small \hfill ПИСЬМА В АСТРОНОМИЧЕСКИЙ ЖУРНАЛ
~ том ?? ~ \textnumero~?? ~ 20??\phantom{xxx}}
\makeatother
\def\CYRg{г}
\def\spislit{СПИСОК ЛИТЕРАТУРЫ}
\def\emailname{Электронный адрес}
\def\keywordsname{Ключевые слова}
\def\postupila{Поступила в редакцию ??.??.20??~г.
  \\
  После доработки ??.??.20??~г.; принята к публикации ??.??.20??~г.}
\renewcommand{\figurename}{{\small\textbf{Риc.}}}
\renewcommand{\tablename}{{\small\textbf{Таблица}}}
\def\azh{\rm{Астрон.\ журн.}}
\def\pazh{\rm{Письма в Астрон.\ журн.}}
}
}


\ProcessOptions\relax

\RequirePackage[T2A,T1]{fontenc}
\RequirePackage{inputenc}
\RequirePackage[english,russian]{babel}
\RequirePackage{indentfirst}
\RequirePackage{abstract}
\usepackage[hang,flushmargin]{footmisc}
\RequirePackage{titlesec}
\titleformat{\section}%
  {\centering\expandafter\MakeUppercase\expandafter}{\thesection.}{0.5em}{}
\titleformat{\subsection}%
  {\centering\slshape}{\thesubsection.}{0.5em}{}
\titleformat{\subsubsection}[runin]%
{\normalfont\normalsize\bfseries}{\thesubsubsection.}{1em}{\addperiod}
\newcommand{\addperiod}[1]{#1.}
\RequirePackage{caption}
\AtEndOfPackage{
\captionsetup{labelsep=period,labelfont={bf,small},textfont=small,justification=raggedright,singlelinecheck=false}
}

\pagestyle{myheadings}
\textwidth=178mm
\textheight=237mm
\voffset=-15mm
\def\baselinestretch{.95}
\setlength{\oddsidemargin}{-10mm}
\setlength{\evensidemargin}{-10mm}
\setlength{\columnsep}{5.5mm}

\makeatletter
\newcommand{\nextauth}{%
 \@ifnextchar[{\nextauth@email}{\nextauth@nothing}%
}
\newcommand{\nextauth@nothing}[2]{%
  \phantom{x}#1$^{#2}$\hspace{-3pt}
}
\newcommand{\nextauth@email}[3][]{%
\if\relax\detokenize{#1}\relax
 \phantom{x}#2$^{#3}$
\else
 \phantom{x}#2$^{#3}$\thanks{\emailname: \texttt{#1}}\,\,%
\fi
}
\makeatother

\newcommand{\titles}[2][]{
\title{\expandafter\MakeUppercase\expandafter{\bf{#2}}}
\markright{\expandafter\MakeUppercase\expandafter{\small\hfill\rm #1 \hfill}}
}

\newcommand{\authors}[2][]{
   \author{\textbf{\copyright~\the\year{}~\CYRg. ~ #2}}%
   \markboth{\rm \hfill #1 \hfill}{}
   }


\newcounter{affil}
\setcounter{affil}{0}

\newcommand{\nextaffil}[1]{%
  \stepcounter{affil}
  $^{\arabic{affil}}$\textit{#1}\\
}

\newcommand{\affiliations}[1]{
\date{{
#1
}
\vspace{1ex}
  {\small \postupila}
}
}

\newcommand{\keywords}[1]{%
\phantom{x}\\
\noindent\textit{{\keywordsname}:} #1}
\newcommand{\doi}[1]{%
\phantom{x}\\
\noindent\textbf{DOI:} #1}

\newcommand{\wideabstract}[1]{
\twocolumn[
    \begin{onecolabstract}    
   \maketitle
   \noindent\normalsize
#1
\vspace{\baselineskip}
\end{onecolabstract}
]
\saythanks % typesets any \thanks commands
}



% ------------------
\AtBeginDocument{
  
  \renewcommand{\abstractname}{\vspace*{-8ex}}

\newenvironment{references}{
\vspace*{3ex}
\centerline{\spislit} 
\begin{enumerate}
\setlength{\itemsep}{-.5\parsep}
\small
\vspace*{-2ex}
}{\end{enumerate}}
\newcommand{\reference}{\item}
}

% ------------------

% ABBREVIATIONS OF JOURNALS:
% BORROWED FROM pazh.sty  prepared by S.Grebenev (IKI, Moscow; May 5, 1996)
%xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
\def\aap{\rm{Astron.\ Astrophys.}}
\def\aapr{\rm{Astron.\ Astrophys.\ Rev.}}
\def\aaps{\rm{Astron.\ Astrophys.\ Suppl.\ Ser.}}
\def\aj{\rm{Astron.\ J.}}
\def\ao{\rm{Appl.\ Optics}}
\def\apj{\rm{Astrophys.\ J.}}
\def\apjl{\rm{Astrophys.\ J.}}
\def\apjs{\rm{Astrophys.\ J.\ Suppl.\ Ser.}}
\def\apss{\rm{Astrophys.\ Space Sci.}}
\def\araa{\rm{Ann.\ Rev.\ Astron.\ Astrophys.}}
\def\asr{\rm{Adv.\ Space Res.}}
\def\astl{\rm{Astron.\ Lett.}}
\def\atel{\rm{Astron.\ Telegram}}
\def\baas{\rm{BAAS}}       
\def\iauc{\rm{IAU Circ.}}
\def\jrasc{\rm{JRASC}}     
\def\memras{\rm{MmRAS}}
\def\mnras{\rm{Mon.\ Not.\ Roy.\ Astron.\ Soc.}}
\def\nat{\hbox{Nature}}
\def\pra{\rm{Phys.\ Rev.\ A}}
\def\prb{\rm{Phys.\ Rev.\ B}}
\def\prc{\rm{Phys.\ Rev.\ C}}
\def\prd{\rm{Phys.\ Rev.\ D}}
\def\prl{\rm{Phys.\ Rev.\ Lett.}}    
\def\pasp{\rm{Publ.\ Astron.\ Soc.\ Pacific}}
\def\pasj{\rm{Publ.\ Astron.\ Soc.\ Japan}}
\def\qjras{\rm{QJRAS}}
\def\skytel{\rm{S\&T}}
\def\solphys{\rm{Solar~Phys.}}
\def\sovast{\rm{Sov.~Astron.}}
\def\sval{\rm{Sov.~Astron.\ Lett.}}
\def\ssr{\rm{Space~Sci.\ Rev.}}
\def\zap{\rm{ZAp}} 

