// ------------- Template -------------------------

#import "@preview/tidy:0.3.0"
#import "@preview/gentle-clues:0.6.0": *
#import "@preview/codly:0.2.0": *

#let show-module = tidy.show-module.with(
  show-outline: false,
  sort-functions: none,
  first-heading-level: 1,
)

#let def-arg(term, t, default: none, description) = {
  if type(t) == str {
    t = t.replace("?", "|none")
    t = `<` + t.split("|").map(s => {
      if s == "b" {
        `boolean`
      } else if s == "s" {
        `string`
      } else if s == "i" {
        `integer`
      } else if s == "f" {
        `float`
      } else if s == "c" {
        `coordinate`
      } else if s == "d" {
        `dictionary`
      } else if s == "a" {
        `array`
      } else if s == "n" {
        `number`
      } else {
        raw(s)
      }
    }).join(`|`) + `>`
  }

  stack(
    dir: ltr,
    [/ #term: #t \ #description],
    align(
      right,
      if default != none {
        [(default: #default)]
      },
    ),
  )
}

#set heading(numbering: "1.")

#show: codly-init.with()
#codly()

// ------------------ Document content -------------------------

#outline(title: none, indent: true, depth: 2)

= Template

#let template-module = tidy.parse-module(read("../../lib.typ"))
#show-module(template-module)

= Entries

#let entries-module = tidy.parse-module(read("../../entries.typ"))
#show-module(entries-module)

= Glossary

#let glossary-module = tidy.parse-module(read("../../glossary.typ"))
#show-module(glossary-module)

= Components

All of the components across each theme share the same API, so changing themes should be guaranteed to work.

#info[
  All of the examples show the default theme, other theme's components will look differently.
]

#import "/lib.typ": *
#import themes.default: default-theme, components

#let default-components-module = tidy.parse-module(
  read("../../themes/default/components.typ"),
  scope: (
    create-body-entry: create-body-entry,
    glossary: glossary,
    components: components,
  ),
)

#show-module(default-components-module)

= Utils

#let utils-module = tidy.parse-module(read("../../utils/misc.typ") + read("../../utils/theme.typ") + read("../../utils/components.typ"))

#show-module(utils-module)
