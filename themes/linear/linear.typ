#import "/utils.typ"

#let rules(doc) = {
  doc
}

#let cover(context: (:)) = [
  #set align(center)
  *Linear Cover*
]

#let toc() = {
  utils.print_toc(context => [
    #context.title
    #box(width: 1fr, line(length: 100%, stroke: (dash: "dotted")))
    #context.page_number
  ])

  utils.print_toc(type: "appendix", context => [
    #context.title
    #box(width: 1fr, line(length: 100%, stroke: (dash: "dotted")))
    #context.page_number
  ])
}

#let frontmatter_entry(context: (:), body) = {
  show: page.with(header: [ = Frontmatter header ], footer: [Frontmatter footer])

  body
}

#let body_entry(context: (:), body) = {
  show: page.with(header: [ = Body header ], footer: [Body footer])

  body
}
#let appendix_entry(context: (:), body) = {
  show: page.with(header: [ = Appendix header ], footer: [Appendix footer])

  body
}

#let default_theme = (
  // Global show rules
  rules: rules, cover: cover,
  // Entry pages
  frontmatter_entry: frontmatter_entry, body_entry: body_entry, appendix_entry: appendix_entry,
)