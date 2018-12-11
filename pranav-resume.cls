%-------------------------------------------------------------------------------
%                Identification
%-------------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{pranav-resume}
\LoadClass{article}

%-------------------------------------------------------------------------------
%                3rd party packages
%-------------------------------------------------------------------------------

% To calculate lengths, for example the skip after the header
\RequirePackage{calc}

% Use options in key value format for package options
\RequirePackage{kvoptions-patch}

% Flexible macros for defining and setting keys
\RequirePackage{xkeyval}

% Draw things (needed for the header). Load before color package!
\RequirePackage{tikz}

% Enable the use of colours
\RequirePackage{color}

% Needed to run XeLaTeX
\RequirePackage{fontspec}

% Important to add, else fontawesome will not work with XeLaTeX
\defaultfontfeatures{
  Path = fonts/
}
% Load cool icons, such as the linked in logo
\RequirePackage{fontawesome}

% To alter the style and spacing of titles
\RequirePackage{titlesec}

% To change \parindent and it adjusts the skips between list items.
\RequirePackage{parskip}

\RequirePackage{hyperref}

\RequirePackage{xpatch}

% Needed to make fixed length table
\RequirePackage{array}

% Needed to use \ifxetex-\else-\fi statement
\RequirePackage{ifxetex}

% Needed to use \if-\then-\else statement
\RequirePackage{xifthen}

% Needed to handle text alignment
\RequirePackage{ragged2e}

% Needed to handle list environment
\RequirePackage{enumitem}


%-------------------------------------------------------------------------------
%                Commands for utilities
%-------------------------------------------------------------------------------
% Use to align an element of tabular table
\newcolumntype{L}[1]{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{C}[1]{>{\centering\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{R}[1]{>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}

% Use to draw horizontal line with specific tickness
\def\vhrulefill#1{\leavevmode\leaders\hrule\@height#1\hfill \kern\z@}

% Use to execute conditional statements by checking empty string
\newcommand*{\ifempty}[3]{\ifthenelse{\isempty{#1}}{#2}{#3}}

% Defines writer's quote (optional)
% Usage: \quote{<quote>}
\renewcommand*{\quote}[1]{\def\@quote{#1}}


% ---------------------------------------------------------------------------- %
%                                 Config for layout                            %
% ---------------------------------------------------------------------------- %
% Size of the margin
\newlength{\margin}
\setlength{\margin}{20mm}

% Size of the left column
\newlength{\leftcol}
\setlength{\leftcol}{19 mm}

% Height of the header
\newlength{\hdrheight}
\setlength{\hdrheight}{40mm}

% Vertical space between rows/paragraphs
\newlength{\vspacepar}
\setlength{\vspacepar}{0.5\baselineskip}

% Horizontal space before and after vertical bar (|) between address and
% the contact details
\newlength{\hspaddress}
\setlength{\hspaddress}{1em}

% Horizontal space after font awesome icons
\newcommand{\FAspace}{\hspace{0.5 em}}

% Left indentation (before the bullet) of an itemized list
\setlength{\leftmargini}{2em}

% # REQUIRED PACKAGES
% Adjust the margins of a page
\RequirePackage[margin = \margin, top = \hdrheight]{geometry}

% ---------------------------------------------------------------------------- %
%                              CALCULATED LENGTHS                              %
% ---------------------------------------------------------------------------- %
% Width of the right column
\newlength{\rightcol}
\setlength{\rightcol}{\textwidth-\leftcol}

% ---------------------------------------------------------------------------- %
%                              CLASS OPTION                                    %
% ---------------------------------------------------------------------------- %

% Add option to change the color of the header and titles
% \define@key[<prefix>]{<family>}{<key>}[<default>]{<function>}
\define@key{pranav-resume.cls}{changecolor}[0, 0, 0]{%
    \definecolor{main}{RGB}{#1}%
}

% Process changecolor to define main color, else colorharmony and titlecolor
% will not work correctly.
\ExecuteOptionsX{changecolor}
\ProcessOptionsX%

% ---------------------------------------------------------------------------- %
%                                     fonts                                    %
% ---------------------------------------------------------------------------- %

\setmainfont{SourceSansPro}[
  Path = fonts/,
  Extension = .otf ,
  UprightFont = *-Light,
  ItalicFont = *-LightIt,
  BoldFont = *-Semibold,
]

\newfontfamily\titlefont{AdventPro}[
  Path = fonts/,
  Extension = .ttf,
  UprightFont = *-ExtraLight,
  BoldFont = *-SemiBold,
]

%-------------------------------------------------------------------------------
%                Configuration for colors
%-------------------------------------------------------------------------------
% Colors
\definecolor{gold}{RGB}{179, 163, 105}
\definecolor{gray}{HTML}{505050}
\definecolor{navy}{HTML}{002B45}


% ---------------------------------------------------------------------------- %
%                                   HEADER                                     %
% ---------------------------------------------------------------------------- %

% Separator with a horizontal space before and after. Is used in the header as
% a separator between address and contact details
\newcommand{\sep}{\hspace{\hspaddress} | \hspace{\hspaddress}}

% This places a header on top of the page.
% #1 First name
% #2 Last name
% #3 = Occupation
% #4 = Address
% #5 = Phone, mail and LinkedIn
\newcommand{\header}[5]{%
  \begin{tikzpicture}[remember picture, overlay]
    % Colored bar on top of the page
    \node[
        below right,
        fill=main,
        minimum height=\hdrheight,
        minimum width=\paperwidth,
        outer sep=0,
      ] (name) at (current page.north west) {};
    % Node for the name
    \node[
        anchor=center,
        text=white,
        inner sep=0.20 cm,
      ] (nametext) at ([yshift=8mm]name.base) {%
        \fontsize{35pt}{30pt}\color{white}
        {\titlefont #1~}{\titlefont {#2}\par}
        };
    % Occupation
    \node[
        anchor=north,
        text=white,
      ] (occupation) at (nametext.south)
        {\fontsize{11pt}{1em}\color{white} #3\par};
    % Address
    \node[
        anchor=north,
        text=white,
      ] (address) at (occupation.south)
        {\fontsize{11pt}{1em}\color{white} #4\par};
    % Phone/mail/nationality
    \node[
        anchor=north,
        text=white,
      ] at (address.south)
        {\fontsize{11pt}{1em}\color{white} #5\par\linebreak};
  \end{tikzpicture}
}


% ---------------------------------------------------------------------------- %
%                                  TITLE FORMAT                                %
% ---------------------------------------------------------------------------- %

% Change format of the section title
\titleformat{\section}%
  {\titlefont\color{title}\huge\bfseries}{\thesection}{0em}{}
% \titlespacing{command}{left spacing}{before spacing}{after spacing}[right]
\titlespacing*{\section}%
  {0pt}{1ex plus 0.2ex minus 0.2ex}{-1ex plus 0.1ex minus 0.1ex}

% Defines a new command which can be used as a formatter for your Job title and
% location.
% example: \worktitle{Study name/Job title}{Location}.
% #1 = Job or education title
% #2 = Company and location
\newcommand{\worktitle}[2]{
  {\bfseries\MakeUppercase{#1}}
  {\itshape #2}
}

% ---------------------------------------------------------------------------- %
%                               ENVIRONMENTS                                   %
% ---------------------------------------------------------------------------- %

% # REQUIRED PACKAGES
% Increase spacing after text, between rows
\usepackage{cellspace}
\setlength{\cellspacebottomlimit}{\vspacepar}

% New environment with two columns, a narrow one on the left for the dates and
% a right one for what was done during that period.
\newenvironment{tabularcv}{%
  \par\noindent
  \begin{tabular}{
      @{}>{\raggedright\arraybackslash}S{p{\leftcol}}
      @{}>{\raggedright\arraybackslash}S{p{\rightcol}}
      @{}
    }
  }
  {\end{tabular}}

% ---------------------------------------------------------------------------- %
%                              BODY TEXT OPTIONS                               %
% ---------------------------------------------------------------------------- %

% Remove indent at the start of a new paragraph
\setlength{\parindent}{0pt}

\hypersetup{colorlinks=true, urlcolor=second}
% Places a link to a website with a fontawesome logo
\newcommand{\link}[1]{\href{#1}{\faExternalLink}}

\newcommand*{\sectionstyle}[1]{{\fontsize{14pt}{1em}\color{gold} \titlefont\textbf{#1}}}

% For elements of entry
\newcommand*{\entrytitlestyle}[1]{{\fontsize{13pt}{1em}\color{navy} \titlefont\textbf{#1}}}
\newcommand*{\entrypositionstyle}[1]{{\fontsize{11pt}{1em}\color{gray} \titlefont #1}}
\newcommand*{\entrydatestyle}[1]{{\fontsize{9pt}{1em}\color{gray} \textit{#1}}}
\newcommand*{\entrylocationstyle}[1]{{\fontsize{9pt}{1em}\color{gray} \textit{#1}}}
\newcommand*{\descriptionstyle}[1]{{\fontsize{8pt}{1em}\color{gray} #1}}

% For elements of skill
\newcommand*{\skilltypestyle}[1]{{\fontsize{10pt}{1em}\color{navy} \titlefont\textbf{#1}}}
\newcommand*{\skillsetstyle}[1]{{\fontsize{8pt}{1em}\color{gray} #1}}

% Define a section for CV
% Usage: \cvsection{<section-title>}
\newcommand{\cvsection}[1]{
  \par\addvspace{0ex}
  \phantomsection{}
  \sectionstyle{#1}
  \color{black}\vhrulefill{0.5pt}
  \par\nobreak\addvspace{0.5pt}
  \vspace{1mm}
}

% Define an environment for cventry
\newenvironment{cventries}{
  \begin{center}
}{
  \end{center}
}
% Define an entry of cv information
% Usage: \cventry{<position>}{<title>}{<location>}{<date>}{<description>}
\newcommand*{\cventry}[5]{
  \setlength\tabcolsep{0pt}
  \setlength{\extrarowheight}{0pt}
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} L{12.5cm} R{4.5cm}}
    \ifempty{#2#3}
      {\entrypositionstyle{#1} & \entrydatestyle{#4} \\}
      {\entrytitlestyle{#2} & \entrylocationstyle{#3} \\
      \entrypositionstyle{#1} & \entrydatestyle{#4} \\}
    \multicolumn{2}{L{17cm}}{\descriptionstyle{#5}} \\
  \end{tabular*}
}

% Define an environment for cvskill
\newenvironment{cvskills}{
  \begin{center}
    \setlength\tabcolsep{1ex}
    \setlength{\extrarowheight}{0pt}
    \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} L{2cm} L{25.0cm}}
}{
    \end{tabular*}
  \end{center}
}
% Define a line of cv information(skill)
% Usage: \cvskill{<type>}{<skillset>}
\newcommand*{\cvskill}[2]{
	\skilltypestyle{#1} & \skillsetstyle{#2}
  \\
}

% Define an environment for cvitems(for cventry)
\newenvironment{cvitems}{
  \vspace{-4mm}
  \begin{justify}
  \begin{itemize}[leftmargin=2ex, nosep, noitemsep]
    \setlength{\parskip}{0pt}
}{
  \end{itemize}
  \end{justify}
  \vspace{-2mm}
}

% ---------------------------------------------------------------------------- %
%                        		      PATCH           	                       %
% ---------------------------------------------------------------------------- %

% Patch to prevent package color and cellspace to clash
% More info: https://tex.stackexchange.com/questions/384664/xcolor-package-disables-cellspace-package
\makeatletter
\xpatchcmd{\@endpbox}{\color@endgroup}{\expandafter\color@endgroup}{}{\ddt}
\makeatother
