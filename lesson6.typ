////////////////////////
// Import 
////////////////////////
#import "macros.typ": *
#import "lemmify.typ": *

////////////////////////
// Show rules
////////////////////////
#show: thm-rules
#show: ex-rules
#show: exs-rules
#show: ta-rules

// Box around exercises
#show thm-selector("exercise-group", subgroup: "exercise"): it => box(
  it,
  stroke: black + 1pt,
  inset: 0.8em
)

// Box around take-aways
#show thm-selector("takeaway-group", subgroup: "takeaway"): it => box(
  it,
  stroke: black + 1pt,
  inset: 0.8em
)

// Reset exercises counter
#show: tail => thm-reset-counter-heading-at("exercise-group", 1, tail)
////////////////////////

= Theory recap 17.10.24 - Continuous random variables

== PDF and cumulative distribution

*Notation* Consider a probability space $probspace$, a function $var from points to #R$, and two points $lval < hval in #Rinf$, with $Rinf = #R union {-infinity, +infinity}$. We use the following notation:
$
intev 
:= { & point in points: var(point) <= hval } sect { point in points: var(point) > lval }  \
equiv { & point in points: var(point) <= hval } without { point in points: var(point) <= lval }.
$<eq:interval-event>
Note that $intev$ is a subset of $jet$, and recall that a subset of $jet$ is an _event_ if it belongs to $events$.

#definition(name: "Continuous random variable")[Given a probability space $probspace$, a _continuous random variable_ $var$ is a function $var from points to #R$ such that $intev$ is an event for all $lval < hval in Rinf$.
]

#definition(name: "Probability density function")[The _probability density function (PDF)_ of a continuous random variable $var from jet to rvals$ is the function $pdf_(var) from rvals to #R _(>=0)  $ such that, for all $lval < hval in Rinf$,
$
prob intev = integral_(lval)^(hval) pdf_(var)(x) dx.
$
]

- $integral_(#R) pdf(x) dx = 1$ for any PDF
- $probof(var = val) = 0$ for all $val in R$

#definition(name: "Cumulative distribution function")[ The _cumulative distribution function (CDF)_ of a continuous random variable $var from points to rvals$ is the function $cum_(var) from rvals to clint$ defined by
$
cum_(var)(val) = probof(var <= val).
$
]
#proposition[The probability density function $pdf_(var)$ of a continuous random variable $var from points to rvals$ can be determined from the cumulative distribution function $cum_(var)$ by differentiating:
$
pdf_(var) = cum'_(var)
$
as long as the derivative exists.
]
#proof[By @eq:interval-event, $sigma$-additivity, and the fundamental theorem of integral calculus,

$
prob intev 
& = probof(var <= hval) -  probof(var <= lval) \
& = cum_(var)(hval) - cum_(var)(lval) \
& = integral_(lval)^(hval) cum'_(var) (x) dx.
$

]

== Density of sum of probability distributions: convolution
#takeaway[This section is just a sketch; see e.g. @billingsleyProbabilityMeasure2012 pag. 266 and #link("https://en.wikipedia.org/wiki/Convolution_of_probability_distributions")[this Wikipedia page] plus the references therein for further details.]

#definition[Two continuous random variables $xvar, yvar$ are _independent_ if the density of $(xvar, yvar)$ is the product of the densities of $xvar$ and $yvar$:
$
pdf_((xvar, yvar))(xval, yval) = pdf_(xvar)(xval) pdf_(yvar)(yval).
$]
For the following c.f. Prop. 3.3.6. in @jourdainProbabilitesStatistiquePour2018.
#proposition(name: "Marginal density")[Let $xvar$ and $yvar$ be continuous random variables. If the density $pdf_((xvar, yvar))$ of $(xvar, yvar)$ is known then one can obtain the densities of $xvar$ and $yvar$ by 
$
pdf_(xvar)(xval) = integral_(rvals) pdf_(xvar, yvar)(xval, yval) dy
$
and similarly for $pdf_(yvar)$.]
Let $xvar from points to xvals$, $yvar from points to yvals$ be _discrete independent_ random variables, and let $Z = xvar + yvar$. Recall by @ex:sum-binomial that the law of $Z$ is given by 
$
z mapsto & probof(xvar + yvar = z) \
& = sum_(xval in xvals \ yval in yvals \ xval + yval = z) probof(xev) probof(yev) \
& = sum_(xval in xvals) probof(xev) probof(yvar = z - xval)
$
This generalizes to continuous random variables as follows:
#definition(name: "Convolution")[Let $xvar from points to rvals$ and $yvar from points to rvals$ be continuous random variables with densities $pdf_(xvar), pdf_(yvar)$ respectively. The _convolution_  of $pdf_(xvar)$ and $pdf_(yvar)$ is the function $pdf_(xvar) conv pdf_(yvar) $ defined by 
$
pdf_(xvar) conv pdf_(yvar)(z) := integral_(rvals) pdf_(xvar)(xval) pdf_(yvar)(z - xval) dx
$
]
#proposition[If $xvar from points to rvals$ and $yvar from points to rvals$ are *independent* continuous random variables then the PDF of their sum is the convolution of their PDFs:
$
pdf_(xvar + yvar) = pdf_(xvar) conv pdf_(yvar).
$
]
#proof(name: "Proof sketch.")[
In the spirit of the marginal density law, 
$
pdf_(xvar + yvar)(z) = integral_(#R) pdf_((xvar,yvar))(xval, z - xval) dx.
$
By independence,
$
pdf_(xvar + yvar)(z) = integral_(#R) pdf_(xvar)(xval) pdf_(yvar)(z-xval) dx = pdf_(xvar) conv pdf_(yvar)(z).
$

]

== Standard PDFs

=== Uniform PDF
Given a continuous RV $var from points to rvals$ we write $var follow unipdf(lval, hval)$ and say that $var$ has _uniform_ density if

$
pdf_(var)(x) = (ind_([lval, hval])(x)) / (hval - lval)
$

=== Exponential PDF
Given a continuous RV $var from points to rvals$ we write $var follow expdf(rate)$ and say that $var$ has _exponential_ density if
$
pdf_(var) = cases(

  0  & "if" val <= 0,
  rate e^(-rate val) & "if" val > 0
)
 = rate e ^(-rate val) ind_{val > 0}

$
#figure(
  image("figs/pdf_exp.png", width: 80%),
  caption: [
  Exponential pdf. $probof(0.5 < var < 1) = integral_(0.5)^(1)pdf_(var)(x) dx$ is the area below the red curve delimited by the blue lines.
  ],
)



////////////////////////////////////////////////////////////////////////

#pagebreak()
#exercises[]
#exercise(name: "An electronic component has a lifetime...")[Exercice corrigé 2.6.4. in @jourdainProbabilitesStatistiquePour2018.]<ex:electrical-component>
#figure(
  image("figs/ex264.png", width: 90%),
)
#figure(
  image("figs/sol264_1.png", width: 70%),
)
#figure(
  image("figs/sol264_2.png", width: 70%),
)
#exercise(name: "Min of exponential variables")[Let $xvar follow expdf(lambda)$ and $yvar follow expdf(mu)$. Find the CDF and the PDF of $min(xvar, yvar)$. ]
*To type.*
#exercise(name: "Sum of exponential variables")[Let $xvar follow expdf(lambda)$ and $yvar follow expdf(mu)$. Find the PDF of $xvar + yvar$. ]
*To type; *include link to #link("https://en.wikipedia.org/wiki/Hypoexponential_distribution#Two_parameter_case")[Hypoexponential distribution].


#exercise(name: "Square of exponential")[Let $xvar follow expdf(lambda)$ and $yvar = xvar^(2)$. Find the CDF and the PDF $yvar$. ]
*To type. *

#pagebreak()
#exercise(name: "Split a stick into a triangle")[Exercice corrigé 3.5.8. in @jourdainProbabilitesStatistiquePour2018.]<ex:split-stick>
#figure(
  image("figs/sol358.png", width: 90%),
)
#pagebreak()

//////////////////////////////////////////////////////////////////