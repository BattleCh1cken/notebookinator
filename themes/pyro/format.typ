#import "./colors.typ": *

#let title(color, body) = box(fill: color, inset: 9pt, radius: 5em)[
  #set text(fill: white, font: "Calibri", 12pt, weight: "bold")
  #body
]

#let rules(doc) = {
  doc
}

#let cover(context: (:)) = {
  grid(
    columns: (10em, 1fr),
    gutter: 20pt,
    rect(width: 100%, height: 100%, fill: red),
    grid(rows: (1fr, 1fr), [
      #set align(horizon)
      #set text(50pt, font: "Tele-Marines")
      #context.team-name
    ], [
      #set text(30pt, fill: red)
      Digital Engineering Notebook

      #set text(20pt, fill: black)
      #context.season
    ]),
  )
}
