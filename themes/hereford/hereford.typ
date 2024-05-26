#import "./format.typ": rules
#import "./entries.typ": cover, frontmatter-entry, body-entry, appendix-entry
#import "./components/components.typ"
#import "./colors.typ"

#let hereford-theme = (
  // Global show and set rules
  rules: rules,
  cover: cover,
  // Entry pages
  frontmatter-entry: frontmatter-entry,
  body-entry: body-entry,
  appendix-entry: appendix-entry,
)
