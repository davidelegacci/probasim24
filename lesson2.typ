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

// Box around exercises
#show thm-selector("exercise-group", subgroup: "exercise"): it => box(
  it,
  stroke: black + 1pt,
  inset: 0.8em
)

// Reset exercises counter
#show: tail => thm-reset-counter-heading-at("exercise-group", 1, tail)
////////////////////////

= Theory recap 18.9.24

== Conditional probability

- _Conditional probability_

$
prob(event given altevent) = prob(event sect altevent) / prob(altevent) "if" prob(B) != 0
$ <cond-prob-1>

- not reallty defined if $prob(altevent) = 0$, cf @billingsleyProbabilityMeasure2012 pag. 427. 
- often used as
$
prob(event sect altevent) = prob(event given altevent) prob(altevent)
$ <cond-prob-2>
- Conditional probability and complementary event (proof: simple exercise.)
$ 
prob(event given eventalt) + prob(nevent given eventalt) = 1
$ <eq:prob-conditional-complementary> 
- _Total probability theorem_
$ prob(event) = prob(event given altevent) prob(altevent) + prob(event given comp(altevent)) prob(comp(altevent)) $
- _Bayes theorem_
$ prob(event sect eventalt) = prob(eventalt sect event) implies prob(event given altevent) prob(altevent) = prob(altevent given event) prob(event) $
See #link("https://github.com/davidelegacci/probasim24/blob/main/Bayes/bayes.ipynb")[this notebook] for an example of Bayes theorem in action.



== Independent events
Let $jet$ be equipped with a probability $prob$.
- two events $event, eventalt subset.eq jet$ are said _independent_ if
$
prob(event sect eventalt) = prob(event) prob(eventalt)
$
- $n$ events $event_1, dots, event_n$ are said _independent_ if
$
prob(sect_(i in I) event_i) = product_(i in I) prob(event_i) "for all" I subset.eq {1, dots, n}
$
- pairwise independence does not imply independence of all events!

#exercises[]



#exercise(name: "Pile ou Face")[
Jet de 2 pieces, $jet={"PP", "PF", "FP", "FF"}$. Cet espace est muni de la probabilite uniforme.
Soient les evenements:
- $A="1ere piece donne P"$
- $B="2eme piece donne F"$
- $C="le deux pieces donnent le meme resultat"$
Questions:
- $A$ et $B$ sont indépendantes?
- $A, B$ et $C$ sont indépendants?
]


#figure(
  image("figs/pileface.png", width: 60%),
  caption: [
    Pairwise independence does not imply independence of all events!
  ],
)


#exercise(name: "Pieces mecaniques defectueuses")[
Parmi 10 pièces mécaniques, 4 sont déefectueuses. On prend successivement deux pièces au hasard dans le lot (sans remise). Quelle est la probabilité pour que les deux pièces soient correctes?]



*Solution 1*
Let $event_i$ be the event _the i-th drawn piece is good_, with $i in {1,2}$. We need the probability of the event $event_2 sect event_1$. By definition of conditional probavility,
$
prob(event_2 sect event_1) = underbrace(prob(event_2 given event_1), 5/9) underbrace(prob(event_1), 6/10) = 1/3.
$

*Solution 2*
The jet set is the set of subsets of cardinality $2$ of a set of cardinality $10$, so $card(jet) = choose(10,2)$. The event we consider is the set of subsets of cardinality $2$ of a set of cardinality $6$, so $card(event) = choose(6,2)$. Then 
$
prob(event) = choose(6,2) / choose(10,2) = (6 dot 5) / (10 dot 9) = 1/3.
$

#exercise(name: "Betting on cards")[
We have three cards:
- a _red_ card with both faces red;
- a _white_ card with both faces white;
- a _mixed_ card with a red face and a white face.

One of the three cards is drawn at random and
one of the faces of this card (also chosen at random) is exposed.
This face is red.
You are asked to bet on the color of the hidden face. Do you choose red or white?
]



*Intuitive solution*
The cards are $R R, R W, W W$ with $W$ for white and $R$ for red. Call $R R$ the "red" card, $W W$ the "white" card, and $W R$ the "mixed" card. Since we observe a red face, the white card cannot be on the table. There are three possibilities left: 1.  we're observing a face of the red card (in which case the hidden face is red); 2.  we are observing the other face of the red card (in which case the hidden face is red); 3. we are observing the red face of the mixed card (in which case the hidden face is white). So the hidden face is red $2$ out of $3$ times. 

*Formal solution*
The jet set contains the possible outcomes of a sequence of two events: 1. draw a card (out of three), and 2. observe a face (out of two). Denote by $R$ a red face and by $W$ a white face, and denote by a subscript $o$ the observed face, and by a subscript $h$ the hidden face. The possible outcomes then are
$
jet = {R_h sect  R_o, R_h sect  W_o, W_h sect  R_o, W_h sect  W_o}
$ where the first entry indicates the hidden face, and the second entry indicates the observed face. For example, $W_h sect R_o$ is the event "_the hidden face is white and the observed face is red_", and similarly for the others.

In this formulation, every element in the jet set is the intersection of two (dependent) events of the type 1. a face is hidden, and 2. a face is observed. Note that the event $W_h sect R_o$ is equivalent to the event "_the mixed card is drawn, and the red face is observed._" Under this second point of view, each outcome in $jet$ is the intersection of two (dependent) events of the type 1. a card is drawn, and 2. a face is observed. Denoting the event _"draw the red card"_ by $r$, the event _"draw the white card"_ by $w$, and the event  _"draw the mixed card"_ by $m$, the jet set is equivalently

$
jet = {r sect R_o, m sect W_o, m sect R_o, w sect W_o}
$
This formulation helps to understand that the probability on $jet$ *is not uniform*. The probabilities of the events in $jet$ are computed by @cond-prob-2:

$
prob(R_h sect R_o) = prob(r sect R_o) = prob(r given R_o) / R_(o)
$
However, we do not know the probabilities on the right hand side. As a simple trick, remember that $prob(event sect eventalt) = prob(eventalt sect event)$, so we can turn this around:

$
prob(R_h sect R_o)
& = prob(R_o sect r) \
& = underbrace(P(R_(o) given r),1)underbrace(P(r), 1/3) = 2/6 
$

$
prob(R_(h) sect W_(o))
& = prob(W_(o) sect m) \
& = underbrace(P(W_(o) given m ),1/2)underbrace(P(m), 1/3) = 1/6 
$

$
prob(W_(h) sect R_(o))
& = prob(R_(o) sect m) \
& = underbrace(P(R_(o) given m),1/2)underbrace(P(m), 1/3) = 1/6 
$

$
prob(W_(h) sect W_(o))
& = prob(W_(o) sect w) \
& = underbrace(P(W_(o) given w),1)underbrace(P(w), 1/3) = 2/6 
$

Now by @cond-prob-1 and using these probabilities,

$
prob(W_(h) given R_(o) )
& = prob(W_(h) sect R_(o)) / prob(R_(o)) \
& = prob(W_(h) sect R_(o)) / ( prob(R_(h) sect R_(o)) + prob(W_(h) sect R_(o)) ) = 1 / 3
$

$
prob(R_(h) given R_(o))
& = prob(R_(h) sect R_(o)) / prob(R_(o)) \
& = prob(R_(h) sect R_(o)) / (prob(R_(h) sect R_(o)) + prob(W_(h) sect R_(o))) = 2 / 3 \
& = 1 - prob(W_(h) given R_(o))
$
where the last line follows from @eq:prob-conditional-complementary and gives directly the answer. So in conclusion, given the fact that we observe a red face, the hidden face is also red with probability $2 slash 3$.

#exercise(name: "Russian roulette")[
You are playing two-person Russian roulette with a revolver featuring a rotating cylinder with six bullet slots. Each time the gun is triggered, the cylinder rotates by one slot. Two bullets are inserted one next to the other into the cylinder, which is then randomly positioned. Your opponent is the first to place the revolver against her temple. She presses the trigger and... she stays alive. With great display of honor, she offers you to rotate the barrel again at random before firing in turn. What do you decide?
]



The bullets occupy the positions $x$ and $x+1$ $mod 6$:
$
jet = {12, 23, 34, 45, 56, 61}
$
Say the revolver shots from position $1$. The event "_the first player dies_" is 
$
"die"_1 = {12, 61}
$
so $prob("die"_1) = 1/3$ and  $prob("live"_1) = 2/3$. We need to compute
$
prob("die"_2 given "live"_1) = prob("die"_2 sect "live"_1) / prob("live"_1)
$
Since the cylynder rotates after being triggered we have
$"die"_2 = {56, 61}$ and $"die"_2 sect "live"_1 = {56}$, so $prob("die"_2 given "live"_1) = 1/6 slash 2/3 = 1/4 < P("die"_1) $. So you don't shuffle the barrel.