#import "/utils.typ"

#let glossary = utils.make-glossary(glossary => {
  stack(
    dir: ttb,
    spacing: 15pt,
    ..for entry in glossary {
      (
        [
          #box(
            inset: 0.5em,
            fill: gray,
          )[== #entry.word]
          #h(5pt)
          #box(
            baseline: -10pt,
            width: 1fr,
            line(length: 100%),
          )

          #entry.definition
        ],
      )
    },
  )
})
