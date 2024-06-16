#import "/utils.typ"

#let glossary() = utils.print-glossary(glossary => {
  stack(
    spacing: 2em,
    dir: ttb,
    [#grid(
      rows: 1em,
      columns: (25%, 75%),
      
      align(left)[TERM],
      align(left)[DEFENITION],
    )],
    ..for entry in glossary {
      ([
        #grid(
          columns: (25%, 75%),
          rows: auto,
          [=== #entry.word],
          [#entry.definition]
        )
      ],)
    }
  )
})
