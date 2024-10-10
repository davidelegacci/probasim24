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

= Theory recap 26.9.24



== Probability measure

The relevant references are @jourdainProbabilitesStatistiquePour2018 pag. 11 and @billingsleyProbabilityMeasure2012, pag. 22 and 160.

#definition(name: "sigma-field")[
Let $jet$ be any set. A _$sigma$-field_ $events$ on $jet$ is a collection of subsets of $jet$ that#footnote[In french, this set is called _tribu_ on $jet$. The term _$sigma$-algebra_ is also used -- and is more common in the context of pure analysis, c.f. @liebAnalysis2001 -- whereas the term _$sigma$-field_ is more common in the context of probabioloty theory, c.f. @billingsleyProbabilityMeasure2012.]
+ is closed under complement: if $event in events$ then $nevent in events$;
+ contains the whole set: $jet in events$;
+ is closed under countable union: if $event_1, event_2, dots$ is a countable family of sets of $events$ then their union $union_(i = 1)^(infinity) event_i$ is also in $events$.
]

A subset of $jet$ that is in $events$ is called _event_.

#definition(name: "Measure")[
Given a set $jet$ and a $sigma$-algebra $events$ on $jet$, a _measure_ $meas$ is a function 
$ mu from events to posR $
such that
+ $meas(emptyset) = 0$
+ _countable additivity_ (also called _$sigma$-additivity_) is fulfilled, namely the measure of a _disjoint_ countable union of sets in $events$ is the sum of their measures:
$
meas(union.big.sq_(i = 1)^(infinity)event_i) = sum_(i = 1)^(infinity) meas(event_(i)).
$ 
]
#definition(name: "Probability measure")[
Given a set $jet$ and a $sigma$-algebra $events$ on $jet$, a _probaility measure_ $prob$ is a measure (in the sense above) with the additional requirement that
$
prob(jet) = 1.
$
]
- Note that this implies that $prob(event) <= 1$ for all events $event in events$.
- A triple $probspace$ where $events$ is a $sigma$-algebra on $jet$ and $prob$ is a probability measure is called _probability space_.

#takeaway[Putting all together, a probability measure $prob from events to clint$ on a space $jet$ is a function from a "well-behaved" collection of subsets of $jet$ (the $sigma$-field) to $clint$, such that $prob(emptyset) = 0$, $prob(jet) = 1$, and fulfilling countable additivity.]

== Discrete random variables
#definition(name: "Discrete random variable")[Given a probability space $probspace$, a _discrete random variable_ $var$ is a function $var from points to values$ such that
+ $values$ is a _countable_ set;
+ _the level sets of $var$ are events_, that is
$
{var = val} := { point in points: var(point) = val } in events "for all" val in values
$
]
- clearly, ${var = val} = emptyset in events$ for all $val in values without im(var)$
- the second property guarantees that $prob{var = val}$ is well-defined for all $val in values$, which allows for the following definition:

#definition(name: "Distribution of a discrete random variable")[The _distribution_ (or _law_) of a random variable $var$ is the function $dist from values to clint$ defined by 
$
dist(val) = prob{var = val} "for all" val in values.
$
]

- two discrete random variables $var$ and $Y$ taking values resp. in $values$ and  $G$ are _independent_ if 
$
prob{var = val, Y = y} = prob{var = val} prob{Y = y} "for all" val in values, y in G
$
- it is understood that ${var = val, Y = y}$ is a shorthand for the event $ {point in points : var(point) = val} sect {point in points : Y(point) = y} in events. $
- the definition generalises to collections of DRVs, see Section 2.2.3 in @jourdainProbabilitesStatistiquePour2018.
#takeaway[A discrete random variable is a _function on $jet$_ with _countable range_. Think of it as an experiment with a random outcome. Its _law, or distribution_, gives the probability to observe each of the possible (countable) _values_ of the random variable.]

#takeaway[
- $probspace$ with $prob from events to clint$ and $prob(points) = 1$
- $var from points to values$ countable, with ${var = val} in events "for all" val in values$
- $dist from values to clint$ such that $dist(val) = prob{var = val}$
]

== Standard discrete distributions
=== Bernoulli $bern(p)$
- The Bernoulli distribution models a random experiment which has two possible outcomes.
- More precisely, the Bernoulli distribution is the distribution of a discrete random variable $var$ that can assume only values in $values = bvalues$.
- The distribution is parametrized by $p in clint$, and we write $var follow bern(p)$.
$
dist from   & values to         && clint \
            & 1 mapsto && p   \
            & 0 mapsto && 1-p \
            & val mapsto && p^(val)(1-p)^(1-val)
$
=== Binomial $bern(n,p)$
- Distribution of the discrete random variable $var = var_(1) + dots + var_(n)$, where the $var_(i)$-s are independent Bernoulli variables of parameter $p in clint$.
- $values = {0, dots, n}$; $k in values$ is value of the sum 
$
dist from   & values to         && clint \
            & k mapsto && choose(n,k) p^(k)(1-p)^(n-k)
$
=== Poisson $poiss(lambda)$
- probability of observing a given number of independent events occurring at constant rate $lambda > 0$
- $values = naturals$; $n in values$ is number of observed events
$
dist from   & values to         && clint \
            & n mapsto && e^(-lambda)lambda^(n)/fact(n)
$
=== Geometric $geo(p)$
- First successful event from a sequence of independent $p$-Bernoulli events.
- $values = posnat$; $k in values$ is first succesful event
$
dist from   & values to         && clint \
            & k mapsto && p (1-p)^(k-1)
$ <eq:geometric-law>

== Useful stuff
- #link("https://en.wikipedia.org/wiki/Vandermonde%27s_identity")[Vandermonde's identity]
$
sum_(k_(1) = 0)^(k) choose(n_(1),k_(1)) choose(n_(2), k-k_(1)) = choose(n_(1) + n_(2),k)
$

#exercises[]

#exercise(name: "Sum of independent binomial distributions")[Let $var_(i) follow bern(n_i, p)$ with $i in {1,2}$ be independent discrete random variables following the Bernoulli law. Find the law of $var_(1) + var_(2)$.]

_Hint: c.f. derivation of binomial distribution @jourdainProbabilitesStatistiquePour2018 pag. 16._

The laws $dist_(i) from values_(i) = {0, dots, n_(i)} to [0,1]$ of the two variables are given by
$
law_(i)(k_(i)) = prob(var_(i) = k_(i)) = choose(n_(i), k_(i)) p^(k_(i)) (1-p)^(n_(i) - k_(i))
$
The law of $var_(1) + var_(2)$ takes value in $values = {0, dots, n_(1) + n_(2)}$
and for all $k in values $ is given by
$
law(k)
& = prob(var_(1) + var_(2) = k) \
& = prob(union.big.sq_(k_(i) in values_(i) \ k_(1) + k_(2) = k) {var_(1) = k_(1), var_(2) = k_(2)}) && \
& = sum_(k_(i) in values_(i) \ k_(1) + k_(2) = k) prob(var_(1) = k_(1)) prob(var_(2) = k_(2)) && "by c. add and indep." \
& = sum_(k_(i) in values_(i) \ k_(1) + k_(2) = k) law(k_(1)) law(k_(2)) && "by def of law" \
& = sum_(k_(i) in values_(i) \ k_(1) + k_(2) = k) choose(n_(1), k_(1)) choose(n_(2), k_(2)) p^(k_(1) + k_(2)) (1-p)^(n_(1) + n_(2) - k_(1) - k_(2)) && \
& = p^(k) (1-p)^(n_(1) + n_(2) - k)  sum_(k_(i) in values_(i) \ k_(1) + k_(2) = k) choose(n_(1), k_(1)) choose(n_(2), k_(2)) && \
$
Let's focus on the sum. For each fixed $k_(1) in values _(1)$, $k_(2)$ is constrained to be $k - k_(1)$. Furthermore, in order for $k_(2)$ to be $>=0$, $k_(1)$ can be at most equal to $k$. So the constraints
$
k_(1) & in {0, dots, n_(1)} \
k_(2) & in {0, dots, n_(2)} \
k_(1) & + k_(2) = k
$
can be replaced by the constraints
$
k_(1) & in {0, dots, k} \
k_(2) & = k - k_(1) 
$
namely
$
sum_(k_(i) in values_(i) \ k_(1) + k_(2) = k) choose(n_(1), k_(1)) choose(n_(2), k_(2))
= sum_(k_(1) = 0)^(k) choose(n_(1), k_(1)) choose(n_(2), k - k_(1))
= choose(n_(1) + n_(2), k)
$ <step-3-1-sum>
where the second step follows by by Vandermonde’s identity.
#remark[Note that it is correct to have $k_(1)$ running from $0$ to $k$:
- If $k <= n_(1)$, $k_(1)$ can be at most $k$ so that $k_(2) = k - k_(1) >= 0$, so we have directly @step-3-1-sum.
- If $k > n_(1)$, we have
$
sum_(k_(i) in values_(i) \ k_(1) + k_(2) = k) choose(n_(1), k_(1)) choose(n_(2), k_(2))
& = sum_(k_(1) = 0)^(n_(1)) choose(n_(1), k_(1)) choose(n_(2), k - k_(1)) \
& = sum_(k_(1) = 0)^(n_(1)) choose(n_(1), k_(1)) choose(n_(2), k - k_(1)) +  sum_(k_(1) = n_(1) + 1)^(k) choose(n_(1), k_(1)) choose(n_(2), k - k_(1))
$
since each summand in the the second sum is zero#footnote[Recall that $choose(a,b) = 0$ if $b > a$.], and we get again @step-3-1-sum.
]

So in conclusion
$
law(k) = choose(n_(1) + n_(2), k) p^(k) (1-p)^(n_(1) + n_(2) - k)
$
namely $var_(1) + var_(2) follow bern(n_(1) + n_(2), p)$.

#exercise(name: "Sum of independent Poisson distributions")[Let $var_(i) follow poiss(lambda_i)$ with $i in {1,2}$ be independent discrete random variables following the Poisson law. Find the law of $var_(1) + var_(2)$.]<ex:sum-poisson>

_Hint: c.f. previous exercise and binomial theorem._

Analogously to before, with $i in {1,2}$, we look for the law $law from naturals to [0,1]$ given by
$
law(n)
= prob(var_(1) + var_(2) = n) 
& = sum_(n_(i) in naturals \ n_(1) + n_(2) = n) law_(1)(n_(1)) law_(2)(n_(2)) \
& = sum_(n_(i) in naturals \ n_(1) + n_(2) = n) e^(-lambda_(1))lambda_(1)^(n_(1))/fact(n_(1)) e^(-lambda_(2))lambda_(2)^(n_(2))/fact(n_(2)) \
$
As before we replace the consraint by $n_(1) in {0, dots, n}$ and $n_(2) = n - n_(1)$, so
$
law(n) & = e^(-(lambda_(1) + lambda_(2))) sum_(n_(1) = 0)^(n) lambda_(1)^(n_(1))/fact(n_(1))  lambda_(2)^(n - n_(1))/fact(n - n_(1)) dot fact(n)/fact(n) \
& = e^(-(lambda_(1) + lambda_(2))) / fact(n) sum_(n_(1) = 0)^(n) choose(n, n_(1)) lambda_(1)^(n_(1)) lambda_(2)^(n-n_(1)) \
& = e^(-(lambda_(1) + lambda_(2))) (lambda_(1) + lambda_(2))^(n) / fact(n)
$
So $var_(1) + var_(2) follow  poiss(lambda_(1) + lambda_(2))$. 

#exercise(name:"Min of independent geometric distributions")[Let $var_(i) follow geo(p_(i))$ with $i in {1,2}$ be independent DRVs following the geometric law. Find the law of $min{var_(1) + var_(2)}$.]
_Hint: set up the problem in terms of inequalities._

Let $Z = min{var_(1) + var_(2)}$. We look for the law $law from posnat to [0,1]$ such that
$
law(k) & = prob(Z = k) \
& = prob(Z >= k) - prob(Z >= k+1) \
& = prob(var_(1) >= k, var_(2) >= k) - prob(var_(1) >= k+1, var_(2) >= k+1) \ 
& = prob(var_(1) >= k) prob( var_(2) >= k) - prob(var_(1) >= k+1) prob(var_(2) >= k+1) \ 
$ <step-3-3>

Let's drop the subscript for a moment. For a DRV $var follow geo(p)$ and for $k in posnat$ we need
$
prob(var >= k)
& = prob(union.big.sq_(val >= k) (var = i)) \
& = sum_(i >= k) prob(var = i) \
& = sum_(i >= k) p(1-p)^(i-1) \
& = p (1-p)^(k-1) + p (1-p)^(k) + p (1-p)^(k+1) + ... \
& = p (1-p)^(k-1)   (1 + (1-p) + (1-p)^2 + ...) \
& = p (1-p)^(k-1) sum_(j = 0)^(infinity) (1-p)^(j) \
& = (1-p)^(k-1) \
$
Plugging in @step-3-3 we get
$
law(k) & = prob(var_(1) >= k) prob( var_(2) >= k) - prob(var_(1) >= k+1) prob(var_(2) >= k+1) \ 
& = (1-p_(1))^(k-1)(1-p_(2))^(k-1) - (1-p_(1))^(k)(1-p_(2))^(k) \
& = (1-p_(1))^(k-1)(1-p_(2))^(k-1) [ 1 - (1-p_(1))(1-p_(2))]
$
Let $alpha = (1-p_(1))(1-p_(2)) $ and $beta = 1-alpha = p_(1) + p_(2) - p_(1)p_(2)$, so $law(k) = beta(1-beta)^(k-1)$, i.e. $Z follow geo(beta)$. 


////////////////



