#import "/utils.typ"

/// Prints the table of contents.
///
/// *Example Usage*
///
/// ```typ
/// #create-frontmatter-entry(title: "Table Of Contents")[
///   #components.toc()
/// ]
/// ```
/// -> content
#let toc = utils.make-toc((_, body, appendix) => {
  heading[Contents]
  stack(
    spacing: 0.5em,
    ..for entry in body {
      (
        [
          #entry.title
          #box(
            width: 1fr,
            line(
              length: 100%,
              stroke: (dash: "dotted"),
            ),
          )
          #entry.page-number
        ],
      )
    },
  )

  heading[Appendix]

  stack(
    spacing: 0.5em,
    ..for entry in appendix {
      (
        [
          #entry.title
          #box(
            width: 1fr,
            line(
              length: 100%,
              stroke: (
                dash: "dotted",
              ),
            ),
          )
          #entry.page-number
        ],
      )
    },
  )
})

/// Prints out the glossary.
///
/// *Example Usage*
///
/// ```typ
/// #glossary.add-term("Foo", lorem(10))
/// #glossary.add-term("Bar", lorem(5))
/// #components.glossary()
/// ```
/// -> content
#let glossary = utils.make-glossary(glossary => {
  stack(
    spacing: 0.5em,
    ..for entry in glossary {
      (
        [
          = #entry.word

          #entry.definition
        ],
      )
    },
  )
})

/// Prints a decision matrix table.
///
/// *Example Usage*
///
/// #example(
/// `components.decision-matrix(
///   properties: (
///     "Cat. 1", // weights will default to 1
///     "Cat. 2",
///     "Cat. 3",
///   ),
///   ("Choice 1", 4, 3, 2),
///   ("Choice 2", 1, 2, 3),
/// )`,
/// scale-preview: 100%
/// )
///
/// #example(
/// `components.decision-matrix(
///   properties: (
///     (name: "Flavor", weight: 2),
///     (name: "Crunch", weight: 1),
///   ),
///   ("Sweet Potato", 1, 2),
///   ("Baked Potato", 2, 1)
/// )
/// `,
/// scale-preview: 100%
/// )
/// - properties (array): A list of the properties that each choice will be rated by and the weight of each property
/// - ..choices (array): An array containing the name of the choices as its first member,
/// and values for each of the properties at its following indices
///
/// -> content
#let decision-matrix = utils.make-decision-matrix((properties, data) => {
  table(
    columns: for _ in range(properties.len() + 2) {
      (1fr,)
    },
    [],
    ..for property in properties {
      ([ *#property.name* ],)
    },
    [*Total*],
    ..for (index, choice) in data {
      let cell = if choice.total.highest {
        table.cell.with(fill: green)
      } else {
        table.cell
      }
      (
        cell[*#index*],
        ..for value in choice.values() {
          (cell[#value.weighted],)
        },
      )
    },
  )
})

/// Prints a pros and cons table.
///
/// *Example Usage*
///
/// #example(`components.pro-con(pros: lorem(10), cons: lorem(5))`, scale-preview: 100%)
///
/// #example(
/// `components.pro-con(
///  pros: [
///    #list(
///      "Sweet potato",
///      "Baked potato"
///    )
///  ],
///  cons: [
///    #list(
///      "Fries",
///      "Wedges"
///    )
///  ]
/// )
/// `, scale-preview: 100%)
/// - pros (content): The positive aspects
/// - cons (content): The negative aspects
/// -> content
#let pro-con = utils.make-pro-con((pros, cons) => {
  table(
    columns: (
      1fr,
      1fr,
    ),
    table.cell(fill: green)[*Pros*],
    table.cell(fill: red)[*Cons*],
    pros,
    cons,
  )
})
