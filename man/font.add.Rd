% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/font.R
\name{font.add}
\alias{font.add}
\title{Add New Font Families to 'sysfonts'}
\usage{
font.add(family, regular, bold = NULL, italic = NULL, bolditalic = NULL,
  symbol = NULL)
}
\arguments{
\item{family}{a character string of maximum 200-byte size,
indicating the family name of the font.
See "Details" for further explanation.}

\item{regular}{path of the font file for "regular" font face.
This argument must be specified as a character string
and cannot be missing.}

\item{bold}{path of the font file for "bold" font face.
If it is \code{NULL}, the function will use the value of
argument \code{regular}.}

\item{italic, bolditalic, symbol}{ditto}
}
\value{
A character vector (invisible) of currently available
        font family names.
}
\description{
This function registers new font families that can be used by package
\pkg{showtext} and the SWF device in package \pkg{R2SWF}.
Currently supported formats include but not limited to
TrueType fonts(*.ttf, *.ttc) and OpenType fonts(*.otf).
}
\details{
In R graphics device, there are two parameters combined together
to select a font to show text. \code{par("family")} is a character
string giving a name to a \strong{series} of font faces. Here
\strong{series} implies that there may be different fonts with the
same family name, and actually they are distinguished by the parameter
\code{par("font")}, indicating whether it is regular, bold, or italic,
etc. In R, \code{par("font")} is an integer from 1 to 5 representing
regular, bold, italic, bold italic, and symbol, respectively.

In \pkg{sysfonts} package, there are three default font families, sans, serif, and mono,
each with five font faces as mentioned above. If one wants
to use other font families, the function \code{font.add()} needs to be called
to register new fonts. Note that the \code{family} argument in this function can be
an arbitrary string that does not need to be the real font name. The specified
family name will be used in functions like \code{par(family = "myfont")}
and \code{text("Some text", family = "myfont")}. The \strong{Examples} section
shows a complete demonstration of the usage.

To find the font file of argument \code{regular} (and the same for
other font faces), this function will first check the existence
of the specified path. If not found, file will be searched in the
directories returned by \code{\link{font.paths}()} in turn. If the
file cannot be found in any of the locations,
an error will be issued.
}
\examples{
\dontrun{
## Example: download the font file of WenQuanYi Micro Hei,
##          add it to SWF device, and use it to draw text in swf().
##          WenQuanYi Micro Hei is an open source and high quality
##          Chinese (and CJKV) font.

wd = setwd(tempdir())
ft.url = "http://sourceforge.net/projects/wqy/files/wqy-microhei"
ft.url = paste(ft.url, "0.2.0-beta/wqy-microhei-0.2.0-beta.tar.gz",
               sep = "/")
download.file(ft.url, basename(ft.url))

## Extract and add the directory to search path
untar(basename(ft.url), compressed = "gzip")
font.paths("wqy-microhei")

## Register this font file and assign the family name "wqy"
## Other font faces will be the same with regular by default
font.add("wqy", regular = "wqy-microhei.ttc")

## A more concise way to add font is to give the path directly,
## without calling font.paths()
# font.add("wqy", "wqy-microhei/wqy-microhei.ttc")

## List available font families
font.families()

if(require(R2SWF))
{
    ## Now it shows that we can use the family "wqy" in swf()
    swf("testfont.swf")

    ## Select font family globally
    op = par(family = "serif", font.lab = 2)
    ## Inline selecting font
    plot(1, type = "n")
    text(1, 1, intToUtf8(c(20013, 25991)), family = "wqy", font = 1, cex = 2)

    dev.off()
    swf2html("testfont.swf")
}

setwd(wd)

}
}
\seealso{
See \code{\link[graphics]{par}()} for explanation of
         the parameters \code{family} and \code{font}.
}
\author{
Yixuan Qiu <\url{http://statr.me/}>
}
