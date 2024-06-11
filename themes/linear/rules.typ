#import "format.typ": *
#import "/utils.typ"

#let rules = utils.make-rules(doc => {
  set text(
    font: "Blinker",
    size: 11pt,
  )
  doc
})
