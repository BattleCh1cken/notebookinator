#import "/globals.typ"

/// A constructor for a table of contents component.
///
/// *Example Usage:*
/// ```typ
/// #let toc = utils.make-toc((frontmatter, body, appendix) => {
///   for entry in body [
///     #entry.title
///     #box(width: 1fr, line(length: 100%, stroke: (dash: "dotted")))
///     #entry.page-number
///   ]
/// })
/// ```
/// - callback (function): A function which returns the content of the toc. The function must take `frontmatter`, `body`, and `appendix` arguments.
/// -> function
#let make-toc(callback) = {
  let helper(type) = {
    let (state, markers) = if type == "frontmatter" {
      (
        globals.frontmatter-entries,
        query(
          selector(<notebook-frontmatter>),
        ),
      )
    } else if type == "body" {
      (
        globals.entries,
        query(
          selector(<notebook-body>),
        ),
      )
    } else if type == "appendix" {
      (
        globals.appendix-entries,
        query(
          selector(<notebook-appendix>),
        ),
      )
    } else {
      panic("No valid entry type selected.")
    }

    let result = ()

    for (index, entry) in state.final().enumerate() {
      let page-number = counter(page).at(
        markers.at(index).location(),
      ).at(0)
      let ctx = entry.ctx
      ctx.page-number = page-number
      result.push(ctx)
    }
    return result
  }

  return () => context {
    let frontmatter-entries = helper("frontmatter")
    let body-entries = helper("body")
    let appendix-entries = helper("appendix")

    callback(
      frontmatter-entries,
      body-entries,
      appendix-entries,
    )
  }
}

/// Constructor for a glossary component
///
/// *Example Usage:*
/// ```typ
/// #let glossary = utils.make-glossary(glossary => {
///   stack(
///     spacing: 0.5em,
///     ..for entry in glossary {
///       (
///         [
///           = #entry.word
///
///           #entry.definition
///         ],
///       )
///     },
///   )
/// })
/// ```
/// - callback (function): A function that returns the content of the glossary. The function must take a `glossary` argument.
/// -> function
#let make-glossary(callback) = {
  return () => context {
    let sorted-glossary = globals.glossary-entries.final().sorted(key: (
      (word: word, definition: definition),
    ) => word)
    callback(sorted-glossary)
  }
}

/// Constructor for a pro / con component
///
/// *Example Usage:*
/// ```typ
/// #let pro-con = utils.make-pro-con((pros, cons) => {
///   table(
///     columns: (
///       1fr,
///       1fr,
///     ),
///     table.cell(fill: green)[*Pros*],
///     table.cell(fill: red)[*Cons*],
///     pros,
///     cons,
///   )
/// })
/// ```
///
/// - callback (function): A function that returns the content of the pro / con table. The function must take `pros` and `cons` arguments.
/// -> function
#let make-pro-con(callback) = {
  return (pros: [], cons: []) => {
    callback(pros, cons)
  }
}

/// Constructor for a decision matrix
///
/// *Example Usage:*
/// ```typ
/// #let decision-matrix = utils.make-decision-matrix((properties, data) => {
///   // ...
/// })
/// ```
/// - callback (function): A function that returns the content of the matrix. The function must `properties` and `data` arguments.
/// -> function
#let make-decision-matrix(callback) = {
  return (properties: (), ..choices) => {
    // ensure the properties are passed in correctly
    //
    // this variable tracks whether the user
    // is using the alternate mode of passing in arguments,
    // where each property is a str instead of a dictionary
    let alternate-format = false
    for property in properties {
      if type(property) == str {
        alternate-format = true
      } else {
        assert(
          not alternate-format,
          message: "Property should be of type 'str'",
        )

        if property.at("weight", default: none) == none {
          property.insert("weight", 1)
        }

        assert.eq(type(property.name), str)
        assert(type(property.weight) == float or type(property.weight) == int)
      }
    }

    // ensure the choices are passed in correctly
    for choice in choices.pos() {
      for (index, rating) in choice.enumerate() {
        if index == 0 {
          assert.eq(type(rating), str)
          continue
        }

        assert(
          type(rating) == int or type(rating) == float,
          message: "Values for decision matrices must be of type 'float' or 'int'",
        )
      }

      assert.eq(
        choice.len() - 1,
        properties.len(),
        message: "The number of supplied values did not match the number of properties.",
      )
    }

    // the calculation should only need to parse data in one format,
    // so if the user passed in the alternate, format we'll just convert it to the standard one
    properties = if alternate-format {
      properties.map(property => (name: property, weight: 1))
    } else {
      properties
    }

    // now we can actually calculate the data
    let data = (:)

    for (index, choice) in choices.pos().enumerate() {
      let name = choice.at(0)

      let values = choice.slice(1)
      let unweighted-total = values.sum()

      let weighted-values = values.enumerate().map((
        (index, value),
      ) => value * properties.at(index).at(
        "weight",
        default: 1,
      ))
      let weighted-total = weighted-values.sum()

      let property-data = (:)

      for (index, property) in properties.enumerate() {
        property-data.insert(
          property.name,
          (
            unweighted: values.at(index),
            weighted: weighted-values.at(index),
            highest: false,
          ),
        )
      }

      property-data.insert(
        "total",
        (
          unweighted: unweighted-total,
          weighted: weighted-total,
          highest: false,
        ),
      )

      data.insert(
        name,
        property-data,
      )
    }

    // now that we've filled in all of the data, we can calculate which choice won

    // we're going to treat total like another property for the sake of calculating if it won
    properties.push((name: "total"))

    for property in properties {
      let highest = ( // Records the index of the choice which had the highest total
        index: 0,
        value: 0,
      )

      for (index, choice) in data {
        let property-value = choice.at(property.name).weighted
        if property-value > highest.value {
          highest.index = index
          highest.value = property-value
        }
      }
      data.at(highest.index).at(property.name).highest = true
    }
    properties.pop()


    return callback(properties, data)
  }
}

/// A constructor for an admonition component.
///
/// *Example Usage:*
/// ```typ
/// #let admonition = utils.make-admonition((type, body) => {
///   //..
/// }
/// ```
/// - callback (function): A function that returns the content for the admonition. The function must take `type` and `body` arguments.
///   Valid types include:
///   -  `"note"`,
///   -  `"example"`,
///   -  `"warning"`,
///   -  `"quote"`,
///   -  `"equation"`,
///
///    -  `"identify"`,
///   -  `"brainstorm"`,
///   -  `"decide"`,
///   -  `"decision"`, // DEPRECATED
///   -  `"build"`,
///   -  `"program"`,
///   -  `"test"`,
///   -  `"management"`,
///   -  `"notebook"`,
///
/// -> function
#let make-admonition(callback) = {
  let valid-types = (
    "note",
    "example",
    "warning",
    "quote",
    "equation",

    "identify",
    "brainstorm",
    "decide",
    "decision",
    "build",
    "program",
    "test",
    "management",
    "notebook",
  )

  let valid-types-printable = valid-types.fold(
    "",
    (
      base,
      value,
    ) => {
      base + " '" + value + "'"
    },
  )

  return (type: none, body) => {
    if not valid-types.contains(type) {
      panic("Entry type '" + str(type) + "' is not valid. Valid types include:" + valid-types-printable)
    }

    callback(
      type,
      body,
    )
  }
}

/// A constructor for a pie chart component
///
/// *Example Usage:*
///
/// ```typ
/// #let pie-chart = utils.make-pie-chart(data => {
///   // ...
/// })
/// ```
/// - callback (function): A function that returns the content for the pie chart. The function must take a `data` argument.
/// -> function
#let make-pie-chart(callback) = {
  return (..data) => {
    callback(data)
  }
}

/// A constructor for a plot component
///
/// *Example Usage:*
/// ```typ
/// #let plot = utils.make-plot((title, x-label, y-label, length, data) => {
///   // ...
/// })
/// ```
///
/// - callback (function): A function that returns the content for the plot.
///   The function must take `title`, `x-label`, `y-label`, `length`, and `data` arguments.
/// -> function
#let make-plot(callback) = {
  return (title: "", x-label: "", y-label: "", length: auto, ..data) => {
    callback(title, x-label, y-label, length, data)
  }
}

// TODO: add method for these extra components:
// - gantt chart
// - tournament
// - team
