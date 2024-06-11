#import "../colors.typ": *
#import "/utils.typ"

#let pro-con = utils.make-pro-con((pros, cons) => {
  table(
    columns: (50%, 50%),
    inset: 0.75em,
    fill: (col, row) => if row == 0 {
      if col == 0 {
        pro-green
      }
      if col == 1 {
        con-red
      }
    },
    align(
      center,
      text(size: 14pt, weight: "semibold", [Pros]),
    ),
    align(
      center,
      text(size: 14pt, weight: "semibold", [Cons]),
    ),
    pros,
    cons,
  )
})
