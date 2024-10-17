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

#show thm-selector("exercise-group", subgroup: "exercise"): it => box(
  it,
  stroke: black + 1pt,
  inset: 0.8em
)
////////////////////////

= Theory recap 11.9.24 - Probability on finite set

- _Jet set_ $jet =$  finite set of possible outcomes $outcome$

- _Probability_ on $jet = $  set of weights $prob(outcome) in bb(R)$ on each $outcome in jet$ such that
  - $prob(outcome) > 0 forall outcome in jet$
  - $sum_(outcome in jet) prob(outcome) = 1$

- _Event_ $event subset.eq jet = $ subset of the jet set

- _Complementary event_ $nevent = jet slash event$

- The cardinality of a set $S$ is denoted by $card(S)$

- _Uniform probability of the event $event$_
$ prob(event)
= sum_(outcome in event)prob(outcome)
= sum_(outcome in event) 1 / card(jet)
= card(event) / card(jet) $ 

$
prob(A union B) = prob(A) + prob(B) - prob(A sect B)
$ <prob-union>

- _Binomial theorem_
$
(x+y)^n = sum_(j=0)^n choose(n,j) x^(n-j)y^j
$ <binomial-theorem>

== Counting

- Number of _permutations_ of $k$ elements:
  - Number of ways to _order_ $k$ elements
  - *Only order matters*
$
perm(k) = 
fact(k)
$


- Number of _dispositions_ of $k$ elements out of $n$ $(k <= n)$:
  - Number of ways to _choose and order_ $k$ elements out of $n$
  - *Order and elements* matter
  - Number of injections $f from {1, dots, k} to {1, dots, n}  $

$
disp(n,k) = 
underbrace(n (n-1) dots, k "times") = n(n-1)dots(n-k+1) = fact(n)/fact((n-k))
$

- Number of _combinations_ of $k$ elements out of $n$ $(k <= n)$:
  - Number of ways to _choose_ $k$ elements out of $n$
  - *Only elements* matter
  - Number of subsets of cardinality $k$ of a set of cardinality $n$
  - Number of dispositions modulo number of permutations
$
comb(n,k) = 
disp(n,k) / perm(k) = fact(n) / ( fact(k) fact((n-k)) ) = choose(n,k) = "choose"(n,k)
$

#pagebreak()


#exercises[]


#exercise(name: "Handshakes and kisses")[

There are $f$ girls and $g$ boys in a room. Boys exchange handshakes, girs exchange kisses, boys and girls exchange kisses. How many kisses in total?
]


The number of kisses exchanegs among girls is the number of subsets of cardinality $2$ of a set of cardinality $f$, that is $choose(f,2) = f(f-1)/2$. Or, think that each girl gives $f-1$ kisses, and one needs a factor of one half to avoid double counting. 

For the number of kisses exchanged between boys and girls: the first girl gives $g$ kisses, the second girl gives $g$ kisses, and so on, so we have $f g$ in total.

$
"number of kisses" = f(f-1)/2 + f g
$

#exercise(name: "Throwing a dice")[
Throw a fair dice with $f$ faces $n$ times. What's the prob to never get the same result twice?
]
Let $#N = {1, dots, n}$ and $#F = {1, dots, f}$. The jet set is
$
jet = 
{outcome = (outcome_1, dots, outcome_n): outcome_i in #F "for all" i in #N}
= #F^n
$
with cardinality
$
card(jet) = card(#F^n) = card(#F)^n = f^n
$
The event we're looking at is
$
event = {outcome in jet: outcome_i != outcome_j "for all" i !=j  in #N }
$ <dice-event>
Clearly if $n > f$ then $prob(event) = 0$. Let $n <=f$. The (uniform) probability of the event $event$ is $prob(event) = card(event)/card(jet)$, with
$
card(event) 
& = "# of ways to choose and order " n "elements out of " f \
& = underbrace(f(f-1) dots, n) = f(f-1)dots(f-n+1) = fact(f)/fact((f-n))
$
$
prob(event) = fact(f)/(f^n fact((f-n)))
$

#exercise(name: "Birthday paradox")[
What is the probability that at least $2$ people out of $n$ have the same birthday? (Assume: uniform birth probability and year with $y$ number of days).
]
*Quick solution*
$
prob(event)
& = 1 - prob(underbrace("no two people have the same birthday", "Ex. 2")) \
& = 1 - fact(y)/(y^n fact((y-n)))
$ <birthday-prob>

*Formal solution*
Let $#N = {1, dots, n}$ and $#Y = {1, dots, y}$ with $n <= y$. The jet set is

$
jet
& = "distributions of possible birthdays of" n "people" \
& = {outcome = (outcome_1, dots, outcome_n): outcome_i in #Y "for all" i in #N}
= #Y^n
$
where $outcome_i$ is the birthday of the $i$-th person. The cardinality of the jet set is
$
card(jet) = card(#Y^n) = card(#Y)^n = y^n
$
The event we're looking at is
$
event = {outcome in jet: exists i != j in #N: outcome_i = outcome_j}
$
Note that this is the complementary event to the event defined in @dice-event of Exercise 2. Thus we can compute its probability as
$
prob(event) = 1 - prob(nevent)
$
in agreement with @birthday-prob.


#figure(
  image("birthday_paradox/birthday_paradox.png", width: 60%),
  caption: [
    Birthday paradox probability. #link("https://github.com/davidelegacci/probasim24/blob/main/birthday_paradox/birthday_paradox.py")[Code available.]
  ],
)

#exercise(name: "Same birthday as the prof")[
What is the probability that at least $1$ student out of $n$ has the same birthday of the prof?  (Assume: uniform birth probability and year with $y$ number of days). 
]
*Quick solution*
$
prob(event)
& = 1 - prob(underbrace("nobody has the prescribed birth date")) \
& = 1 - ((y-1)/y)^n
$ <prof-prob>

*Formal solution 1* As above $#N = {1, dots, n}$ and $#Y = {1, dots, y}$ with $n <= y$. The jet set is $jet = #Y^(n+1)$, that is the set of possible birthdays of $n+1$ people, the $(n+1)$-th being the prof. Its cardinality is $card(jet) = y^(n+1)$. The event we're looking at is
$
event = {outcome in jet: exists i in #N: outcome_i = outcome_(n+1)}
$
with complementary event
$
nevent = {outcome in jet: outcome_i != outcome_(n+1) forall i in #N}
$
As usual $prob(event) = 1 - prob(nevent) = 1 - card(nevent) / card(jet)$, with
$
card(nevent) = underbrace(y, "prof") dot underbrace((y-1)^n, "students")
$
So, $prob(event) = 1 - y(y-1)^n / y^(n+1) = 1 - ((y-1)/y)^n  $, in agreement with @prof-prob.

*Formal solution 2* Using the probability of the complementary event is often the smartest way to proceed, but for the sake of completeness let's see how to get the same result directly. Let $event_j$ be the event "exactly $j$ students out of $n$ have the same birthday as the prof". The event we look at then is
$
event = union.sq_(j in #N) event_j
$

with probability (cf @prob-union)
$
prob(event) 
= sum_(j in #N) prob(event_j)
= (sum_(j in #N) card(event_j))/card(jet)
$

The cardinality of $event_j$ is

$
card(event_j)
& = underbrace(1 dots 1, j" times") dot underbrace( (y-1) dots (y-1), n-j "times" ) dot underbrace(y, "prof") dot underbrace(choose(n,j), "number of ways to choose" j "elements out of" n) \
& = y (y-1)^(n-j)  choose(n,j)
$

By an application of the binomial theorem (@binomial-theorem) and a short manipulation, 

$ sum_(j = 1)^n card(event_j) = y(y^n - (y-1)^n) $

which leads back to @prof-prob.

