#import "./colors.typ": *
#import "./icons/icons.typ"
#import "./components/title.typ" as components
#import "/utils.typ"
#import "./metadata.typ": entry-type-metadata

// TODO: make an actual cover
#let cover = utils.make-cover(ctx => [
  #set align(center)
  *Radial Cover*
])

#let frontmatter-entry = utils.make-frontmatter-entry((ctx, body) => {
  show: page.with(
    header: components.title(ctx.title),
    footer: align(right, context counter(page).display("i")),
  )
  body
})

#let body-entry = utils.make-body-entry((ctx, body) => {
  let metadata = entry-type-metadata.at(ctx.type)
  show: page.with(
    header: components.title(
      beginning: image.decode(
        utils.change-icon-color(raw-icon: metadata.icon, fill: white),
        height: 1em,
      ),
      end: ctx.date.display("[year]/[month]/[day]"),
      color: metadata.color,
      ctx.title,
    ),
    footer: [
      #line(length: 100%)
      #align(
        left,
        [
          *Designed by:* #ctx.author #h(2pt) \
          *Witnessed by:* #ctx.witness
          #h(1fr) #context counter(page).display()
        ],
      )
    ],
  )
  body
})

#let appendix-entry = utils.make-appendix-entry((ctx, body) => {
  show: page.with(
    header: components.title(ctx.title),
    footer: align(right, context counter(page).display()),
  )

  body
})
