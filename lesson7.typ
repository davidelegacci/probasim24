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

= Theory recap - 24.10.24
The theory recap for this session is included in @th-recap-6.
#exercises[] 
#exercise(name: "Expected value of functions of normal distribution")[Ler $var follow norpdf(0, 1)$. Find 
+ $exof(abs(var))$
+ $exof(e^(var))$
+ $Var(e^(var))$]

1.
$
exof(abs(var)) & = integral_(#R) abs(x) e^(-x^(2)/2) / (sqrt(2pi)) dx \
& = integral_(-infinity)^(0) -x e^(-x^(2)/2) / (sqrt(2pi)) dx + integral_(0)^(infinity) +x e^(-x^(2)/2) / (sqrt(2pi)) dx \
& = 2 integral_(0)^(infinity) x e^(-x^(2)/2) / (sqrt(2pi)) dx && " since " x mapsto -x e^(-x^(2)/2) "is an odd function"\
& = sqrt(2/pi) && "by change of variable" u = x^(2)
$

2. 
$
exof(e^(var)) & = integral_(#R) e^(x) e^(-x^(2)/2) / (sqrt(2pi)) dx\
& = sqrt(e) integral_(#R) e^(-(x-1)^(2)/2)/(sqrt(2 pi)) dx && "by completing the square in the exponential" \
& = sqrt(e) && "since the integrand is a probability density".
$

3.
$
Var(e^(var)) & = exof((e^var)^(2)) - exof(e^(var))^(2) \
& = e^(2) - e && "as above (completing the square and integral of pdf = 1) "
$

#figure(
  image("figs/exp2X.png", width: 50%),
)

#exercise(name: "Dropping a CD on a parquet")[
  On laisse tomber au hasard un CD de diamètre $d$ sur un parquet dont les lames ont une largeur $D >= d$. Calculer la probabilité que le CD tombe à cheval sur deux lames de parquet.
]
Let $var$ be the RV describing the distance between the center of the CD and the closest floorboard. Then $X follow unipdf([0, D/2])$. The CD falls between two floorboards iff $var <= d/2$. The PDF of $var$ is $pdf_(var)(x) = 2/D ind_((0, D/2))$, so
$
probof(0 <= var <= d/2) = integral_(0)^(d/2) 2/D dx = d/D.
$