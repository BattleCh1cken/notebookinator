#import "/utils.typ"
#import "./format.typ": *
#import "./metadata.typ": *

#let toc() = utils.print-toc(
  (frontmatter, body, appendix) => {
    heading[Contents]

    stack(
      spacing: 1em,
      ..for entry in body {
        ([
          #let entry-data = entry-types.at(entry.type)
          #box(baseline: 25%)[#title(entry-data.color, entry.title)]
          #h(1em)
          #box(
            width: 1fr,
            line(length: 100%, start: (0pt, -.35em), stroke: (dash: "loosely-dotted")),
          )
          #h(1em)
          #entry.page-number

        ],)
      },
    )
  },
)
