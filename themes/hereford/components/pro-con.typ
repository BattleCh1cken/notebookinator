#import "../colors.typ": *

#let pro-con(
  pros: [],
  cons: [],
) = {
  show grid.cell.where(
    y: 0,
    x: 0,
  ): it => rect(
    radius: 5pt,
    width: 100%,
    fill: pro-green,
    it,
  )
  show grid.cell.where(
    y: 0,
    x: 1,
  ): it => rect(
    radius: 5pt,
    width: 100%,
    fill: con-red,
    it,
  )

  grid(
    columns: (
      1fr,
      1fr,
    ),
    gutter: 5pt,
    inset: (
      x,
      y,
    ) => if y == 0 {
      2pt
    } else {
      (
        top: 10pt,
        rest: 5pt,
      )
    },
    row-gutter: -5pt,
    fill: (
      x,
      y,
    ) => if y == 0 {
      return
    } else if x == 0 {
      pro-green.lighten(50%)
    } else if x == 1 {
      con-red.lighten(50%)
    },
    align(center)[*Pros*],
    align(center)[*Cons*],
    pros,
    cons,
  )
}
