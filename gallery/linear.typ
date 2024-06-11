#import "../lib.typ": *
#import themes.linear: linear-theme
#import themes.linear.components

#show: notebook.with(
  theme: linear-theme,
  team-name: "53C",
  season: "Over Under",
  year: "2023-2024",
)

#create-frontmatter-entry(title: "Color Coding Guide")[
  This key represents each step of the Engineering Design Process with a color that corresponds to the Engineering Notebooking Rubric categories. In the table of contents, each page is assigned to a color which summarizes the content on that page. However, if a page highlights multiple sections of the Engineering Design Process, headings on the page will be colored accordingly.

  #grid(
    columns: (1fr, 5fr),
    gutter: 10pt,
    // Row 1
    square(size: 1in, fill: components.dark-red),
    align(horizon,
    [
      #set text(size: 14pt)
      Identify the Problem

      #set text(size: 12pt)
      Identifies the game and robot design challenges in detail at the start of each design process cycle with words and pictures. States the goals for accomplishing the challenge.
    ]),
    // Row 2
    square(size: 1in, fill: components.dark-yellow),
    align(horizon,
    [
      #set text(size: 14pt)
      Brainstorm, Diagram, or Prototype Solutions

      #set text(size: 12pt)
      Lists three or more possible solutions to the challenge with labeled diagrams. Citations provided for ideas that came from outside sources such as online videos or other teams.
    ]),
    // Row 3
    square(size: 1in, fill: components.dark-green),
    align(horizon,
    [
      #set text(size: 14pt)
      Select the Best Solution and Plan

      #set text(size: 12pt)
      Explains why the solution was selected through testing and/or a decision matrix. Fully describes the plan to implement the solution.
    ]),
    // Row 4
    square(size: 1in, fill: components.dark-blue),
    align(horizon,
    [
      #set text(size: 14pt)
      Build the Solution

      #set text(size: 12pt)
      Records the steps to build the solution. Includes enough detail that the reader can follow the logic used by the team to develop their robot design, as well as recreate the robot design from the documentation.
    ]),
    // Row 5
    square(size: 1in, fill: components.dark-purple),
    align(horizon,
    [
      #set text(size: 14pt)
      Program the Solution

      #set text(size: 12pt)
      Records the steps to program the solution. Includes enough detail that the reader can follow the logic used by the team to develop their robot code, as well as recreate the robot code from the documentation.
    ]),
    // Row 6
    square(size: 1in, fill: components.dark-pink),
    align(horizon,
    [
      #set text(size: 14pt)
      Test the Solution

      #set text(size: 12pt)
      Records all the steps to test the solution, including test results.
    ]),
    // Row 7
    square(size: 1in, fill: components.surface-4),
    align(horizon,
    [
      #set text(size: 14pt)
      Reflect on Prior Solutions

      #set text(size: 12pt)
      Evaluates the decisions and mistakes made in the past to better prepare and overcome challenges in the future.
    ])
  )
  We also wanted to create a new category: Reflect on Prior Solutions. We believe this is an important step in the Engineering Design Process and we want to highlight our reflections using our color coding guide.
]

#create-frontmatter-entry(title: "Table of Contents")[
  #components.toc()
]

#create-body-entry(
  title: "Title",
  type: "identify",
  date: datetime(year: 1111, month: 11, day: 1),
)[
  = Heading 1
  #lorem(50)
  #grid(
    columns: (1fr, 1fr),
    gutter: 15pt,
    lorem(30),
    align(
      center + horizon,
      image("../logo.png"),
    ),
  )
  == Subheading 1
  #components.pro-con(
    pros: [
      #list(
        [#lorem(10)],
        [#lorem(12)],
        [#lorem(15)],
      )
    ],
    cons: [
      #list(
        [#lorem(12)],
        [#lorem(10)],
      )
    ],
  )
  == Subheading 2
  #components.decision-matrix(
    properties: (
      (name: "Category 1"),
      (name: "Category 2"),
      (name: "Category 3", weight: 2),
    ),
    ("Decision", 3, 1, 4),
    ("Matrix", 2, 3, 5),
  )
  = Heading 2
  ```cpp
  #include <iostream>
  #include <cstdio>

  int main() {
    printf("Hello world!");

    return 0;
  }
  ```
]

#create-body-entry(
  title: "Title",
  type: "brainstorm",
  date: datetime(year: 1111, month: 11, day: 2),
)[]
#create-body-entry(
  title: "Title",
  type: "brainstorm",
  date: datetime(year: 1111, month: 11, day: 2),
)[]
#create-body-entry(
  title: "Title",
  type: "brainstorm",
  date: datetime(year: 1111, month: 11, day: 2),
)[]
#create-body-entry(
  title: "Title",
  type: "brainstorm",
  date: datetime(year: 1111, month: 11, day: 2),
)[]
#create-body-entry(
  title: "Title",
  type: "decide",
  date: datetime(year: 1111, month: 11, day: 3),
)[]
#create-body-entry(
  title: "Title",
  type: "build",
  date: datetime(year: 1111, month: 11, day: 3),
)[]
#create-body-entry(
  title: "Title",
  type: "build",
  date: datetime(year: 1111, month: 11, day: 3),
)[]
#create-body-entry(
  title: "Title",
  type: "build",
  date: datetime(year: 1111, month: 11, day: 3),
)[]
#create-body-entry(
  title: "Title",
  type: "program",
  date: datetime(year: 1111, month: 11, day: 3),
)[]
#create-body-entry(
  title: "Title",
  type: "program",
  date: datetime(year: 1111, month: 11, day: 3),
)[]
#create-body-entry(
  title: "Title",
  type: "test",
  date: datetime(year: 1111, month: 11, day: 4),
)[]
#create-body-entry(
  title: "Title",
  type: "test",
  date: datetime(year: 1111, month: 11, day: 4),
)[]
#create-body-entry(
  title: "Title",
  type: "build",
  date: datetime(year: 1111, month: 11, day: 5),
)[]
#create-body-entry(
  title: "Title",
  type: "build",
  date: datetime(year: 1111, month: 11, day: 5),
)[]
#create-body-entry(
  title: "Title",
  type: "brainstorm",
  date: datetime(year: 1111, month: 11, day: 5),
)[]
#create-body-entry(
  title: "Title",
  type: "brainstorm",
  date: datetime(year: 1111, month: 11, day: 5),
)[]
#create-body-entry(
  title: "Title",
  type: "decide",
  date: datetime(year: 1111, month: 11, day: 5),
)[]
#create-body-entry(
  title: "Title",
  type: "program",
  date: datetime(year: 1111, month: 11, day: 5),
)[]
#create-body-entry(
  title: "Title",
  type: "test",
  date: datetime(year: 1111, month: 11, day: 5),
)[]

#glossary.add-term("Lorem")[
  #lorem(10)
]

#glossary.add-term("Ipsum")[
  #lorem(25)
]

#glossary.add-term("Dolor")[
  #lorem(11)
]

#glossary.add-term("Sit")[
  #lorem(5)
]

#create-appendix-entry(title: "Glossary")[
  #lorem(50)
  #components.glossary()
]