#import "entry-types.typ": *
/// Formats the border lines
///
/// Example Usage:
///
/// ```typ
/// #set-border()
/// ```
#let set-border(type) = {
  let top-axis = -8.4% // The title line height
  let bottom-axis = 100% // The automatic bottom border

  // Adjusts top and bottom borders for frontmatter and appendix entries
  if (type == none) {
    top-axis = -6.6%
    bottom-axis = 106%
  }

  let left-axis = -8% // 8% less than the automatic left border (0%)
  let right-axis = 108% // 8% more than the automatic right border (100%)

  set line(stroke: 1.5pt)
  // Top left border
  place(line(start: (left-axis, top-axis), end: (0%, top-axis)))
  // Top right border
  place(line(start: (right-axis, top-axis), end: (100%, top-axis)))
  // Left border
  place(line(start: (left-axis, top-axis), end: (left-axis, bottom-axis)))
  // Right border
  place(line(start: (right-axis, top-axis), end: (right-axis, bottom-axis)))
  // Bottom border
  place(line(start: (left-axis, bottom-axis), end: (right-axis, bottom-axis)))
}

#let set-heading(it, type) = {
  show: block
  let color = entry-type-metadata.at(type)

  if it.level == 1 {
    set text(18pt)
  }
  if it.level == 2 {
    set text(15pt)
  }
  if it.level == 3 {
    set text(13pt)
  } else {
    set text(11pt)
  }

  set text(weight: "semibold")

  box(inset: 0.5em, fill: color)[#it.body]
  h(5pt)
  box(baseline: -10pt, width: 1fr, line(length: 100%))
}
