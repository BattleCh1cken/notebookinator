#import "/utils.typ"

#let toc() = utils.print-toc((
  _,
  body,
  _,
) => {
  set align(center)
  let line = table.vline(stroke: gray)
  table(
    stroke: none,
    columns: (
      1fr,
      1fr,
      2fr,
      1fr,
    ),
    [*Page \#*],
    line,
    [*EDP Step*],
    line,
    [*Entry Description*],
    line,
    [*Date*],
    line,
    ..for entry in body {
      (
        [#entry.page-number],
        [#entry.type],
        [#entry.title],
        [#entry.date.display("[month]/[day]/[year]")],
      )
    },
  )
})
