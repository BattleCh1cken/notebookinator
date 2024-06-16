#import "/utils.typ"
#import "/themes/revision/colors.typ": *
#import "header.typ": header-map

#let toc() = utils.print-toc((frontmatter, body, appendix) => {
  let last-page = 0
  let previous-color
  
  stack(
    spacing: none,
    [#heading(level: 1)[ENTRIES]#v(1em)],
    [#grid(
      rows: 1em,
      columns: (1fr, 10fr, 2fr),
      align(center)[PAGE],
      align(center)[SUBJECT],
      align(center)[DATE]
    )],
    ..for entry in body {
      if entry.at("page-number") - last-page > 1 {
        for i in range(entry.at("page-number") - last-page - 2) {
          ([#table(
            stroke: (luma(120) + 0.5pt),
            rows: (18pt),
            columns: (1fr, 10fr, 2fr),
            align(center)[#(last-page + i + 1)],
          align(horizon)[#place(dx: 35pt)[#rect(height: 18.5pt, width: 1pt, fill: black, stroke: 0pt)]],
          []
          )],)
        }
        let i = entry.at("page-number") - last-page -1
        ([#table(
          stroke: (luma(120) + 0.5pt),
          rows: (18pt),
          columns: (1fr, 10fr, 2fr),
          align(center)[#(last-page + i + 1)],
          align(horizon)[#place(dx: 35pt, dy: -4.25pt)[#rect(height: 10pt, width: 1pt, fill: black, stroke: 0pt)#place(center)[#rotate(180deg)[#polygon.regular(size: 5pt, fill: black)]]]],
          []
        )],)
      }
      ([#table(
        stroke: (luma(120) + 0.5pt),
        rows: (18pt),
        columns: (1fr, 10fr, 2fr),
        align(center)[#entry.at("page-number")],
        if entry.at("type") != none {
          previous-color = color-map.at(entry.at("type"))
          align(left)[#highlight(fill: previous-color, radius: 2pt, extent: 2pt)[
            #header-map.at(entry.at("type"))] #h(2pt)$->$ #entry.at("title")]
        } else {
          align(left)[#entry.at("title")]
        },
        align(center)[#entry.at("date").display("[month]/[day]/[year]")]
      )],)

      last-page = entry.at("page-number")
    },
    [#v(2em) #heading(level: 1)[APPENDIX] #v(1em)],
    [#grid(
      rows: 1em,
      columns: (1fr, 10fr, 2fr),
      align(center)[PAGE],
      align(center)[SUBJECT],
      align(center)[DATE]
    )],
    ..for entry in appendix {
      ([#table(
        stroke: (luma(120) + 0.5pt),
        rows: (18pt),
        columns: (1fr, 10fr, 2fr),
        align(center)[#numbering("I", entry.at("page-number"))],
        align(left)[#entry.at("title")],
        align(center)[#entry.at("date").display("[month]/[day]/[year]")]
      )],)
    }
  )
})