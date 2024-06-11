#import "../colors.typ": *
#import "/utils.typ"

#let decision-matrix = utils.make-decision-matrix((properties, data) => {
  let title-cell(body) = table.cell(
    fill: surface-2,
    inset: 0.8em,
    text(size: 13pt, body),
  )

  let body-cell(total: false, highest: none, body) = table.cell(
    fill: if highest == none {
      white
    } else if highest {
      pro-green
    } else {
      white
    },
    inset: 0.8em,
    text[#body],
  )

  let table-height = data.len() + 2
  let table-width = properties.len() + 2

  set table.cell(align: center + horizon)
  table(
    stroke: none,
    columns: for _ in range(properties.len() + 2) {
      (1fr,)
    },

    // draw the lines for the graph

    // draw vertical lines
    table.vline(start: 1, end: table-height - 1),
    ..for num in range(1, table-width + 1) {
      (table.vline(x: num, end: table-height - 1),)
    },

    // draw horizontal lines
    table.hline(start: 1),
    ..for num in range(1, table-height) {
      (table.hline(y: num),)
    },

    // draw weight lines
    ..for num in range(0, table-width) {
      (table.vline(stroke: gray, x: num, start: table-height - 1, end: table-height),)
    },
    table.hline(stroke: gray,y: table-height, end: table-width - 1),


    // draw the actual graph

    // title row
    [],
    ..for property in properties {
      (title-cell(property.name),)
    },
    title-cell[Total],

    // score rows
    ..for (index, result) in data {
      (
        [#index],
        ..for property in properties {
          let value = result.at(property.name)
          (body-cell(highest: value.highest, value.weighted),)
        },
        body-cell(highest: result.total.highest, result.total.weighted)
      )
    },

    // weights row
    text(fill: gray)[Weight],
    ..for property in properties {
      (body-cell[
        #property.at("weight", default: 1)x
      ],)
    },
  )
})
