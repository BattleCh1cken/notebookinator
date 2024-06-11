#import "/lib.typ": *
#import themes.radial: radial-theme, components, colors
#import colors: *

#show: notebook.with(
  theme: radial-theme,
  team-name: "53E",
  season: "Over Under",
)

#create-frontmatter-entry(
  title: "test",
  type: "decide",
  date: datetime(year: 2024, month: 1, day: 1),
)[
  #components.toc()
]

#create-body-entry(
  title: "Title",
  type: "decide",
  date: datetime(year: 2024, month: 1, day: 1),
)[
  = Heading

  #lorem(20)

  #grid(
    columns: (1fr, 1fr),
    gutter: 20pt,
    lorem(40),
    components.pie-chart(
      (value: 8, color: green, name: "wins"),
      (value: 2, color: red, name: "losses"),
    ),
  )

  #lorem(23)

  = Heading

  #lorem(40)

  #components.decision-matrix(
    properties: (
      (name: "property 1", weight: 2),
      (name: "property 2", weight: 0.5),
      (name: "property 3", weight: 0.33),
      (name: "property 4", weight: 0.01),
    ),
    ("choice 1", 5, 2, 3, 4),
    ("choice 2", 1, 2, 3, 1),
    ("choice 3", 1, 3, 3, 2),
    ("choice 4", 1, 2, 3, 5),
    ("choice 5", 1, 2, 3, 1),
  )

  #lorem(20)

  #components.admonition(type: "decision")[#lorem(20)]

  = Heading

  ```cpp
  #include <iostream>

  int main() {
    printf("hello world\n")
    return 0;
  }
  ```

]

#create-body-entry(
  title: "Title",
  type: "test",
  date: datetime(year: 2024, month: 1, day: 1),
)[
  = Heading
  #lorem(20)
  #components.admonition(type: "note")[#lorem(50)]

  = Heading

  #lorem(20)

  #components.plot(
    title: "My Epic Graph",
    (name: "thing 1", data: ((1, 2), (2, 5), (3, 5))),
    (name: "thing 2", data: ((1, 1), (2, 7), (3, 6))),
    (name: "thing 3", data: ((1, 1), (2, 3), (3, 8))),
  )

  #grid(
    columns: (1fr, 1fr),
    gutter: 20pt,
    components.admonition(type: "warning")[#lorem(20)], lorem(20),
  )

]

#create-body-entry(
  title: "Title",
  type: "management",
  date: datetime(year: 2024, month: 1, day: 1),
)[
  = Heading

  #lorem(50)

  #align(
    center,
    components.pie-chart(
      (value: 2985, color: yellow, name: "Competitions"),
      (value: 3000, color: blue, name: "Travel"),
      (value: 2400, color: red, name: "Materials"),
    ),
  )

  #lorem(50)

  = Heading

  #components.gantt-chart(
    start: datetime(year: 2024, month: 1, day: 27),
    end: datetime(year: 2024, month: 2, day: 3),
    tasks: (
      ("Build Robot", (0, 4)),
      ("Code Robot", (3, 6)),
      ("Drive Robot", (5, 7)),
      ("Destroy Robot", (7, 8)),
    ),
    goals: (("Tournament", 4),),
  )

  #lorem(40)

  #components.admonition(type: "example")[#lorem(50)]

]
