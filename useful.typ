// https://github.com/typst/typst/discussions/4031

#let appendix(body) = {
  set heading(numbering: "A", supplement: [Appendix])
  counter(heading).update(0)
  body
}

#show: appendix

= Useful stuff
Blah