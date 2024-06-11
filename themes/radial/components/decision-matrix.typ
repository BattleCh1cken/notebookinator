#import "../colors.typ": *
#import "/utils.typ"

#let decision-matrix = utils.make-decision-matrix((properties, data) => {
  set align(center)

  let winning-row
  for (index, choice) in data.values().enumerate() {
    if choice.total.highest {
      winning-row = index + 2
    }
  }

  table(
    stroke: none,
    columns: properties.len() + 2,
    fill: (_, row) => {
      if row == winning-row { green }
      else if calc.odd(row) { surface-3 }
      else if calc.even(row) { surface-1 }
    },

    // Top line
    table.hline(stroke: (cap: "round", thickness: 2pt)),
    // Blank column to account for names of choices
    [],
    // Print out all the properties
    ..for property in properties {
      ([ *#property.name* ],)
    },
    // Last box in the row
    [*Total*],
    // Print out the data for each choice

    ..for (index, choice) in data {
      (
        [#index],
        ..for property in properties {
          let value = choice.at(property.name)
          ([#value.weighted],)
        },
        [#choice.total.weighted]
      )
    },

    //..for result in data {
      // Override the fill if the choice has the highest score
      //let cell = if choice.values.total.highest { cellx.with(fill: green) } else { cellx }
      //(cell[*#choice.name*], ..for value in choice.values {
        //(cell[#value.at(1).value],)
      //})
    //},
    // Bottom line
    table.hline(stroke: (cap: "round", thickness: 2pt)),
  )
})
