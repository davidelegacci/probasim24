//////////////////////////////////////////////////////////
// SETUP
//////////////////////////////////////////////////////////

#set heading(numbering: "1.")

#set math.equation(numbering: "(1)")
#set page(numbering: "1")
#show link: underline

//////////////////////////////////////////////////////////
// TITLE
//////////////////////////////////////////////////////////

#let title = [
#link("https://github.com/jonatha-anselmi/INFO4-PS")[Probabilité et Simulation]
]

#let subtitle = [
PolyTech INFO4 (Grenoble) – 2024-2025 – Practical Sessions
]

#align(center, text(17pt)[
  *#title*
])

#align(center, text(12pt)[
  *#subtitle*
])

#let today = datetime.today()
#align(right, [
Last updated: #today.display(). Info: davide.legacci`@`univ-grenoble-alpes.fr
])


//////////////////////////////////////////////////////////
// BODY
//////////////////////////////////////////////////////////

#include "lesson1.typ"

#include "lesson2.typ"

#include "lesson3.typ"

#include "lesson4.typ"

#include "lesson5.typ"

// #include "useful.typ"

//////////////////////////////////////////////////////////
// BIBLIO
//////////////////////////////////////////////////////////

#bibliography("probasim.bib")