#import "rules.typ": rules
#import "entries.typ": cover, frontmatter-entry, body-entry, appendix-entry
#import "format.typ": set-margins, set-heading
#import "components.typ": set-toc, set-glossary
#import "colors.typ": *

#let linear-theme = (
  // Global show rules
  rules: rules,
  cover: cover,
  // Entry pages
  frontmatter-entry: frontmatter-entry,
  body-entry: body-entry,
  appendix-entry: appendix-entry,
)
