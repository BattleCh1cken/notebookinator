#import "./icons/icons.typ"
#import "./colors.typ": *

// These should really be with their respective files, but that causes a cyclic import error, so I put them here.

// @typstyle off
#let entry-type-metadata = (
  "identify": (icon: icons.question-mark, color: yellow),
  "brainstorm": (icon: icons.light-bulb, color: orange),
  "decide": (icon: icons.target, color: blue),
  "build": (icon: icons.hammer, color: red),
  "program": (icon: icons.terminal, color: purple),
  "test": (icon: icons.flask, color: green),
  "management": (icon: icons.bar-chart, color: surface-4),
  "notebook": (icon: icons.page, color: pink),
)

// @typstyle off
#let admonition-type-metadata = (
  "note": (icon: icons.pencil, color: green, title: "Note"),
  "warning": (icon: icons.warning, color: red, title: "Warning"),
  "example": (icon: icons.web, color: purple, title: "Example"),
  "quote": (icon: icons.quotes, color: gray, title: "Quote"),
  "equation": (icon: icons.function, color: orange, title: "Equation"),
  "decision": (icon: icons.target, color: blue, title: "Final Decision"),
  "build": (icon: icons.hammer, color: red, title: "Build Complete"),
)
