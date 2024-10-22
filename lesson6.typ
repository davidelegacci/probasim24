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

= Theory recap (17 + 24).10.24 - Continuous random variables
<th-recap-6>

== PDF and CDF

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
#proposition(name: "PDF = CDF'")[The probability density function $pdf_(var)$ of a continuous random variable $var from points to rvals$ can be determined from the cumulative distribution function $cum_(var)$ by differentiating:
$
pdf_(var) = cum'_(var)
$
as long as the derivative exists.
]<prop:cdf-pdf>
#proof[By @eq:interval-event, $sigma$-additivity, and the fundamental theorem of integral calculus,

$
prob intev 
& = probof(var <= hval) -  probof(var <= lval) \
& = cum_(var)(hval) - cum_(var)(lval) \
& = integral_(lval)^(hval) cum'_(var) (x) dx.
$
]

#takeaway[
  - integral of PDF gives probability to observe RV in an integral
  - CDF gives probability to observe RV below a value 
  - $"PDF" = "CDF"'$
]


== Expected value, Théorème de transfert, variance

#definition[
  The _expected value_ of a RV $xvar from points to rvals$ with PDF $pdf_(xvar)$ is
$
exof(xvar) = integral_(rvals) xval  pdf_(xvar)(xval) d xval
$
]
- Let now $xvar$ be a vector-valued random variable, $xvar from points to rvals^(n)$
- Let $func from rvals^(n) to #R$ be a real-valued function.
- This defines the real-valued random variable $func(xvar) from points to rvals$
- For example, if $func from rvals^(2) to rvals$ is $f(a,b) = a+b$ then $func(xvar, yvar) = xvar + yvar$ is a RV. 

We have the following generalization of the "Théorème de transfert":
#theorem(name: "Théorème de transfert vectoriel")[The random variable $xvar from points to rvals^(n)$ has the probability density function $pdf_(xvar)$ if and only if
$
exof(func(xvar)) = integral_(rvals^(n)) func(x) pdf_(xvar)(x) dx
$]<th:transfert>
#takeaway[
  This is very useful to find the pdf of a function of a real-valued RV $xvar from points to rvals$. Say we have $xvar follow pdf_(xvar)$, and we are asked to find $pdf_(func(xvar))$ for some $func from rvals to rvals$. Let $h from rvals to rvals$ be a generic test function; then by the transfert theorem
  $
  exof(h(func(xvar)))
  & = integral_(rvals) h compose func (x) pdf_(xvar)(x) dx \
  & = integral_(rvals) h(f(x)) pdf_(func(xvar))(x) dx
  $
  So if we can cast the first integral into the second, usually by the change of variables $y = f(x)$, we can read off $pdf_(func(xvar))$.
]
#example[Let $xvar from points to rvals follow pdf_(xvar)$ with $pdf_(xvar)(xval) = e^(-x^(2)/2)/(sqrt(2 pi)) $ (cf @normal-distribution). We want to find the pdf of $func(xvar) = e^xvar$. Let $h from rvals to rvals$ be a test function; then
#figure(
  image("figs/transfert_find_pdf.png", width: 90%),

)
]
#definition(name: "variance")[
  The _variance_ of the RV $xvar from points to rvals$ is 
$
Var(xvar) = exof(xvar^(2)) - exof(xvar)^(2)
$
]
== Relation between CDF and expected value
This is a very useful technique to find the CDF of a RV (and hence its PDF, by differentiating) by expressing the CDF as the expectation of a function (in particular, and indicator function), that can be computed  by @th:transfert.

#proposition(name: "Indicator technique to find the CDF")[Let $xvar from points to rvals$ be a real-valued random variable. Then its CDF $cdf_(xvar)(xval) = probof(xvar <= xval)$ is given by the expected value of the indicator function of ${xvar <= xval}$, that is
$
cdf_(xvar)(xval) = exof(indof(xvar <= xval))
$
]<prop:cdf-indicator>
Before the proof, let's see make sure this is well posed. Consider the RV $xvar from points to rvals$, and fix some $xval in rvals$. Consider real-valued function indicator $indof( <= xval) from rvals to rvals$, defined by $indof( <= xval)(z) = 1 $ if $z <= xval$ and $0$ else. As usual, composing the real-valued function $indof( <= xval)$ with the real-valued RV $xvar$ is itself a random variable, and we denote this random variable by $indof(xvar <= xval) := indof( <= xval)(xvar) from points to rvals$. The expected value of this random variable can then be found by @th:transfert. 
#proof[ Let $xval in rvals$ and consider the function
$
xval mapsto exof(indof(xvar <= xval)) 
& = integral_(rvals) indof( <= xval) (y) pdf_(xvar)(y) d y && "by transfert theorem" \
& = integral_(- infinity)^(xval) 1 dot   pdf_(xvar)(y) d y && "by def of indicator function" \
& = probof(-infinity <= xvar <= xval) && "by def of pdf" \
& = cdf_(xvar)(xval) && "by def of cdf",
$
which is what we need.
]
#takeaway[To find the PDF of a random variable, try 
- first finding the CDF by the indicator technique (@prop:cdf-indicator), 
- then differentiating (@prop:cdf-pdf). ]

== PDF of function of random variables
The techniqueo of the previous secion generalizes to real-valued functions of random variables. We present the idea for $2$ RVs, but it readily generalises to $n$.
- Let $xvar from points to rvals$ and $yvar from points to rvals$ be continuous random variables.
- Together they make the random variable $(xvar,yvar) from points to rvals^(2)$. 
- Let now $func from rvals^(2) to #R$ be a real-valued function.
- As usual, $func(xvar, yvar) from points to #R$ is a real-valued random variable.
- For example, if $func from rvals^(2) to rvals$ is $f(a,b) = a+b$ then $func(xvar, yvar) = xvar + yvar$ is a RV. 
- We can use the indicator technique (@prop:cdf-indicator) to find the CDF of $func(xvar, yvar)$, and
- differentiate it (@prop:cdf-pdf) to find the PDF of $func(xvar, yvar)$.

A key step in this procedure relies on the _independence_ of the RVs:
#definition[Two continuous random variables $xvar, yvar$ are _independent_ if the density of $(xvar, yvar)$ is the product of the densities of $xvar$ and $yvar$:
$
pdf_((xvar, yvar))(xval, yval) = pdf_(xvar)(xval) pdf_(yvar)(yval).
$]

#takeaway[
Given the RVs $xvar from points to rvals$ and $yvar from points to rvals$ and the function $func from rvals^(2) to #R$, find the CDF of $func(xvar, yvar)$.
$
z mapsto probof(func(xvar, yvar) <= z)
& = exof(indof(func(xvar, yvar)<=z))  && "by the indicator technique " \
& = integral_(rvals^(2)) indof(func(xval, yval) <= z)(xval, yval) pdf_(xvar, yvar)(xval, yval) d x d y  && "by transfert theorem" \
& = integral_(rvals^(2)) indof(func(xval, yval) <= z)(xval, yval) pdf_(xvar)(xval) pdf_(yvar)(yval) d x d y  && "by independence" \
$<eq:pdf-funv-rvs>
Now the problem is solved up to the resolution of an integral, which usually involves taking care of the integration domain, changes of variables, etc.]


See @cdf-sum-rvs,  @ex:pdf-min, @ex:pdf-sum, @ex:pdf-square for some examples. 

#takeaway[To find the PDF of a function of random variables, try 
- first finding the CDF by the indicator technique (@prop:cdf-indicator), 
- then differentiating (@prop:cdf-pdf).]

=== PDF of sum of RVs: Convolution
#takeaway[c.f. @billingsleyProbabilityMeasure2012 pag. 266 and #link("https://en.wikipedia.org/wiki/Convolution_of_probability_distributions")[this Wikipedia page] plus the references therein for further details.]
In the special case of $func(xvar, yvar) = xvar + yvar$ the pdf $pdf_(xvar + yvar)$ takes an important form.


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
#proof[We first find the CDF of $xvar + yvar$ following the steps of @eq:pdf-funv-rvs specializing to $func(xvar, yvar) = xvar + yvar$, then differentiate to find the PDF.
$
z mapsto probof(xvar + yvar <= z)
& = exof(indof(xvar + yvar<=z))  && "by the indicator technique " \
& = integral_(rvals^(2)) indof(xval + yval <= z) (xval, yval) pdf_(xvar, yvar)(xval, yval) d x d y  && "by transfert theorem" \
& = integral_(rvals^(2)) indof(xval + yval <= z) (xval, yval) pdf_(xvar)(xval) pdf_(yvar)(yval) d x d y  && "by independence" \
$<cdf-sum-rvs>
Now one needs to set the correct domain of integration: the indicator function $indof(xval + yval <= z) (xval, yval)$ is $1$ when $xval + yval <= z$, and $0$ elsewhere. This means $xval in (-infinity, +infinity)$ and  $yval in (-infinity, z - xval)$ - see @fig:indicator.

So the CDF of $xvar + yvar$ is
$
cdf_(xvar + yvar)(z) =  probof(xvar + yvar <= z)
= integral_(rvals) pdf_(xvar)(xval) 
( integral_( - infinity)^(z - xval) pdf_(yvar)(yval) d yval )
d xval
$
The PDF follows by differentiating with respect to $z$:
$
pdf_(xvar + yvar)(z)
= d/(d z) cdf_(xvar + yvar)(z)
& = integral_(rvals) pdf_(xvar)(xval) 
d/(d z)( integral_( - infinity)^(z - xval) pdf_(yvar)(yval) d yval )
d xval \
& = integral_(rvals) pdf_(xvar)(xval) pdf_(yvar)(z - xval) d x
$<eq:convolution-pdf>
where the last step follows from the fundamental theorem of integral calculus. #footnote[$d / (d z) integral_(a)^(z-b) func(y) dy = d / (d z) integral_(a)^(z-b) F'(y) d y "with" f = F' = d /(d z)  {F(z-b) - F(a)}  = F'(z-b) = f(z-b)$.] 
]

#figure(
  image("figs/indicator.jpg", width: 50%),
  caption: [
    Domain where $indof(xval + yval <= z)$ is non-zero: $xval in (-infinity, +infinity)$ and  $yval in (-infinity, z - xval).$
  ],
)<fig:indicator>


== Standard PDFs

=== Uniform PDF
Given a continuous RV $var from points to rvals$ we write $var follow unipdf(lval, hval)$ and say that $var$ has _uniform_ density if

$
pdf_(var)(x) = (ind_([lval, hval])(x)) / (hval - lval)
$

=== Exponential PDF
Given a continuous RV $var from points to rvals$ we write $var follow expdf(rate)$ and say that $var$ has _exponential_ density if
$
pdf_(xvar)(xval) = cases(

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

=== Normal PDF
<normal-distribution>
Given a continuous RV $var from points to rvals$ we write $var follow norpdf(norex, norvar)$ and say that $var$ has _normal_ density if
$
pdf_(xvar)(xval) = 1 / (sqrt(2 pi norvar)) e ^(- (xval - norex)^(2) / (2 norvar) )
$

== Misc
For the following c.f. Prop. 3.3.6. in @jourdainProbabilitesStatistiquePour2018.
#proposition(name: "Marginal density")[Let $xvar$ and $yvar$ be continuous random variables. If the density $pdf_((xvar, yvar))$ of $(xvar, yvar)$ is known then one can obtain the densities of $xvar$ and $yvar$ by 
$
pdf_(xvar)(xval) = integral_(rvals) pdf_(xvar, yvar)(xval, yval) dy
$
and similarly for $pdf_(yvar)$.]

////////////////////////////////////////////////////////////////////////


#exercises[]


#exercise(name: "Min of exponential variables")[Let $xvar follow expdf(lambda)$ and $yvar follow expdf(mu)$. Find the CDF and the PDF of $min(xvar, yvar)$. ]<ex:pdf-min>
First we find the CDF, then differentiate to get the PDF.
$
cdf_(min(xvar, yvar))(z) & = probof(min(xvar, yvar) <= z) \
& = probof(xvar <= z "or" yvar <= z) \
& = 1 - probof(xvar > z "and" yvar > z) \
& = 1 - probof(xvar > z) probof(yvar > z) "by independence"
$
We have $probof(xvar > z) = integral_(z)^(infinity) mu e ^(-mu x) d x = e^(-mu z$, so the CDF is $z mapsto 1 - e^(-(mu + lambda)z)$, and by taking the derivative with respect to $z$ we find $pdf_(min(xvar, yvar))(z) = (mu + lambda) e ^(-(mu + lambda)z)$, so $min(xvar, yvar) follow expdf(mu + lambda)$.

#exercise(name: "Sum of exponential variables")[Let $xvar follow expdf(lambda)$ and $yvar follow expdf(mu)$ with $mu != lambda$. Find the PDF of $xvar + yvar$. ]<ex:pdf-sum>

*Method 1: indicator technique*
Let's find the CDF of $xvar + yvar$: by the indicator technique @prop:cdf-indicator and independence,
$
cdf_(xvar + yvar)(z) & = probof(xvar + yvar <= z) = exof(indof(xvar + yvar <= z)) \
& = integral_(rvals^(2)) indof(x+y <= z)(x,y) pdf_(xvar)(x) pdf_(yvar)(y) dx dy \
& = integral_(rvals^(2)) indof(x+y <= z)(x,y) indof(x >= 0)(x) indof(y >= 0)(y) lambda e ^(-lambda x) mu e^(-mu y )dx dy \
& = integral_(0)^(z) lambda e ^(-lambda x)
(integral_(0)^(z-x)  mu e^(-mu y )dy )
dx \
& = "...some standard calculations..." \
& = 1 - e ^(-lambda z) - lambda/(lambda - mu) [e^(-mu z) - e^(- lambda z)]
$
By taking the derivative with respect to $z$ we get the pdf:
$
pdf_(xvar + yvar)(z) = (lambda mu) / (lambda - mu) [e^(-mu z) - e^(- lambda z)].
$<pdf-sum-exponentials>
This is known as #link("https://en.wikipedia.org/wiki/Hypoexponential_distribution#Two_parameter_case")[Hypoexponential distribution].

*Method 2: convolution*
The indicator technique of the previous section can be used to find the cdf anfd pdf of any $func(xvar, yvar)$. In the particular case $func(xvar, yvar) = xvar + yvar$ we can directly apply @eq:convolution-pdf: 
$
pdf_(xvar + yvar)(z)
& = integral_(rvals) pdf_(xvar)(x) pdf_(yvar)(z-x) dx \
& =  integral_(0)^(z) lambda e ^(-lambda x) mu e^(-mu(z-x) ) dx
$
which after some standard steps leads back to @pdf-sum-exponentials. 


#exercise(name: "Square of exponential variable")[Let $xvar follow expdf(lambda)$ and $yvar = xvar^(2)$. Find the CDF and the PDF $yvar$. ]<ex:pdf-square>
By the indicator technique the cdf is
$
cdf_(xvar^(2))(z) & = probof(xvar^(2) <= z) = exof(indof(xvar^(2)<= z)) \
& = integral_(rvals) indof(x^(2) <= z)(x) pdf_(xvar)(x) dx \
& = integral_(0)^(sqrt(z)) pdf_(xvar)(x) dx  = 1 - e^(-lambda sqrt(z))
$
From which the pdf is
$
d/(d z)cdf_(xvar^(2))(z) = pdf_(xvar^(2))(z) = lambda/2 e^(-lambda sqrt(z)) / (sqrt(z)).
$

#pagebreak()
#exercise(name: "Split a stick into a triangle")[Exercice corrigé 3.5.8. in @jourdainProbabilitesStatistiquePour2018.]<ex:split-stick>
#figure(
  image("figs/sol358.png", width: 90%),
)
#pagebreak()

//////////////////////////////////////////////////////////////////