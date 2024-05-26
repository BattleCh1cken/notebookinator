#import "/utils.typ"
#import "../colors.typ": *

#let decision-matrix(
  properties: none,
  ..choices,
) = {
  let data = utils.calc-decision-matrix(
    properties: properties,
    ..choices,
  )

  //repr(data)

  let winning-column
  for (
    index,
    result,
  ) in data.enumerate() {
    if result.values.total.highest == true {
      winning-column = index + 2
      break
    }
  }

  let table-height = properties.len() + 2
  let table-length = choices.pos().len() + 2

  import table: hline, vline, cell
  show cell: it => {
    set align(center + horizon)
    box(
      height: 30pt,
      it,
    )
  }
  table(
    columns: for _ in range(choices.pos().len() + 2) {
      (
        1fr,
      )
    },
    stroke: none,
    fill: (
      x,
      y,
    ) => {
      if y == 0 or (
        x == 0 and not y == properties.len() + 1
      ) {
        yellow.lighten(50%)
      }

      if x == winning-column and not y == 0 {yellow.lighten(50%)}
    },

    // we make lines

    vline(stroke: yellow, end: table-height - 1),
    hline(stroke: yellow),

    ..for num in range(0, table-height) {
      let stroke = if num < 2 {yellow} else {gray}
      (hline(y: num, stroke: stroke, start: 2),)
    },

    hline(stroke: gray, y: table-height, start: 1),

    ..for num in range(1, table-height + 2) {
      (
        vline(x: num, stroke: yellow, start: 0, end: 1),
        vline(x: num, stroke: gray, start: 1),
      )
    },

    // outline the properties
    ..for num in range(0, table-height) {
      (hline(y: num, stroke: yellow, start: 0, end: 1),)
    },



    // outline the weights
    hline(stroke: pro-green, start: 1, end: 2),
    hline(y: table-height - 1, stroke: pro-green, start: 1, end: 2),
    vline(x: 1, stroke: pro-green, end: table-height - 1),
    vline(x: 2, stroke: pro-green, end: table-height - 1),

    ..for num in range(0, table-height) {
      (hline(y: num, stroke: pro-green, start: 1, end: 2),)
    },


    // outline the best choice
    hline(start: winning-column, end: winning-column + 1, stroke: yellow),
    vline(x: winning-column, stroke: yellow),
    vline(x: winning-column + 1, stroke: yellow),
    hline(y: table-height, start: winning-column, end: winning-column + 1, stroke: yellow),

    ..for num in range(0, table-height + 1) {
      (hline(y: num, stroke: yellow, start: winning-column, end: winning-column + 1),)
    },


    // ok we're done making lines


    [],
    cell(fill: pro-green.lighten(50%))[*Weights*],
    ..for choice in choices.pos() {
      (
        [*#choice.at(0)*],
      )
    },
    ..for (
      index,
      property,
    ) in properties.enumerate() {
      (
        [*#property.name*],
        table.cell(fill: pro-green.lighten(50%))[#property.weight],
        ..for result in data {
          (
            [#result.values.values().at(index).value],
          )
        },
      )
    },
    [],
    [*Totals:*],
    ..for (
      index,
      result,
    ) in data.enumerate() {
      (
        [#result.values.at("total").value],
      )
    },
  )
}
