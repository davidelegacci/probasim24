#import "@preview/lemmify:0.1.5": *

#let (
   theorem, lemma, corollary,
   remark, proposition, example,
   proof, definition, rules: thm-rules
) = default-theorems("thm-group", lang: "en")


#let (exercises, rules: exs-rules) = new-theorems("exercises-group", ("exercises": text(15pt, red)[Exercises]))
#let exercises = exercises.with(numbering: none)

#let (exercise, rules: ex-rules) = new-theorems("exercise-group", ("exercise": text[Exercise]), thm-numbering: thm-numbering-heading.with(max-heading-level: 1))

#let (takeaway, rules: ta-rules) = new-theorems("takeaway-group", ("takeaway": text[Tip]), thm-numbering: thm-numbering-heading.with(max-heading-level: 1))
#let takeaway = takeaway.with(numbering: none)
