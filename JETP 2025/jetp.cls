%% jetp.cls based on etf-g.cls %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Documentation:
%%           JETP-TeX-class-5.3.txt
%%           JETP-author-notes.txt
%%
%% Packages:
%%           antibabel.sty    -- package available in typesetter mode
%%           jetpdoi.sty      -- package available in typesetter mode
%%           jetphtml.sty     -- additional package for external usage;
%%                               in its modified form is built-in
%%
%% Figures:
%%
%%           mainhead.eps -- used in title page (jetptitle1.tex)
%%           jetfhead.eps -- used in TOC        (contentshead.tex)
%%
%% Include files:
%%
%%           jetptitle1.tex   -- title page
%%           jetptitle2.tex   -- editorial staff page
%%           toc.tex          -- just {\tableofcontents}
%%           contentshead.tex -- TOC head
%%           rules1.tex       -- rules for authors 1
%%           rules2.tex       -- rules for authors 2
%%           lastpage.tex     -- issue data
%%
%% Service files:
%%
%%           jetppart.txt -- list of parts/subparts
%%                           (categories/subcategories) available
%%                           in typesetter mode
%%
%% Last update: 23/12/2015
%% (C) 2015 JETP
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{jetp}[2015/12/20 v5.2 JETP document class]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newif\ifJETPPart \JETPParttrue
\newif\if@restonecol
\newif\if@titlepage
\newif\if@mcol
\newif\if@wideon
\newif\iftypesetter \typesetterfalse
\newif\ifeditor     \editorfalse
\newif\ifjubilee    \jubileefalse

\def\@ptsize{}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Options =============================================================

\if@compatibility\else
   \DeclareOption{a4paper}{\setlength\paperheight{297mm}\setlength\paperwidth{210mm}}
   \DeclareOption{landscape}{\setlength\@tempdima{\paperheight}%
      \setlength\paperheight{\paperwidth}\setlength\paperwidth{\@tempdima}}
\fi

\if@compatibility \def\@ptsize{0}\else \DeclareOption{10pt}{\def\@ptsize{0}}\fi

\DeclareOption{11pt}{\def\@ptsize{1}}
\DeclareOption{12pt}{\def\@ptsize{2}}

\if@compatibility \else \DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse}\fi

\DeclareOption{twoside}{\@twosidetrue\@mparswitchtrue}
\DeclareOption{draft}{\setlength\overfullrule{5pt}}

\newif\ifjetpflushend \jetpflushendfalse
\DeclareOption{flushend}{\jetpflushendtrue}

\if@compatibility\else \DeclareOption{final}{\setlength\overfullrule{0pt}}\fi

\DeclareOption{titlepage}{\@titlepagetrue}

\if@compatibility\else
   \DeclareOption{notitlepage}{\@titlepagefalse}
\fi

\if@compatibility\else
   \DeclareOption{onecolumn}{\@twocolumnfalse\@mcolfalse\@wideontrue}
\fi

\DeclareOption{twocolumn}{\@twocolumntrue\@mcolfalse\@wideontrue}
\DeclareOption{mcolumn}{\@mcoltrue\@twocolumnfalse}
\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{\input{fleqn.clo}}
\DeclareOption{single}{\typesettertrue\editorfalse\JETPPartfalse}
\DeclareOption{singlearticle}{\typesettertrue\editorfalse\JETPPartfalse}
\DeclareOption{typesetter}{\typesettertrue\editorfalse}
\DeclareOption{editor}{\editortrue\typesetterfalse}
\DeclareOption{jubilee}{\jubileetrue}

\DeclareOption{openbib}{%
  \AtEndOfPackage{%
     \def\@openbib@code{\advance\leftmargin\bibindent
         \itemindent -\bibindent \listparindent\itemindent \parsep \z@}%
     \def\newblock{\par}}%
}

\newcount\JETPCP \JETPCP=0
\DeclareOption{cp1251}{\JETPCP=0}
\DeclareOption{cp866}{\JETPCP=1}
\DeclareOption{koi8-r}{\JETPCP=2}
\DeclareOption{maccyr}{\JETPCP=3}
\DeclareOption{utf8}{\JETPCP=4}

\ExecuteOptions{a4paper,10pt,twoside,onecolumn,final}%,russian}
\ProcessOptions\relax

%% =====================================================================

\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{textcase}
\RequirePackage{bm}
\let\hmbm=\hm
%%\RequirePackage{calrsfs}
\RequirePackage{multicol}
\RequirePackage{tabularx}
\RequirePackage{euscript}
\RequirePackage{calc}
\RequirePackage{cite}
\RequirePackage{indentfirst}

\RequirePackage[T1,T2A]{fontenc}

\ifeditor
   \JETPCP=0\relax \def\@ptsize{2}\def\PartName#1{}\def\SubPartName#1{}%
\fi
\iftypesetter \JETPCP=0\relax \fi

\ifcase\JETPCP \RequirePackage[cp1251]{inputenc}
           \or \RequirePackage[cp866]{inputenc}
           \or \RequirePackage[koi8-r]{inputenc}
           \or \RequirePackage[maccyr]{inputenc}
           \or \RequirePackage[utf8]{inputenc}
         \else \RequirePackage[cp1251]{inputenc} % default
\fi

\RequirePackage[english,russian]{babel}

\ifeditor \AtBeginDocument{\EditorStyle}\fi

%% Drop AntiBabel external commands by default
\let\AntiBabel\relax
\let\AntiBabelX\relax

\iftypesetter
   \usepackage{antibabel}
   \usepackage{jetpdoi}
\fi

%% Additions ===========================================================
\def\Line{\hbox to \textwidth}
\let\THINSKIP=\,
%% \def\thinspace{\hskip.16667em plus 0.05em minus 0.02em}
\def\,{\protect\ThinSpace}% allows hypehnation of the following word
\def\ThinSpace{\nobreak\kern.16667em\nobreak\hskip0pt\relax}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Article page references: see \include section below
\def\@firstpage{\expandafter\Pageref\expandafter{\Jobname firstpage}}
\def\@lastpage{\expandafter\Pageref\expandafter{\Jobname lastpage}}

\@titlepagefalse

\input{size1\@ptsize.clo} % point size commands

\AtEndOfClass{%
    \def\twocol{\twocolumn
        \RequirePackage{ftnright}%
        \renewcommand\footnoterule{\vspace*{-3pt}%
        \noindent\rule{0.4\columnwidth}{0.4pt}\vspace*{2.6pt}}%
    }
}

\def\english{\selectlanguage{english}}
\def\russian{\selectlanguage{russian}}
\let\English\english
\let\Russian\russian

\setlength\lineskip{1\p@}
%% \setlength\normallineskip{1\p@}
\def\baselinestretch{1.05}
\setlength\parskip{0\p@ \@plus \p@}
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301

\setcounter{topnumber}{2}
\setcounter{bottomnumber}{1}
\setcounter{totalnumber}{3}
\setcounter{dbltopnumber}{2}

\def\topfraction{1} % 0.7
\def\bottomfraction{0.7} % 0.3
\def\textfraction{0} % 0.2
\def\dbltopfraction{0.95} % 0.7
\def\floatpagefraction{0.9} % 0.5
\def\dblfloatpagefraction{0.9} % 0.7

%% \paperheight=285mm \paperwidth=205mm
\hoffset=-25.4mm
\voffset=-25.4mm
\topmargin=14mm
\headsep=6mm
\textwidth=170mm
\textheight=230mm
\oddsidemargin=21mm % 0pt
\evensidemargin=21mm
\headheight=12pt
\marginparsep=0pt
\marginparwidth=0pt
\footskip=9mm
\footnotesep=1mm
\tabcolsep=6pt
\def\TCS#1{\tabcolsep=#1\tabcolsep}
\setlength{\skip\footins}{15\p@ \@plus 4\p@ \@minus 2\p@}

\AtBeginDocument{%
  \addtolength{\columnsep}{8pt}%
  \addtolength{\textwidth}{10pt}%
}

%% Multicols ===========================================================
\AtEndDocument{\if@wideon\else\end{multicols}\fi}
\AtEndOfClass{%
 \if@mcol
   \RequirePackage{multicol}%
   \global\@wideonfalse
   \multicolsep=0pt   % before/after skips
   \premulticols=50pt % free space at the left of a page
   \postmulticols=20pt%
   \newlength\colwidth{} \colwidth\textwidth
   %% \advance\colwidth-10pt
   \divide\colwidth\tw@ %% ignore \colsep value?
 \fi
}

\def\JETPrule{}

\AtBeginDocument{% -----------------------------------------------------
   \def\JETPrule{\rightline{\rule[-3mm]{0.1pt}{3mm}\rule{\colwidth}{0.5pt}}}
   \def\wideonx{%
     \if@twocolumn\else
        \if@mcol
           \if@wideon\else\global\@wideontrue\par\end{multicols}\par\noindent\fi
        \fi
     \fi
   }%
   \def\wideon{%
     \if@twocolumn\else
        \if@mcol
           \if@wideon\else\global\@wideontrue\par\end{multicols}%
              \leftline{\rule{\colwidth}{.1pt}\rule{0.1pt}{2mm}}\par\noindent
           \fi
        \fi
     \fi
   }%
   \def\wideoffx{%
     \if@twocolumn\else
        \if@mcol
        \if@wideon\global\@wideonfalse\par\begin{multicols}{2}[~]\noindent\fi
        \fi
     \fi
   }%
   \def\wideoff{%
     \if@twocolumn\else
        \if@mcol
           \if@wideon\global\@wideonfalse
              \rightline{\rule[-4mm]{0.1pt}{2mm}\rule[-2mm]{\colwidth}{0.5pt}}%
              \par\begin{multicols}{2}\noindent
           \fi
        \fi
     \fi
   }%
}% ---------------------------------------------------------------------

\def\eqalign{\split}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                             Title page                             %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\Centerlast{% Last line centering
    \addtolength{\leftskip}{0pt plus 1fil}%
    \addtolength{\rightskip}{0pt plus -1fil}%
    \setlength{\parfillskip}{0pt plus 2fil}%
}

\def\centerlast#1{%  Last line centering with left/rightr skips
    \addtolength{\leftskip}{#1 plus 1fil}%
    \addtolength{\rightskip}{#1 plus -1fil}%
    \setlength{\parfillskip}{#1 plus 2fil}%
}

\def\@abstract{}
\def\@@abstract{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Calligrafic Math and Euler Script Math. * euscripr.sty             %%
%% and their protection                                               %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newif\ifLastLetter
\def\LatinU{ABCDEFGHIJKLMNOPQRSTUVWXYZ}
\def\LetterZ{Z}
\def\DefMathCmd{\expandafter\DMCycle\LatinU}
\def\UnDefMathCmd{\expandafter\UMCycle\LatinU}

\def\DoLetterKern#1#2{%
    \edef\DoLetter{{\noexpand\ensuremath\noexpand#1{\next}}}
    \expandafter\let\csname #2\next\endcsname\DoLetter
}

\def\DMCycle#1{\LastLetterfalse\def\next{#1}%
        \ifx\next\LetterZ \LastLettertrue \fi
        \DoLetterKern\mathcal c% \def\c*{\ensuremath\mathcal{*}}
        \DoLetterKern\EuScript s% \def\s*{\ensuremath\EuScript{*}}
        \ifLastLetter \let\next\relax \else \let\next\DMCycle \fi
        \next
}

\def\UMCycle#1{\LastLetterfalse\def\next{#1}%
        \ifx\next\LetterZ \LastLettertrue \fi
        \expandafter\let\csname c\next\endcsname\relax
        \expandafter\let\csname s\next\endcsname\relax
        \ifLastLetter \let\next\relax \else \let\next\UMCycle \fi
        \next
}

\DefMathCmd

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Protecting various commands for different tools: %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\FontProtect{%
    \let\rm=\relax \let\it=\relax \let\bf=\relax \let\sf=\relax
    \let\textrm=\relax \let\rmfamily=\relax
    \let\textsf=\relax \let\sffamily=\relax
    \let\texttt=\relax \let\ttfamily=\relax
    \let\textnormal=\relax \let\normalfont=\relax
    \let\textbf=\relax \let\bfseries=\relax
    \let\textmd=\relax \let\mdseries=\relax
    \let\textit=\relax \let\itshape=\relax
    \let\textsl=\relax \let\slshape=\relax
    \let\textsc=\relax \let\scshape=\relax
    \let\textup=\relax \let\upshape=\relax
    \let\Huge\relax  \let\huge\relax
    \let\LARGE\relax \let\Large\relax \let\large\relax
    \let\small\relax \let\tiny\relax
    \let\color=\relax
    \let\AE\relax \let\ae\relax
    \let\i\relax \let\j\relax \let\IJ\relax \let\ij\relax
    \let\L\relax \let\l\relax \let\O\relax \let\o\relax
    \let\OE\relax \let\oe\relax \let\ss\relax
}

\def\FontDiscard{%
    \def\rm{}\def\it{}\def\bf{}\def\sf{}%
    \def\textrm{}\def\rmfamily{}%
    \def\textsf{}\def\sffamily{}%
    \def\texttt{}\def\ttfamily{}%
    \def\textnormal{}\def\normalfont{}%
    \def\textbf{}\def\bfseries{}%
    \def\textmd{}\def\mdseries{}%
    \def\textit{}\def\itshape{}%
    \def\textsl{}\def\slshape{}%
    \def\textsc{}\def\scshape{}%
    \def\textup{}\def\upshape{}%
    \def\Huge{}\def\huge{}%
    \def\LARGE{}\def\Large{}\def\large{}%
    \def\small{}\def\tiny{}%
    \let\color=\@gobble
    \let\AE\relax \let\ae\relax
    \let\i\relax \let\j\relax \let\IJ\relax \let\ij\relax
    \let\L\relax \let\l\relax \let\O\relax \let\o\relax
    \let\OE\relax \let\oe\relax \let\ss\relax
}

\def\MathProtect{% math operators and other non robust commands
    \UnDefMathCmd
    \let\sin\relax \let\asin\relax \let\tan\relax  \let\cot\relax
    \let\cos\relax \let\acos\relax \let\atan\relax \let\acot\relax
    \let\tg\relax  \let\arctg\relax
    \let\ctg\relax \let\arcctg\relax
    \let\sec\relax \let\asec\relax \let\arcsec\relax \let\csc\relax
    \let\cosec\relax \let\acosec\relax \let\arccosec\relax
    \let\sinh\relax \let\cosh\relax \let\tanh\relax \let\coth\relax
    \let\sh\relax \let\arsh\relax \let\ch\relax \let\arch\relax
    \let\th\relax \let\arth\relax \let\cth\relax \let\arcth\relax
    \let\Sp\relax \let\Re\relax \let\Im\relax
    \let\exp\relax \let\sqrt\relax \let\hat\relax \let\erf\relax
    \let\min\relax \let\max\relax
    \let\sum\relax \let\int\relax \let\prod\relax
    \let\lim\relax \let\liminf\relax \let\limsup\relax \let\arg\relax
    \let\tilde\relax \let\text\relax
    \let\mathbb\relax \let\mathbf\relax \let\mathrm\relax \let\mathcal\relax
    \let\otimes\relax \let\oplus\relax
    \let\operatorname\relax
    \let\{\relax \let\}\relax \let\[\relax \let\]\relax
    \let\bar\relax \let\overbar\relax \let\overline\relax
    \let\langle\relax \let\rangle\relax
    \def\qopname##1##2{\noexpand\operatorname}% protect function names
    \def\qopnamewl@##1##2{\noexpand\operatorname}% protect function names
    \let\deg\relax \let\det\relax \let\dim\relax \let\gcd\relax
    \let\hom\relax \let\inf\relax \let\injlim\relax
    \let\ker\relax \let\ln\relax \let\lg\relax \let\log\relax
    \let\Pr\relax \let\projlim\relax \let\sup\relax
    \let\varinjlim\relax \let\varprojlim\relax
    \let\varliminf\relax \let\varlimsup\relax
    \let\dot\relax \let\ddot\relax \let\dddot\relax
}

\def\UnChem{%
   \def\chem{}\def\@chem{}\def\echem{}\def\@echem{}\def\Chem{}\def\@Chem{}%
}

\def\ChemProtect{%
   \let\chem=\relax \let\@chem=\relax
   \let\echem=\relax \let\@echem=\relax
   \let\Chem=\relax \let\@Chem=\relax
}

\def\EtcProtect{%
    \def\unhbox{}\def\voidb@x{}\let\penalty\@gobble \let\fbox\relax
    \let\cite\relax
    \let\dots\relax \let\ldots\relax \let\cdots\relax
}

\def\BreaksProtectA{%
    \let\break\space
    \let\sectionbreak\space
    \let\tocbreak\space
    \def\tochyphen{}%
    \let\-=\relax
    \def\discretionary##1##2##3{}%
}

\def\BreaksProtectB{%
    \let\@sectionbreak\space
    \let\@tocbreak\relax
    \let\@tochyphen\relax
}

\def\AccentProtect{%
    \let\'=\relax \let\`=\relax \let\"=\relax
    \let\i=\relax \let\j=\relax
    \let\c=\relax \let\v=\relax \let\~=\relax \let\==\relax
    \let\^=\relax
}

\let\UserProtect\relax
\let\UserInfoProtect\relax
\let\UserIndexProtect\relax
\let\UserTOCProtect\relax

\def\InfoProtect{%
    \AntiBabelX % protect Russian letters and decode \CYR*/\cyr*
    % Additional protection (place volatile and unwanted commands here)
    \MathProtect
    % Font commands
    \FontDiscard
    \def\lc##1{##1}\def\bm##1{##1}\UnChem \let\oe\relax \let\ss\relax
    \EtcProtect \def\_{\string_}\AccentProtect
    % Spacing
    \let\tmspace\@gobble \let\thinmuskip\@gobble \let\vspace\@gobble
    \let\par=\space \let~=\space \let\\=\space \let\ =\space
    \def\,{}%
    \def\ThinSpace{}%
    % Breaks
    \BreaksProtectA
    \def\dots{...}%
    \def\-{}%
    \UserProtect
    \UserInfoProtect
}

\def\IndexProtect{%
    \AntiBabelX % protect Russian letters and decode \CYR*/\cyr*
    % Additional protection (place volatile and unwanted commands here)
    \MathProtect
    % Font commands
    \FontProtect
    \let\lc\relax\let\bm=\relax \UnChem \let\oe\relax \let\ss\relax
    \EtcProtect \let\@M=\space \let\_=\relax \AccentProtect
    % Spacing
    \let\tmspace\@gobble \let\thinmuskip\@gobble \let\vspace\@gobble
    \let\par=\relax \let~=\relax \def\\##1{\space##1}%
    \let\ =\space \let\,=\relax \let\ThinSpace\relax
    % Breaks
    \BreaksProtectA
    \UserProtect
    \UserIndexProtect
}

\def\TOCProtect{%
    \AntiBabelX % protect Russian letters and decode \CYR*/\cyr*
    \MathProtect
    % Font commands
    \FontProtect
    \def\bm{}\let\lc=\relax \ChemProtect
    \let\RefNameFont\@empty \let\@RefNameFont\@empty
    \let\_=\relax \AccentProtect
    % Spacing
    \let~=\relax \let\\=\space
    \let\,\relax \let\ThinSpace\relax
    \def\label{\string\label}%
    \makeatletter
    % Breaks
    \BreaksProtectB
    \UserProtect
    \UserTOCProtect
}

%% \def\ErrataProtect{%
%%     \AntiBabelX % protect Russian letters and decode \CYR*/\cyr*
%%     \MathProtect
%%     % Font commands
%%     \FontProtect
%%     \def\bm{}\let\lc=\relax \UnChem
%%     \let\_=\relax \AccentProtect
%%     % Spacing
%%     \let~=\relax \let\\=\space
%%     % Breaks
%%     \BreaksProtectB
%%     \def\vas{\noexpand\vas}%
%%     \UserProtect
%% }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\let\oriHuge=\Huge    \def\Huge{\protect\oriHuge}
\let\orihuge=\huge    \def\huge{\protect\orihuge}
\let\oriLARGE=\LARGE  \def\LARGE{\protect\oriLARGE}
\let\oriLarge=\Large  \def\Large{\protect\oriLarge}
\let\orilarge=\large  \def\large{\protect\orilarge}
\let\orismall=\small  \def\small{\protect\orismall}
\let\oritiny=\tiny    \def\tiny{\protect\oritiny}
\let\oriss=\ss        \def\ss{\protect\oriss}

\def\AbstractWidth{150mm}

{\AntiBabel
\long\gdef\abstract#1{{\InfoProtect\xdef\@@abstract{#1}}%
    \gdef\@abstract{\parbox{\AbstractWidth}{%\Centerlast
         \noindent\sffamily\small\ignorespaces#1}}%
 }%
}

%% Calm down LaTeX: the \title absence at the beginning of the document
%% due to \tableofcontents
\def\@title{}
\def\@rtitle{}
\def\title#1{\gdef\@title{#1}\rtitle{#1}}
\def\rtitle#1{\gdef\@rtitle{#1}}

\def\@rauthor{}
\def\@Rauthor{}
\def\rauthor#1{\gdef\@rauthor{#1}}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Authors and affiliations %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newif\ifInitialsFirst \InitialsFirsttrue
\newif\ifAffilRef \AffilReftrue

%% Author %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\GetValueKern#1#2{\expandafter\let\expandafter#1\csname #2\endcsname}
\def\GetValue#1#2{\GetValueKern{#1}{#2\the\authorsno}}
\def\GetValueS#1#2{\GetValueKern{#1}{#2\the\authorno}}
\def\DropValue#1{\expandafter\let\csname #1\the\authorsno\endcsname\relax}
\def\SetValueDef#1#2{\expandafter\def\csname #1\endcsname{#2}}
\def\SetValueLet#1#2{\expandafter\let\csname #1\endcsname#2}
\def\SetValue#1#2{\SetValueDef{#1\the\authorno}{#2}}
\def\SetValueL#1#2{\SetValueLet{#1\the\authorno}#2}

\newcount\authorno \authorno=0
\SetValueDef{author0}{{}{}}% dummy author
% \expandafter\def\csname author0\endcsname{{}{}}% dummy author

\def\makeauthor#1#2{%
    \def\jetp@tmp{#1}%
    \ifx\jetp@tmp\@empty \gdef\namesurname{#2}%
    \else
         \def\jetp@tmp{#2}%
         \ifx\jetp@tmp\@empty \gdef\namesurname{#1}%
         \else \gdef\namesurname{#1~#2}\fi
    \fi
}

\def\makeauthorswap#1#2{%
    \def\jetp@tmp{#2}%
    \ifx\jetp@tmp\@empty \gdef\namesurname{#1}%
    \else
         \def\jetp@tmp{#1}%
         \ifx\jetp@tmp\@empty \def\namesurname{#2}%
         \else \gdef\namesurname{#2~#1}\fi
    \fi
}

%% #1 = initials or first name(s); #2 = surname or last name
\def\author#1#2{\global\advance \authorno by 1\relax
    \SetValue{author}{{#1}{#2}}\makeauthor{#1}{#2}%
    %% \ifnum\authorno=1 \edef\@Rauthor{\namesurname}\else
    %%     \ifnum\authorno<\MaxRauthor \edef\@Rauthor{\@Rauthor, \namesurname}\else \@EtAl\fi
    %% \fi
}

%% Same if the author has died:
\def\authord#1#2{\global\advance \authorno by 1\relax
    \SetValue{author}{{#1}{#2}}\@authordead\makeauthor{#1}{#2}%
    %% \ifnum\authorno=1 \edef\@Rauthor{\fbox{\namesurname}}\else
    %%     \ifnum\authorno<\MaxRauthor \edef\@Rauthor{\@Rauthor, \fbox{\namesurname}}\else \@EtAl\fi
    %% \fi
}

\def\DefaultMaxRauthor{4}% maximal number of author names in the column title + 1
\let\MaxRauthor=\DefaultMaxRauthor
\let\MaxRauthorCT=\DefaultMaxRauthorCT
%% \def\@EtAl{\ifnum\authorno=\MaxRauthor \xdef\@Rauthor{\@Rauthor~\noexpand\@etal}\fi}

\def\maxauthor#1{\def\MaxRauthor{#1}}
\def\gmaxauthor#1{\gdef\MaxRauthor{#1}}
\def\dmaxauthor{\global\let\MaxRauthor=\DefaultMaxRauthor}

\newcount\authorsno

\def\AuthorsBLS{1.5} % authors baselinestretch value

\newif\ifemail
\newif\ifthanks

\def\Ast{*}
\newif\if@dead \@deadfalse

\def\CheckDead{\GetValue\DeadVal{@authordead}%
    \ifx\DeadVal\Ast\@deadtrue\else\@deadfalse\fi
}

\def\authors{% for \maketitle
   \ifnum\authorno>0 \let\jetp@tmp=\runauthors
   \else \let\jetp@tmp=\relax \fi
   \jetp@tmp
}

\def\runauthors{%
   \thanksfalse \authorsno=0\relax
   \loop
     \advance \authorsno by 1\relax \emailfalse
     \ifnum\authorsno>1 ,
        % Break author list before the specified author ----------------
        \GetValue\AffilArg{authorbreak}%
        \ifx\AffilArg\relax
        \else \ifx\AffilArg\@empty \break \else \vskip\AffilArg \fi \fi
        \DropValue{authorbreak}% % Drop the current author break setting
        %---------------------------------------------------------------
     \fi
     \GetValue\AuthorArgs{author}\CheckDead
     \if@dead\let\authorcmd=\fbox\else\@deadfalse\let\authorcmd=\relax\fi
     \authorcmd{%
       %% \ifInitialsFirst \expandafter\AuthorNorm\AuthorArgs
       %% \else            \expandafter\AuthorSwap\AuthorArgs\fi
       \ifInitialsFirst \expandafter\makeauthor\AuthorArgs
       \else            \expandafter\makeauthorswap\AuthorArgs\fi
       \namesurname
     }%
     \ifAffilRef
        \leavevmode\/\kern0.1pt\relax
        %---------------------------------------------------------------
        \GetValue\AffilArg{authoraff}%
        % \,$^?$ % not needed for common affiliation
        \ifx\AffilArg\relax \else\,$^{\AffilArg}$\fi
        %---------------------------------------------------------------
        \ifthanks \else \EmailFN \fi
        %---------------------------------------------------------------
        \GetValue\AffilArg{thanks}%
        \ifx\AffilArg\relax \else
            \ifx\AffilArg\@empty
                \ifx\ThanksMark\@empty \else
                    \ifemail \,\fi
                    \@textsuperscript{\normalfont\ThanksMark}%
                \fi
            \else
                \thankstrue \ifemail \,\fi
                \footnotemark \xdef\ThanksMark{\thefootnote}%
                \ProtectedDef\@thanks{\AffilArg}%
            \fi
        \fi
        %---------------------------------------------------------------
        \ifemail \else \ifthanks \EmailFN \fi \fi
        %---------------------------------------------------------------
     \fi
     %------------------------------------------------------------------
     % if \authorsno=1: \edef\@Rauthor{\namesurname}
     % if \authorsno<\MaxRauthor: \edef\@Rauthor{\@Rauthor, \namesurname}
     % if \authorsno=\MaxRauthor:
     %    if \authorno>\MaxRauthor: \@EtAl
     %    else: \edef\@Rauthor{\@Rauthor, \namesurname}
     \ifnum\authorsno=1
        \if@dead \xdef\@Rauthor{\fbox{\namesurname}}%
        \else \xdef\@Rauthor{\namesurname}\fi
     \else
        \ifnum\authorsno<\MaxRauthor
           \if@dead \xdef\@Rauthor{\@Rauthor, \fbox{\namesurname}}%
           \else \xdef\@Rauthor{\@Rauthor, \namesurname}\fi
        \else
           \ifnum\authorsno=\MaxRauthor
               \ifnum\authorno>\MaxRauthor \xdef\@Rauthor{\@Rauthor~\noexpand\@etal}%
               \else
                  \if@dead \xdef\@Rauthor{\@Rauthor, \fbox{\namesurname}}%
                  \else \xdef\@Rauthor{\@Rauthor, \namesurname}\fi
               \fi
           \fi
        \fi
     \fi
     %------------------------------------------------------------------
   \ifnum\authorsno<\authorno \repeat
}

\def\EmailFN{\GetValue\AffilArg{email}\ifx\AffilArg\relax \else
    \emailtrue \footnotemark \ProtectedDef\@thanks{E-mail: \AffilArg}\fi}

%% Redeclare LaTeX commands, so that they work in Russian %%%%%%%%%%%%%%
\DeclareTextSymbolDefault{\AE}{OT1}
\DeclareTextSymbolDefault{\ae}{OT1}
\DeclareTextSymbolDefault{\i}{OT1}
\DeclareTextSymbolDefault{\j}{OT1}
\DeclareTextSymbolDefault{\IJ}{OT1}
\DeclareTextSymbolDefault{\ij}{OT1}
\DeclareTextSymbolDefault{\L}{OT1}
\DeclareTextSymbolDefault{\l}{OT1}
\DeclareTextSymbolDefault{\O}{OT1}
\DeclareTextSymbolDefault{\o}{OT1}
\DeclareTextSymbolDefault{\OE}{OT1}
\DeclareTextSymbolDefault{\oe}{OT1}
\DeclareTextSymbolDefault{\ss}{OT1}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\DEBUG#1{\immediate\message{^^J#1}\read16 to \dummy}

\def\ProtectedDef#1#2{\protected@xdef#1{#1\protect\footnotetext[\the\c@footnote]{#2}}}

\def\ThanksMark{}

\def\@authordead{\SetValue{@authordead}{*}}

\def\authorbreak#1{\def\jetp@tmp{#1}%
    \ifx\jetp@tmp\@empty \SetValue{authorbreak}{}%
    \else \SetValue{authorbreak}{#1}\fi
}

\newif\ifAffilOut \AffilOutfalse

\def\authorswrite{% kernel for info and index files
   \ifnum\authorno>0 \let\jetp@tmp=\runauthorswrite
   \else \let\jetp@tmp=\relax \fi
   \jetp@tmp
}

\def\runauthorswrite{\authorsno=0\relax
   \loop
      \advance \authorsno by 1\relax
      \GetValue\AuthorArgs{author}\CheckDead
      {\LocalProtect
       \ifInitialsFirst \expandafter\makeauthor\AuthorArgs
       \else        \expandafter\makeauthorswap\AuthorArgs \fi
       \if@dead
          %% \ifInitialsFirst \WriteCmd{author=\expandafter\fbox\expandafter{\namesurname\AuthorNorm\AuthorArgs}}%
          %% \else           \WriteCmd{author=\expandafter\fbox\expandafter{\expandafter\AuthorSwap\AuthorArgs}}\fi
          \WriteCmd{author=\fbox{\namesurname}}%
       \else
          %% \ifInitialsFirst \WriteCmd{author=\expandafter\AuthorNorm\AuthorArgs}%
          %% \else            \WriteCmd{author=\expandafter\AuthorSwap\AuthorArgs}\fi
          \WriteCmd{author=\namesurname}%
       \fi
      }%
      \ifAffilOut
         \GetValue\AffilArg{authoraff}%
         \ifx\AffilArg\relax \else \WriteCmd{affiliations=\AffilArg}\fi
      \fi
      \GetValue\AffilArg{email}%
      \ifx\AffilArg\relax \else \WriteCmd{email=\AffilArg}\fi
      \GetValue\AffilArg{thanks}%
      \ifx\AffilArg\relax \else \WriteCmd{thanks=\AffilArg}\fi
   \ifnum\authorsno<\authorno \repeat
}

\def\authorstoinfo{\let\WriteCmd=\WriteInfo \def\LocalProtect{\let~=\space \let\,=\space}\AffilOuttrue\authorswrite} % for info file
\def\authorstoindex{\let\WriteCmd=\WriteIndex \def\LocalProtect{\let~=\relax \let\,=\relax}\AffilOutfalse\authorswrite} % for index file

\def\authorstoc{% for TOC
    \ifnum\authorno>0 \let\jetp@tmp=\runauthorstoc
    \else \def\AuthorsList{}\let\jetp@tmp=\relax \fi
    \jetp@tmp
}%

{\AntiBabel
  \gdef\runauthorstoc{%
        \def\AuthorsList{}\authorsno=0\relax\AntiBabelX
        \loop
           \advance \authorsno by 1\relax
           \GetValue\AuthorArgs{author}\CheckDead
           \ifInitialsFirst \expandafter\makeauthor\AuthorArgs \edef\jetp@tmpa{\namesurname}%
                 %% \edef\jetp@tmpa{\expandafter\AuthorNorm\AuthorArgs}%
           \else \expandafter\makeauthorswap\AuthorArgs \edef\jetp@tmpa{\namesurname}\fi
                 %% \edef\jetp@tmpa{\expandafter\AuthorSwap\AuthorArgs}\fi
           \if@dead
               \ifnum\authorsno=1 \edef\AuthorsList{\fbox{\jetp@tmpa}}%
               \else \edef\AuthorsList{\AuthorsList, \fbox{\jetp@tmpa}}\fi
           \else
               \ifnum\authorsno=1 \edef\AuthorsList{\jetp@tmpa}%
               \else \edef\AuthorsList{\AuthorsList, \jetp@tmpa}\fi
           \fi
        \ifnum\authorsno<\authorno \repeat
  }%
  \gdef\titletoc{\AntiBabelX \edef\TitleList{\@title}}%
}

%% See also \makeauthor, \makeauthorswap
\def\AuthorNorm#1#2{#1~#2} % {#1\,#2}
\def\AuthorSwap#1#2{#2~#1}

%% Affiliation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcount\affilno \affilno=0
\newcount\affilsno
\newcount\affilfound

\def\GetAffilArg{\GetValueS\AffilArg{authoraff}}
\def\GetAuthorArgs{\GetValueKern\AuthorArgs{affil\the\affilsno}}%

\def\affiliation#1{%
   \ifnum\authorno=0\relax \SetValueDef{affil0}{#1}%
   \else
      \global\advance \affilno by 1\relax \AffilFoundfalse
      \ifnum \affilno>1 \TestAffil{#1}\fi
      \ifAffilFound
         \GetAffilArg
         \ifx\AffilArg\relax \edef\AffilArg{\@alph{\the\affilfound}}
         \else               \edef\AffilArg{\AffilArg,\@alph{\the\affilfound}}\fi
         \SetValueL{authoraff}\AffilArg
         \global\advance \affilno by -1\relax
      \else
         \SetValueDef{affil\the\affilno}{#1}\GetAffilArg
         \ifx\AffilArg\relax \edef\AffilArg{\@alph{\the\affilno}}
         \else               \edef\AffilArg{\AffilArg,\@alph{\the\affilno}}\fi
         \SetValueL{authoraff}\AffilArg
      \fi
   \fi
}

\newif\ifAffilFound

\def\TestAffil#1{\def\jetp@tmp{#1}%
    \affilfound=0\relax \AffilFoundfalse \affilsno=0\relax
    \loop
       \advance \affilsno by 1\relax
       \GetValueKern\AffilArg{affil\the\affilsno}%
       \ifx\jetp@tmp\AffilArg \AffilFoundtrue \affilfound=\affilsno \affilsno=\affilno \advance \affilsno by 1\fi
    \ifnum\affilsno<\affilno \repeat
}

\def\AffilSkip{}

\def\affils{% output affiliations
    \affilsno=0\relax \GetAuthorArgs
    \ifx\AuthorArgs\relax
       \loop
          \advance \affilsno by 1\relax \GetAuthorArgs \endgraf
          $^{\@alph{\the\affilsno}}$\,\AuthorArgs\AffilSkip\endgraf
       \ifnum\affilsno<\affilno \repeat
    \else \AuthorArgs \fi % common affiliation
    \def\AffilSkip{}%
}

\def\affilstoinfo{% for info file
    \affilsno=0\relax
    {\let~=\space \let\,=\space \GetAuthorArgs
     \ifx\AuthorArgs\relax
         \loop
            \advance \affilsno by 1\relax \GetAuthorArgs
            \WriteInfo{affiliation.\@alph{\the\affilsno}=\AuthorArgs}%
         \ifnum\affilsno<\affilno \repeat
     \else
         \WriteInfo{affiliation=\AuthorArgs}% common affiliation
     \fi
    }%
}

\def\email#1{\SetValue{email}{#1}}
\def\thanks#1{\SetValue{thanks}{#1}}
%% \let\@email\@empty
\let\@thanks\@empty

%% Alternative methods for setting authors and affiliations %%%%%%%%%%%%

\def\setaffiliation#1#2{% set affiliation #2 by number #1
    \affilno=#1\relax \SetValueDef{affil\the\affilno}{#2}%
}

%% Set author
%% #1=initials #2=surname and reference affiliation numbers as #3
%% #3 is a set of numbers: {1} or {{1}{2}} or {{1}{2}{3}} or {{3}{6}{9}}
%% and so on.
%% No extra braces needed if single digit reference is used, e.g.,
%% {123} or {28}, same as {{1}{2}{3}} and {{2}{8}}
\def\setauthor#1#2#3{\author{#1}{#2}\expandafter\RunSetAuthor#3{}}
\def\setauthord#1#2#3{\authord{#1}{#2}\expandafter\RunSetAuthor#3{}}

\def\RunSetAuthor#1{\def\jetp@tmp{#1}%
    \ifx\jetp@tmp\@empty \let\next\relax
    \else
        \GetAffilArg
        \ifx\AffilArg\relax \edef\AffilArg{\@alph{#1}}
        \else               \edef\AffilArg{\AffilArg,\@alph{#1}}\fi
        \SetValueL{authoraff}\AffilArg \let\next\RunSetAuthor
    \fi
    \next
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\let\@DOI\@empty
\def\DOI#1 {\def\@DOI{#1}}
%% \def\@PACS{}
%% \def\PACS#1 {\gdef\@PACS{#1}}

%% Postupila v~redakciyu
\def\RusReceived{\CYRP\cyro\cyrs\cyrt\cyru\cyrp\cyri\cyrl\cyra\
                        \cyrv~\cyrr\cyre\cyrd\cyra\cyrk\cyrc\cyri\cyryu}
%% posle pererabotki
\def\RusRevised{\cyrp\cyro\cyrs\cyrl\cyre\
                \cyrp\cyre\cyrr\cyre\cyrr\cyra\cyrb\cyro\cyrt\cyrk\cyri}
\def\IfEng{\iflanguage{english}}\@gobble\fi % just for coloring
\def\submitted{{\IfEng{Received\ }{\RusReceived\ }}}
\def\resubmitted{{\IfEng{revised version\ }{\RusRevised\ }}}

\def\@dates{}
\def\dates#1#2{%
    \gdef\@dates{\footnotesize\rm\centering
                 \submitted#1{\if#2*\else\par\resubmitted#2\fi}\par
}}

\newcounter{c@JETPvol} % Volume number counter
\def\thec@JETPvol{0}
\def\volume#1{%
  \def\jetp@tmp{#1}\ifx\jetp@tmp\@empty \else
    \if\thec@JETPvol 0\gdef\thec@JETPvol{#1}% User variable
    \else
       \@latexerr{\string\volume\space specified more than once in the issue.}\@ehc
    \fi
  \fi
}

\newcounter{c@JETPissue} % Issue number counter
\def\thec@JETPissue{0}
\def\issue#1{%
  \if\thec@JETPissue 0 \gdef\thec@JETPissue{#1}% User variable
  \else
     \@latexerr{\string\issue\space specified more than once in the issue.}\@ehc
  \fi
}

% Compute year by volume number (from 1999 and Vol. 115)
\newcount\VolToYear

\def\JETPyear#1{%
    \JETPyearKern{#1}\relax % the \relax is needed for some obscured reason
    \ifnum\VolToYear=0 \else \the\VolToYear \fi
}

\def\JETPyearKern#1{%
    \VolToYear=#1\relax \advance\VolToYear by -115\relax
    \ifnum\VolToYear<0 \VolToYear=0\else
       \divide\VolToYear by 2\relax
       \advance\VolToYear by 1999\relax
    \fi
}

\def\issuename{\cyrv\cyrery\cyrp.} % vyp.
\def\JETPissue#1{%
  \def\jetp@tmp{#1}\ifx\jetp@tmp\@empty \else
    \ifcase#1\relax \@latexerr{Issue number is zero}\@ehc\or,
       \issuename\,1\or, \issuename\,2\or, \issuename\,3\or,
       \issuename\,4\or, \issuename\,5\or, \issuename\,6\or,
       \issuename\,1\,(7)\or, \issuename\,2\,(8)\or,
       \issuename\,3\,(9)\or, \issuename\,4\,(10)\or,
       \issuename\,5\,(11)\or, \issuename\,6\,(12)%
    \else \@latexerr{Issue \thec@JETPissue\space inconsistent}\@ehc\fi
  \fi
}

\def\JETPissueB#1{% bare: no issue prefix, just number(s)
  \def\jetp@tmp{#1}\ifx\jetp@tmp\@empty \else
    \ifcase#1\relax \@latexerr{Issue number is zero}\@ehc\or
    1\or2\or3\or4\or5\or6\or1\,(7)\or2\,(8)\or3\,(9)\or4\,(10)\or5\,(11)\or6\,(12)%
    \else \@latexerr{Issue \thec@JETPissue\space inconsistent}\@ehc\fi
  \fi
}

\def\JETPmonth#1{%
    \ifcase#1\relax \@latexerr{Issue number is zero}\@ehc\or
       \cyrya\cyrn\cyrv\cyra\cyrr\cyrsftsn\or                         %  yanvar'
       \cyrf\cyre\cyrv\cyrr\cyra\cyrl\cyrsftsn\or                     %  fevral'
       \cyrm\cyra\cyrr\cyrt\or \cyra\cyrp\cyrr\cyre\cyrl\cyrsftsn\or  %  mart aprel'
       \cyrm\cyra\cyrishrt\or \cyri\cyryu\cyrn\cyrsftsn\or            %  maishrt iyun'
       \cyri\cyryu\cyrl\cyrsftsn\or \cyra\cyrv\cyrg\cyru\cyrs\cyrt\or %  iyul' avgust
       \cyrs\cyre\cyrn\cyrt\cyrya\cyrb\cyrr\cyrsftsn\or               %  sentyabr'
       \cyro\cyrk\cyrt\cyrya\cyrb\cyrr\cyrsftsn\or                    %  oktyabr'
       \cyrn\cyro\cyrya\cyrb\cyrr\cyrsftsn\or                         %  noyabr'
       \cyrd\cyre\cyrk\cyra\cyrb\cyrr\cyrsftsn                        %  dekabr'
    \else \@latexerr{Issue \thec@JETPissue\space inconsistent}\@ehc\fi
}

%% Head column title of the article's 1-st page ========================

\def\JETPlogo{\Line{\fontsize{10}{12pt}\usefont{T2A}{cmr}{m}{n}%
  %% ZhETF
  \CYRZH\CYREREV\CYRT\CYRF, \JETPyear{\thec@JETPvol},
  %% tom:
  \cyrt\cyro\cyrm~\thec@JETPvol \JETPissue{\thec@JETPissue},
  %% str.:
  \cyrs\cyrt\cyrr. \@firstpage--\@lastpage
  \hfill \copyright~\JETPyear{\thec@JETPvol}
}}

\def\ps@titlehead{% titlehead style for the 1-st article's page
   \let\@evenhead\JETPlogo
   \let\@oddhead\@evenhead
   %% \def\@evenfoot{\reset@font\sffamily\thepage\hfil}%
   %% \def\@oddfoot{\hfil\reset@font\sffamily\thepage}%
}

\def\DropTitleHead{\let\ps@titlehead=\ps@plain}

%% Info and last page files %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newif\ifWriteInfo \WriteInfotrue
\newif\ifWriteIndex \WriteIndextrue
\def\NoWriteInfo{\WriteInfofalse}
\def\NoWriteIndex{\WriteIndexfalse}
\def\NoTOC{\let\tableofcontents\relax}

\iftypesetter
   \newwrite\infofile
   \newwrite\indexfile
   \newwrite\lastpagefile
   \def\WriteInfo{\immediate\write\infofile}
   \def\WriteIndex{\immediate\write\indexfile}
\else
   \NoWriteInfo \NoWriteIndex \NoTOC
\fi

\AtEndDocument{%
 \iftypesetter
   \ifJETPPart
      {\let\hbox=\@gobble
       %%\advance\c@page by 1\relax
       \immediate\write\@mainaux{\string\newlabel{LastPage}{{}{\thepage}}}%
          \immediate\write\lastpagefile{\string\setcounter{FirstPageOfTheIssue}{\Pageref{LastPage}}}}%
      \closeout\lastpagefile
      \ifWriteInfo \closeout\infofile \fi
      \ifWriteIndex \closeout\indexfile \fi
    \fi
 \fi
}

\newcount\FirstIssue % issue number mod 6
\newcount\FirstIssueD

\AtBeginDocument{%
  \let\@rauthor\@empty
  %---------------------------------------------------------------------
  \FirstIssue=\thec@JETPissue \FirstIssueD=\FirstIssue
  \divide\FirstIssueD by 6\relax \multiply\FirstIssueD by 6\relax
  \advance\FirstIssue by -\FirstIssueD % issue mod 6
  \setcounter{FirstPageOfTheIssue}{1}% default
  \ifnum\FirstIssue=1\else
     \JETPyearKern{\thec@JETPvol}%
     \@JETP@DOI@cnt=\thec@JETPissue \advance\@JETP@DOI@cnt by -1\relax
     \edef\prevpath{\the\VolToYear-\thec@JETPvol-\ifnum\@JETP@DOI@cnt<10 0\fi\the\@JETP@DOI@cnt}%
     \@input{../\prevpath/\jobname.firstpage}%
  \fi
  \c@page=\c@FirstPageOfTheIssue
  %---------------------------------------------------------------------
  \iftypesetter
     \ifWriteInfo
        \immediate\openout\infofile=\jobname.info
        \WriteInfo{[common]}%
        \WriteInfo{version=1.0}%
        \WriteInfo{volume=\thec@JETPvol}%
        \WriteInfo{issue=\thec@JETPissue}%
        \ifjubilee
           {\InfoProtect
             \edef\@JTE{\JubileeTextEng}\WriteInfo{jubileeE=\@JTE}%
             \edef\@JTR{\JubileeTextRus}\WriteInfo{jubileeR=\@JTR}%
           }%
        \else
           \WriteInfo{jubileeE=0}%
           \WriteInfo{jubileeR=0}%
        \fi
        \WriteInfo{}%
     \else \let\WriteInfoFile\relax \fi
     \ifWriteIndex
        \immediate\openout\indexfile=\jobname.index
        \WriteIndex{version=1.0}%
        \WriteIndex{volume=\thec@JETPvol}%
        \WriteIndex{issue=\thec@JETPissue}%
        \ifjubilee
           {\IndexProtect
             \edef\@JTE{\JubileeTextEng}\WriteIndex{jubileeE=\@JTE}%
             \edef\@JTR{\JubileeTextRus}\WriteIndex{jubileeR=\@JTR}%
           }%
        \else
           \WriteIndex{jubileeE=0}%
           \WriteIndex{jubileeR=0}%
        \fi
        \WriteIndex{}%
        \WriteParts\WriteIndex
     \else \let\WriteIndexFile\relax \fi
     \ifJETPPart %% only in typesetter (not single) mode
        \JETPyearKern{\thec@JETPvol}%
        \@JETP@DOI@cnt=\thec@JETPissue \advance\@JETP@DOI@cnt by 1\relax
        \edef\nextissue{\the\VolToYear-\thec@JETPvol-\ifnum\@JETP@DOI@cnt<10 0\fi\the\@JETP@DOI@cnt}
        \immediate\openout\lastpagefile=\nextissue.firstpage
     \fi
  \fi
}

\newcount\JNcount
\def\JNcnt{\global\JNcount=0\expandafter\JobNameCount\Jobname*}
\def\JobNameCount#1{\def\JNtmp{#1}%
    \ifx\JNtmp\Ast\let\JNtmp\relax
    \else \global\advance\JNcount by 1\let\JNtmp\JobNameCount \fi
    \JNtmp
}

\def\ExtractThird#1#2#3#4{#3}

\def\FileId{% New idea: just file name
    \Jobname
    %% \ifnum\VolToYear=0 ?\else \expandafter\ExtractThird\the\VolToYear\fi
    %% \ifnum\JNcount<5 \Jobname \fi
    %% \ifnum\JNcount=5 \expandafter\@gobble\Jobname \fi
    %% \ifnum\JNcount>5 \expandafter\@gobbletwo\Jobname\fi
}

{\AntiBabel
  \gdef\WriteInfoFile{%
      \WriteInfo{[article]}%
      {\InfoProtect \def\hbox##1{##1}%
       \Russian
       \JETPyearKern{\thec@JETPvol}%
       \WriteInfo{id=\FileId}%
       \WriteInfo{title=\@title}%
       \authorstoinfo
       \affilstoinfo
       %% (yubilejnyj)
       \ifjubilee \def\Jubilee{ (\cyryu\cyrb\cyri\cyrl\cyre\cyrishrt\cyrn\cyrery\cyrishrt)}\else \def\Jubilee{}\fi
       %%              Tom                            Vyp.                                        Str.
       \WriteInfo{link=\CYRT\cyro\cyrm~\thec@JETPvol, \CYRV\cyrery\cyrp\Jubilee. \thec@JETPissue, \CYRS\cyrt\cyrr. \@firstpage--\@lastpage}%
%%%%   \WriteInfo{volume=\thec@JETPvol}% moved to \AtBeginDocument
%%%%   \WriteInfo{issue=\thec@JETPissue}%
       \WriteInfo{firstpage=\@firstpage}%
       \WriteInfo{lastpage=\@lastpage}%
       \def\protect{ }%
       \WriteInfo{abstract=\@@abstract}%
       \WriteInfo{doi=\@DOI}
%%     \WriteInfo{pacs=\@PACS}%
       \WritePartList\WriteInfo
       \WriteInfo{directory=\jobname}%
%%     \WriteInfo{ps=\jobname.ps}%
%%     \WriteInfo{pdf=\jobname.pdf}%
%%     \WriteInfo{djvu=\jobname.djvu}%
       \iflocaltoc \WriteInfo{Review=1}\else \WriteInfo{Review=0}\fi
       \WriteInfo{}%
      }%
  }%
  \gdef\WriteIndexFile{%
      %% \WriteIndex{[article]}%
      {\IndexProtect \def\hbox##1{##1}%
       \Russian
       \JETPyearKern{\thec@JETPvol}%
       \WriteIndex{id=\FileId}%
       \WriteIndex{title=\@title}%
       \InitialsFirstfalse \AffilReffalse
       \authorstoindex
       \WriteIndex{firstpage=\@firstpage}%
       \WriteIndex{lastpage=\@lastpage}%
       %% \def\protect{ }%
       %% \WriteIndex{abstract=\@@abstract}%
       \WriteIndex{doi=\@DOI}
       %% \WritePartList\WriteIndex
       \WritePartRefs\WriteIndex
       %% \iflocaltoc\WriteIndex{Review=1}\else\WriteIndex{Review=0}\fi
       \WriteIndex{}%
      }%
  }%
}

\def\WriteParts#1{\let\WriteCommand#1
    \edef\MaxPart{\the\JPcnt}\JPcnt=0\relax
    \loop
       \advance\JPcnt by 1\relax
       {\edef\JPline{\csname JPline\the\JPcnt\endcsname}\SelectPartProtect
         \expandafter\ifx\csname JPsub\the\JPcnt\endcsname\@empty
            \def\JETPsub{}\else\def\JETPsub{sub}\fi
         \WriteCommand{\JETPsub category=\@PartData}%
       }%
    \ifnum\JPcnt<\MaxPart \repeat
    \JPcnt=\MaxPart % restore maximal value
    \WriteCommand{}%
}

\def\WritePartList#1{\let\WriteCommand#1{\SelectPartProtect\expandafter\DoPartList\PartList}}
\def\WritePartRefs#1{\let\WriteCommand#1{\SelectPartProtect\expandafter\DoPartRefs\PartList}}

\def\SelectPartProtect{\ifx\WriteCommand\WriteIndex \PartProtect\PartIndex \else \PartInfo \fi}
\def\SelectSubPartProtect{\ifx\WriteCommand\WriteIndex \PartProtect\SubPartIdx \else \SubPart \fi}

\def\DoPartList#1#2{\def\jetp@tmp{#1}%
  \ifx\jetp@tmp\@empty \let\next=\relax
  \else
     {\edef\JPline{#1. \csname JPartName#1\endcsname}\SelectPartProtect
      \WriteCommand{category=\@PartData}%
      \def\PartNo{#1}\def\SubPartNo{#2}\SubPart\WriteCommand{subcategory=\@SubPart}%
     }%
     \let\next=\DoPartList
  \fi
  \next
}

\def\DoPartRefs#1#2{\def\jetp@tmp{#1}%
  \ifx\jetp@tmp\@empty \let\next=\relax
  \else
      {\edef\JPline{}\SelectPartProtect
        %% \WriteCommand{category=#1}%
        \WriteCommand{subcategory=#1.#2}%
      }%
      \let\next=\DoPartRefs
  \fi
  \next
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Quite robust command that does not conflist with \MakeUppercase
\def\Centering{\leftskip=0pt plus 1fill \rightskip=\leftskip \parfillskip=0pt \parindent=0pt\relax}

\def\Title{{\sffamily\Large\bfseries\mathversion{bold}\let\\=\sectionbreak \MakeTextUppercase\@title\par}}

{\AntiBabel
 \gdef\TitleTOC{{\TOCProtect
      \InitialsFirstfalse \AffilReffalse \authorstoc \titletoc
      \IfEng{\addtocontents{toc}{\English}}{\addtocontents{toc}{\Russian}}%
      \addcontentsline{toc}{Section}{{\TitleList}{\AuthorsList}}}}%
}

\def\Authors{{%
       %% \dimen0=-\prevdepth \advance\dimen0 by 8mm\relax
       %% \nointerlineskip\rm \vrule height\dimen0 width 0pt depth 3mm\relax
       {\bfseries\mathversion{bold}\itshape\ignorespaces\authors\unskip}\par}}

\def\Affiliations{{\footnotesize\it\centering\ignorespaces\affils\unskip\par}}

\def\ETFMakeTitleSkips{% etf-g.cls skips
    \def\TitleSkip{\vskip 12pt plus 0.05fil minus 6pt}%
    \def\AuthorsSkip{\vskip 6pt plus 0.05fil minus 3pt}%
    \def\AuthorsBLS{1.5}%
    \def\AffilSkip{\\~\\}%
    \def\AffiliationsSkip{% \ifdim\prevdepth=-1000pt \prevdepth0pt\fi
        \vskip 2em plus 0.05fil minus 1ex% \vbox to 0.3cm{\vfill}%
    }%
    \def\DatesSkip{\vskip 2em plus 0.05fil minus 1ex}%
    \def\AbstractSkip{\vskip 2em plus 1em minus 1ex}%
    \def\DefaultDOISkip{\vskip -2.5mm}%
    \let\JubileeSkip=\AbstractSkip
}

\def\MakeTitleSkips{% jetp.cls default settings
    \def\TitleSkip{\vskip 6mm}%
    \def\AuthorsSkip{\vskip 3mm}%
    \def\AuthorsBLS{1.5}%
    \def\AffilSkip{\vskip 3mm}%
    \def\AffiliationsSkip{\vskip 6mm}%
    \def\DatesSkip{\vskip 6mm}%
    \def\AbstractSkip{\vskip 5mm}%
    \def\DefaultDOISkip{\vskip -2.5mm}%
    \let\JubileeSkip=\AbstractSkip
}

\MakeTitleSkips
%% The \DOISkip is special (Local TOC and Errata dependent)
\let\DOISkip\DefaultDOISkip

\def\JubileeCase#1#2{\gdef\JubileeCaseEng{#1}\gdef\JubileeCaseRus{#2}}
\JubileeCase{}{}
\def\JubileeTextEng{Contribution for the JETP special issue in honor of \JubileeCaseEng}
%% Stat'a~dlya~special'nogo~vypuska~Zh`ETF, posvyashchyonnogo~\JubileeCaseRus
\def\JubileeTextRus{\CYRS\cyrt\cyra\cyrt\cyrsftsn\cyrya~\cyrd\cyrl\cyrya~%
             \cyrs\cyrp\cyre\cyrc\cyri\cyra\cyrl\cyrsftsn\cyrn\cyro\cyrg\cyro~%
             \cyrv\cyrery\cyrp\cyru\cyrs\cyrk\cyra~\CYRZH\CYREREV\CYRT\CYRF,
             \cyrp\cyro\cyrs\cyrv\cyrya\cyrshch\cyryo\cyrn\cyrn\cyro\cyrg\cyro~\JubileeCaseRus}

\def\defaultmaketitleoffset{\vbox to 10mm{\vfill}}
\let\maketitleoffset=\defaultmaketitleoffset

\def\@maketitle{%
    %-------------------------------------------------------------------
    \ifx\@AddToTocP\relax
    \else {\PartTOC
           \addtocontents{toc}{\bgroup\russian}%
           \addcontentsline{toc}{Part}{\@PartTOC}%
           \addtocontents{toc}{\egroup}%
           \global\let\@AddToTocP\relax
          }%
    \fi
    %-------------------------------------------------------------------
    \vbox{\maketitleoffset
      {\Centering
          \ifx\Title\@empty \else \Title \TitleSkip\fi
          {\baselineskip=\AuthorsBLS\baselineskip \Authors\par}\AuthorsSkip
          %% If \rauthor has not been specified, used automatic value:
          \ifx\@rauthor\@empty \global\let\@rauthor\@Rauthor \fi
          \ifx\@ErrataRef\@empty
             \Affiliations \AffiliationsSkip
             \ifx\@dates\@empty \else \@dates\par \DatesSkip \fi % Dates the article submitted
             \ifx\@abstract\@empty \else \@abstract\par \AbstractSkip \fi % Abstract
             \ifjubilee
               {\parbox{\AbstractWidth}{\leftskip=0pt plus 1 fill
                \rightskip=0pt \parfillskip=0pt\relax \it \small
                \IfEng{\JubileeTextEng}{\JubileeTextRus}}}\par
               \JubileeSkip
             \fi
          \else
             \centerline{\@ErrataRef}\ErrataRefSkip
             \ifx\@dates\@empty \else \@dates\par \DatesSkip \fi % Dates the article submitted
          \fi
          \TitleTOC % TOC record
          \iftypesetter
             \WriteInfoFile % Info file record
             \WriteIndexFile % Index file record
          \fi
      \par}%
      %% \ifx\@PACS\@empty \else{\noindent\small PACS: \@PACS}\\[2mm]\fi
    }%
    \iflocaltoc
       \edef\DOISkip{\DOISkip\vskip\baselineskip}\OutputDOI\DoLocalTOC
    \fi
    \MakeTitleSkips % reset to defaults
}

\def\OutputDOI{\ifx\@DOI\@empty \else
     \noindent{\bf DOI:} \expandafter\HTMLDOI\expandafter{\@DOI}\HTMLclose\par\DOISkip \fi
     \let\DOISkip\DefaultDOISkip}

%% DOI generation using jetpdoi.sty %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newif\ifjetpdoi
\iftypesetter \jetpdoitrue \else \jetpdoifalse \fi

\newcounter{jetparticle}\setcounter{jetparticle}0\relax

\newcount\@JETP@DOI@cnt
\def\PrepareDOI{% Automatically create DOI code if it is not provided
    % article is a file/text containing \maketitle
    \addtocounter{jetparticle}1\relax
    \ifjetpdoi % if DOI is to be inserted (typesetter issue mode)
       \ifx\@DOI\@empty % if not defined for the current article
           \JETPyearKern{\thec@JETPvol}% 2-digit year and issue
           \edef\JETPxxyear{\expandafter\@gobbletwo\the\VolToYear}%
           \@JETP@DOI@cnt=\thec@JETPissue\relax
           \ifnum\@JETP@DOI@cnt<10\edef\@JETPissue{0\the\@JETP@DOI@cnt}%
           \else \edef\@JETPissue{\the\@JETP@DOI@cnt}\fi
           \MakeDOI{\JETPxxyear}{\@JETPissue}{\the\c@jetparticle}%
           \let\@DOI\DOIcode
       \fi
    \fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\maketitle{\par
  \setcounter{footnote}{0}%
  \PrepareDOI
  \begingroup
    \def\thefootnote{%
        \ifcase\c@footnote\or*\or**\or***\or****\or
               $\dagger$\or$\ddagger$\or$\ddagger\ddagger$%
        \else{\@latex@error{Too many footnotes (see jetp.cls: \string\maketitle)}\@ehc}\fi}%
    \def\@makefnmark{\@textsuperscript{\normalfont\@thefnmark}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hb@xt@1.8em{\hss\@textsuperscript{\normalfont\@thefnmark}}\kern0.33em\relax##1}%
    \if@twocolumn
      {\ifnum \col@number=\@ne \@maketitle
       \else \twocolumn[\@maketitle]\fi}%
    \else
      \global\@topnum\z@ % Prevents figures from going at top of page.
      \@maketitle
    \fi
    \iflocaltoc \else \OutputDOI \fi
    \thispagestyle{titlehead}\@thanks
    %% \thispagestyle{plain}%
    %% \onecolumn
  \endgroup
  \if@mcol\begin{multicols}{2}\fi
  \global\let\@DOI\@empty
  %% \global\let\@PACS\@empty
  %% \global\let\@email\@empty
  \global\let\@thanks\@empty
  %% \global\let\@author\@empty
  %% \global\let\@authoraddress\@empty
  \global\let\@dates\@empty
  \global\let\@title\@empty
  \Drop{affil}0%
  \Drop{affil}1%
  \authorsno=-1\relax
  \loop \advance\authorsno by 1\relax
     \DropAu{email}%
     \DropAu{thanks}%
     \DropAu{author}%
     \DropAu{authoraff}%
     \DropAu{@authordead}%
  \ifnum\authorsno<\authorno \repeat
  \global\authorno=0\relax
  \global\affilno=0\relax
  \gdef\ThanksMark{}%
  \global\localtocfalse
  \immediate\openout\@parttoc \Jobname.toc
  \setcounter{footnote}{0}%
  \setcounter{section}{0}%
  \setcounter{figure}{0}%
  \setcounter{table}{0}%
  \setcounter{equation}{0}%
  \let\maketitleoffset=\defaultmaketitleoffset
  \NormEq
}

\def\Drop#1#2{\expandafter\global\expandafter\let\csname#1#2\endcsname\relax}
\def\DropAu#1{\Drop{#1}{\the\authorsno}}

%%%% End of titlepage ==================================================

\newcounter{FirstPageOfTheIssue}
\newcounter{c@RelativePageOfTheIssue}%
\newsavebox{\lSignature}% signature of sheet N (on pages 16N+1)
\newsavebox{\rSignature}% signature of sheet N (on pages 16N+3)
\newcounter{c@PageInList}% Page number inside a sheet: 0,1,2,...,15
\newcounter{c@List}% Sheet number: 1,2,... (16 pages per sheet)
\def\theList{\arabic{List}}

\def\SignatureBase{16}

\def\Signature{%
    \setcounter{c@RelativePageOfTheIssue}{\value{page}-\value{FirstPageOfTheIssue}+1}%
    \setcounter{c@List}{1+(\value{c@RelativePageOfTheIssue}/\SignatureBase)}%
    \setcounter{c@PageInList}{ (\value{c@RelativePageOfTheIssue} -
                (\value{c@RelativePageOfTheIssue}/\SignatureBase)*\SignatureBase)}%
    \savebox{\lSignature}{\hbox{%
       \ifnum\value{c@PageInList}=1%
          {\noindent\fontsize{10}{12pt}\usefont{T2A}{cmr}{m}{n}%
          \small\thec@List\ \ \footnotesize \CYRZH\CYREREV\CYRT\CYRF\JETPissue{\thec@JETPissue}}% ZhEtF
       \fi
    }}%
    \savebox{\rSignature}{\hbox{%
       \ifnum\value{c@PageInList}=3%
          \ifnum\value{c@List}>1
             {\fontsize{10}{12pt}\usefont{T2A}{cmr}{m}{n}\small\thec@List*}%
          \fi
       \fi
    }}%
}

%% Column titles =======================================================
\def\HeadRule{\hrule width \textwidth depth0.2pt height0pt}

\newsavebox{\rjournal}
\AtBeginDocument{
    \savebox{\rjournal}{%
       \fontsize{10}{12pt}\usefont{T2A}{cmr}{m}{n}%
       %%               ZhETF                      tom
       {\sffamily\small \CYRZH\CYREREV\CYRT\CYRF,~~\cyrt\cyro\cyrm~\bfseries\thec@JETPvol}\JETPissue{\thec@JETPissue},~\JETPyear{\thec@JETPvol}%
    }%
}

\def\ps@headings{%
   \def\@evenfoot{\Signature\noindent
       \lower2ex\rlap{\usebox{\lSignature}}\hfil
       \reset@font\sffamily\thepage\hfil
       \lower2ex\llap{\usebox{\rSignature}}}%
   \let\@oddfoot\@evenfoot
   \if\c@page=@firstpage%\@titlehead%
   \else
     %% \def\@evenfoot{\reset@font\sffamily\thepage\hfil\usebox{\rjournal}}%
     %% \def\@oddfoot{\reset@font\sffamily\usebox{\rjournal}\hfil\thepage}%
     \def\@oddhead{\vbox{\let\@sectionbreak\space
         \Line{{\usebox{\rjournal}\hfil\sffamily\@rtitle}}%
         \smallskip \HeadRule
     }}%
     \def\@evenhead{\vbox{\let\@sectionbreak\space
         \Line{\it{\sffamily\@rauthor}\hfill\usebox{\rjournal}}%
         \smallskip \HeadRule
     }}%
   \fi
}

\pagestyle{headings}

% Math =================================================================
% to forbid hyphenation in formulas
\binoppenalty=10000
\relpenalty=10000
\def\qqq#1{#1\nobreak\discretionary{}{\hbox{\m@th$#1$}}{}} % see also \hm

\def\th{\operatorname{th}}
%\def\arctg{\operatorname{arctg}}
\def\Im{\operatorname{Im}}
\def\Re{\operatorname{Re}}
\def\Sp{\operatorname{Sp}}
%% \def\arctg{\mathop{\text{arctg}}\nolimits}
%% \def\Re{\mathop{\text{Re}}\nolimits}
%% \def\Im{\mathop{\text{Im}}\nolimits}
%% \def\Sp{\mathop{\text{Sp}}\nolimits}
%% \DeclareMathOperator*{\Im}{\rm{Im}}

\DeclareRobustCommand\lambdabar{%
  \bgroup
    \def\@tempa{%
      \hbox{\raise.73\ht\z@
         \hb@xt@\z@{\kern.25\wd\z@
            \vrule \@width.5\wd\z@\@height.1\p@\@depth.1\p@ \hss}%
         \box\z@}%
    }%
    \mathchoice{\setbox\z@\hbox{$\displaystyle     \lambda$}\@tempa}%
               {\setbox\z@\hbox{$\textstyle        \lambda$}\@tempa}%
               {\setbox\z@\hbox{$\scriptstyle      \lambda$}\@tempa}%
               {\setbox\z@\hbox{$\scriptscriptstyle\lambda$}\@tempa}%
  \egroup
}%

% Misc =================================================================
\def\Frac{\displaystyle\frac}

% \DeclareTextSymbol{\No}{T2aenc}{157}
\DeclareTextSymbolDefault{\textnumero}{T2A}
% \mathchardef\Re="023D
\def\@makefnmark{\hbox{\@textsuperscript{\normalfont\@thefnmark)}}}

%1) Added  "\hyphenchar\font=127" in t2acmr.fd to use alternative hyphen
%         \DeclareFontShape..........genb*#5}{"\hyphenchar\font=127}

%\renewcommand{\epsilon}{\varepsilon} % tokens to be redefined
\renewcommand{\~}{\ensuremath{\thinspace}}
%\renewcommand{\rm}[1]{\ensuremath{\text#1}}

%\doublehyphendemerits=-10000 % does not work (?)

\pretolerance=-1
\tolerance=1900
\adjdemerits=10000
\emergencystretch=10mm % Knuth, p. 131
\clubpenalty=10000 % first line break penalty
\widowpenalty=4000 % hanging line break penalty (last paragraph line)
\displaywidowpenalty=4000% same before a display formula


% Referencies ==========================================================
% Redefine Babel's setting:
\def\captionsenglish{%
  \def\prefacename{Preface}%
  \def\refname{References}%
  \def\abstractname{Abstract}%
  \def\bibname{Bibliography}%
  \def\chaptername{Chapter}%
  \def\appendixname{Appendix}%
  \def\contentsname{Contents}%
  \def\listfigurename{List of Figures}%
  \def\listtablename{List of Tables}%
  \def\indexname{Index}%
  \def\figurename{Fig.}%
%%\def\figurename{Figure}%
  \def\tablename{Table}%
  \def\partname{Part}%
  \def\enclname{encl}%
  \def\ccname{cc}%
  \def\headtoname{To}%
  \def\pagename{Page}%
  \def\seename{see}%
  \def\alsoname{see also}%
  \def\proofname{Proof}%
  \def\glossaryname{Glossary}%
  \def\@etal{et~al.}
  \def\see{see~}
}
\def\captionsrussian{%
  \def\prefacename{\CYRP\cyrr\cyre\cyrd\cyri\cyrs\cyrl\cyro\cyrv\cyri\cyre}% Predislovie
  \def\refname{\CYRL\cyri\cyrt\cyre\cyrr\cyra\cyrt\cyru\cyrr\cyra}% Literatura
  \def\abstractname{\CYRA\cyrn\cyrn\cyro\cyrt\cyra\cyrc\cyri\cyrya}% Annotaciya
  \def\bibname{\CYRL\cyri\cyrt\cyre\cyrr\cyra\cyrt\cyru\cyrr\cyra}% Literatura
  \def\chaptername{\CYRG\cyrl\cyra\cyrv\cyra}% Glava
  \def\appendixname{\CYRP\cyrr\cyri\cyrl\cyro\cyrzh\cyre\cyrn\cyri\cyre}% Prilozhenie
  \@ifundefined{thechapter}
    {\def\contentsname{\CYRS\cyro\cyrd\cyre\cyrr\cyrzh\cyra\cyrn\cyri\cyre}}% Soderzhanie
    {\def\contentsname{\CYRO\cyrg\cyrl\cyra\cyrv\cyrl\cyre\cyrn\cyri\cyre}}% Oglavlenie
  \let\tocname=\contentsname
  \def\listfigurename{\CYRS\cyrp\cyri\cyrs\cyro\cyrk\ \cyri\cyrl\cyrl\cyryu\cyrs\cyrt\cyrr\cyra\cyrc\cyri\cyrishrt}% Spisok illyustracij
  \def\listtablename{\CYRS\cyrp\cyri\cyrs\cyro\cyrk\ \cyrt\cyra\cyrb\cyrl\cyri\cyrc}% Spisok tablic
  \def\indexname{\CYRP\cyrr\cyre\cyrd\cyrm\cyre\cyrt\cyrn\cyrery\cyrishrt\ \cyru\cyrk\cyra\cyrz\cyra\cyrt\cyre\cyrl\cyrsftsn}% Predmetnyj ukazatel'
  \def\authorname{\CYRI\cyrm\cyre\cyrn\cyrn\cyro\cyrishrt\ \cyru\cyrk\cyra\cyrz\cyra\cyrt\cyre\cyrl\cyrsftsn}% Imennoj ukazatel'
  \def\figurename{\CYRR\cyri\cyrs.}% Ris.
  \def\tablename{\CYRT\cyra\cyrb\cyrl\cyri\cyrc\cyra}% Tablica
  \def\partname{\CYRCH\cyra\cyrs\cyrt\cyrsftsn}% Chast'
  \def\enclname{\cyrv\cyrk\cyrl.}% vkl.
  \def\ccname{\cyri\cyrs\cyrh.}% iskh.
  \def\headtoname{\cyrv\cyrh.}% vkh.
  \def\pagename{\cyrs.}% s.
  \def\seename{\cyrs\cyrm.}% sm.
  \def\alsoname{\cyrs\cyrm.\ \cyrt\cyra\cyrk\cyrzh\cyre}% sm. takzhe
  \def\proofname{\CYRD\cyro\cyrk\cyra\cyrz\cyra\cyrt\cyre\cyrl\cyrsftsn\cyrs\cyrt\cyrv\cyro}% Dokazatel'stvo
  \def\glossaryname{\CYRS\cyrl\cyro\cyrv\cyra\cyrr\cyrsftsn\ \cyrt\cyre\cyrr\cyrm\cyri\cyrn\cyro\cyrv}% Slovar' terminov
  \def\acronymname{\CYRA\cyrb\cyrb\cyrr\cyre\cyrv\cyri\cyra\cyrt\cyru\cyrr\cyrery}% Abbreviatury
  \def\lstlistingname{\CYRL\cyri\cyrs\cyrt\cyri\cyrn\cyrg}% Listing
  \def\lstlistlistingname{\CYRL\cyri\cyrs\cyrt\cyri\cyrn\cyrg\cyri}% Listingi
  \def\notesname{\CYRZ\cyra\cyrm\cyre\cyrt\cyrk\cyri}% Zametki
  \def\@etal{\cyri~\cyrd\cyrr.}% i~dr.
  \def\see{\cyrs\cyrm.~}% sm.
}

\def\@biblabel#1{{\bf#1}.}
\newenvironment{references}
  {\reset@font\parsep=0pt\itemsep=0pt\begin{thebibliography}{999}\small}
  {\end{thebibliography}}

%% Figure ==============================================================
%% artcle.cls remnants -------------------------------------------------
\newcounter{figure}

%% \renewcommand \thefigure {\@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename~\thefigure}
\let\FigureStart\relax
\let\FigureEnd\relax
\newenvironment{figure}{\@float{figure}}{\end@float}
\newenvironment{figure*}{\@dblfloat{figure}}{\end@dblfloat}

\def\@xfloat #1[#2]{%
   \@nodocument
   \def\@captype{#1}%
   \def\@fps{#2}%
   \@onelevel@sanitize\@fps
   \def\reserved@b{!}%
   \ifx\reserved@b\@fps \@fpsadddefault
   \else \ifx\@fps\@empty \@fpsadddefault \fi \fi
   \ifhmode \@bsphack \@floatpenalty -\@Mii
   \else \@floatpenalty-\@Miii \fi
   \ifinner \@parmoderr\@floatpenalty\z@
   \else
     \@next\@currbox\@freelist
       {%
        \@tempcnta \sixt@@n
        \expandafter \@tfor \expandafter \reserved@a
          \expandafter :\expandafter =\@fps
          \do {%
            \if \reserved@a h%
              \ifodd \@tempcnta \else \advance \@tempcnta \@ne \fi
            \fi
            \if \reserved@a t%
              \@setfpsbit \tw@
            \fi
            \if \reserved@a b%
              \@setfpsbit 4%
            \fi
            \if \reserved@a p%
              \@setfpsbit 8%
            \fi
            \if \reserved@a !%
              \ifnum \@tempcnta>15 \advance\@tempcnta -\sixt@@n\relax \fi
            \fi
          }%
        \@tempcntb \csname ftype@\@captype \endcsname
        \multiply \@tempcntb \@xxxii
        \advance \@tempcnta \@tempcntb
        \global \count\@currbox \@tempcnta
       }%
     \@fltovf
   \fi
   \global\setbox\@currbox
   \color@vbox
   \normalcolor
   %% Special part -----------------------------------------------------
   \ifx\@captype\captype@fig \FigureStart \fi
   %%-------------------------------------------------------------------
   \vbox \bgroup \hsize\columnwidth \@parboxrestore \@floatboxreset
}

\def\end@float{%
  \@endfloatbox
  \ifnum\@floatpenalty <\z@
    \@largefloatcheck
    \@cons\@currlist\@currbox
    \ifnum\@floatpenalty <-\@Mii
      \penalty -\@Miv \@tempdima\prevdepth
      \vbox{}\prevdepth\@tempdima \penalty\@floatpenalty
    \else
      \vadjust{\penalty -\@Miv \vbox{}\penalty\@floatpenalty}\@Esphack
    \fi
  \fi
}

\def\end@dblfloat{%
  \if@twocolumn
    \@endfloatbox
    \ifnum\@floatpenalty <\z@
      \@largefloatcheck \@cons\@dbldeferlist\@currbox
    \fi
    \ifnum \@floatpenalty =-\@Mii \@Esphack\fi
  \else \end@float \fi
}

\def\@endfloatbox{\par\vskip\z@skip %% \par\vskip\z@ added 15 Dec 87
    \@minipagefalse \outer@nobreak
    \egroup %% end of vbox
    %% Special part ----------------------------------------------------
    \ifx\@captype\captype@fig \FigureEnd \fi
    %%------------------------------------------------------------------
   \color@endbox
}

%% ---------------------------------------------------------------------
%% \RequirePackage[emtex,dvips]{graphicx}
\RequirePackage{graphicx}
\graphicspath{{EPS/}}
\newif\ifJETPcolor \JETPcolorfalse
\def\EnableColor{\graphicspath{{EPS/color/}{EPS/}}\JETPcolortrue}
\def\EnableLowRes{\graphicspath{{EPS/LowRes/}{EPS/}}}
\RequirePackage{color}
\setlength{\textfloatsep}{15pt plus 2pt minus 4pt}
%% \def\dblfigrule{\vspace{3mm}\noindent\rule{\textwidth}{0.1pt}}%
%% \def\botfigrule{\noindent\rule{\columnwidth}{0.1pt}\vspace{3mm}}%

\newif\if@captlabel\@captlabeltrue
\newif\if@jetp@caption\@jetp@captiontrue
\newbox\jetp@figbox

\let\figtrail=\relax

%% \fig{fname}{width}{height}{caption text}
%% \fig[fignumber]{fname}{width}{height}{caption text}
%% If fignumber is * then no `Fig #.' appears
%% If fname is * then no graphics file is loaded
%% width is actual if fname is *; if it is empty then
%% \wd\jetp@figbox=0pt; else \wd\jetp@figbox=width.
%% If capion text is * then no caption appears and figure counter is not
%% advanced.
%% height is not used.
\newcommand\fig[5][\@arabic\c@figure]{%
    \ifx*#1\@captlabelfalse\else\@captlabeltrue\fi
    \ifx*#5\@jetp@captionfalse\else\@jetp@captiontrue\fi
    \ifx*#2%
       \def\jetp@tmp{#3}%
       \ifx\jetp@tmp\@empty \setbox\jetp@figbox=\hbox{}%
       \else \setbox\jetp@figbox=\hbox{\hskip#3}\fi
    \else
        \def\jetp@tmp{*}%
        \setbox\jetp@figbox=\hbox{\includegraphics*{#2.eps}}%
    \fi
    \ifdim\wd\jetp@figbox<\columnwidth
       \parbox[c]{\columnwidth}{\noindent
    %% \ifdim\wd\jetp@figbox<0.5\textwidth
    %%    \parbox[c]{0.5\textwidth-\columnsep}{\noindent
             %% \colorbox{yellow}{%
                \@JETP@figbox
             %% }%
             \if@jetp@caption \caption{#5}\addcaptionskip \fi
        }\hspace{\columnsep}%
    \else
        \@JETP@figbox
        \if@jetp@caption \caption{#5}\addcaptionskip \fi
    \fi
    \figtrail
}

\def\@JETP@figbox{\ifx\jetp@tmp\@empty \else\centerline{\box\jetp@figbox}\fi}

\let\@fig=\fig

\def\FigCharProtect{\@makeother\_}

\def\UnFig{\let\fig=\unfig}
%% \let\UserIG=\relax
\def\UserIG#1{\fbox{\vbox to 4cm{\hsize=\columnwidth\vss\centerline{#1}\vss}}}

{\FigCharProtect
 \gdef\unfig{\bgroup\FigCharProtect\let\figtrail=\egroup
             \def\includegraphics*{\UserIG}\@fig}%
}

\def\addcaptionskip{\vskip3mm\relax}

%% Table ===============================================================
%% artcle.cls remnants -------------------------------------------------
\newcounter{table}\setcounter{table}{1}
\renewcommand\thetable{\@arabic\c@table}
\renewcommand{\tabularxcolumn}[1]{m{#1}}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename~\thetable}
%% ---------------------------------------------------------------------

\RequirePackage{array}
%\setlength{\extrarowheight}{4pt}
\def\arraystretch{1.2} % vertical spacing
\RequirePackage{dcolumn}
\newcolumntype{d}[1]{D{.}{.}{#1}}

%% sttools -------------------------------------------------------------
%% Wide objects (text, formulae) insertion
%% \RequirePackage[unskipbreak,autobase]{cuted}
%% \RequirePackage[unskipbreak]{cuted}
%% \RequirePackage[autobase]{cuted}
\RequirePackage{cuted}

%% Column balance without using multicols environement
\let\flushcolsend=\relax
\ifjetpflushend
   %%\RequirePackage[autobase]{flushend}
   \RequirePackage{flushend}
   \ifx\flushcolsend\relax
        \@latex@error{The command \string\flushcolsend\space
        undefined.^^JProbably flushend package is older that V2.2 or
        incompatible.^^JThe command is redefined as \string\relax}\@ehc
   \fi
\fi
%%----------------------------------------------------------------------

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\tabl}[2][\thetable]{%
  \addtolength{\leftskip}{0.06\columnwidth  plus 1fil}% centering
  \addtolength{\rightskip}{0.06\columnwidth  plus -1fil}%
  \setlength{\parfillskip}{0.06\columnwidth  plus 2fil}%
  \def\tabtmp{#1}\def\tabtmpc{#2}%
  \ifx\tabtmpc\@empty \let\tabldot\relax\else\def\tabldot{.}\fi
  \ifx\Ast\tabtmp \def\TheTable{\unskip\tabldot\@gobble}\def\TableAdd{0}%
  \else \def\TheTable{#1}\def\TableAdd{1}\fi
  {{\CaptionHeadFont\tablename~\TheTable.~}{\CaptionFont#2}\par}%
  \addtocounter{table}{\TableAdd}%
}

\newdimen\cvboxd
%% Means for vertical centering in tables (PTEMAC)
\def\cvbox#1#2{%
  \setbox\cvboxd=\hbox{#2}%
  \dimen\cvboxd\ht\strutbox
  \advance\dimen\cvboxd+\dp\strutbox
  \multiply\dimen\cvboxd by#1\relax
  \advance\dimen\cvboxd-\ht\cvboxd\relax
  \advance\dimen\cvboxd-\dp\cvboxd\relax
  \divide\dimen\cvboxd by 2\relax
  \setbox\cvboxd=\hbox{\lower\dimen\cvboxd\hbox{#2}}\dp\cvboxd=0pt\box\cvboxd\relax}

\newenvironment{table}
  {%%\@centering%
   %% \renewcommand{\as@makecaption}[2]{%
   %% \setlength{\leftskip}{\captionmargin}%
   %% \setlength{\rightskip}{\captionmargin}%
   %% \addtolength{\as@captionwidth}{-2\captionmargin}%
   %% \captionfont%
   %% \newsavebox{\as@mycaptionbox}
   %% \as@caption{\parbox{\columnwidth}{ {\hfill \CYRT\cyra\cyrb\cyrl.\thetable\par#2}} % Tabl.
   %% \par}}%
   \@float{table}}%
{\end@float}

\newenvironment{table*}{\@dblfloat{table}}{\end@dblfloat}

%% Caption =============================================================
\def\captype@fig{figure}
\def\captype@tab{table}
%% artcle.cls remnants -------------------------------------------------
\newlength\abovecaptionskip
\newlength\belowcaptionskip
\setlength\abovecaptionskip{10\p@ plus 2pt minus 4pt}
\setlength\belowcaptionskip{0\p@ plus 4pt minus 4pt}

\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  %% \sbox\@tempboxa{#1: #2}%
  %% \ifdim \wd\@tempboxa >\hsize
  %%   #1: #2%\par
  %% \else
  %%   \global \@minipagefalse
  %%   \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  %% \fi
  \addtolength{\leftskip}{0.04\columnwidth plus 1fil}% centering
  \addtolength{\rightskip}{0.04\columnwidth plus -1fil}%
  \setlength{\parfillskip}{0.04\columnwidth  plus 2fil}%
  \def\@mktmp{#2}%
  \ifx\@mktmp\@empty \let\@mksep\relax\else\let\@mksep=~\fi
  \ifx\@captype\captype@fig
       \if@captlabel{{\CaptionHeadFont\fnum@figure.\@mksep}}\fi
  \else
       \ifx\@captype\captype@tab
           \if@captlabel{{\CaptionHeadFont\fnum@table.\@mksep}}\fi
       \fi
  \fi
  {\CaptionFont#2\par}
  \vskip\belowcaptionskip
  }
%% ---------------------------------------------------------------------

\def\CaptionFont{\sffamily\small}
\def\CaptionHeadFont{\CaptionFont\bfseries}

%%\newcounter{figure}
%%\newcounter{table}
%%\def\@makecaption[2]{} %will be redefined later in caption.sty

%% \RequirePackage[centerlast,ruled]{caption}
%%\AtEndOfClass{
%%\renewcommand{\captionlabelfont}{\sffamily\small\bfseries}
%%\renewcommand{\captionfont}{\sffamily\small}
%% \renewcommand{\as@makecaption}[2]{%
%%  \setlength{\leftskip}{\captionmargin}%
%%  \setlength{\rightskip}{\captionmargin}%
%%  \addtolength{\as@captionwidth}{-2\captionmargin}%
%%  \captionfont%
%%  \if@captlabel%
%%     \sbox{\as@captionbox}{{\captionlabelfont #1} #2}%
%%     \ifdim \wd\as@captionbox >\as@captionwidth
%%       \as@caption{{\captionlabelfont #1}}{#2}%
%%     \else%
%%        \as@shortcaption{{\captionlabelfont #1}}{#2}%
%%     \fi
%%   \else
%%     \sbox{\as@captionbox}{{\captionlabelfont} #2}%
%%     \ifdim \wd\as@captionbox >\as@captionwidth
%%       \as@caption{{\captionlabelfont}}{#2}%
%%     \else%
%%        \as@shortcaption{{\captionlabelfont}}{#2}%
%%     \fi
%%   \fi
%%   }
%%}

%% Old style ===========================================================
\newcount\@indentflag \global\@indentflag=1
\def\@indentamount{%
    \ifcase\@indentflag 0pt\or\@centering\or0pt plus1fil\fi\relax
}
\def\inc@eqnnum{\addtocounter{equation}{1}}
\def\dec@eqnnum{\addtocounter{equation}{-1}}
\def\@eqnnum{\hbox{\reset@font\rm(\theequation)}}
\let\make@eqnnum=\@eqnnum %
\def\eqnum#1{\dec@eqnnum \global\def\make@eqnnum{\reset@font\rm(#1)}
    \def\@currentlabel{\Jobname-#1}%
}

\def\eqalign#1{\null\,\vcenter{\openup2\jot\m@th
  \ialign{\strut\hfill$\displaystyle{##}$&$\displaystyle{{}##}$\hfill
        \crcr#1\crcr}}\,}

\def\eqnarray{\par\vskip-\lastskip\vskip\abovedisplayskip
    \inc@eqnnum\let\@currentlabel=\theequation
    \global\@eqnswtrue\m@th \global\@eqcnt\z@
    \tabskip\@totalleftmargin\advance\tabskip by\@indentamount\let\\\@eqncr
    \halign to\hsize\bgroup\hskip\@centering
    $\displaystyle\tabskip\z@{##{}}$&\global\@eqcnt\@ne
    \hfill${{}##{}}$\hfill
    &\global\@eqcnt\tw@ $\displaystyle\tabskip\z@{##}$\hfil
    %%\tabskip\@centering \if@eqnsw\phantom{\make@eqnnum\kern\@eqtoeqnum}\fi
    \tabskip\@centering \if@eqnsw\phantom{\make@eqnnum}\fi
    &\llap{##}\tabskip\z@\cr
}

\def\endeqnarray{\@@eqncr\egroup
    \vskip\belowdisplayskip\noindent \dec@eqnnum\global\@indentflag=1
    \global\let\make@eqnnum\@eqnnum \global\@ignoretrue
}

\def\nonumber{\global\@eqnswfalse
   \def\label##1{\@revmess{error}{\string\label{##1} used with
       \string\nonumber\space before (\theequation)}}%
}

% end old style  =======================================================

%% ---------------------------------------------------------------------
\setcounter{secnumdepth}{5}
\newcounter{part}
\newcounter{section}
\newcounter{subsection}[section]
\newcounter{subsubsection}[subsection]
\newcounter{paragraph}[subsubsection]
\newcounter{subparagraph}[paragraph]
\def\thepart{\@Roman\c@part.}%
\def\thesection{\@arabic\c@section}%\kern-6pt}%
\def\thesubsection{\thesection.\@arabic\c@subsection}
\def\thesubsubsection{\thesubsection.\@arabic\c@subsubsection}
\def\theparagraph{\thesubsubsection.\@arabic\c@paragraph}
\def\thesubparagraph{\theparagraph.\@arabic\c@subparagraph}

\def\part{\if@noskipsec \leavevmode \fi \par
   \addvspace{4ex}\@afterindentfalse \secdef\@part\@spart}

\def\@part[#1]#2{%
    \ifnum \c@secnumdepth >\m@ne
      \refstepcounter{part}%
      \addcontentsline{toc}{part}{\thepart\hspace{1em}#1}%
    \else \addcontentsline{toc}{part}{#1}\fi
    {\parindent\z@\raggedright \interlinepenalty \@M \normalfont
     \ifnum \c@secnumdepth>\m@ne
       \Large\bfseries \partname~\thepart \par\nobreak
     \fi
     \huge \bfseries #2\markboth{}{}\par
    }%
    \nobreak \vskip 3ex \@afterheading
}

\def\@spart#1{%
    {\parindent \z@ %\raggedright%
     \interlinepenalty \@M \normalfont \centering
     \huge \bfseries #1\par}%
     \nobreak \vskip 3ex\@afterheading
}

%% Sections ------------------------------------------------------------

\newif\ifsection \sectionfalse % \section flag (not \sub*section)
%% \section and \section* consecutive number; total number of \section(*)'s
\newcount\maxsect \maxsect=0\relax

\def\section{\suppressfloats[t]%
    \@startsection{section}{3}{\z@}%
    {-8mm \@plus -1ex \@minus -.2ex}%------% {-3.5ex \@plus -1ex \@minus -.2ex}%
    { 2ex \@plus.3ex}%---------------------% {2.3ex \@plus.2ex}%
    {\global\sectiontrue\normalfont\small\bfseries\mathversion{bold}\SetSecEq\centering\MakeTextUppercase}% {\normalfont\Large\bfseries}
}

\def\subsection{\@startsection{subsection}{4}{\z@}%
    {-6mm\@plus -1ex \@minus -.2ex}%-------% {-3.25ex\@plus -1ex \@minus -.2ex}%
    { 2mm\@plus .2ex}%---------------------% {1.5ex \@plus .2ex}%
    {\global\sectiontrue\normalfont\bfseries\mathversion{bold}\SetSubSecEq\centering}}%-----% {\normalfont\large\bfseries}}
%    {\normalfont\bfseries\centerlast{3mm}\noindent}}%-----% {\normalfont\large\bfseries}}

\def\subsubsection{\@startsection{subsubsection}{5}{\z@}%
    {-3.25ex\@plus -1ex \@minus -.2ex}%
    {1.5ex \@plus .2ex}%
    {\global\sectiontrue\normalfont\small\bfseries\mathversion{bold}\centering}}% {\normalfont\normalsize\bfseries}}

\def\paragraph{\@startsection{paragraph}{6}{\z@}%
    {3.25ex \@plus1ex \@minus.2ex}%
    {-1em}%
    {\normalfont\bfseries}}%---------%{\normalfont\normalsize\bfseries}}

\def\subparagraph{\@startsection{subparagraph}{8}{\parindent}%
    {3.25ex \@plus1ex \@minus .2ex}%
    {-1em}%
    {\normalfont\small\bfseries}}%---------%{\normalfont\normalsize\bfseries}}

\def\@startsection#1#2#3#4#5#6{%
  \if@noskipsec \leavevmode \fi \par
  \@tempskipa #4\relax
  \@afterindenttrue
  \ifdim \@tempskipa <\z@ \@tempskipa -\@tempskipa \@afterindentfalse \fi
  \if@nobreak \everypar{}%
  \else \addpenalty\@secpenalty\addvspace\@tempskipa \fi
  \@ifstar{\@ssect{#1}{#2}{#3}{#4}{#5}{#6}}%
          {\@dblarg{\@sect{#1}{#2}{#3}{#4}{#5}{#6}}}%
}

\def\@seccntformat#1{\csname the#1\endcsname}

\def\@sect#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    %% \protected@edef\@svsec{\@seccntformat{#1}\relax}%
    \protected@edef\@svsec{\@seccntformat{#1}.~}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #6{%\@hangfrom
      {\hskip #3\relax\@svsec}\interlinepenalty\@M #8\@@par}%
    \endgroup
    \csname #1mark\endcsname{#7}%
    \SectionTOC{#1}{#2}{#8}% global and local TOC
  \else
    \def\@svsechd{%
      #6{\hskip #3\relax \@svsec #8}%
      \csname #1mark\endcsname{#7}%
      \SectionTOC{#1}{#2}{#7}% global and local TOC
    }%
  \fi
  \@xsect{#5}%
}

\def\@ssect#1#2#3#4#5#6#7{%
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \begingroup #6{%\@hangfrom
    {\hskip #3}\interlinepenalty\@M #7\@@par}\endgroup
  \else \def\@svsechd{#6{\hskip #3\relax #7}}\fi
      \SSectionTOC{#1}{#2}{#7}% global and local TOC
  \@xsect{#5}%
}

{\AntiBabel % Writing global and local TOC -----------------------------

  \gdef\sectiontoc#1{{\AntiBabelX\let\ref\relax\xdef\@sectiontoc{#1}}}%

  \gdef\SectionTOC#1#2#3{{\TOCProtect
      \sectiontoc{#3}%
      \addcontentsline{toc}{#1}{\ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname}\fi \@sectiontoc}%
      \ifsection % writing data for the local TOC ----------------------
         \global\advance\maxsect by 1\relax
         \xdef\@msts{\the\maxsect-\expandafter\csname the#1\endcsname}%
         \expandafter\WriteAux\@msts-{\@sectiontoc}%
         \xdef\@msts{#1-\expandafter\csname the#1\endcsname}%
         \expandafter\WriteLTOC\@msts-{\@sectiontoc}%
         \global\sectionfalse
      \fi %-------------------------------------------------------------
 }}%

 \gdef\SSectionTOC#1#2#3{{%
    \ifJETPtoc \else
      \TOCProtect \sectiontoc{#3}%
      \addcontentsline{toc}{s#1}{\@sectiontoc}%
      \ifsection % writing data for the local TOC
        \global\advance\maxsect by 1\relax
        \xdef\@msts{\the\maxsect-}%
        \expandafter\WriteAux\@msts-{\@sectiontoc}%
        \xdef\@msts{#1-}%
        \expandafter\WriteLTOC\@msts-{\@sectiontoc}%
        \global\sectionfalse
      \fi %-------------------------------------------------------------
    \fi
 }}%
} %---------------------------------------------------------------------

%% Local TOC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newwrite\@parttoc

\def\JETPlocalTOC#1{\expandafter\gdef\csname #1\endcsname}
\def\JETPLTOC#1{\csname LTOC#1\endcsname}

\def\LTOCsection#1{\advance\sectno by 1\relax
    \let\LocalTOCshape=\DefaultLocalTOCshape
    \let\LocalTOCfont=\DefaultLocalTOCfont
    #1\sectno\relax
}
\let\LTOCssection=\LTOCsection

\def\LTOCsubsection#1{\ifnum\LocalTOCdepth>1\relax
     \advance\sectno by 1\relax
     \let\LocalTOCshape=\DefaultLocalTOCshape
     \def\LocalTOCfont{\normalsize\rmfamily\mdseries}%
     #1\sectno\fi
}
\let\LTOCssubsection=\LTOCsubsection

\def\LTOCsubsubsection#1{\ifnum\LocalTOCdepth>2\relax
    \advance\sectno by 1\relax
    \let\LocalTOCshape=\DefaultLocalTOCshape
    \def\LocalTOCfont{\small\rmfamily\mdseries}%
     #1\sectno\fi
}
\let\LTOCssubsubsection=\LTOCsubsubsection

%% #1 - local toc section number (including unnumbered sections)
%% #2 - section number or empty
%% #3 - section title
\def\WriteAux#1-#2-#3{% Write data for local TOC
     \protected@write\@auxout{% place commands to protect here
       \let\label\@gobble \let\index\@gobble \let\glossary\@gobble
     }{\string\JETPlocalTOC{jetpsection#1}%
       {\string\LocalTOCitem{#2}{#3}{\thepage}}%
        \string\gdef\string\MaxSect{#1}%
     }%
}

%% #1 - section type (section/ssection/subsection/etc.)
%% #2 - section number or empty
%% #3 - section title
\def\WriteLTOC#1-#2-#3{% Write data for local TOC
     \protected@write\@parttoc{% place commands to protect here
       \let\label\@gobble \let\index\@gobble \let\glossary\@gobble
     }{\string\JETPLTOC{#1}{\string\LocalTOCitem{#2}{#3}{\thepage}}%
     }%
}

\def\MaxSect{0}
\newcount\sectno
\newcount\maxsectno

\let\LocalTOCcommands\relax
\def\LocalTOCbreak#1{\xdef\@LocalTOCbreak{#1}}
\def\LocalTOCskip#1{\gdef\@LocalTOCskip{\vrule width 0pt depth #1pt}}
\def\DefaultLocalCSR{0.4pt}
\def\DefaultLocalTOCitemSkip{\smallskip}

\def\LocalTOCdefs{% set/reset to defaults
        \LocalTOCbreak{0}%
        \LocalTOCskip{}%
        \let\LocalCSR=\DefaultLocalCSR
        \let\LocalTOCitemSkip=\DefaultLocalTOCitemSkip
}

\LocalTOCdefs

%% 1 = sections only
%% 2 = + subsections
%% 3 = + subsubsections
\newcount\LocalTOCdepth \LocalTOCdepth=3\relax

\newif\iflocaltoc \localtocfalse
\newif\iflocaltocforcetwocol \localtocforcetwocolfalse
\newif\iflocaltoctwocol \localtoctwocolfalse
\newif\iflocaltocs \localtocsfalse

\def\LocalTOCs{\localtoctrue\localtocstrue}
\def\LocalTOC{\localtoctrue\localtocsfalse}

\def\DoLocalTOC{{\maxsectno=\MaxSect\relax
     \columnseprule=\LocalCSR
     \if@twocolumn \localtoctwocoltrue \else \localtoctwocolfalse \fi
     \iflocaltocforcetwocol \localtoctwocoltrue \fi % force 2-column
     \iflocaltoctwocol
        \begin{multicols}2[\centerline{\bfseries\large\MakeTextUppercase\contentsname}]
     \else
        \centerline{\bfseries\large\MakeTextUppercase\contentsname}
     \fi
     \LocalTOCcommands
     \let\@RefNameFont\relax
     \let\@sectionbreak\space
     \def\@tocbreak{\break}%
     \def\@tochyphen{-\break}%
     \sectno=0\relax
     \iflocaltocs
        \ifnum\maxsectno>0
           \loop \advance\sectno by 1\relax
               \expandafter\csname jetpsection\the\sectno\endcsname\sectno
           \ifnum\sectno<\maxsectno \repeat
        \fi
     \else \@input{\Jobname.toc}\fi
     \if@twocolumn \end{multicols}\fi
    }%
    \LocalTOCdefs
}

\def\DefaultLocalTOCshape{\hangindent=1.3em\hangafter1\rightskip=2em %plus 1fil
    \parfillskip=-\rightskip \noindent
}
\def\DefaultLocalTOCfont{\bfseries\mathversion{bold}}

\let\LocalTOCshape=\DefaultLocalTOCshape
\let\LocalTOCfont=\DefaultLocalTOCfont

\def\LocalTOCitem#1#2#3#4{%
  {%%\let\normalfont=\relax \def\fontsize##1##2{} %\let\selectfont\relax
   \LocalTOCshape
   {\LocalTOCfont \ifx#1\@empty \else#1.~\fi #2}~\dotfill~#3\unskip
   \ifnum\@LocalTOCbreak=#4\relax \@LocalTOCskip\fi \par
   \ifnum\@LocalTOCbreak=#4\relax \columnbreak \LocalTOCbreak{0}\fi
   \LocalTOCitemSkip
  }%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\if@twocolumn \setlength\leftmargini{2em}\else \setlength\leftmargini{2.5em}\fi

\leftmargin\leftmargini
\setlength\leftmarginii {2.2em}
\setlength\leftmarginiii{1.87em}
\setlength\leftmarginiv {1.7em}

\if@twocolumn
  \setlength\leftmarginv {.5em}
  \setlength\leftmarginvi{.5em}
\else
  \setlength\leftmarginv {1em}
  \setlength\leftmarginvi{1em}
\fi

\setlength\labelsep{.5em}
\setlength\labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty

\def\theenumi{\@arabic\c@enumi}
\def\theenumii{\@alph\c@enumii}
\def\theenumiii{\@roman\c@enumiii}
\def\theenumiv{\@Alph\c@enumiv}

\def\labelenumi{\theenumi.}
\def\labelenumii{(\theenumii)}
\def\labelenumiii{\theenumiii.}
\def\labelenumiv{\theenumiv.}

\def\p@enumii{\theenumi}
\def\p@enumiii{\theenumi(\theenumii)}
\def\p@enumiv{\p@enumiii\theenumiii}

\def\labelitemi{\textbullet}
\def\labelitemii{\normalfont\bfseries \textendash}
\def\labelitemiii{\textasteriskcentered}
\def\labelitemiv{\textperiodcentered}

\newenvironment{description}
  {\list{}{\labelwidth\z@ \itemindent-\leftmargin
    \let\makelabel\descriptionlabel}}
  {\endlist}

\def\descriptionlabel#1{\hspace\labelsep\normalfont\bfseries #1}

\newenvironment{verse}
  {\let\\\@centercr \list{}{\itemsep\z@ \itemindent-1.5em\relax
    \listparindent\itemindent \rightmargin\leftmargin
    \advance\leftmargin 1.5em}\item\relax}
  {\endlist}
\newenvironment{quotation}
  {\list{}{\listparindent 1.5em \itemindent\listparindent
    \rightmargin\leftmargin \parsep\z@ \@plus\p@}\item\relax}
  {\endlist}
\newenvironment{quote}
  {\list{}{\rightmargin\leftmargin}\item\relax}{\endlist}

\if@compatibility
  \newenvironment{titlepage}
    {\if@twocolumn \@restonecoltrue\onecolumn
     \else \@restonecolfalse\newpage\fi
     \thispagestyle{empty}%
     \setcounter{page}\z@
    }%
    {\if@restonecol\twocolumn \else \newpage \fi}%
\else
  \newenvironment{titlepage}
    {\if@twocolumn \@restonecoltrue\onecolumn
     \else \@restonecolfalse\newpage\fi
     \thispagestyle{empty}%
     \setcounter{page}\@ne
    }%
    {\if@restonecol\twocolumn \else \newpage \fi
     \if@twoside\else \setcounter{page}\@ne\fi
    }
\fi

\def\appendix{\par
  \setcounter{section}{0}%
  \setcounter{subsection}{0}%
  \def\thesection{\Alph{section}}%
%%\gdef\thesection{\@Alph\c@section}%
}

\newif\ifFirstAppendix \FirstAppendixtrue

\def\Appendix{%
    \ifFirstAppendix \appendix \FirstAppendixfalse \fi
    \addtocounter{section}{1}%
    \setcounter{subsection}{0}%
    \section*{\appendixname~\thesection}
    \setcounter{equation}{0}%
    \SecEq
}

\def\sAppendix{%
    \appendix
    \addtocounter{section}{1}%
    \setcounter{subsection}{0}%
    \section*{\appendixname}
    \setcounter{equation}{0}%
    \SecEq
}

\setlength\arraycolsep{5\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}

\def\DropSecEq{\def\SetSecEq{}\def\SetSubSecEq{}}
\def\NormEq{\def\theequation{\@arabic\c@equation}\DropSecEq\@removefromreset{equation}{section}\@removefromreset{equation}{subsection}}
\def\SecEq{\def\theequation{\thesection.\@arabic\c@equation}\@addtoreset{equation}{section}\DropSecEq}
\def\SubSecEq{\SecEq
    \def\SetSecEq{\gdef\theequation{\thesection.\@arabic\c@equation}\@addtoreset{equation}{section}}%
    \def\SetSubSecEq{\gdef\theequation{\thesubsection.\@arabic\c@equation}\@addtoreset{equation}{subsection}}%
}

%% The following definition is copied from remreset package by David Carlisle
\def\@removefromreset#1#2{{%
  \expandafter\let\csname c@#1\endcsname\@removefromreset
  \def\@elt##1{\expandafter
    \ifx\csname c@##1\endcsname\@removefromreset
    \else \noexpand\@elt{##1}\fi}%
  \expandafter\xdef\csname cl@#2\endcsname{\csname cl@#2\endcsname}}}

\NormEq

%% =====================================================================

\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*\cal{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*\mit{\@fontswitch\relax\mathnormal}

%% TOC =================================================================

\def\@pnumwidth{1.55em}
\def\@tocrmarg{2.55em}
\def\@dotsep{4.5}
\setcounter{tocdepth}{0}

\def\tableofcontents{%
    %% \thispagestyle{plain}
    \@restonecoltrue
    \if@twocolumn \onecolumn \@restonecolfalse \fi
    \ifnum\FirstIssue=1\else \input contentshead.tex \fi
    \begin{center}\vspace*{5mm}{\large\bf \MakeTextUppercase\contentsname}\end{center}
    \vspace*{2mm}\title{~}\rtitle{}%
    %% \Markboth{\MakeTextUppercase\contentsname}}%
    \@starttoc{toc}%
}

\let\TOCcommands\relax
\newif\ifJETPtoc \JETPtocfalse

\def\@starttoc#1{%
  \begingroup
   \JETPtoctrue \TOCcommands
   \let\@sectionbreak\space
   \def\@tocbreak{\break}%
   \def\@tochyphen{-\break}%
    \makeatletter
    \@input{\jobname.#1}%
    \if@filesw
      \expandafter\newwrite\csname tf@#1\endcsname
      \immediate\openout \csname tf@#1\endcsname \jobname.#1\relax
    \fi
    \@nobreakfalse
    \if@restonecol \else \twocolumn \fi
  \endgroup
}

\newif\ifPartFirst \PartFirsttrue
\newif\ifPart
\newif\ifEnglish

\def\PartList{{}{}}%
\let\OldPart\relax

\def\TestEnglish{\IfEng{\Englishtrue}{\Englishfalse}\russian}

%% Set part (rubric) list
\def\Part#1 {\Parttrue
  \ifPartFirst
     \PartFirstfalse \TestEnglish \DoPart#1{}{}\def\PartList{#1{}{}}%
  \else
     \@latexerr{\string\Part\space
                specified more than once in the article.}\@ehc
  \fi
}

%% Parse rubric list, use the 1-st one and check all
\def\DoPart#1#2{\def\jetp@tmp{#1}%
  \ifx\jetp@tmp\@empty \def\next{\ifEnglish\english\fi}%
  \else
     \ifPart
        \if\jetp@tmp\OldPart \else
           \PartNameTest{#1}%
           {\TOCProtect\AddToTocP{#1. \PartName{#1}}}\gdef\OldPart{#1}%
        \fi
     \fi
     \gdef\PartNo{#1}\gdef\SubPartNo{#2}%
     \def\jetp@tmp{#2}\ifx\jetp@tmp\@empty \gdef\SubPartNo{0}\fi
     \if\SubPartNo0%% test if there is no subparts in the part
         \expandafter\ifx\csname JPartName#1.1\endcsname\relax%\@undefined
            \expandafter\gdef\csname JPartName#1.0\endcsname{}%
         \fi
      \fi
     \SubPartNameTest{#1}{#2}%
     \let\next=\DoPart
  \fi
  \Partfalse \next
}

\let\@AddToTocP\relax
\let\@SubPart\relax
\def\AddToTocP#1{\xdef\@AddToTocP{#1}}

{\AntiBabel
 \gdef\SubPartUni#1{{#1\xdef\@SubPart{\PartNo.\SubPartNo. \SubPartName{\PartNo}{\SubPartNo}}}}%
 \gdef\PartUni#1{{#1\xdef\@PartData{\JPline}}}%
 \gdef\PartTOC{\PartInfo{\TOCProtect\xdef\@PartTOC{\@AddToTocP}}}%
}

\gdef\SubPart{\SubPartUni\InfoProtect}
\gdef\SubPartIdx{\SubPartUni\IndexProtect}
\def\PartInfo{\PartUni\InfoProtect}
\gdef\PartIndex{\PartUni{\IndexProtect\PartProtect}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\PartProtect{\let\,=\relax\let~=\relax\let\break=\relax}

\def\EndList{}

\iftypesetter\ifJETPPart % Part/subpart list setting ===================

   \newread\jetppart
   \immediate\openin\jetppart=../jetppart.txt

   \newcount\JPcnt \JPcnt=0% part/subpart (\jetppart line counter)

   \ifeof\jetppart % ---------------------------------------------------

      \@latex@error{^^JFile ../jetppart.txt not found,
                       part/subpart list unavailabe.^^J}\@ehc

   \else % read the file if exists -------------------------------------

      \immediate\message{^^JReading JETP part/subpart file...^^J}

      %% 1.\EndList   -> \csname JPartName1\endcsname   -> part 1 name
      %% 1.1.\EndList -> \csname JPartName1.1\endcsname -> subpart 1.1 name
      \def\KillDot#1.{#1}
      \def\JPSsplit#1.#2\EndList{\def\jetp@tmp{#2}%
          \ifx\jetp@tmp\@empty\else\JPsub{*}\fi}
      \def\JPsplit#1. #2\EndList{\JPsub{}\JPSsplit#1.\EndList
          {\PartProtect\expandafter\xdef\csname JPartName#1\endcsname{#2}}}
      \def\JPsub#1{\expandafter\gdef\csname JPsub\the\JPcnt\endcsname{#1}}

      \loop
         \immediate\read\jetppart to\JPline
         \ifeof\jetppart \else
            {\global\advance\JPcnt by 1\relax
             \PartProtect\expandafter\JPsplit\JPline\EndList
             \expandafter\xdef\csname JPline\the\JPcnt\endcsname{\JPline}}%
         \repeat

      \def\PartName#1{\csname JPartName#1\endcsname}
      \def\PartNameTest#1{%
          \expandafter\ifx\csname JPartName#1\endcsname\relax%\@undefined
             \immediate\errmessage{^^J\string\PartName: Undefined part id: #1.}\fi
      }

      \def\SubPartName#1#2{\csname JPartName#1.#2\endcsname}
      \def\SubPartNameTest#1#2{%
          \expandafter\ifx\csname JPartName#1.#2\endcsname\relax%\@undefined
                \immediate\errmessage{^^J\string\SubPartName: Undefined subpart id: #1.#2.}\fi
      }

      %% #1 is the source, where the error has been detected;
      %% #2 is the part number/id
      %% #3 is the subpart number/id
      \def\PartError#1#2{}
      \def\SubPartError#1#2#3{}

   \fi % ---------------------------------------------------------------

\fi\fi % ===============================================================

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% \def\TOCDoubleArg#1#2{{\bfseries#1.} #2}
%%
%% \def\l@Section#1#2{%
%%     \addpenalty\@secpenalty
%%     \addvspace{1.0em \@plus\p@}%
%%     \setlength\@tempdima{1.5em}%
%%     \begingroup
%%       \parindent \z@ \rightskip \@pnumwidth
%%       \parfillskip -\@pnumwidth
%%       \leavevmode
%%       \advance\leftskip\@tempdima
%%       \hskip -\leftskip
%%       \TOCDoubleArg#1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
%%     \endgroup
%% }

\def\TOCSectionSkip{\medskip}

\def\l@Section#1#2{\TOCSectionSkip\l@@SectionP#1{#2}}
%% \def\l@Section#1#2{\TOCSectionSkip\l@@Section#1{#2}}

\def\l@@Section#1#2#3{{\parindent=0pt \finalhyphendemerits=0\relax
    \hangindent=2em \hangafter1 \rightskip=\@pnumwidth
    \rightskip=2\rightskip \parfillskip=-\rightskip
%     {{\sffamily#1}~\rlap{\hskip2em}}\dotfill{\unskip\nobreak\penalty50\vadjust{}\nobreak\dotfill\bf#2}%
%     {\hfill#3}\par}
      {\sffamily#1\unskip.}\enskip{\bf#2}~\dotfill~\hb@xt@\@pnumwidth{\hss #3}\par}%
}

\def\l@@SectionP#1#2#3{%\smallskip
    \noindent\hspace{0.5cm}
    \parbox[b]{15cm}{\parindent=-0.5cm
    {{\sffamily#1}~\rlap{\hskip2em}}\dotfill
    {\unskip\nobreak \penalty50\vadjust{}\nobreak\dotfill
    \bf#2}\parfillskip=0pt\finalhyphendemerits=0}{\hfill#3}\par
    \smallskip
}

\def\SetPart#1.#2\EndList{\MakeTextUppercase{#2}}

\def\TOCPartSkip{\addvspace{2.25em \@plus\p@}}

\def\l@Part#1#2{%
      \TOCPartSkip
%     {\Centering
%      \bfseries \SetPart#1\EndList\nopagebreak\par}%\nopagebreak\vskip6pt
%    \nopagebreak
     \section*{\SetPart#1\EndList}
}

\ifjubilee \def\l@Part#1#2{}\fi

%% Subparts curretly are not passed to TOC
%% \def\l@Subpart#1#2{%\addvspace{2.25em \@plus\p@}%
%% % {\parindent \z@ {\leavevmode \Large #1\hfil}\par\nobreak}%
%% }

\def\l@part#1#2{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty\@secpenalty
    \addvspace{2.25em \@plus\p@}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      {\leavevmode
       \large \bfseries #1\hfil \hb@xt@\@pnumwidth{\hss #2}}\par
       \nobreak
       \if@compatibility
         \global\@nobreaktrue
         \everypar{\global\@nobreakfalse\everypar{}}%
      \fi
    \endgroup
  \fi}

\def\TOCsectionSkip{\addvspace{1.0em \@plus\p@}}

\def\l@section#1#2{%
  \ifnum \c@tocdepth >\z@
    \addpenalty\@secpenalty
    \TOCsectionSkip
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \bfseries
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
    \endgroup
  \fi}

\def\l@ssection#1#2{%
  \ifnum \c@tocdepth >\z@
    \addpenalty\@secpenalty
    \TOCsectionSkip
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \bfseries
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
    \endgroup
  \fi}

\def\l@subsection{\@dottedtocline{2}{1.5em}{2.3em}}
\def\l@subsubsection{\@dottedtocline{3}{3.8em}{3.2em}}
\def\l@paragraph{\@dottedtocline{4}{7.0em}{4.1em}}
\def\l@subparagraph{\@dottedtocline{5}{10em}{5em}}
\def\l@ssubsection{\@dottedtocline{2}{1.5em}{2.3em}}
\def\l@ssubsubsection{\@dottedtocline{3}{3.8em}{3.2em}}
\def\l@pparagraph{\@dottedtocline{4}{7.0em}{4.1em}}
\def\l@ssubparagraph{\@dottedtocline{5}{10em}{5em}}

%% =====================================================================

\def\MarkBoth#1{\@mkboth{#1}{#1}}

\def\listoffigures{%
    \section*{\listfigurename\MarkBoth{\MakeTextUppercase\listfigurename}}%
    \@starttoc{lof}%
}

\def\l@figure{\@dottedtocline{1}{1.5em}{2.3em}}

\def\listoftables{%
    \section*{\listtablename \MarkBoth{\MakeTextUppercase\listtablename}}%
    \@starttoc{lot}%
}

\let\l@table\l@figure
\newdimen\bibindent
\setlength\bibindent{1.5em}

\def\RefNameFont{\protect\@RefNameFont}
\def\@RefNameFont{\reset@font\large}

\newenvironment{thebibliography}[1]
   {\section*{\RefNameFont\refname}
    \@mkboth{\MakeTextUppercase\refname}{\MakeTextUppercase\refname}%
    \list{\@biblabel{\@arabic\c@enumiv}}%
         {\settowidth\labelwidth{\@biblabel{#1}}%
          \leftmargin\labelwidth \advance\leftmargin\labelsep
          \@openbib@code
          \usecounter{enumiv}%
          \let\p@enumiv\@empty
          \renewcommand\theenumiv{\@arabic\c@enumiv}}%
    \sloppy
    \clubpenalty4000
    \@clubpenalty \clubpenalty
    \widowpenalty4000
    \sfcode`\.\@m}
   {\def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}\endlist}
\def\newblock{\hskip .11em\@plus.33em\@minus.07em}
\let\@openbib@code\@empty

\newenvironment{theindex}
  {\if@twocolumn \@restonecolfalse \else \@restonecoltrue \fi
     \columnseprule \z@ \columnsep 35\p@
     \twocolumn[\section*{\indexname}]%
     \MarkBoth{\MakeTextUppercase\indexname}%
     \thispagestyle{plain}\parindent\z@ \parskip\z@ \@plus .3\p@\relax
     \let\item\@idxitem}
  {\if@restonecol\onecolumn\else\clearpage\fi}

\def\@idxitem{\par\hangindent 40\p@}
\def\subitem{\@idxitem \hspace*{20\p@}}
\def\subsubitem{\@idxitem \hspace*{30\p@}}
\def\indexspace{\par \vskip 10\p@ \@plus5\p@ \@minus3\p@\relax}

\def\footnoterule{\kern-6\p@\hrule\@width.4\columnwidth\kern2.6\p@}
\def\@makefntext#1{\parindent 1em\noindent\hb@xt@1.8em{\hss\@makefnmark}\kern0.33em\relax#1}

\def\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}

\setlength\columnsep{10\p@}
\setlength\columnseprule{0\p@}

\pagenumbering{arabic}
\if@twoside \else \raggedbottom \fi
\if@twocolumn \twocolumn \sloppy \flushbottom \else \onecolumn \fi

%% Include =============================================================

\def\includeonly#1{\@partswtrue \edef\@partlist{\zap@space#1 \@empty}}

\@onlypreamble\includeonly

\let\Jobname\jobname

\def\include#1{\relax
  \ifnum\@auxout=\@partaux
    \@latex@error{\string\include\space cannot be nested}\@ehc
  \else \xdef\Jobname{#1}\JNcnt\maxsect=0\def\MaxSect{0}\relax\PartFirsttrue\NormEq\@include#1 \fi}

\def\@include#1 {\clearpage \ifeditor \DropCaptionBox \fi
  \if@filesw \immediate\write\@mainaux{\string\@input{#1.aux}}\fi
  \@tempswatrue
  \if@partsw
    \@tempswafalse \edef\reserved@b{#1}%
    \@for\reserved@a:=\@partlist\do
      {\ifx\reserved@a\reserved@b\@tempswatrue\fi}%
  \fi
  \if@tempswa
    \let\@auxout\@partaux
    \if@filesw
      \immediate\openout\@partaux #1.aux
      \immediate\write\@partaux{\relax}%
    \fi
    \LabelWrite{firstpage}\let\@rauthor\@empty\let\@Rauthor\@empty
    \bgroup\russian
      \@input@{#1.tex}\CaptionBoxOutput\EndLabelWrite
    \egroup
    \clearpage
    \@writeckpt{#1}%
    \if@filesw \immediate\closeout\@partaux \fi
  \else
    \deadcycles\z@ \@nameuse{cp@#1}%
  \fi
  \let\@auxout\@mainaux
}

\def\CaptionBoxOutput{\ifdim\ht\CaptionBox>0pt \clearpage \hsize=\textwidth\unvbox\CaptionBox \fi}

%% Pagerefs ============================================================
\def\@Setref#1#2#3{\ifx#1\relax 0\else \expandafter#2#1\null\fi}
\def\Pageref#1{\expandafter\@Setref\csname r@#1\endcsname\@secondoftwo{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\let\No=\textnumero % undefined in new Babel
\def\lc#1{\ensuremath{\text{\NoCaseChange{#1}}}}

%% Chemical formulae:
\def\chem{\protect\@chem}   \def\@chem{\bgroup\rmfamily}
\def\echem{\protect\@echem} \def\@echem{\egroup}
\def\Chem{\protect\@Chem}   \def\@Chem#1{\bgroup\lc{#1}\egroup}

\def\EnsureOneCol{\@restonecolfalse \if@twocolumn \@restonecoltrue\onecolumn \fi}
\def\ReColumn{\if@restonecol \@restonecoltrue\twocolumn \fi}
\def\Hrule{\hrule height 1pt depth 0pt}

{%%\AntiBabel
  \long\gdef\@xmakecaption#1#2{% \@makecaption for editor style
    \hsize=\textwidth
    \vskip\abovecaptionskip
    {%%\AntiBabelX
    \if@captlabel
       \centerline{\CaptionHeadFont\fnum@figure}
       \global\setbox\CaptionBox=\vbox{\hsize=\textwidth\unvbox\CaptionBox
          \bigskip {\CaptionHeadFont\fnum@figure.}~{\CaptionFont#2\par}}%
    \else
       \centerline{\CaptionHeadFont\fnum@figure}
       \global\setbox\CaptionBox=\vbox{\hsize=\textwidth\unvbox\CaptionBox
           \bigskip {\CaptionHeadFont\fnum@figure.}~{\CaptionFont#2\par}}%
    \fi
    }%
    \vskip\belowcaptionskip
    \vfill
    \null
  }%
  \gdef\PageFigure{\def\fps@figure{p}%
      \def\FigureStart{\vbox to \textheight\bgroup%%\AntiBabelX
            \let\@makecaption\@xmakecaption}\def\FigureEnd{\vss\egroup}}
}

\newbox\CaptionBox

\ifeditor
  \def\DropCaptionBox{\setbox\CaptionBox=\vbox{\hsize=\textwidth
    \centerline{\bf %% Podrisunochnye podpisi
     \CYRP\cyro\cyrd\cyrr\cyri\cyrs\cyru\cyrn\cyro\cyrch\cyrn\cyrery\cyre\
     \cyrp\cyro\cyrd\cyrp\cyri\cyrs\cyri}}}%
  \DropCaptionBox
\fi

%% Style for single article typesetting mode
\def\EditorStyle{\def\baselinestretch{1.5}\relax
    \usepackage[nofiglist,nomarkers,figuresonly]{endfloat}
    %% Vladimir Volovich's endfloat inernalization fix:
    \def\efloat@iwrite##1{\expandafter\immediate
        \expandafter\protected@write\csname efloat@post##1\endcsname{}}%
    \PageFigure \DropCaptionBox \DropTitleHead
    \AtEndDocument{\CaptionBoxOutput}%
}

\def\KillSignatures{%
    \def\Signature{\savebox{\lSignature}{\hbox{}}\savebox{\rSignature}{\hbox{}}}%
}

%% Setting for authors
\iftypesetter \else \ifeditor \else
   \KillSignatures \volume{1}\issue{1}%
   \def\JETPyear#1{}\def\JETPissue#1{}\def\thec@JETPvol{}%
   \def\JETPlogo{{\Russian\CYRZH\CYREREV\CYRT\CYRF}}% ZhETF
   \AtBeginDocument{\savebox{\rjournal}{{\Russian\CYRZH\CYREREV\CYRT\CYRF}}}%
\fi \fi

\def\TypeSetterStyle{% Style for single article typesetting mode
    \jetpdoifalse \KillSignatures
    \def\Part##1 {}%
    \NoWriteInfo  %% do not make info-file
    \NoWriteIndex %% do not make index-file
    \NoTOC %% discard table fo contents
    %% Simulate first and last page referencing w/o \include:
    \let\Jobname=\jobname \JNcnt
    \DOI 10.7868/S0044451000000000 %% blank DOI (trailing space required!)
    \AtBeginDocument{\expandafter\label\expandafter{\Jobname firstpage}}%
    %% The following does not work if the last page if full:
    %% \AtEndDocument{\expandafter\label\expandafter{\Jobname lastpage}}%
    \AtEndDocument{\EndLabelWrite}%
}

\AtBeginDocument{%
  \ifJETPcolor \else \let\color=\@gobble \fi
}

\def\LabelWrite#1{\immediate\write\@auxout{\string\newlabel{\Jobname #1}{{}{\thepage}}}}
\def\EndLabelWrite{{\clearpage\addtocounter{page}{-1}\LabelWrite{lastpage}}\addtocounter{page}{+1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\dash{\nobreak\hskip0pt\nobreak-\hskip0pt}% Babel's "= analog
% Nonbreaking dash allowing hyphenation in the rest of the word:
\def\Dash{{\penalty10000\hbox{-}\penalty10000\hskip0pt}}% Babel's "~ analog

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Typesetting hacks:                                                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\VAE{\vadjust{\eject}}
\let\vae=\VAE
\def\vas#1{\vadjust{\vskip#1pt}}

\def\hbreak{\hfill\break}
\def\ubreak{\unskip\break}

\def\breakpar{{\unskip\parfillskip=0pt\par}}
\def\breakparn{\breakpar\noindent}
\def\BreakPar{\breakpar\eject\noindent}

\def\sectionbreak{\protect\@sectionbreak}
\def\@sectionbreak{\unskip\break}

\def\tocbreak{\protect\@tocbreak}
\let\@tocbreak\space

\def\tochyphen{\protect\@tochyphen}
\let\@tochyphen\relax

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Mathematical formulae typesetting hacks:                           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\PDP{\postdisplaypenalty=10000}
\def\PDPM{\postdisplaypenalty=-10000}
\def\pdp{\predisplaypenalty=10000}
\def\pdpm{\predisplaypenalty=-10000}
\def\DS#1#2{\def\jetp@tmpads{#1}\def\tmpbds{#2}%
 \ifx\jetp@tmpads\empty\else\abovedisplayskip=#1pt\abovedisplayshortskip=#1pt\fi
 \ifx\tmpbds\empty\else\belowdisplayskip=#2pt\belowdisplayshortskip=#2pt\fi
}
\newdimen\mathskip
%% Compress spaces in math (NB: \def\setlength#1#2{#1#2\relax}):
\def\MathSkip#1{\def\mathskiptmp{#1}%
    \ifx\mathskiptmp\empty
        \setlength\thickmuskip{1\thickmuskip minus1\thickmuskip}%
        \setlength\medmuskip  {1\medmuskip   minus1\medmuskip}%
        \setlength\thinmuskip {1\thinmuskip  minus1\thinmuskip}%
    \else
        \thickmuskip=#1\thickmuskip
        \medmuskip=#1\medmuskip
        \thinmuskip=#1\thinmuskip
    \fi
}

\def\Strut{\vrule width 0pt depth \maxdepth}
\def\STRUT#1 {\vrule width 0pt height 0pt depth #1pt}

% Math `hyphenation':
\def\hm#1{#1\nobreak\discretionary{}{\hbox{$#1$}}{}}
\def\Hm#1{#1\break #1}

% Breaks in compelx math formulae:
\def\BRK#1{#1{}\\{}#1}
\def\BRKS#1#2{#1{}\\[#2]{}#1}

%% Tools for wide formulae %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\Longformulapagestart{\breakpar\onecolumn\begin{multicols}2\noindent}
\def\Longformulapagestartn{\onecolumn\begin{multicols}2\noindent}
\def\Longformulapageend{\breakpar\end{multicols}\twocolumn\noindent}
\def\Longformulapageendn{\end{multicols}\twocolumn\noindent}

\def\TopLFrule{\leftline{\rule{0.5\textwidth}{.1pt}\rule{0.1pt}{2mm}}}
\def\BotLFrule{\rightline{\rule[-4mm]{0.1pt}{2mm}\hspace{-0.2mm}\rule[-2mm]{0.5\textwidth}{0.1pt}}}

\def\LFVS{\vspace*{-5mm}}
\def\ELFVS{\vspace*{-5mm}}

\def\longformula{\par\end{multicols}\LFVS \TopLFrule\par}
\def\endlongformula{\par \ELFVS \BotLFrule \begin{multicols}2\noindent}

\stripsep=2mm

\newenvironment{wide}
{\unskip \flushcolsend \begin{strip}\TopLFrule}
{\BotLFrule\end{strip}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Errata %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\errataname{\CYRP\cyro\cyrp\cyrr\cyra\cyrv\cyrk\cyra} % Popravka
\def\Toarticle{\CYRK~\cyrs\cyrt\cyra\cyrt\cyrsftsn\cyre} % K~stat'e
\def\toarticle{\cyrk~\cyrs\cyrt\cyra\cyrt\cyrsftsn\cyre} % k~stat'e

%% Old style in-line errata: -------------------------------------------
%% \let\beforeerrataskip\bigskip
%% \let\erratatitleskip\medskip
%% \let\aftererrataskip\bigskip
%%
%% %% #1 -- authors with initials/firstname at left (in genitive)
%% %% #2 -- authors with initials/firstname at right (in genitive)
%% %% #3 -- title
%% %% #4 -- reference
%% {\AntiBabel
%%  \gdef\Errata#1#2#3#4{\beforeerrataskip
%%     % Expand arguments and protect possible \vas
%%     {\ErrataProtect
%%      \xdef\ErrataName{\Toarticle~#1}%
%%      \xdef\ErrataNameR{\errataname\ \toarticle\ #2}%
%%      \xdef\ErrataTitle{#3}%
%%      \xdef\ErrataIssue{#4}%
%%     }%
%%     {\interlinepenalty \@M
%%       \centerline{\bf\errataname}
%%       \erratatitleskip
%%       \ErrataName\par
%%       {\centering\ignorespaces\ErrataTitle\unskip\par
%%        (\ignorespaces\ErrataIssue\unskip).\par}%
%%       {\TOCProtect \def\vas##1{}%
%%       \addcontentsline{toc}{Section}{{\ErrataTitle\
%%                                      (\ErrataIssue)}{\ErrataNameR}}}%
%%     }%
%%     \aftererrataskip
%%  }%
%% }
%% ---------------------------------------------------------------------

%% #1 -- original title
%% #2 -- original volume
%% #3 -- original issue
%% #4 -- original page
\def\ErrataTitle#1#2#3#4{\affiliation{}%
      \def\DOISkip{\bigskip}%
      \title{\errataname\ \toarticle\\#1}\ErrataRef{#2}{#3}{#4}%
      \let\@DOI\@empty
      \jetpdoifalse
}

%% #1 -- original volume
%% #2 -- original issue
%% #3 -- original page
\def\@ErrataRef{}%
\def\ErrataRef#1#2#3{%
    \gdef\@ErrataRef{(\CYRZH\CYREREV\CYRT\CYRF, \JETPyear{#1},
                 \cyrt\cyro\cyrm~{\bfseries#1}\JETPissue{#2},
                 \cyrs\cyrt\cyrr.~#3)}%
}

\def\Erratartitle#1{\rtitle{\errataname\ \toarticle\ #1}}
\def\ErrataRefSkip{\bigskip}

\def\EditorTitle#1{\affiliation{}%
    \let\@abstract\@empty
    \let\JubileeTextEng\@empty
    \let\JubileeTextRus\@empty
    \def\title{#1}%
    \let\@DOI\@empty
    \jetpdoifalse
    \jubileefalse
    \maketitle
    \thispagestyle{empty}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Indices %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Author index %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Alfavitnyj\ ukazatel'\ toma~\thec@JETPvol\ za~\lc{\JETPyear{\thec@JETPvol}}~\lc g.
%% \lc{\JETPyear{\thec@JETPvol}} helps \JETPyear not to expand with
%% \MakeTextUppercase
\def\AlphabeticIndexName{\CYRA\cyrl\cyrf\cyra\cyrv\cyri\cyrt\cyrn\cyrery\cyrishrt\
 \cyru\cyrk\cyra\cyrz\cyra\cyrt\cyre\cyrl\cyrsftsn\
 \cyrt\cyro\cyrm\cyra~\thec@JETPvol\ \cyrz\cyra~\lc{\JETPyear{\thec@JETPvol}}~\lc\cyrg.}

%% %% Alfavitnyj\ ukazatel'
\def\AuthorIndexName{{\russian
               \CYRA\cyrl\cyrf\cyra\cyrv\cyri\cyrt\cyrn\cyrery\cyrishrt\
                     \cyru\cyrk\cyra\cyrz\cyra\cyrt\cyre\cyrl\cyrsftsn}}

%% Predmetnyj\ ukazatel'\ toma~\thec@JETPvol\ za~\lc{\JETPyear{\thec@JETPvol}}~\lc g.
%% \lc{\JETPyear{\thec@JETPvol}} helps \JETPyear not to expand with
%% \MakeTextUppercase
\def\SubjectIndexName{\CYRP\cyrr\cyre\cyrd\cyrm\cyre\cyrt\cyrn\cyrery\cyrishrt\
 \cyru\cyrk\cyra\cyrz\cyra\cyrt\cyre\cyrl\cyrsftsn\
 \cyrt\cyro\cyrm\cyra~\thec@JETPvol\ \cyrz\cyra~\lc{\JETPyear{\thec@JETPvol}}~\lc\cyrg.}

%% Predmetnyj\ ukazatel'
\def\SubjIndexName{{\russian
               \CYRP\cyrr\cyre\cyrd\cyrm\cyre\cyrt\cyrn\cyrery\cyrishrt\
                     \cyru\cyrk\cyra\cyrz\cyra\cyrt\cyre\cyrl\cyrsftsn}}

\def\YearProtect{\def\lc{\string\lc}\def\JETPyear{\string\JETPyear}}

\def\AlphabeticIndex{%
        {\russian\def\addcontentsline##1##2##3{}\let\small=\normalsize
        \section*{\AlphabeticIndexName}}
        \rtitle{{\it\AuthorIndexName}}%
        \rauthor{{\it\AuthorIndexName}}%
        \aindextoc{\YearProtect\addcontentsline{toc}{Section}{{\AIndexList}{}}}%
}

\def\SubjectIndex{%
        {\russian\def\addcontentsline##1##2##3{}\let\small=\normalsize
        \section*{\SubjectIndexName}}
        \rtitle{{\it\SubjIndexName}}%
        \rauthor{{\it\SubjIndexName}}%
        \sindextoc{\YearProtect\addcontentsline{toc}{Section}{{\SIndexList}{}}}%
}

{\AntiBabel
 \gdef\aindextoc{{\TOCProtect\YearProtect\xdef\AIndexList{\AlphabeticIndexName}}}%
 \gdef\sindextoc{{\TOCProtect\YearProtect\xdef\SIndexList{\SubjectIndexName}}}%
}

%% Typesetter fine tuning:
\def\IndexRS{5em}   % right skip value
\def\IndexHI{1em}   % hanging indent value
\def\IndexCS{0.4pt} % column separation rule width
\def\IndexIW{2em}   % issue field width
\def\IndexPW{2.5em}  % page field width
\def\AuthorIndexCommands{\interlinepenalty \@M}
\def\SubjectIndexCommands{\interlinepenalty \@M}

\def\IndexLegend{\hbox to 0.5\textwidth{\hss\issuepage{\CYRV\cyrery\cyrp.}{\CYRS\cyrt\cyrr.}}}% Vyp.~Str.
\def\issuepage#1#2{\hbox to \IndexIW{\hss#1}~\hbox to \IndexPW{\hss#2}}

\def\IndexStart#1{%
  \if@twocolumn \@restonecolfalse \else \@restonecoltrue \fi \onecolumn
  \columnseprule=\IndexCS\relax #1
  \begin{multicols}2[\Line{\hss\IndexLegend\hskip0.5\columnsep\hskip-\IndexCS\IndexLegend}]
  \def\addcontentsline##1##2##3{}%
}

\def\IndexEnd{\end{multicols}\if@restonecol\clearpage\else\twocolumn\fi}

\newenvironment{JETPAuthorIndex}
  {\thispagestyle{titlehead}\IndexStart{\AlphabeticIndex \AuthorIndexCommands}}{\IndexEnd}

\newenvironment{JETPSubjectIndex}
  {\thispagestyle{titlehead}\IndexStart{\SubjectIndex \SubjectIndexCommands}}{\IndexEnd}

\newif\ifSpecialPart \SpecialPartfalse
\newcount\JETPspc

\def\JETPPid#1#2\EndList{\def\@JETPPid{#1}}%

%% Test if the category id is not a number
\def\TestSpecailPart#1{\SpecialParttrue \JETPPid#1\EndList
    \JETPspc=-1\relax
    \loop \advance \JETPspc by 1\relax
      \if\@JETPPid\the\JETPspc\SpecialPartfalse\JETPspc=10\relax\fi
    \ifnum\JETPspc<10\relax\repeat
}

%% Output id. Partname or Partname if id is not a number
\def\Category#1#2{\TestEnglish\russian \TestSpecailPart{#1}%
        \ifSpecialPart \xsection*{#2}\else\xsection*{#1.~#2}\fi
        \ifEnglish\english\fi}

\newif\ifzerosubcat \zerosubcatfalse
\def\TestSubSecNo#1.#2\EndList{\if#20 \zerosubcattrue
                               \else  \zerosubcatfalse \fi}

\def\Subcategory#1#2{\TestSubSecNo#1\EndList
    \ifzerosubcat\else
       \TestEnglish\russian\xsubsection*{#1~#2}\ifEnglish\english\fi
    \fi
}

\def\xsectioncmd{\normalfont\large\bfseries\mathversion{bold}}
\let\xsectionform=\raggedright

\def\xsubsectioncmd{\normalfont\normalsize\bfseries\mathversion{bold}}
\let\xsubsectionform=\raggedright

\def\indexletter#1{{\let\xsectionform=\Centering\xsection*{#1\hskip\IndexRS}}}

\def\xsection{\@startsection{xsection}{3}{\z@}% section-like
    {-8mm \@plus -1ex \@minus -.2ex}{2ex \@plus.3ex}%
    {\xsectioncmd\xsectionform}%
}

\def\xsubsection{\@startsection{xsubsection}{4}{\z@}% subsection-like
    {-6mm\@plus -1ex \@minus -.2ex}{2mm\@plus .2ex}%
    {\xsubsectioncmd\xsubsectionform}%
}

%% Disable in TOC
\def\l@xsection#1#2{}
\def\l@xsubsection#1#2{}
\def\l@sxsection#1#2{}
\def\l@sxsubsection#1#2{}

\def\IndexItemShape{\par \rightskip=\IndexRS \parfillskip=-\rightskip
               \parindent=0pt\hangafter1\hangindent\IndexHI}

\def\authoritem#1{\IndexItemShape\textbf{#1}}

% \titleitem{002004}{On the Einstein--Cartan cosmology vs. Planck data}{Palle~D.}~\dotfill~\issuepage{4}{94}
\def\titleitem#1#2#3{\IndexItemShape #2. {\it #3}}

\newdimen\Parindent \Parindent=\parindent
\def\Indent{\leavevmode\hbox to \Parindent{\hss}}

%% Insertion from jetphtml.sty. %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Modification:
%% \JETPhyper  defines authomatic hyper-referencing commands
%% \ifJETPhtml tests whether hyper-referencing is enabled
%%
%% jetphtml.sty -- automatic insertion of HTML hyperlinks.
%%
%% Automatically inserts hyperlinks to \cite, \bibitem, \label, \ref.
%% User commands are
%% \HTMLspec  % inserts any special for its argument:
%%            % \HTMLurl{html:<a href="http://www.kedit.com">} ->
%%            %           \special{html:<a href="http://www.kedit.com">}
%%
%% \HTMLurl   % inserts HTML-\special for its argument:
%%            % \HTMLurl{http://www.kedit.com} ->
%%            %           \special{html:<a href="http://www.kedit.com">}
%%
%% \HTMLhref  % inserts HTML-\special for its argument as local
%%            % reference:\HTMLhref{bib-1} ->
%%            %                         \special{html:<a href="#bib-1">}
%%
%% \HTMLname  % inserts HTML-\special for its argument as a mark name:
%%            % \HTMLname{bib-1} -> \special{html:<a name="bib-1">}
%%
%% \HTMLmail  % inserts HTML-mailto-\special:
%%            % \HTMLmail{myname@yandex.ru} ->
%%            %       \special{html:<a href="mailto:myname@yandex.ru">}%
%%            %       myname@yandex.ru\HTMLclose
%%
%% \HTMLclose % inserts HTML-\special for referene end:
%%            % \special{html:</a>}
%%
%% \arXiv     % inserts reference to http://arxiv.org/pdf/XXXv1, where
%%            % XXX = article number, specified as the command argument
%%
%% \arXivV    % same, but has two arguments: article number, and
%%            % version number: http://arxiv.org/pdf/XXXvV, where
%%            % XXX = article number (1-st argument), V = version number
%%            % (2-nd argument).
%%
%% \HTMLDOI   % inserts reference to http://dx.doi.org/DOIcode
%%
%% \url{url}{hypertext} % \url{http://www.kedit.com}{KEDIT cite}
%% \URL{url} % \URL{http://www.kedit.com}
%% in \URL the url argument may contain the \break command, which is
%% discarded in hyperreference; the same argument used as a hypertext.
%% \urlclean redefines \url as \urlgobble
%% \urlgobble{url}{hypertext} % ignores hypertext and runs as \URL{url}

\newif\ifJETPhtml \JETPhtmlfalse

\newcount\JETPCCC

\catcode`^^A=12\relax
\catcode`^^B=12\relax

\def\htmlcatcodes{%
    \JETPCCC=\the\catcode`\# \catcode`^^A=\JETPCCC \@makeother\#\relax
    \JETPCCC=\the\catcode`\% \catcode`^^B=\JETPCCC \@makeother\%\relax
    \@makeother\~\relax \@makeother\_\relax
    \@makeother\$\relax \@makeother\&\relax
}

{\htmlcatcodes
 \gdef\HTMLspec^^A1{{\htmlcatcodes\ifJETPhtml\special{^^A1}\fi}}^^B
 \gdef\HTMLurl^^A1{\HTMLspec{html:<a href="^^A1">}}^^B
 \gdef\HTMLhref^^A1{\HTMLurl{#^^A1}}^^B
 \gdef\HTMLmail^^A1{\HTMLurl{mailto:^^A1}^^A1\HTMLclose}^^B
 \gdef\HTMLname^^A1{\HTMLspec{html:<a name="^^A1">}}^^B
 \gdef\arXiv^^A1{\HTMLurl{http://arxiv.org/pdf/^^A1v1}^^A1\HTMLclose}^^B
 \gdef\arXivV^^A1^^A2{\HTMLurl{http://arxiv.org/pdf/^^A1v^^A2}^^A1\HTMLclose}^^B
 \gdef\HTMLDOI^^A1{\HTMLurl{http://dx.doi.org/^^A1}^^A1\HTMLclose}^^B
}

\def\HTMLclose{\ifJETPhtml\special{html:</a>}\fi}

\def\JETPhyper{\JETPhtmltrue
    \let\refori=\ref
    \let\labelori=\label
    \let\citeformori=\citeform
    \let\@lbibitemori=\@lbibitem
    \let\@bibitemori=\@bibitem
    %
    \def\ref##1{\HTMLhref{##1}\refori{##1}\HTMLclose}%
    \def\label##1{\HTMLname{##1}\labelori{##1}\HTMLclose}%
    %
    \let\ltx@label\label % AMS Math support if jetphtml.sty loaded after
    %
    %% Hyperlinking \cite (of cite package)
    \def\citeform##1{\HTMLhref{bib-##1}##1\HTMLclose}%
    %
    %% Hyperlinking \bibitem
    \def\@lbibitem[##1]##2{\HTMLname{bib-##1}\item[\@biblabel{##1}\hfill]\HTMLclose\if@filesw
        {\let\protect\noexpand
         \immediate\write\@auxout{\string\bibcite{##2}{##1}}}\fi\ignorespaces}%
    %
    \def\@bibitem##1{\addtocounter\@listctr\@ne
        \HTMLname{bib-\the\value{\@listctr}}\addtocounter\@listctr{-1}\relax
        \item\HTMLclose
        \if@filesw \immediate\write\@auxout
        {\string\bibcite{##1}{\the\value{\@listctr}}}\fi\ignorespaces}%
}

\def\URLcommands{\def\break{}}

\def\URL{\protect\@URL}
\def\@URL{\bgroup\htmlcatcodes\@@URL}
\def\@@URL#1{{\URLcommands\HTMLurl{#1}}#1\HTMLclose\egroup}

\def\url{\protect\@url}
\def\@url{\bgroup\htmlcatcodes\@@url}
\def\@@url#1{\HTMLurl{#1}\egroup\@@@url}
\def\@@@url#1{#1\HTMLclose}

\def\urlclean{\def\url\urlgobble}
\def\urlgobble{\protect\@urlgobble}
\def\@urlgobble{\bgroup\htmlcatcodes\@@urlgobble}
\def\@@urlgobble#1{{\URLcommands\HTMLurl{#1}}#1\HTMLclose\egroup\@gobble}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\ralph#1{\expandafter\@ralph\csname c@#1\endcsname}
\def\Ralph#1{\expandafter\@Ralph\csname c@#1\endcsname}

\def\@ralph#1{%
    \ifcase#1\or\cyra\or\cyrb\or\cyrv\or\cyrg\or\cyrd\or\cyre\or\cyrzh
    \or\cyrz\or\cyri\or\cyrk\or\cyrl\or\cyrm\or\cyrn\or\cyro\or\cyrp
    \or\cyrr\or\cyrs\or\cyrt\or\cyru\or\cyrf\or\cyrh\or\cyrc\or\cyrch
    \or\cyrsh\or\cyrshch\or\cyrerev\or\cyryu\or\cyrya\else\@ctrerr\fi}
\def\@Ralph#1{%
    \ifcase#1\or\Cyra\or\Cyrb\or\Cyrv\or\Cyrg\or\Cyrd\or\Cyre\or\Cyrzh
    \or\Cyrz\or\Cyri\or\Cyrk\or\Cyrl\or\Cyrm\or\Cyrn\or\Cyro\or\Cyrp
    \or\Cyrr\or\Cyrs\or\Cyrt\or\Cyru\or\Cyrf\or\Cyrh\or\Cyrc\or\Cyrch
    \or\Cyrsh\or\Cyrshch\or\Cyrerev\or\Cyryu\or\Cyrya\else\@ctrerr\fi}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ifJETPPart \else \TypeSetterStyle \fi

\hyphenation{
\cyrch\cyra\cyrs-\cyrt\cyri\cyrc\space                                                          %% chas-tic
\cyrch\cyra\cyrs-\cyrt\cyri-\cyrc\cyrery\space                                                  %% chas-ti-cery
\cyrch\cyra\cyrs-\cyrt\cyri-\cyrc\cyra\cyrh\space                                               %% chas-ti-cah
\cyrch\cyra\cyrs-\cyrt\cyri-\cyrc\cyra-\cyrm\cyri\space                                         %% chas-ti-ca-mi
\cyrch\cyra\cyrs-\cyrt\cyri-\cyrc\cyre\cyrishrt\space                                           %% chas-ti-ceishrt
\cyrr\cyro\cyrs-\cyrt\cyro\cyrm\space                                                           %% ros-tom
\cyrv\cyro\cyrz-\cyrb\cyru\cyrzh-\cyrd\cyre\cyrn-\cyrn\cyrery\cyre\space                        %% voz-buzh-den-nerye
\cyrv\cyro\cyrz-\cyrb\cyru\cyrzh-\cyrd\cyre\cyrn-\cyrn\cyrery-\cyrm\cyri\space                  %% voz-buzh-den-nery-mi
\cyrv\cyro\cyrz-\cyrb\cyru\cyrzh-\cyrd\cyre\cyrn-\cyrn\cyro\cyre\space                          %% voz-buzh-den-noe
\cyrv\cyro\cyrz-\cyrb\cyru\cyrzh-\cyrd\cyre-\cyrn\cyri\cyrya\space                              %% voz-buzh-de-niya
\cyrv\cyro\cyrz-\cyrb\cyru\cyrzh-\cyrd\cyre-\cyrn\cyri\cyryu\space                              %% voz-buzh-de-niyu
\cyrv\cyro\cyrz-\cyrb\cyru\cyrzh-\cyrd\cyre\cyrn-\cyrn\cyro-\cyrg\cyro\space                    %% voz-buzh-den-no-go
\cyrv\cyro\cyrz-\cyrb\cyru\cyrzh-\cyrd\cyre-\cyrn\cyri-\cyrya-\cyrm\cyri\space                  %% voz-buzh-de-ni-ya-mi
\cyrv\cyro\cyrz-\cyrb\cyru\cyrzh-\cyrd\cyre-\cyrn\cyri\cyrishrt\space                           %% voz-buzh-de-niishrt
\cyrk\cyrl\cyra\cyrs-\cyrt\cyre\cyrr\space                                                      %% klas-ter
\cyrk\cyrl\cyra\cyrs-\cyrt\cyre-\cyrr\cyra\space                                                %% klas-te-ra
\cyrk\cyrl\cyra\cyrs-\cyrt\cyre-\cyrr\cyro\cyrv\space                                           %% klas-te-rov
\cyrch\cyra\cyrs-\cyrt\cyri-\cyrc\cyrery\space                                                  %% chas-ti-cery
\cyrch\cyra\cyrs-\cyrt\cyri-\cyrc\cyra\cyrm\space                                               %% chas-ti-cam
\cyrch\cyra\cyrs-\cyrt\cyri\cyrc\space                                                          %% chas-tic
\cyrch\cyra\cyrs-\cyrt\cyro\space                                                               %% chas-to
\cyrch\cyra\cyrs-\cyrt\cyro-\cyrt\cyra\space                                                    %% chas-to-ta
\cyrch\cyra\cyrs-\cyrt\cyro-\cyrt\cyrery\space                                                  %% chas-to-tery
\cyrch\cyra\cyrs-\cyrt\cyro-\cyrt\cyro\cyrishrt\space                                           %% chas-to-toishrt
\cyrch\cyra\cyrs-\cyrt\cyro-\cyrt\cyre\space                                                    %% chas-to-te
\cyrch\cyra\cyrs-\cyrt\cyro\cyrt\space                                                          %% chas-tot
\cyrv\cyrery-\cyrs\cyro-\cyrk\cyro-\cyrch\cyra\cyrs-\cyrt\cyro\cyrt-\cyrn\cyrery\cyrh\space     %% very-so-ko-chas-tot-neryh
\cyrv\cyrery-\cyrs\cyro-\cyrk\cyro-\cyrch\cyra\cyrs-\cyrt\cyro\cyrt-\cyrn\cyro\cyrishrt\space   %% very-so-ko-chas-tot-noishrt
\cyrv\cyrery-\cyrs\cyro-\cyrk\cyro-\cyrch\cyra\cyrs-\cyrt\cyro\cyrt-\cyrn\cyro-\cyrg\cyro\space %% very-so-ko-chas-tot-no-go
\cyrv\cyrery-\cyrs\cyro-\cyrk\cyro-\cyrch\cyra\cyrs-\cyrt\cyro\cyrt-\cyrn\cyru\cyryu\space      %% very-so-ko-chas-tot-nuyu
\cyro\cyrb-\cyrs\cyru\cyrzh-\cyrd\cyre-\cyrn\cyri\cyre\space                                    %% ob-suzh-de-nie
\CYRO\CYRI\CYRYA\CYRI\space                                                                     %% OIYaI
}

%% End of file `jetp.cls'.
