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

= Theory recap 3.10.24
Recall from last week that
#takeaway[
- $probspace$ with $prob from events to clint$ and $prob(points) = 1$
- $var from points to values$ countable, with ${var = val} in events "for all" val in values$
- $dist from values to clint$ such that $dist(val) = prob{var = val}$
]

== Expected value of a discrete random variable
<sec:expected-value>
In this section when we say _"$var$ is a RV"_ we mean "_$var from points to values subset #R$ is a discrete random variable with real values._"

#definition(name: "Expected value")[
A RV is _integrable_ if $sum_(val in values) abs(x) prob(var = val) < + infinity$, and in this case its _expected value_ $ex(var)$ is the real number
$
ex(var) := sum_(val in values) val prob(var = val).
$
]

#proposition(name: "Linearity of expectation")[
$
ex(var + a varalt) = ex(var) + a ex(varalt)
$
]

Some *properties* of the expected value of a RV:

- $ex("constant") = "constant"$
- Sufficient condition, positivity, monotonicity: see @jourdainProbabilitesStatistiquePour2018 pag. 20.

Some *examples*:
- $var follow bern(p) implies ex(var) = p$
- $var follow bern(n,p) implies ex(var) = n p$ (immediate by linearity from the above)
- $var follow poiss(rate) implies ex(var) = rate$
- $var follow geo(p) implies ex(var) = 1/p$

#theorem(name: "Expectation of function")[
Let $var from points to values subset #R$ be RV, and consider some function $f from values to #R $. Then 
$
ex(f(var)) = sum_(val in values) f(val) P(var = val)
$
whenever defined (see @jourdainProbabilitesStatistiquePour2018 Th. 2.3.6 for details).
]<th:expectation-function>

#proposition(name: "Expectation and independence")[
Let $var, varalt$ be RV and $f,g$ two functions on their values such that all the expectations are well-defined (i.e. al the random variables are integrable). Then
$
ex( f(var) g(varalt) ) = ex(f(var)) ex(g(varalt))
$
]

== Variance of a discrete random variable
#definition(name: "Variance")[
A RV $var$ is called _square integrable_ if $var^(2)$ is integrable, that is if $sum_(val in values) val^(2) prob(var = val) < + infinity$, and in this case
$
Var(var) := ex[ (var - ex[var])^(2) ]
$
]
- If $var$ is square integrable then the variance is well defined, cf @jourdainProbabilitesStatistiquePour2018 Remark 2.3.11
- The variance is a measure of the spreading, dispersion, of a random variable around its expected value

The two following properties of the variance are very useful for concrete calculations:
#lemma(name: "Variance as difference of expectations")[
  $
Var(var) = ex(var^(2)) - ex(var)^(2) 
$<eq:variance-difference>
]
The variance is in general *not linear*:
#lemma(name: "Variance after scaling and shifting")[
$
Var(a var + b) = a^(2) Var(var) "for all" a, b in #R
$
]
#proof[
Exercise; both lemmas follow by linearity of the expectation.
]
#proposition(name: "Variance and independence")[
Let $(var_(i))_(i in {1, dots, n})$ be a family of square integrable random variables. Then their sum is square integrable, and *if the $var_(run)$ are independent * then
$
Var(sum_(run =1)^(n)var_(run)) = sum_(run=1)^(n)Var(var_(run))
$
]<prop:variance-sum>
Some *examples*:
- $var follow bern(p) implies Var(var) = p(1-p)$, see @ex:binomial-variance and #link("https://proofwiki.org/wiki/Variance_of_Bernoulli_Distribution")[proof].
- $var follow bern(n,p) implies Var(var) = n p (1-p)$ (immediate by @prop:variance-sum)
- $var follow poiss(rate) implies Var(var) = rate$, see #link("https://proofwiki.org/wiki/Variance_of_Poisson_Distribution")[proof].


#exercises[]


////////////////

#let lost =  $L$
#let arr =  $A$

#let nlost = $l$
#let narr =  $a$

////////////////

#let plost = $p$
#let dummy = $j$
#exercise(name: "Lost messages")[
On a telecommunication channel, it has been estimated that in $T$ time units there arrives a number of messages that can be estimated by a DRV $follow poiss(rate T)$. Each message has a loss probability equal to $plost$, independent of the other messages. Find the probability that the number of lost message in $T$ units of time is equal to $nlost$.
]


Without loss of generality rescale $rate arrow.l rate T $.  We need to find the discrete random variable $lost$ whose range ${0, 1, 2, dots} in.rev nlost$ contains the possible numbers $nlost$ of lost messages in one time unit. The probability $prob(lost = nlost)$ to lose $nlost$ message is then by definition by the law of $lost$.

Let $var_(run)$ be the DRV for the event "_the $run$-th message is lost_". Since each message is lost with probability $plost$, $var_(run) follow bern(plost)$ for all $run in {1, 2, ...}$.

Let $lost_(narr) = sum_(run = 1)^(narr) var_(run)$ be the DRV whose range $im(lost_(narr)) = {0, 1, dots, narr} in.rev nlost$ contains the numbers $nlost$ of possible lost messages out of $narr$ arrived. Since $lost_(narr)$ is the sum of $narr$ independent $plost$-Bernoulli DRVs, $lost_(narr)$ follows the binomial distribution:
$
lost_(narr) follow bern(narr, plost).
$

Finally, let $arr$ be the DRV estimating the number of arrived messages $narr in {0, 1, dots, }$ in one time unit; we are given that $arr follow poiss(rate)$.

The law of $lost$ is given by
$
prob(lost = nlost) = prob[ union.big.sq_(narr = nlost)^(infinity) { lost_(narr) = nlost sect arr = narr } ],
$
that is, we look at the disjoint union of all the events in which, given $narr$ arrived messages, $nlost$ are lost. By countable additivity and independence, 
$
prob(lost = nlost)
= sum_(narr = nlost)^(infinity)
prob(lost_(narr) = nlost)
prob(arr = narr)
$
Now $lost_(narr)$ follows a binomial distribution and $arr$ follows a Poisson distribution, so
$
prob(lost = nlost) & = sum_(narr = nlost)^(infinity) choose(narr, nlost) plost^nlost (1-plost)^(narr-nlost) e^(-rate ) rate ^narr/narr! dot rate^(nlost) / rate^(nlost) \
& = rate ^nlost plost^nlost 1/nlost! e^(-rate ) sum_(narr = nlost)^(infinity) 1/(narr-nlost)! (1-plost)^(narr-nlost)   rate ^(narr-nlost) \
& = rate ^nlost plost^nlost 1/nlost! e^(-rate ) sum_(dummy  = 0)^(infinity)   (rate - rate plost )^dummy / fact(dummy) \
& = rate ^nlost plost^nlost 1/nlost! e^(-rate ) e^(rate  - rate  plost) \
& = (rate plost )^nlost / fact(nlost) e^(  - rate  plost). \
   $


So $ V tilde poiss(lambda  p)$. 

#exercise(name: "Poisson expectation")[Let $N follow poiss(rate)$. Find $ex(var := 1/(N+1))$].
By @th:expectation-function we have
$
ex(var) = sum_(n = 0)^(infinity) 1/(n+1)e^(-rate)rate^(n)/fact(n)
$
Multiply and divide by $rate$ and shift the running index to get $ex(var) = (1-e^(-rate))/rate$.
#exercise(name: "Archery")[
  An archer shots $n$ arrows at a target. The shots are independent, and each shot hits the target with probability $p$. Let $var$ be the random variable "_number of times the target is hit_".
  + What is the law of $var$? 
  + What is the expectation of $var$?
  + What is the value of $p$ that maximises the variance of $var$?

  The archer bets on his result. He gets $g$ euros when he hits the target, and loses $l$ euros when he misses it. Let $varalt$ be the random variable that represent the net gain of the archer at the end of the $n$ shots.

  4.  What is the expectation of $varalt$?
  + What is the relation between $g$ and $l$ that guarantees the archer an expected gain of zero?
]<ex:binomial-variance>

1. $var$ is the sum of $n$ independent $p$-Bernoullli variables, hence $var follow bern(n,p)$ (binomial distribution).

2. We have to compute the expectation of a binomial random variable $var = var_(1) + dots + var_(n)$, where each $var_i$ is a Bernoulli variable. Since expectations are linear we can compute the expectation of the Bernoulli variables, and sum them:
$
ex(var_(i)) = 1 dot p + 0 dot (1-p) = p
$
$
ex(var_(1) + dots + var_(n)) = ex(var_(1)) + dots + ex(var_(n)) = n p
$
For example, if $p = 0.5$ and $n = 10$, this means that the archer expects to hit the target $5$ times. 

3. Let's compute the variance of a Bernoulli and a binomial variable by @eq:variance-difference:
$
ex(var_(i)^(2)) = 1^(2) dot p + 0^(2) dot (1-p) = p
$
$
Var(var_(i)) = ex(var_(i)^(2)) - ex(var_(i))^(2) = p(1-p)
$
By independence, $Var( var_(1) + dots + var_(n)  ) = Var(var_(1)) + dots + Var(var_(n)) = n p (1-p)$. To find the value of $p$ that maximises the variance differentiate: $n(1-2p) = 0 implies p = 0.5$.

4. Let $varalt_(i) = $ gain of $i$-th shot. Then $ex(varalt_(i)) = g p - l (1-p)$, and 
$
ex(varalt = varalt_(1) + dots + varalt_(n)) = n[ g p - l (1-p) ]
$
For example if $n = 10$, $g = 1$, $l = 2$, we have $ex(varalt) = 30 p - 20 $; and if furthermore $p = 0.5$ then $ex(varalt) = -5$.

5. To find the value of relation between $g$ and $l$ required to have an expected gain of zero solve the equation $ex(varalt) = 0$ to get
$
g/l =  (1-p)/p.
$
Thus as the probability $p$ to hit the target goes to zero, a very big $g/l$ is required to guarantee an expected gain of zero; viceversa $g/l$ becomes infinitely small as $p to 1$. At $p = 0.5$, as one would expect, $g = l$. 



#exercise(name: "Martingale doubling betting system")[See @ex:martingale.]