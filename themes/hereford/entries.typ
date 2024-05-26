#import "./colors.typ": *
#import "./format.typ": format-heading

#let entry-type-metadata = (
  identify: (
    color: red,
    text: "Identify",
  ),
  brainstorm: (
    color: orange,
    text: "Brainstorm",
  ),
  decide: (
    color: yellow,
    text: "Solution",
  ),
  build: (
    color: green,
    text: "Build",
  ),
  program: (
    color: blue,
    text: "Program",
  ),
  test: (
    color: purple,
    text: "Test",
  ),
  reflection: (
    color: pink,
    text: "Reflection",
  ),
  management: (
    color: brown,
    text: "Management",
  ),
  strategy: (
    color: gray,
    text: "Strategy",
  ),
)

#let heading-text-size = 14pt

#let cover(
  ctx: (:),
) = { }

#let frontmatter-entry(
  ctx: (:),
  body,
) = {
  show heading: it => format-heading(it, surface-0)
  show: page.with(
    margin: (
      top: 5em,
    ),
    header: {
      // background bar
      place(
        top + right,
        dx: 100pt,
        box(
          width: 250%,
          height: 100%,
          fill: surface-0,
        ),
      )
      // the other thing
      set align(center + horizon)
      box(
        radius: 0.3em,
        width: 200pt,
        outset: 9pt,
        fill: surface-1,
        text(
          size: heading-text-size,
          weight: "bold",
          ctx.title,
        ),
      )
    },
  )

  body
}

#let body-entry(
  ctx: (:),
  body,
) = {
  let metadata = entry-type-metadata.at(ctx.type)
  show heading: it => format-heading(it, metadata.color.lighten(60%))
  show: page.with(
    header: {
      // background bar
      place(
        top + left,
        dx: -100pt,
        box(
          width: 250%,
          height: 100%,
          fill: metadata.color.lighten(60%),
        ),
      )
      // edp box
      place(
        horizon + left,
        box(
          radius: 0.3em,
          outset: 9pt,
          width: 90pt,
          fill: metadata.color,
          align(
            center,
            text(
              size: 14pt,
              weight: "bold",
              metadata.text,
            ),
          ),
        ),
      )
      // title
      set align(center + horizon)
      text(
        weight: "bold",
        size: 14pt,
        ctx.title,
      )
    },
    footer: {
      place(
        dx: -50pt,
        box(
          fill: surface-0,
          width: 200%,
          height: 100%,
        ),
      )
      set align(horizon + center)
      grid(
        columns: (
          1fr,
          1fr,
          1fr,
        ),
        [*Name* #h(5pt) #ctx.author],
        [*Date* #h(5pt) #ctx.date.display("[month]/[day]/[year]")],
        [*Page* #h(5pt) #context counter(page).display()],
      )
    },
  )

  body
}

#let appendix-entry(
  ctx: (:),
  body,
) = {
  frontmatter-entry(
    ctx: ctx,
    body,
  )
}
