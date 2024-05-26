#import "./colors.typ": *

#let format-heading(
  it,
  color,
) = {
  if it.level == 1 {
    set text(size: 13pt)
    set block(spacing: 1em)
    block(
      radius: 0.3em,
      outset: 7pt,
      width: 100%,
      fill: color,
      it.body,
    )
  } else {
    set text(size: 12pt)
    it
  }
}

#let rules(
  doc,
) = {
  set page(
    "us-letter",
    margin: (
      top: 2cm,
      x: 1.5cm,
      bottom: 1.5cm,
    ),
  )
  set text(
    font: "Roboto",
    size: 11pt,
  )

  doc
}
