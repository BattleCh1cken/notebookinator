#import "colors.typ": *
#import "components/header.typ": header-map

#let frontmatter-entry(ctx: (:), body) = {
  show: page.with(
    paper: "us-letter",
    margin: (y: 90pt),
    header: align(center)[
      #text(size:24pt)[#upper(ctx.title)] \
      #line(length: 100%)
    ],
    footer: grid(
      rows: (10pt, auto),
      columns: (auto, auto, auto),
      column-gutter: 10pt,
      row-gutter: 10pt,
      align(horizon+right)[#line(length: 100%)],
      align(top)[#context(counter(page).display("I"))],
      align(horizon+left)[#line(length: 100%)],
      if (ctx.type != "toc") {
        align(left)[#text(weight: "bold")[Authors:]]
      } else {[]},
      [],
      if (ctx.date != none) {
        align(right)[#text(weight: "bold")[Date:] #ctx.date.display("[month]/[day]/[year]")]
      } else {[]}
    )
  )
  body
}

#let body-entry(ctx: (:), body) = {
  show: page.with(
    paper: "us-letter",
    margin: (y: 90pt),
    header: 
      if ctx.type != none {
        align(center)[
          #text(size:24pt)[#upper(header-map.at(ctx.type))] \
          #grid(
            rows: 10pt,
            columns: (auto, auto, auto),
            column-gutter: 10pt,
            align(horizon+right)[#line(length: 100%)],
            align(top)[#ctx.title],
            align(horizon+left)[#line(length: 100%)]
          )
        ]
      } else {
        align(center)[
          #text(size:24pt)[#upper(ctx.title)] \
          #line(length: 100%)
        ]
      },
    footer: grid(
      rows: (10pt, auto),
      columns: (auto, auto, auto),
      column-gutter: 10pt,
      row-gutter: 10pt,
      align(horizon+right)[#line(length: 100%)],
      align(top)[#context(counter(page).display())],
      align(horizon+left)[#line(length: 100%)],
      align(left)[#text(weight: "bold")[Authors:]],
      [],
      align(right)[#text(weight: "bold")[Date:] #ctx.date.display("[month]/[day]/[year]")]
    )
  )
  context(if calc.even(here().position().at("page")) and ctx.type != none {
    place(left + top, dx: -35pt, dy: -33.5pt)[
      #box(fill: color-map.at(ctx.type), height: 100% + 66pt, width: 5%)[
        #align(horizon)[
          #rotate(90deg, origin : center, reflow: true)[
            #upper(header-map.at(ctx.type))#v(40%)
          ]
        ]
      ]
    ]   
  } else if ctx.type != none {
    place(right + top, dx: 35pt, dy: -33.5pt)[
      #box(fill: color-map.at(ctx.type), height: 100% + 66pt, width: 5%)[
        #align(horizon)[
          #rotate(90deg, origin : center, reflow: true)[
            #v(40%)#upper(header-map.at(ctx.type))
          ]
        ]
      ]
    ]
  })
  body
}

#let appendix-entry(ctx: (:), body) = {
  show: page.with(
    paper: "us-letter",
    margin: (y: 90pt),
    header: align(center)[
      #text(size:24pt)[#upper(ctx.title)] \
      #line(length: 100%)
    ],
    footer: grid(
      rows: (10pt, auto),
      columns: (auto, auto, auto),
      column-gutter: 10pt,
      row-gutter: 10pt,
      align(horizon+right)[#line(length: 100%)],
      align(top)[#context(counter(page).display("I"))],
      align(horizon+left)[#line(length: 100%)],
      align(left)[#text(weight: "bold")[Authors:]],
      [],
      if (ctx.date != none) {
        align(right)[#text(weight: "bold")[Date:] #ctx.date.display("[month]/[day]/[year]")]
      } else {[]}
    )
  )
  body
}

#let cover(ctx: (:)) = [
  #set align(center)
  #text(size: 26pt)[ \ \ \ \
    == ENGINEERING NOTEBOOK
  ]
]