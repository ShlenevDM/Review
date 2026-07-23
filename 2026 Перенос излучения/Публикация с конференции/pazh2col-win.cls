%% This is pazh2col-win.cls, version December 15, 2023.
%% This LaTeX class is intended to emulate the layout of "Pis'ma v Astronomicheskii Zhurnal".
%% Written by Alexander Potekhin (Ioffe Institute) <palex-spb@yandex.ru>.
%% Please report any discovered bugs to the above address!
%% This class file can be freely used and redistributed
%%  according to the LaTeX Project Public License (LPPL).

\NeedsTeXFormat{LaTeX2e}

\ProvidesPackage{pazh2col-win}[2023-15-12 LaTeX package for emulation of
"Pis'ma v Astronomicheskii Zhurnal"]

\LoadClass[a4paper,twocolumn,twoside,11pt]{article}

\AtEndOfPackage{
\makeatletter
\renewcommand{\@oddfoot}{\small \phantom{xxx} \journame\hfill}
\renewcommand{\@evenfoot}{\small \hfill \journame\phantom{xxx}}
\makeatother
}

\RequirePackage[T2A,T1]{fontenc}
\RequirePackage[cp1251]{inputenc}
\RequirePackage[english,russian]{babel}
\RequirePackage{indentfirst}
\RequirePackage{abstract}
\RequirePackage[hang,flushmargin]{footmisc}
\RequirePackage{caption}
\AtEndOfPackage{
\captionsetup{labelsep=period,labelfont={bf,small},textfont=small,singlelinecheck=false}
}

\pagestyle{myheadings}
\textwidth=180mm
\textheight=240mm
\voffset=-20mm
\def\baselinestretch{.9}
\setlength{\oddsidemargin}{-10mm}
\setlength{\evensidemargin}{-10mm}
\setlength{\columnsep}{5.5mm}

\makeatletter
\newcommand{\nextauth}{%
 \@ifnextchar[{\nextauth@email}{\nextauth@nothing}%
}
\newcommand{\nextauth@nothing}[2]{%
  \phantom{,}#1$^{#2}$\hspace{-3pt}
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
\title{\expandafter\MakeUppercase\expandafter{\Large\bf{#2}}}
\markright{\expandafter\MakeUppercase\expandafter{\small\hfill\rm #1 \hfill}}
}

\newcommand{\authors}[2][]{
   \author{\parbox{.9\linewidth}{\centering\normalsize%
   \textbf{\copyrights ~ #2}}}
   \markboth{\small\rm \hfill #1 \hfill}{}
   }


\newcounter{affil}
\setcounter{affil}{0}

\newcommand{\nextaffil}[1]{%
  \stepcounter{affil}
  {\normalsize$^{\arabic{affil}}$\textit{#1}}\\
}

\newcommand{\affiliations}[1]{
\date{\vspace*{-1ex}{
#1
}
 {\small \postupila}
}
}

\newcommand{\keywords}[1]{%
\phantom{x}\\
\phantom{x}\\
\noindent\textit{{\keywordsname}:} #1}
\newcommand{\doi}[1]{%
\phantom{x}\\
\phantom{x}\\
\noindent\textbf{DOI:} #1}

\newcommand{\wideabstract}[1]{
\twocolumn[
    \begin{onecolabstract}    
   \maketitle
   \vspace*{-1ex}\small\noindent#1
\vspace{\baselineskip}
\end{onecolabstract}
]
\saythanks % typesets any \thanks commands
}

%% Formatting sections' titles:
\makeatletter
\renewcommand\section{%
  \@startsection{section}% name
    {1}% level
    {0pt}% indent
    {-3.5ex plus -1ex minus -.2ex}% beforeskip
    {2.3ex plus.2ex}% afterskip
    {\centering\expandafter\MakeUppercase\expandafter}% style
  }
\renewcommand\subsection{%
  \@startsection{subsection}% name
    {2}% level
    {0pt}% indent
    {-3.5ex plus -1ex minus -.2ex}% beforeskip
    {2.3ex plus.2ex}% afterskip
    {\centering\slshape}% style
  }
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
    {-1ex\@plus -1ex \@minus -.2ex}%
    {-1.5ex \@plus -.2ex}% Formerly 1.5ex \@plus .2ex
    {\normalfont\normalsize\bfseries}% style
  }
\renewcommand{\@seccntformat}[1]{\csname the#1\endcsname.\,\,\,\,% put dot and space after section number
  \expandafter\ifx\csname c@#1\endcsname \c@subsubsection% decrease space before subsubsection title
    \!% decrease space before subsubsection title
  \fi
}
\makeatother

% ------------------
\AtBeginDocument{

\def\spislit{\small СПИСОК ЛИТЕРАТУРЫ}
\def\emailname{Электронный адрес}
\def\keywordsname{Ключевые слова}
\renewcommand{\figurename}{{\small\textbf{Риc.}}}
\renewcommand{\tablename}{{\small\textbf{Таблица}}}
\def\copyrights{\copyright~\the\year{}~г.}
\def\postupila{Поступила в редакцию ??.??.20??~г. \\ 
После доработки ??.??.20??~г.; принята к публикации ??.??.20??~г.}
\def\journame{ПИСЬМА В АСТРОНОМИЧЕСКИЙ ЖУРНАЛ ~ том ?? ~ \textnumero~?? ~ 20??}
\renewcommand{\abstractname}{\vspace*{-8ex}}

\newenvironment{references}{
\vspace*{3ex}
\centerline{\spislit} 
\begin{enumerate}
\setlength{\itemsep}{-.7\parsep}
\small
\vspace*{-2ex}
}{\end{enumerate}}
\newcommand{\reference}{\item}


% ------------------

% ABBREVIATIONS OF JOURNALS:
% BORROWED FROM pazh.sty prepared by S.Grebenev (IKI, Moscow; May 5, 1996)
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
\def\mnras{\rm{MNRAS}}
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
\def\azh{\rm{Астрон.\ журн.}}
\def\pazh{\rm{Письма в Астрон.\ журн.}}
}

