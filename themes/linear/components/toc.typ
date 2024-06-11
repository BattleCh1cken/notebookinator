#import "../../../utils.typ"
#import "../entry-types.typ": *
/// Prints the table of contents.
///
/// *Example Usage*
/// ```typ
/// #create-frontmatter-entry(title: "Table of Contents")[
///   #components.toc()
/// ]
/// ```
#let toc = utils.make-toc((
  _,
  body,
  appendix,
) => {
  let previous-date

  let toc = stack(
    dir: ttb,
    spacing: 0.3em,
    ..for entry in body {
      let date-content = if entry.date == previous-date { } else {
        box(
          inset: 5pt,
          fill: white,
          entry.date.display("[day]/[month]/[year]"),
        )
      }

      previous-date = entry.date
      (
        [
          // Single line content
          #box(
            baseline: 0.35em,
            width: 5em,
          )[
            #set align(center)
            #date-content
          ]
          #h(1em)
          #box(
            fill: entry-type-metadata.at(entry.type),
            inset: (
              x: .4em,
              y: .6em,
            ),
            baseline: 25%,
          )[#entry.title #h(1.4em)]
          #h(1em)
          #box(
            width: 1fr,
            line(
              length: 100%,
              start: (
                0pt,
                -.35em,
              ),
            ),
          )
          #h(1em)
          #entry.page-number
        ],
      )
    },
  )

  let height = measure(toc).height

  box[
    #place(
      top + left,
      dx: 2.5em,
      dy: 1em,
      line(
        angle: 90deg,
        length: height - 12pt,
      ),
    )
    #toc
  ]
})
