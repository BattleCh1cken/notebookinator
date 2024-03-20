#import "./metadata.typ": entry-types
#import "./colors.typ":*
#import "./format.typ": *

#let frontmatter-entry(context: (:), body) = {
  show: page.with(
    footer: align(center, counter(page).display()),
    background: place(rect(fill: gray, height: 100%, width: 15pt)),
  )

  body
}

#let body-entry(context: (:), body) = {
  let entry-data = entry-types.at(context.type)

  show: page.with(
    header: [
      #grid(
        columns: (1fr, 2fr, 1fr),
        [
          #set text(font: "Tele-Marines", weight: "bold")
          #context.team-name
        ], // TODO: get team name from from context
        [
          #set align(center)
          #context.season
          Engineering Notebook
        ],
        [
          #set align(right)
          #context.date.display("[month repr:long] [day padding:none], [year]")
        ],
      )
      #line(length: 100%, stroke: 0.5pt)
    ],
    footer: [
      #line(length: 100%, stroke: 0.5pt)
      #grid(
        columns: (1fr, 0.3fr, 1fr),
        [
          #set text(11pt)
          _All information in this document is property of team #context.team-name, unless
          otherwise stated_
        ],
        [
          #set align(center)
          #counter(page).display()
        ],
        [
          #set align(right)
          *Signature:* #context.author
          #linebreak()
          *Witness:* #context.witness
        ],
      )
    ],
    background: place[#rect(fill: entry-data.color, height: 100%, width: 15pt)],
  )

  block[
    #title(entry-data.color)[#context.title]
    #h(1fr)
    #title(entry-data.color)[#entry-data.title]
  ]

  show image: it => {
    box(stroke: 5pt + entry-data.color, radius: 1em, clip: true, it)
  }

  body
}

#let appendix-entry(context: (:), body) = {
  show: page.with(header: [ = Appendix header ], footer: [Appendix footer])

  body
}
