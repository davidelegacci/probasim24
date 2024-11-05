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

= Theory recap - 7.11.24

== Moments

See @billingsleyProbabilityMeasure2012 Section 21. Consider a random variable $var from points to rvals$ with density $pdf_(var)$.

- The _absolute moments_ of $var$ are
$
exof(abs(var)^(k)) = integral_(rvals) abs(x)^(k) pdf_(var)(x) dx, quad  k = 1, 2, dots
$

- If $var$ has finite absolute moment of order $k$ then it has finite absolute moments of order $1, 2, dots, k-1$ as well
- For each $k$ for which $exof(abs(var)^(k)) < infinity$, the _$k$-th monent of $var$ _is 
$
exof(var^(k)) = integral_(rvals) x^(k) pdf_(var)(x) dx, quad  k = 1, 2, dots
$


== Extra: Conditional density and conditional expectation
- cf @jourdainProbabilitesStatistiquePour2018 (3.3.2 and 3.3.6) for general theory
- cf @lesson:conditional-law in these notes for comparison with the discrete case
- Given $xvar from points to vecxvals$ and $yvar from points to vecyvals$
- Consider $(xvar, yvar) from points to vecxvals times vecyvals$
- Assume $(xvar, yvar)$ has the pdf $pdf_(xvar, yvar)(x, y) from vecxvals times vecyvals to #R _(>=0) $
- Let $pdf_(xvar) from vecxvals to pdfvals$ and $pdf_(yvar) from vecyvals to pdfvals$ be the correspinding marginal densities, that is 
$
pdf_(xvar)(x) = integral_(vecyvals) pdf_(xvar, yvar)(x, y) dy
$

$
pdf_(yvar)(y) = integral_(vecxvals) pdf_(xvar, yvar)(x, y) dx
$
#definition(name: "Conditional density")[For any $yval in vecyvals$, the _conditional density of $xvar$ given $yvar = yval$_ is the density $pdf_(xvar, yval) from vecxvals to pdfvals$ on $vecxvals$ given by
$
pdf_(xvar, yval)(x) := (pdf_(xvar, yvar)(x, y) )/ (pdf_(yvar)(yval))
$
]

#definition[For any $func from vecxvals times vecyvals to #R$, the _conditional expectation of $func(xvar, yvar)$ given $yvar$_ is the random variable $exof(func(xvar, yvar) given yvar) from points to #R$ given by
$
exof(func(xvar, yvar) given yvar) := psi(yvar)
$
where $psi from vecyvals to #R $ is the function defined by
$
psi(y) = integral_(vecxvals) func(x, y) pdf_(xvar, y)(x) dx
$
]

#pagebreak()
#exercises[] 

#exercise(name: "Uniform distribution")[
  #figure(
  image("figs/s8_37.png", width: 100%),
)
]
  #figure(
  image("figs/s8_37_sol.png", width: 100%),
)

#pagebreak()
#exercise(name: "Moments, fonction muette, indicator method")[
    #figure(
  image("figs/s8_38.png", width: 100%),
)
]
  #figure(
  image("figs/s8_38_sol.png", width: 90%),
)

#pagebreak()
#exercise(name: "Inf and sup of uniform distributions")[
    #figure(
  image("figs/s8_39.png", width: 100%),
)
]
  #figure(
  image("figs/s8_39_sol.png", width: 100%),
)