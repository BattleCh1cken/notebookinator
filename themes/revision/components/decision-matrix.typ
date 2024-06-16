#import "/utils.typ"
#import "/packages.typ": tablex
#import "../colors.typ": *
#import tablex: *

#let decision-matrix(properties: none, ..choices) = {
  let data = utils.calc-decision-matrix(properties: properties, ..choices)
  rect(inset: 0.5pt)[
    #table(
      stroke: (),
      inset: 0.75em,
      columns: properties.len() + 2,
      rows: auto,
      [],
      ..for property in properties {
        (align(center)[#property.name],)
      },
      align(center)[Total],
      ..for choice in data {
        if choice.values.total.highest {(
          table.cell(fill: green)[#align(center)[#choice.name]],
          ..for value in choice.values {(
            table.cell(fill: green)[#align(center)[#value.at(1).value]],
          )}
        ,)} else {(
          align(center)[#choice.name],
          ..for value in choice.values {(
              align(center)[#value.at(1).value],
          )}
        ,)}
      },
    )
  ]
}