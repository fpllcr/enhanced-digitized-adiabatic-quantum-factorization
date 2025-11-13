\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dissertation}[2020/08/25 v1.0 Atlarge dissertation class by LV]
%% Changes over the 2018/11/1 v2.0 TU Delft dissertation class by Laurens Versluis

\newif\if@nativefonts
\DeclareOption{nativefonts}{\@nativefontstrue}
\newif\if@print
\DeclareOption{print}{\@printtrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax

\LoadClass[11pt]{book}
\usepackage{etoolbox}
\patchcmd{\DeclareMathAlphabet}{\mathgroup\symletters}{\mathgroup\symletters\relax}{}{}


%% Import packages
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\usepackage{physics}
\DeclareMathAlphabet{\mathcal}{OMS}{cmsy}{m}{n}

\RequirePackage[english]{babel}
\RequirePackage{calc}
\RequirePackage[nooneline,footnotesize]{caption}
\RequirePackage{fancyhdr}
\RequirePackage[flushmargin,hang]{footmisc}
\RequirePackage{ifpdf}
\RequirePackage{ifxetex}
\ifxetex
    \RequirePackage[xetex]{geometry}
    \RequirePackage[xetex]{graphicx}
    \RequirePackage[xetex,bookmarks=false,hidelinks]{hyperref}
    \RequirePackage{fontspec}
    \RequirePackage{xltxtra}
    \defaultfontfeatures{Ligatures=TeX}
\else
    \ifpdf
        \RequirePackage[pdftex]{geometry}
        \RequirePackage[pdftex]{graphicx}
        \RequirePackage[pdftex,bookmarks=false,hidelinks]{hyperref}
    \else
        \RequirePackage[dvips]{geometry}
        \RequirePackage[dvips]{graphicx}
        \RequirePackage[hypertex,bookmarks=false,hidelinks]{hyperref}
        \fi
    \RequirePackage[utf8]{inputenc}
\fi
\RequirePackage{lettrine}
\RequirePackage[numbers,sort&compress]{natbib}
\RequirePackage[nottoc]{tocbibind}
\RequirePackage[noindentafter]{titlesec}
\RequirePackage{titletoc}
\RequirePackage[usenames,dvipsnames,svgnames,table,xcdraw]{xcolor}
\RequirePackage{tikz}

%% If the document is not compiled with XeLaTeX, we need to use the native
%% fonts.
\ifxetex\else
    \@nativefontstrue
\fi

\if@nativefonts
    \RequirePackage[T1]{fontenc}
    \RequirePackage[utf8]{inputenc}
    \RequirePackage{libertine}
    \RequirePackage[libertine]{newtxmath}
    \RequirePackage[scaled=0.95]{inconsolata}

    \def\titlefont{\rmfamily}
    \def\titleshape{}
    \def\titlestyle{\titlefont\titleshape\bfseries}
    \def\headerstyle{\titlefont\titleshape}
\else
    %% Use Libertinus fonts for XeLaTeX compilation
    \RequirePackage{unicode-math}

    \setmainfont[Path = fonts/libertinus/, ItalicFont=libertinusserif-italic.otf, BoldFont=libertinusserif-bold.otf, BoldItalicFont=libertinusserif-bolditalic.otf]{libertinusserif-regular.otf}
    \setsansfont[Path = fonts/libertinus/, BoldFont=libertinussans-bold.otf, ItalicFont=libertinussans-italic.otf]{libertinussans-regular.otf}
    \setmathfont[Path = fonts/libertinus/]{libertinusmath-regular.otf}
    \setmonofont[Scale=MatchLowercase, Path=fonts/inconsolata/]{Inconsolata-Regular.ttf}
    \def\titlefont{\rmfamily}
    \def\titleshape{}
    \def\titlestyle{\titlefont\titleshape}
    \def\headerstyle{\titlestyle}
\fi

\RequirePackage[noabbrev]{cleveref}
\Crefname{enumi}{Step}{Steps}
\crefname{enumi}{step}{steps}

\RequirePackage{array}
\RequirePackage{pifont}
\RequirePackage{textcomp}

\RequirePackage{microtype}
\RequirePackage{multirow}

\definecolor{light-gray}{gray}{0.95}

\RequirePackage{listings}

\lstset{
  backgroundcolor=\color{light-gray},
  language=C,
  numbers=left,
  numbersep=5pt,
  showspaces=false,
  stepnumber=1,
  numberstyle=\tiny,
  breaklines=true,
  breakatwhitespace=true,
  breakindent=2ex,
  escapechar=*,
  basicstyle=\scriptsize\ttfamily
}

% Setup of cref/lstlisting
\renewcommand{\lstlistingname}{Example}
\crefname{lstlisting}{Example}{Examples}

\usepackage{subcaption}
\RequirePackage{float}
\RequirePackage[section]{placeins}
\DeclareGraphicsExtensions{.pdf,.jpeg,.png,.eps}


\RequirePackage{enumitem}
\RequirePackage{booktabs}
\RequirePackage{multicol}

\RequirePackage[nomain,acronym,nonumberlist,style=list]{glossaries} % nomain, if you define glossaries in a file, and you use \include{INP-00-glossary}

%% Stop importing packages


% Advanced Hyphenation
\clubpenalty=1000
\widowpenalty=1000

%% Define colors for document structure
\definecolor{chapter-blue}{cmyk}{1,0.5,0,0.2}
\definecolor{section-blue1}{cmyk}{0.8,0.4,0,0}
\definecolor{drocap-color}{cmyk}{0.8,0.4,0,0}
\definecolor{mark-color}{cmyk}{0.6,0.3,0,0}
\definecolor{atlarge-black}{cmyk}{0,0,0,1}
\definecolor{atlarge-white}{cmyk}{0,0,0,0}

%% Use Atlarge blue as the color for titles, unless the 'print' option is
%% specified, in which case we use anthracite, a dark gray, which is also used
%% for the thumb indices.
\definecolor{anthracite}{cmyk}{0,0,0,1}
\if@print
    \colorlet{title}{chapter-blue}
\else
    \colorlet{title}{chapter-blue}
\fi
\colorlet{thumb}{anthracite}

\geometry{
  a4paper,
  top=25mm,
  bottom=25mm,
  left=30mm,
  right=25mm,
  bindingoffset=0mm
}

%% Redefine the title command to accept an optional subtitle.
\renewcommand*\title[2][]{%
    \def\@subtitle{#1}%
    \def\@title{#2}%
    %% Add the title to the PDF meta data.
    \hypersetup{pdftitle=#2}%
}
%% Redefine the author command to accept a first and last name, and to add the
%% full name to the PDF meta data.
\renewcommand*\author[2]{%
    \def\@firstname{#1}%
    \def\@lastname{#2}%
    \hypersetup{pdfauthor=#1\ #2}%
}

%% Remove the header and page number on empty pages.
\def\cleardoublepage{%
    \clearpage%
    \if@twoside%
        \ifodd\c@page%
        \else%
            \thispagestyle{empty}%
            \vspace*{\fill}%
            \newpage%
        \fi%
    \fi%
}
\renewcommand{\cleardoublepage}{\clearpage}
\if@print%
    \newcommand*\cropmarks{%
        \ifodd\c@page%
            \begin{tikzpicture}[remember picture,overlay]
                \draw ($(current page.north east)+(0mm,-3mm)$) -- ($(current page.north east)+(-2mm,-3mm)$);
                \draw ($(current page.north east)+(-3mm,0mm)$) -- ($(current page.north east)+(-3mm,-2mm)$);
                \draw ($(current page.south east)+(0mm,3mm)$) -- ($(current page.south east)+(-2mm,3mm)$);
                \draw ($(current page.south east)+(-3mm,0mm)$) -- ($(current page.south east)+(-3mm,2mm)$);
            \end{tikzpicture}%
        \else%
            \begin{tikzpicture}[remember picture,overlay]
                \draw ($(current page.north west)+(0mm,-3mm)$) -- ($(current page.north west)+(2mm,-3mm)$);
                \draw ($(current page.north west)+(3mm,0mm)$) -- ($(current page.north west)+(3mm,-2mm)$);
                \draw ($(current page.south west)+(0mm,3mm)$) -- ($(current page.south west)+(2mm,3mm)$);
                \draw ($(current page.south west)+(3mm,0mm)$) -- ($(current page.south west)+(3mm,2mm)$);
            \end{tikzpicture}%
        \fi%
    }
\else
    \newcommand*\cropmarks{}
\fi%

%%% Thumb indices consist of white text on a rectangular colored background. The
%%% font-size is 75% of the size of thumb height.
\newif\ifthumb
\newlength\thumbheight
\setlength\thumbheight{24pt}
\newlength\thumbedge
\setlength\thumbedge{4pt}
\newlength\thumbhspace
\setlength\thumbhspace{36pt}
\newlength\thumbvspace
\setlength\thumbvspace{2\thumbheight}

\newlength\thumbwidth
\setlength\thumbwidth{36pt}
\newlength\thumbspacing
\setlength\thumbspacing{2\thumbheight}

%% We need the TikZ library calc to calculate the coordinates of the thumb
%% indices.
\usetikzlibrary{calc}

%% The lthumb command prints the current chapter number in a thumb index on the
%% left (even) page.
\newcommand*\lthumb{%
    \ifthumb%
        \begin{tikzpicture}[remember picture,overlay]
            \coordinate (top margin) at (0pt,1in+\topmargin+\headheight+\headsep);
            \coordinate (left margin) at (1.1in+\evensidemargin,0pt);
            %% Calculate the corners of the thumb index based on the current
            %% chapter number.
            \coordinate (top left) at ($(current page.north west)-(top margin)-(0pt,\value{chapter}\thumbvspace-\thumbvspace)$);
            \coordinate (bottom right) at ($(top left)+(left margin)-(\thumbhspace,\thumbheight)$);
            %% Shift the left edge to prevent the rounded corner from showing.
            \coordinate (top left) at ($(top left)-(\thumbedge,0pt)$);
            %% Draw the thumb index.
            \fill[fill=mark-color,rounded corners=\thumbedge](top left) rectangle (bottom right);
            %% Print the chapter number at the center right in the thumb index.
            \coordinate (center right) at ($(bottom right)+(0pt,0.5\thumbheight)$);
            \node at (center right)[anchor=east,inner sep=2\thumbedge]{
                \titlefont\bfseries\color{atlarge-white}
                \fontsize{0.75\thumbheight}{0.75\thumbheight}\selectfont
                \thechapter
            };
        \end{tikzpicture}%
    \fi%
}

%% rthumb draws a thumb index on the right (odd) page.
\newcommand*\rthumb{%
    \ifthumb%
        \begin{tikzpicture}[remember picture,overlay]
            \coordinate (top margin) at (0pt,1in+\topmargin+\headheight+\headsep);
            \coordinate (right margin) at (1.1in+\evensidemargin,0pt);
            %% Calculate the corners of the thumb index based on the current
            %% chapter number.
            \coordinate (top right) at ($(current page.north east)-(top margin)-(0pt,\value{chapter}\thumbvspace-\thumbvspace)$);
            \coordinate (bottom left) at ($(top right)-(right margin)-(-\thumbhspace,\thumbheight)$);
            %% Shift the left right to prevent the rounded corner from showing.
            \coordinate (top right) at ($(top right)+(\thumbedge,0pt)$);
            %% Draw the thumb index.
            \fill[fill=mark-color,rounded corners=\thumbedge](top right) rectangle (bottom left);
            %% Print the chapter number at the center right in the thumb index.
            \coordinate (center left) at ($(bottom left)+(0pt,0.5\thumbheight)$);
            \node at (center left)[anchor=west,inner sep=2\thumbedge]{
                \titlefont\bfseries\color{atlarge-white}
                \fontsize{0.75\thumbheight}{0.75\thumbheight}\selectfont
                \thechapter
            };
        \end{tikzpicture}%
    \fi%
}

%% Page style for empty pages.
\fancypagestyle{empty}{%
    \fancyhf{}
    \renewcommand*\headrulewidth{0pt}
    \renewcommand*\footrulewidth{0pt}
    \fancyhead{\cropmarks}
}

%% Page style for title pages.
\fancypagestyle{plain}{%
    \fancyhf{}
    \renewcommand*\footrulewidth{0pt}
    \fancyhead{\cropmarks}
    \fancyhead[LE]{\cropmarks\lthumb\titlefont\color{chapter-blue}\thepage}
    \fancyhead[RO]{\cropmarks\rthumb\titlefont\color{chapter-blue}\thepage}
}

%% Fancy style for the main matter.
\fancypagestyle{mainmatter}{%
    \fancyhf{}
    %% Page numbers on the top left and top right.
    \fancyhead[LE]{\cropmarks\lthumb\fontsize{8.5pt}{8.5pt}\titlefont\color{chapter-blue}\thepage}
    \fancyhead[RO]{\cropmarks\rthumb\fontsize{8.5pt}{8.5pt}\titlefont\color{chapter-blue}\thepage}
    %% Chapter name on the left (even) page.
    \fancyhead[RE]{\fontsize{8.5pt}{8.5pt}\titlefont\titleshape\color{chapter-blue}\nouppercase{\leftmark}}
    %% Section name on the right (odd) page.
    \fancyhead[LO]{\fontsize{8.5pt}{8.5pt}\titlefont\titleshape\color{chapter-blue}\nouppercase{\rightmark}}
}

%% The mainmatter style is default for normal pages.
\pagestyle{mainmatter}

%% Print the current chapter and section at the top of the page in cyan.
\renewcommand*\chaptermark[1]{\markboth{\color{chapter-blue}\thechapter\ #1}{}}
\renewcommand*\sectionmark[1]{\markright{\color{chapter-blue}\thesection\ #1}}

%% The setheader command can be used to print the title of unnumbered chapters
%% in the page header.
\newcommand*\setheader[1]{\markboth{\color{chapter-blue}#1}{\color{chapter-blue}#1}}

\setlength{\headheight}{14pt}
\addtolength{\topmargin}{-2pt}
%% Change the headrule command (from fancyhdr.sty) to draw the line below the
%% header in the title color.
\renewcommand*\headrule{%
    \if@fancyplain%
        \let\headrulewidth\plainheadrulewidth%
    \fi%
    {\color{chapter-blue}\hrule\@height\headrulewidth\@width\headwidth}%
    \vskip-\headrulewidth%
}

%% Draw the line above a footnote in the title color as well.
\renewcommand*\footnoterule{%
    \vspace*{-3pt}%
    {\color{chapter-blue}\hrule width 0.5\textwidth height 0.4pt}%
    \vspace*{2.6pt}%
}

%% A part title starts with a huge (96pt) bold black number, flushed to the
%% right, followed by the part name on the next line in the title color.
\titleformat{\part}[display]
    {\flushright\titlestyle}
    {\fontsize{96pt}{96pt}\selectfont\bfseries\thepart}
    {0pt}
    {\Huge\color{title}}
%% Separate the title from the text by two empty lines.
\titlespacing{\part}{0pt}{0pt}{2\baselineskip}
%% In the table of contents, the part name is preceded by an empty line, printed
%% in bold, and not followed by a line of dots.
\dottedcontents{part}[0em]{\vspace{\baselineskip}\titlefont\bfseries}{1.5em}{0pc}

%% Chapter titles have the same layout as parts.
\titleformat{\chapter}[display]
    {\flushright\titlestyle}
    {\color{chapter-blue}\fontsize{35pt}{35pt}\selectfont\bfseries\thechapter}
    {0pt}
    {\huge\color{title}}
\titlespacing{\chapter}{0pt}{0pt}{\baselineskip}
%% In the table of contents, a chapter is similar to a part, except that it is
%% preceded by half an empty line.
\dottedcontents{chapter}[1.5em]{\color{chapter-blue}\vspace{0.5\baselineskip}\titlefont\bfseries}{1.5em}{0pc}

%% Section titles start with the number in bold, followed by the name printed
%% in the title color.
\titleformat{\section}
    {\Large\bfseries\headerstyle}
    {\color{section-blue1}\thesection\ }
    {0pt}
    {\color{section-blue1}}
%% Sections are preceded by an empty line.
\titlespacing{\section}{0pt}{\baselineskip}{0pt}
%% In the table of contents, section names are followed by a line of dots 8pt
%% apart.
\dottedcontents{section}[3.8em]{\titlefont}{2.3em}{8pt}

%% Subsection titles have the same layout as section titles, except in a smaller
%% font.
\titleformat{\subsection}
    {\large\bfseries\headerstyle}
    {\color{section-blue1}\thesubsection\ }
    {0pt}
    {\color{section-blue1}}
\titlespacing{\subsection}{0pt}{\baselineskip}{0pt}
\dottedcontents{subsection}[7em]{\titlefont}{3.2em}{8pt}

%% Subsubsections have the same font and color as sections and subsections, but
%% are not preceded by a number.
\titleformat{\subsubsection}
    {\bfseries\headerstyle}
    {}
    {0pt}
    {\color{black}}
%% Subsubsections are preceded by an empty line and do not appear in the table
%% of contents.
\titlespacing{\subsubsection}{0pt}{\bigskipamount}{0pt}

%% Color the bullets of the itemize environment and make the symbol of the third
%% level a diamond instead of an asterisk.
\renewcommand*\labelitemi{\color{black}\textbullet}
\renewcommand*\labelitemii{\color{black}--}
\renewcommand*\labelitemiii{\color{black}$\diamond$}
\renewcommand*\labelitemiv{\color{black}\textperiodcentered}

%% The dedication is vertically centered on a separate page and flushed to the
%% right.
\newcommand\dedication[1]{%
    \thispagestyle{empty}%
    \vspace*{\fill}%
    \begin{flushright}%
        #1%
    \end{flushright}%
    \vspace*{\fill}%
    \cleardoublepage%
}

%% Define an unnumbered footnote command.
\def\blfootnote{\xdef\@thefnmark{}\@footnotetext}

%% The authors environment is used to display the authors of a chapter on the
%% title page. This is only necessary if multiple people contributed
%% significantly to the chapter.
\newcommand*\authors[1]{%
    \begin{center}%
        {\Large\bfseries #1}%
    \end{center}%
    \vspace{2\baselineskip}%
}

%% The epigraph environment can be used to to add a quote to the title page of
%% a chapter.
\newcommand\epigraph[3][2\baselineskip]{%
    \begin{flushright}%
        {\rmfamily\itshape #2}%
        \vskip 0.5\baselineskip%
        #3%
    \end{flushright}%
    \vspace{#1}%
}

%% The abstract environment is used for the abstract of a chapter.
\newenvironment{abstract}{%
    \list{}{\leftmargin\rightmargin}%
    \item%
    \relax%
    \rmfamily\itshape%
}{%
    \endlist%
}

%% Define a drop command which can be used to generate drop caps at the
%% beginning of a section.
\renewcommand*\LettrineTextFont{\titleshape}
\newcommand*\dropcap[1]{%
    \lettrine[lines=2,findent=0.2em,nindent=0pt]{\color{drocap-color}#1}{}%
}

%% Hyperlinks are cyan, except in print mode, when they are all black.
\hypersetup{
    colorlinks = false
}