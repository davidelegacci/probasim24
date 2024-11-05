#let jet = $Omega$
#let points = $jet$ // set of all events
#let point = $omega$ // sample point in set of all events
#let outcome = $omega$ // alias



#let R = $bb(R)$ // real numbers
#let Rinf = $hat(#R)$ // real numbers
#let clint = $[0,1]$ // closed interval
#let posR = $#(R)_(>=0)$ // non-negative real numbers
#let event = $A$ // event
#let altevent = $B$ // other event
#let events = $cal(event)$ // sigma algebra, tribu, on Omega
#let comp(x) = $#x^c$ // complementary event
#let eventalt = $altevent$ //alias
#let nevent = $comp(event)$ // complementary event
#let meas = $mu$ // measure
#let dist = $mu$ // probability distribution
#let law = $dist$ // probability distribution
#let prob = $P$ // probability measure
#let probspace = $(jet, events, prob)$
#let ex = $bb(E)$

#let given = $bar.v$ // for conditional probability

#let pof(x) = $prob(#x)$
#let probof(x) = $pof(#x)$ // alias
#let exof(x) = $ex[#x]$
#let conex(x,y) = $exof(#x given #y)$
#let conexf(f, x, y) = $exof( #f ( #x , #y) given #y )$

#let card(x) = $|#x|$ // cardinality of finite set
#let fact(x) = $#x!$ // factorial
#let perm(k) = $P_#k$ // number of permutations
#let disp(n,k) = $D_(#n,#k)$ // number of dispositions
#let comb(n,k) = $C_(#n,#k)$ // number of combinations
#let choose(n,k) = $binom(#n,#k)$ // chose




#let et = $,$ // set theoretical and, intersection
#let from = $:$
#let to = $arrow$
#let mapsto = $arrow.r.long.bar$
#let im = $"Im"$ // image
#let implies = $arrow.r.double$
#let iff = $arrow.l.r.double$

#let var = $X$ // random variable
#let Var = $"Var"$ // variance
#let varalt = $Y$ // random variable
#let val = $x$ // value of random variable
#let lval = $a$ // low value of random variable
#let hval = $b$ // high value of random variable
#let intev = ${lval < var <= hval}$ // interval event



#let func = $f$ // generic function
#let xvar = $X$ // random variable
#let xval = $x$ // value
#let xvals = $F$ // value
#let rvals = $#R$ // real values
#let pdfvals= $#R _(>=0)$ // non-negative reals
#let dimvals = $n$ // dimension of vector values
#let vectorvals = $#R^(dimvals)$ // vector values
#let vecxvals = $#R^(dimvals_(1))$ // vector values
#let vecyvals = $#R^(dimvals_(2))$ // vector values
#let openvals = $D$ // open in vector values
#let openev = ${var in openvals}$ // open event


#let yvar = $Y$ // random variable
#let yval = $y$ // value
#let yvals = $G$ // value
#let yfunc = $g$ // 

#let xev = $xvar = xval$ // event {X = x}
#let yev = $yvar = yval$ // event {Y = y}

#let pdf = $rho$ // probability density
#let cum = $F$ // cumulative distribution
#let cdf = $cum$ // alias

#let iid = "I.I.D."


#let follow = $tilde$

#let values = $F$ // value of random variable
#let bvalues = $ {0,1}$ // Bernoulli values


#let N = $cal(N)$

#let bern = $cal(B)$
#let poiss = $cal(P)$
#let geo = $cal(G)$

#let unipdf = $cal(U)$
#let expdf = $cal(E)$
#let norpdf = $cal(N)$
#let norex = $mu$
#let norvar = $sigma^(2)$

#let F = $cal(F)$
#let Y = $cal(Y)$

#let naturals = $bb(N)$
#let posnat = $naturals^(ast)$


#let run = $i$

#let rate = $lambda$

#let ind = $bb(1)$ // indicator function

#let indof(foo) = $ind_{foo}$

#let conv = $ast$



#let dx = $d x$
#let dy = $d y$
