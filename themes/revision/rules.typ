#let rules(doc) = {
  set text(font: "linux libertine", size: 12pt)
  set page("us-letter")

  // Enforce the correct font on Excalidraw drawings
  show image: it => [
    #align(center)[
      #set text(font: "Virgil 3 YOFF")
      #it
    ]
  ]
  
  doc
}