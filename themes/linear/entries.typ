#import "format.typ": *
#import "./colors.typ": *
#import "/utils.typ"

#let cover = utils.make-cover(ctx => {
  v(50pt)

  line(
    length: 100%,
    stroke: 2pt,
  )
  h(5pt)
  rect(
    inset: 30pt,
    fill: surface-0,
    width: 100%,
  )[
    #grid(
      columns: (1fr, 3fr),
      gutter: 2fr,
      [
        #set text(72pt)
        #ctx.team-name
      ],
      align(
        right,
        [
          #set text(20pt)
          #ctx.season

          Engineering Design Notebook
        ],
      ),
    )
  ]
  h(5pt)
  line(
    length: 100%,
    stroke: 2pt,
  )

  place(
    center + bottom,
    dy: -50pt,
    [
      #set text(20pt)
      #box(
        width: 150pt,
        stroke: (
          top: white,
          bottom: white,
          left: black,
          right: black,
        ),
        ctx.year,
      )
    ],
  )
})

#let frontmatter-entry = utils.make-frontmatter-entry((
  ctx,
  body,
) => {
  show: page.with(header: {
    set text(size: 25pt)
    set line(stroke: 1.5pt)
    set align(center + horizon)
    grid(
      columns: (1fr, auto, 1fr),
      line(length: 100%),
      {
        h(20pt)
        ctx.title
        h(20pt)
      },
      line(length: 100%),
    )
  })

  set-border(ctx.type)

  body
})

#let body-entry = utils.make-body-entry((
  ctx,
  body,
) => {
  show: page.with(
    margin: (top: 88pt),
    header: {
      set text(size: 30pt)
      set line(stroke: 1.5pt)

      set align(center + horizon)
      grid(
        columns: (1fr, auto, 1fr),
        line(length: 100%),
        {
          h(20pt)
          box(
            fill: entry-type-metadata.at(ctx.type),
            outset: 10pt,
            ctx.title,
          )
          h(20pt)
        },
        line(length: 100%),
      )
    },
    footer: {
      grid(
        columns: (2fr, 2fr, 1fr),
        [Written by: #h(10pt) #ctx.author],
        [Witnessed by: #h(10pt) #ctx.witness],
        align(
          right,
          box(
            fill: surface-1,
            outset: 8pt,
            context counter(page).display(),
          ),
        ),
      )
    },
  )
  set-border(ctx.type)

  show heading: it => {
    set-heading(
      it,
      ctx.type,
    )
  }

  show raw.where(block: false): box.with(
    fill: surface-1,
    inset: (
      x: 4pt,
      y: 0pt,
    ),
    outset: (
      x: 0pt,
      y: 4pt,
    ),
  )
  show raw.where(block: true): block.with(
    fill: surface-1,
    inset: 8pt,
    width: 100%,
  )

  body
})

#let appendix-entry = utils.make-appendix-entry((
  ctx,
  body,
) => {
  show: page.with(header: [
    #set text(size: 25pt)
    #set line(stroke: 1.5pt)

    #align(
      center + horizon,
      grid(
        columns: (
          1fr,
          auto,
          1fr,
        ),
        line(length: 100%),
        [
          #h(20pt)
          #ctx.title
          #h(20pt)
        ],
        [
          #line(length: 100%)
        ],
      ),
    )
  ])

  set-border(ctx.type)

  body
})
