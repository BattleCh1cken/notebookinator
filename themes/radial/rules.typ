#import "./format.typ"
#import "./colors.typ": *
#import "/utils.typ"

#let rules = utils.make-rules(doc => {
  set text(
    font: "Calibri",
    size: 11pt,
  )
  set page("us-letter")

  set footnote.entry(separator: none)

  // Enforce the correct font on Excalidraw drawings
  show image: it => [
    #align(center)[
      #set text(font: "Virgil 3 YOFF")
      #it
    ]
  ]

  show link: it => [
    #text(
      fill: blue,
      [ _ #it _ ],
    )
  ]

  show figure: it => align(center)[
    #it.body

    #if it.caption != none [
      _ #it.caption.body _
    ]
  ]

  set raw(theme: "./radial.tmTheme")
  show raw.where(block: false): format.raw-not-block
  show raw.where(block: true): it => format.raw-block(it)

  show heading: format.heading
  //show table: format.table

  // Display the whole document
  doc
})
