#import "../colors.typ": *
#import "/packages.typ": cetz
#import "/utils.typ"

/// Creates a labeled pie chart.
///
/// Example Usage:
///
/// ```typ
/// #pie-chart(
///   (value: 8, color: green, name: "wins"),
///   (value: 2, color:  red, name: "losses")
/// )
/// ```
///
/// - ..data (dictionary): Each dictionary must contain 3 fields.
///   - value: `<integer>` The value of the section
///   - color: `<color>` The value of the section
///   - name: `<string>` The name of the section
/// -> content
#let pie-chart = utils.make-pie-chart(data => {
  let total
  let percentages = ()

  for value in data.pos() {
    total += value.value
  }

  for value in data.pos() {
    percentages.push(calc.round(value.value / total * 100))
  }

  cetz.canvas({
    import cetz.draw: *

    let chart(..values, name: none) = {
      let values = values.pos()
      let anchor-angles = ()

      let offset = 0
      let total = values.fold(0, (s, v) => s + v.value)

      let segment(from, to) = {
        merge-path(
          close: true,
          {
            stroke((paint: black, join: "round", thickness: 0pt))
            line((0, 0), (rel: (360deg * from, 2)))
            arc((), start: from * 360deg, stop: to * 360deg, radius: 2)
          },
        )
      }

      let chart = group(
        name: name,
        {
          stroke((paint: black, join: "round"))

          for v in values {
            fill(v.color)
            let value = v.value / total

            // Draw the segment
            segment(offset, offset + value)

            // Place an anchor for each segment
            let angle = offset * 360deg + value * 180deg
            anchor(v.name, (angle, 1.75))
            anchor-angles.push(angle)

            offset += value
          }
        },
      )

      return (chart, anchor-angles)
    }

    // Draw the chart
    let (chart, angles) = chart(..data, name: "chart")

    chart

    set-style(
      mark: (fill: white, start: "o", stroke: black),
      content: (padding: .1),
    )
    for (index, value) in data.pos().enumerate() {
      let anchor = "chart." + value.name
      let angle = angles.at(index)

      let (line-end, anchor-direction) = if angle > 90deg and angle < 275deg {
        ((-0.5, 0), "east")
      } else {
        ((0.5, 0), "west")
      }

      line(anchor, (to: anchor, rel: (angle, 0.5)), (rel: line-end))

      content((), [#value.name], anchor: "south-" + anchor-direction)
      content(
        (),
        [ #percentages.at(index)% ],
        anchor: "north-" + anchor-direction,
      )
    }
  })
})

/// Example Usage:
/// ```typ
/// #plot(
///   title: "My Epic Graph",
///   (name: "thingy", data: ((1,2), (2,5), (3,5))),
///   (name: "stuff", data: ((1,1), (2,7), (3,6))),
///   (name: "potato", data: ((1,1), (2,3), (3,8))),
/// )
/// ```
///
/// - title (string): The title of the graph
/// - x-label (string): The label on the x axis
/// - y-label (string): The label on the y axis
/// - ..data (dictionary):
/// -> content
#let plot = utils.make-plot((title, x-label, y-label, length, data) => {
  // The length of the whole plot is 8.5 units.
  let length = if length == auto {
    8.5%
  } else {
    length / 8.5
  }

  // Will be populated by the names of the rows of data, and their corresponding colors
  let legend = ()

  set align(center)
  cetz.canvas(
    length: length,
    {
      import cetz.draw: *
      import cetz.plot
      import cetz.palette

      // Style for the data lines
      let plot-colors = (blue, red, green, yellow, pink, orange)
      let plot-style(i) = {
        let color = plot-colors.at(calc.rem(i, plot-colors.len()))
        return (
          stroke: (thickness: 1pt, paint: color, cap: "round", join: "round"),
          fill: color.lighten(75%),
        )
      }

      set-style(axes: (
        grid: (
          stroke: (paint: luma(66.67%), dash: "loosely-dotted", cap: "round"),
          fill: none,
        ),
        tick: (stroke: (cap: "round")),
        stroke: (cap: "round"),
      ))

      plot.plot(
        name: "plot",
        plot-style: plot-style,
        size: (9, 5),
        axis-style: "left",
        x-grid: "both",
        y-grid: "both",
        {
          for (index, row) in data.pos().enumerate() {
            plot.add(row.data)
            legend.push((color: plot-colors.at(index), name: row.name))
          }
        },
      )

      content("plot.north", [*#title*])
      content((to: "plot.south", rel: (0, -0.5)), [#x-label])
      content((to: "plot.west", rel: (-0.5, 0)), [#y-label], angle: 90deg)
    },
  )

  // legend time
  for label in legend [
    #box(rect(fill: label.color, radius: 1.5pt), width: 0.7em, height: 0.7em)
    #label.name
    #h(10pt)
  ]
})
