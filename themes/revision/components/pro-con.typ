#import "../colors.typ": *

#let pro-con(pros: [], cons: []) = {
  table(
    columns: (50%, 50%),
    inset: 0.75em,
    fill: (col, row) => 
      if row == 0 {
        if col == 0 {
          green
        }
        if col == 1 {
          red
        } 
      },
    align(left)[Positives],
    align(left)[Negatives],
    pros,
    cons
  )
}