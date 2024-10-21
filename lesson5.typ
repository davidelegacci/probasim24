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

= Theory recap 10.10.24 - Conditional law and conditional expectation
#takeaway[
All the random variables (RVs) we consider in the following are supposed to be integrable discrete random variables with real values. Recall that
- the _expected value_ of a random variable $xvar from jet to xvals$ is $exof(xvar) = sum_(xval in xvals)xval pof(xev)$;
- the _law_ of $xvar$ is the function $xvals to clint$ defined by $xval mapsto pof(xev)$.
]

== Marginal law
Let $xvar from jet to xvals$ and $yvar from jet to yvals$ be random variables. Knowing the law of $X$ and the law of $Y$ is not enough to obtain the law of $(X et Y)$, unless we have further information on how $X$ and $Y$ are related. If they are independent, then 
$probof(xev et yev) = probof(xev) probof(yev)$.

- Conversely, knowing the law of $(X,Y)$ we can recover the laws of $X$ and $Y$ by the _marginal law_:
$
probof(xev) = sum_(yval in yvals) probof(xev et yev).
$

- If the law of $(xvar,yvar)$ *factors* as a product,
$
probof(xvar = xval et yvar = yval) = c mu(xval) nu(yval) "for all" xval in xvals, yval in yvals,
$
then $xvar$ and $yvar$ are *independent* (cf. @jourdainProbabilitesStatistiquePour2018 Rem. 2.2.12.)


== Conditional law

Let $xvar$ and $yvar$ be random variables.
#definition[The _conditional law of $xvar$ given $(yev)$_ is the function from $xvals$ to $[0,1]$ defined by
$
xval mapsto pof(xev given yev).
$
]<def:conditional-law>

- By definition of conditional probability (@cond-prob-1), 
$
pof(xev given yev) = pof(xev et yev) / pof(yev)
$
- Recall that $(xev et yev) equiv {xev} sect {yev}$ is a short-hand for the intersection of two events.
////////////////////////////////////////////////////////////////////////

== Conditional expectation
- Let $xvar from jet to xvals$ and $yvar from jet to yvals$ be random variables.
- Consider a function $f from xvals times yvals to #R $.
- $f(xvar, yvar)$ is a random variable (assume it is integrable).
#definition[The _conditional expectation of $f(xvar,yvar)$ given $yvar$_ is a *discrete random variable*; it is denoted by $conexf(f, xvar, yvar)$, and it is defined by
$
conexf(func, xvar, yvar) := psi(yvar)
$
with $psi from yvals to #R$ defined by
$
psi(yval)  = sum_(xval in xvals) func(xval, yval) probof(xev given yev)
$
]<def:conditional-expectation>

Note that the probability appearing in the sum is the conditional law of $xvar$ given $yvar = yval$.

*Special cases*
- If $func(xval, yval) = xval$ the conditional expectation of $xvar$ given $yvar$ is the discrete random variable
$
conex(xvar, yvar) = psi(yvar) "with" psi(yval) = sum_(xval in xvals) xval probof(xev given yev).
$<eq:conditional-exp-identity>


- If $xvar$ and $yvar$ are *independent* we have 
$
psi(yval) = sum_(xval in xvals) func(xval, yval) probof(xev) = exof(func(xvar, yval)).
$<eq:conditional-exp-independent>

- Combining the previous two cases, if $func(xval, yval) = xval$ and $xvar, yvar$ are independent we have
$
conex(xvar, yvar) = psi(yvar) "with" psi(yval) = exof(xvar).
$<eq:conditional-exp-identity-independent>
*Expected value*

Now since $psi(yvar) = conexf(func, xvar, yvar)$ is a RV it makes sense to look at its expected value $exof(psi(yvar))$.
- Let $xvar from jet to xvals$ and $yvar from jet to yvals$ be random variables
- consider functions $func from xvals times yvals to #R$ and $yfunc from yvals to #R$
- let $conexf(func, xvar, yvar) = psi(yvar)$ as above
- $psi(yvar)$ and $yfunc(yvar)$ are random variables, and so is their product $psi(yvar)yfunc(yvar)$
- similarly, $func(xvar, yvar)$ and $yfunc(yvar)$ are random variables, and so is their product $func(xvar, yvar)yfunc(yvar)$
- the expected values of these RVs are related by the following
#proposition()[
$
exof(  psi(yvar)yfunc(yvar) ) = exof( func(xvar, yvar) yfunc(yvar) )
$<prop:exp-of-conditional-exp>
whenever all the RVs involved are integrable.
]
By setting $yfunc equiv 1$:
#corollary[
$
  exof(  psi(yvar) ) = exof( func(xvar, yvar)  )
$<cor:exp-of-conditional-exp>
whenever all the RVs involved are integrable.
]

#takeaway[
  - Let $xvar from jet to xvals$ and $yvar from jet to yvals$ be random variables.
  - The law of $xvar$ is $xval mapsto probof(xvar = xval)$
  - The expectation of $xvar$ is $exof(xvar) = sum_(xval in xvals) xval probof(xev)$
  - The conditional law of $xvar$ given $(yev)$ is $xval mapsto probof(xev given yev)$
  - The conditional expectation of $xvar$ given $yvar$ is $exof(xvar given yvar) = psi(yvar) $ with
  - $psi(yval) = sum_(xval in xvals) xval probof(xev given yev) $
  ]

*!to check -----------------------------------------------------------------------*
$
exof(exof(xvar given yvar)) = exof(xvar)
$
////////////////////////////////////////////////////////////////////////


#exercises[]
#let win = $1$
#let lose = $0$
#let inbet = $b_(1)$

#let pwin = $p$
#let plost = $q$
#exercise(name: "Martingale doubling betting system")[
Let $var_(n) follow bern(pwin)$, $n =  1, 2, 3, 4 dots$ be a sequence of independent Bernoulli variables (set $prob(var = lose) = plost$ and $prob(var = win) = pwin$ with $plost + pwin = 1$, $plost > 0$, $pwin > 0$). Fix a number $inbet > 0$. Before each $var_(n)$ is drawn, you bet on the outcome $var_n = win$ the amount $b_(n)$ defined recursively by $b_(n) = 2 b_(n-1)$. If you win the bet, you receive $g_(n) = 2b_(n)$ and the game ends; else, you keep going.
+ What is your final gain?
+ What is the expected amount of money bet?
]<ex:martingale>
First, note that the amount placed on the $n$-th bet can be written as $b_(n) = 2^(n-1)inbet$. Let's then write down explicitely the process:
#line(length: 100%)
0. You bet $b_(1)$ on the event $var_(1) = win$;
+ $var_(1)$ is drawn:
  - if $var_(1) = win$, you get $g_(1)$ and the game ends;
  - else, you bet $b_(2)$ on the event $var_(2) = win$.

+ $var_(2)$ is drawn:
  - if $var_(2) = win$, you get $g_(2)$ and the game ends;
  - else, you bet $b_(3)$ on the event $var_(3) = win$.

$dots$

n. $var_(n)$ is drawn:
  - if $var_(n) = win$, you get $g_(n)$ and the game ends;
  - else, you bet $b_(n+1)$ on the event $var_(n+1) = win$.

$dots$
#line(length: 100%)

*Final gain*

After placing $n$ bets the invested amount is 
$
B_(n)
= sum_(k = 1)^(n)b_(k)
= sum_(k = 1)^(n) inbet 2^(k-1)
= inbet sum_(l = 0)^(n-1)2^(l)
= inbet (1-2^(n))/(1-2) = inbet (2^(n)-1) .
$<eq:bet-after-n>
If the $n$-th placed bet is the winning one you receive $g_(n) = 2b_(n)$ and the game ends, so your final gain is always
$
2b_(n) - B_(n) =  2^(n) inbet - (2^(n)-1) inbet =  inbet.
$
This result is surprising: with this strategy (doubling your bet until you win), no matter how big $n$ is (that is, how late you win) and how small the probability $p$ to win is, _at the end of the day you go home with a net gain equal to your initial bet_. But before running to the closest casino, beware! If the probability to win is sufficiently small this well known strategy#footnote[
#link("https://en.wikipedia.org/wiki/Martingale_(betting_system)")[Martingale betting system] and
#link("https://johnwoodsspace5.quora.com/Is-the-martingale-strategy-legal-on-betting-sites")[some]
#link("https://www.kingcasino.com/blog/is-martingale-strategy-allowed-in-casinos/")[random]
#link("https://www.quora.com/Do-casinos-ban-Martingale")[discussions]
on the matter.
] can lead you to invest colossal sums which may well bankrupt you before you get your win.

*Expected bet amount*
The first occurrence of a winning bet is described by a random variable $var follow geo(p)$ with values $values = {1, 2, 3, ...} in.rev n$. After placing $n$ bets, the amount of invested money is the function $B from values to #R$ with $B_(n) = inbet(2^(n)-1) $ as per @eq:bet-after-n. By @th:expectation-function and @eq:geometric-law the expected amount of money bet is
$
ex(B(X)) = sum_(n = 1)^(infinity) B_(n)prob(var = n) =  sum_(n = 1)^(infinity) B_(n) (1-pwin)^(n-1) pwin
$
For clarity let's write down more explicitely what is going on, recalling that $prob(var_(run) = lose) = plost$ is the probabiloty to lose each bet and $prob(var_(run) = win) = pwin$ is the probability to win each bet, with $plost + pwin = 1$.
$
ex(B(X)) & 
= b_(1) && prob(var_(1) = win) + \
& + (b_(1) + b_(2)) && prob( var_(1) = lose, var_(2) = win ) + \
& + (b_(1) + b_(2) + b_(3)) && prob( var_(1) = lose, var_(2) = lose, var_(3) = win ) + \
& + dots + \
& + (b_(1) + dots + b_(n)) && prob( var_(1) = lose, dots, var_(n-1) = lose, var_(n) = win )
& + dots \
$
Then
$
ex(B(X)) 
& = inbet sum_(n = 1)^(infinity) (2^(n)-1) plost^(n-1) pwin \
& = inbet  pwin / plost sum_(n = 1)^(infinity) [ (2plost)^(n) - plost^(n) ] \
$
Recall that the geometric series $sum_(run = 0)^(infinity) r^(i)$ with $r >= 0$ converges to $ 1/(1-r)$ iff $ r < 1$, else it diverges to $+infinity$; and analogously for $sum_(run = 1)^(infinity) r^(i) = r /(1-r)$. Since $plost < 1$ the second series converges, whereas the first series converges iff $2plost < 1$, that is if the probability $pwin$ to win is strictly bigger than $0.5$:
$
"Finite expected bet amount" iff  "prob. to win" pwin > 1/2.
$

_Thus, if $pwin <= 1/2$, the expected invested amount diverges to infinity_. On the other hand, if $pwin > 1/2$:
$
ex(B(X))
& = inbet  pwin / plost sum_(n = 1)^(infinity) [ (2plost)^(n) - plost^(n) ] \
& = inbet  pwin / plost [ (2 plost) / (1-2 plost) - plost  / (1-plost) ] \
& = inbet / (2 pwin - 1).
$
Reasonably, the expected invested amount diverges to $+infinity$ as $pwin to 1/2$ from the right, and is equal to $inbet$ if there is certainty to win ($pwin = 1$). The graph of $(1/2, 1] in.rev p mapsto 1 / (2 p - 1) $ is shown below:

#figure(
  image("figs/martin.png", width: 40%),
  caption: [
  Horizontal: probability $pwin$ of each winning Bernoulli event.
  Vertical: expected bet amount.
  ],
)
#takeaway[
Whenever a "special" number appears in your results, ask yourself whether it arises from the theory or whether it is imposed by the model at hand. Why is the probability $1/2$ special? Is it a consequence of our modeling choices, like the "doubling" betting strategy, or is it intrinsic to this problem (if there were an outcome more likely than the other, then you would bet on that one)? Try to generalize this scenario to different betting and reward policies, like $b_(n) = alpha b_(n-1)$ and $g_(n) = beta b_(n)$ for some $alpha, beta > 0$.
]


#exercise(name: "Conditional law and expectation 1")[
Let $var_(1), dots, var_(n)$ be independent and identically distributed (#iid) random variables following $bern(p)$ with $p in (0,1)$, and let $S = var_(1) + dots + var_(n)$. For $s in [0, n]$,
+ find the conditional law of $var_(1)$ given $S = s$, and
+ find the conditional expectation of $var_(1)$ given $S$.
]

*Hint*: use @def:conditional-law to find the conditional law, and  @eq:conditional-exp-identity to compute the conditional expectation.

1. By @def:conditional-law the conditional law of $var_(1)$ given $S = s$ is
$
x mapsto & probof(X_(1) = x given S = s) \
& = probof(X_(1) = x et S = s) / probof(S=s) \
& = probof(X_(1) = x et X_(2) + dots + X_(n) = s-x) / probof(S=s) \
& = probof(X_(1) = x) probof( X_(2) + dots + X_(n) = s-x) / probof(S=s) \
$
We have that $X_(1) follow bern(p)$, $X_(2) + dots + X_(n) follow bern(n-1, p)$, and $S follow bern(n,p)$, so
$
probof(X_(1) = x given S = s) & = (p^(x)(1-p)^(1-x)choose(n-1, s-x)p^(s-x)(1-p)^(n-1-s+x))/(choose(n,s)p^(s)(1-p)^(n-s)) = choose(n-1, s-x)/choose(n,s)
$
Let's evaluate this for $x in {0,1}$. For $x = 0$ the binomial coefficients simplify to
$
probof(X_(1) = 0 given S = s) = (n-s)/n,
$
while for $x = 1$ we get$
probof(X_(1) = 1 given S = s) = s/n.
$
For $x in {0,1}$ these can be packed into 
$
probof(X_(1) = x given S = s) = (s/n)^(x) ((n-s)/n)^(1-x)
$
meaning that the law of $X_(1)$ given $S = s$ is $bern(s/n)$; note that this is independent of $p$!

2. For the second part, by @eq:conditional-exp-identity the conditional expectation of $X_(1)$ given $S$ is
$
conex(X_(1), S) = psi(S) "with" psi(s) = sum_(x in {0,1}) x  probof(X_(1) = x given S = s) = s/n
$
Hence, the conditional expectation of $X_(1)$ given $S$ is the random variable
$
conex(X_(1), S) = S/n.
$

#exercise(name: "Conditional law and expectation 2")[Let $X follow poiss(lambda)$ and $Y follow poiss(mu)$ be independent random variables.
+ Find the conditional law of $X$ given $X+Y = s$, and
+ Find the conditional expectation of $X$ given $X+Y$.
]
1. Let $S = X+Y$. The conditional law of $X$ given $S = s$ is 
$
{0, 1, dots, s} in.rev x mapsto probof(X = x given S = s)
$
Following the steps of the previous exercise we readily arrive to 
$
probof(X = x given S = s) = (probof(X = x)probof(Y = s-x))/probof(S = s).
$
Recall by @ex:sum-poisson that $S follow poiss(mu + lambda)$, so
$
probof(X = x given S = s) = ( e^(-lambda) lambda^(x))/fact(x) ( e^(-mu) mu^(s-x))/fact((s-x)) fact(s)/(e^(-(lambda+mu))(lambda + mu)^(s))
$
which can be manipulated into
$
probof(X = x given S = s) = choose(s,x)p^(x)(1-p)^(s-x) "with" p = lambda/(lambda+mu).
$
Hence the law of $X$ given $S = s$ is binomial with $s$ iterations and probability $p$.

2. To find the conditional expectation of $X$ given $S$, solve
$
conex(X, S) = psi(S) "with" psi(s) = sum_(x  = 0)^(s) x choose(s,x)p^(x)(1-p)^(s-x) = s p
$
The series can be solved directly (#link("https://proofwiki.org/wiki/Expectation_of_Binomial_Distribution")[see for example this page]), but it's much more convenient to recognise this as $exof(bern(s,p))$, the expected value of the binomial distribution, which by linearity (c.f. @sec:expected-value) is immediately concluded to be $s p$ (where as above $p = lambda / (lambda + mu) $). So in conclusion the conditional expectation of $X$ given $X+Y$ is the random variable
$
conex(X, X+Y) = lambda / (lambda + mu) (X+Y).
$

#exercise(name: "An electronic component has a lifetime...")[Exercice corrigé 2.6.4. in @jourdainProbabilitesStatistiquePour2018.]<ex:electrical-component>

#figure(
  image("figs/ex264.png", width: 90%),
)
#pagebreak()
#figure(
  image("figs/sol264_1.png", width: 70%),
)
#figure(
  image("figs/sol264_2.png", width: 70%),
)
#pagebreak()
//////////////////////////////////////////////////////////////////