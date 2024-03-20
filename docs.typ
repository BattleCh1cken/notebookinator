#import "./docs-template.typ": *
#import "./packages.typ": tidy, gentle-clues
#import gentle-clues: *

#let version = toml("/typst.toml").package.version
#let import-statement = "#import \"@preview/tidy:" + version + "\""

#show: docs-template.with(
  title: "The Notebookinator",
  subtitle: "Easy formatting for robotics notebooks.",
  abstract: [
    Welcome to the Notebookinator, a Typst package meant to simplify the notebooking
    process for the Vex Robotics Competition. Its theming capabilities handle all of
    the styling for you, letting you jump right into writing documentation.

    While it was designed with VRC in mind, it could just as easily be used for
    other competitor systems such as the First Robotics Competition and the First
    Tech Challenge.
  ],
  version: version,
  url: "https://github.com/BattleCh1cken/notebookinator",
)

#outline(indent: true, depth: 3)
#pagebreak(weak: true)

= Installation

#info[
  This installation process is temporary, as we wait for Typst to overhaul its
  process for packaging templates and packages.
]

The best way to install the Notebookinator is as a local package. Make sure you
have the following software installed on your computer:

- #link("https://github.com/casey/just#installation")[Typst]
- #link("https://github.com/casey/just#installation")[Git]
- #link("https://code.visualstudio.com/")[VSCode]
- #link("https://github.com/casey/just#installation")[just]

Once you've installed everything, simply run the following commands:

```bash
git clone https://github.com/BattleCh1cken/notebookinator
cd notebookinator
just install
```

#info[
  If you're running this on Windows, you'll need to run these commands in a sh
  shell, like git-bash or the shell packaged with Cygwin or GitHub Desktop.
]

= Basic Usage

Once the template is installed, you can import it into your project like this:

#raw(
  block: true,
  lang: "typ",
  "#import \"@local/notebookinator:" + version + "\": *",
)

Once you've done that you can begin to write your notebook:

```typ
#import themes.default: default-theme, components

#show: notebook.with(theme: default-theme)

#create-body-entry(title: "My Entry")[
 #lorem(200)
]
```

You can then compile your notebook with the Typst CLI:

```bash
typst compile your-notebook-file.typ
```

= API Reference

== Template

#let template-module = tidy.parse-module(read("lib.typ"))
#show-module(template-module)

== Entries

#let entries-module = tidy.parse-module(read("entries.typ"))
#show-module(entries-module)

== Glossary

#let glossary-module = tidy.parse-module(read("glossary.typ"))
#show-module(glossary-module)

== Additional Datatypes

=== Theme <theme>

Themes are stored as dictionaries with a set number of fields.

#def-arg(
  "rules",
  [`<function>`],
  default: none,
  [ The show and set rules that will be applied to the document ],
)
#def-arg(
  "cover",
  [`<function>`],
  default: none,
  [ A function that returns the cover of the notebook. Must take context as input. ],
)
#def-arg(
  "frontmatter-entry",
  [`<function>`],
  default: none,
  [ A function that returns a frontmatter entry. Must take context and body as
    input. ],
)
#def-arg(
  "body-entry",
  [`<function>`],
  default: none,
  [ A function that returns a body entry. Must take context and body as input. ],
)
#def-arg(
  "appendix-entry",
  [`<function>`],
  default: none,
  [ A function that returns a appendix entry. Must take context and body as input. ],
)

=== Context <context>

Provides information to a callback about how it's being called.

Context is stored as a dictionary with the following fields:

#def-arg("title", [`<string>`], default: none, [The title of the entry])
#def-arg(
  "type",
  [`<string>` or `<none>`],
  default: none,
  [The type of the entry. This value is used differently by different templates.
    Refer to the template level documentation to see what this means for your theme.],
)
#def-arg(
  "start-date",
  [`<datetime>`],
  default: none,
  [The date at which the entry started.],
)
#def-arg(
  "end-date",
  [`<datetime>`],
  default: none,
  [The date at which the entry ended.],
)
#def-arg(
  "page-number",
  [`<integer>` or `<none>`],
  default: none,
  [The page number of the first page of the entry. Only available while using the
  `print-toc()` utility function. ],
)

== Default Theme

The default theme.

#warning[
  This theme is very minimal, and is generally intended as a fallback for stuff
  that other themes don't implement. We recommend that you use one of the other
  more polished themes instead.
]

=== Required Fonts

This theme uses on the standard fonts packaged with Typst, so no further fonts
need to be installed.

=== Components

#let default-components-module = tidy.parse-module(read("./themes/default/components.typ"))
#show-module(default-components-module, first-heading-level: 3)

== Radial Theme

The Radial theme is a minimal theme focusing on nice, rounded corners.

You can change the look of body entries by changing their type. The following
types are available:

- `"identify"`: For entries about the identify stage of the engineering design
  process.
- `"brainstorm"`: For entries about the brainstorm stage of the engineering design
  process.
- `"decide"`: For entries about the decide stage of the engineering design
  process.
- `"build"`: For entries about the build stage of the engineering design process.
- `"program"`: For entries about the programming stage of the engineering design
  process.
- `"test"`: For entries about the testing stage of the engineering design process.
- `"management"`: For entries about team management
- `"notebook"`: For entries about the notebook itself

Minimal starting point:

```typ
// Import the template and theme here

#show: notebook.with(theme: radial-theme)

#create-frontmatter-entry(title: "Table of Contents")[
  #components.toc()
]

#create-body-entry(
  title: "Sample Entry", type: "identify", start-date: datetime(year: 1984, month: 1, day: 1),
)[

= Top Level heading

#lorem(20)

#components.admonition(type: "note")[
  #lorem(20)
]

#components.pro-con(pros: [
  #lorem(50)
], cons: [
  #lorem(20)
])

#components.decision-matrix(
  properties: ("Flavor", "Versatility", "Crunchiness"), ("Sweet Potato", 5, 3, 1), ("White Potato", 1, 2, 3), ("Purple Potato", 2, 2, 2),
)
]

#create-appendix-entry(title: "Glossary")[
  #components.glossary()
]

```

#let parse-modules(predicate, ..names) = {
  for name in names.pos() {
    read(predicate + name + ".typ")
  }
}

=== Required Fonts

This theme requires that the following fonts be installed on your computer:
- #link("https://www.freefonts.io/calibri-font/")[Calibri]

=== Components

#let raw-radial-module = parse-modules(
  "./themes/radial/components/",
  "toc",
  "glossary",
  "admonitions",
  "pro-con",
  "decision-matrix",
  "tournament",
  "graphs",
  "gantt-chart",
  "team",
  "label",
)

#let radial-module = tidy.parse-module(raw-radial-module)
#show-module(first-heading-level: 3, radial-module)

== Linear Theme

The Linear theme is a template that uses straight lines and boxes.

You can change the look of body entries by changing their type. The following
types are available:

- `"identify"`: For entries about the identify stage of the engineering design
  process.
- `"brainstorm"`: For entries about the brainstorm stage of the engineering design
  process.
- `"decide"`: For entries about the decide stage of the engineering design
  process/
- `"build"`: For entries about the build stage of the engineering design process.
- `"program"`: For entries about the programming stage of the engineering design
  process.
- `"test"`: For entries about the testing stage of the engineering design process

Minimal starting point:

```typ
#create-frontmatter-entry(title: "Table of Contents")[
  #components.toc()
]

#create-body-entry(title: "Day 1", type: "identify", date: datetime(year: 1984, month: 1, day: 1))[
  = Heading

  #lorem(50)

  #components.pro-con(
    pros: [
      #list(
        [Sweet potato],
        [Red potato],
        [Yellow potato]
      )
    ],
    cons: [
      #list(
        [Fries],
        [Wedges],
        [Mashed]
      )
    ]
  )
]

#create-body-entry(title: "Day 2", type: "identify", date: datetime(year: 1984, month: 1, day: 2))[
  = Another Heading

  #lorem(50)

  #components.decision-matrix(
    properties: (
      (name: "Lorem", weight: 2),
      (name: "Ipsum")
    ),
    ("Dolor", 1, 3),
    ("Sit", 2, 2),
    ("Amet", 3, 1)
  )

  == A Smaller Heading

  #lorem(50)
]

#glossary.add-term("Term 1")[
  #lorem(10)
]

#glossary.add-term("Term 2")[
  #lorem(10)
]

#create-appendix-entry(title: "Glossary")[
  #components.glossary()
]
```

=== Required Fonts

This theme requires that the following fonts be installed on your computer:
- #link("https://fonts.google.com/specimen/Blinker")[Blinker]

=== Components

#let raw-linear-module = parse-modules(
  "/themes/linear/components/",
  "decision-matrix",
  "pro-con",
  "glossary",
  "toc",
)

#let linear-module = tidy.parse-module(raw-linear-module)
#show-module(first-heading-level: 3, linear-module)

= Developer Documentation

== Project Architecture

The Notebookinator is split into two sections, the base template, and the
themes. The base template functions as the backend of the project. It handles
all of the information processing, keeps track of global state, makes sure page
numbers are correct, and so on. It exposes the main API that the user interacts
for creating entries and creating glossary entries.

The themes act as the frontend to the project, and are what the user actually
sees. The themes expose an API for components that need to be called directly
inside of entries. This could include things like admonitions, charts, and
decision matrices.

== File Structure

- `lib.typ`: The entrypoint for the whole template.
- `internals.typ`: All of the internal function calls that should not be used by
  theme authors or users.
- `entries.typ`: Contains the user facing API for entries, as well as the internal
  template functions for printing out the entries and cover.
- `glossary.typ`: Contains the user facing API for the glossary.
- `globals.typ`: Contains all of the global variables for the entire project.
- `utils.typ`: Utility functions intended to help implement themes.
- `themes/`: The folder containing all of the themes.
  - `themes.typ`: An index of all the themes are contained in the template
- `docs.typ`: The entry point for the project documentation.
- `docs-template.typ`: The template for the project documentation.

== Implementing Your Own Theme

The following section covers how to add a theme to the ones already in the
template. It only covers how to write the code, and not how to get it merged
into the main project. If you want to learn more about our contributing
guidelines, check our `CONTRIBUTING.MD` file in our GitHub.

=== Creating the Entry Point

This section of the document covers how to add your own theme to the template.
The first thing you'll have to do is create the entry point for your theme.
Create a new directory inside the `themes/` directory, then create a Typst
source file inside of that directory. For example, if you had a theme called
`foo`, the path to your entry point would look like this: `themes/foo/foo.typ`.

Once you do this, you'll have to add your theme to the `themes/themes.typ` file
like this:

```typ
#import `./foo/foo.typ`
```
Do not use a glob import, we don't want to pollute the namespace with the
functions in the theme.

=== Implementing Theme Functions

Next you'll have to implement the functions contained inside the theme. These
functions are all called internally by the template. While we recommend that you
create implementations for all of them, if you omit one the template will fall
back on the default theme.

The first functions you should implement are the ones that render the entries.
You'll need three of these, one for each type of entry (frontmatter, body, and
appendix).

Each of these functions must take a context parameter, and a body parameter. The
context parameter provides important information, like the type of entry, and
the date it was written at. The body parameter contains the content written by
the user.

// TODO: document the context data type

The template expects that each of these functions returns a `#page()` as
content.

Here's a minimal example of what these functions might look like:

```typ
#let frontmatter-entry(context: (:), body) = {
  show: page.with(
    header: [ = Frontmatter header ],
    footer: counter(page).display("i")
  )

  body
}
```

```typ
#let body-entry(context: (:), body) = {
  show: page.with(
    header: [ = Body header ],
    footer: counter(page).display("1")
  )

  body
}
```

```typ
#let appendix-entry(context: (:), body) = {
  show: page.with(
    header: [ = Appendix header ],
    footer: counter(page).display("i")
  )

  body
}
```

Next you'll have to define the rules. This function defines all of the global
configuration and styling for your entire theme. This function must take a doc
parameter, and then return that parameter. The entire document will be passed
into this function, and then returned. Here's and example of what this could
look like:

```typ
#let rules(doc) = {
  set text(fill: red) // Make all of the text red

  doc // Return the entire document
}
```

Then you'll have to implement a cover. The only required parameter here is a
context variable, which stores information like team number, game season and
year.

Here's an example cover:

```typ
#let cover(context: (:)) = [
  #set align(center)
  *Foo Cover*
]
```

=== Defining the Theme

// TODO: create a theme type documentation thingy
Once you define all of your functions you'll have to actually define your theme.
The theme is just a dictionary which stores all of the functions that you just
defined.

The theme should be defined in your theme's entry point (`themes/foo/foo.typ`
for this example).

Here's what the theme would look like in this scenario:

```typ
#let foo-theme = (
  // Global show and set rules
  rules: rules,

  cover: cover,

  // Entry pages
  frontmatter-entry: frontmatter-entry,
  body-entry: body-entry,
  appendix-entry: appendix-entry
)
```

=== Creating Components

With your base theme done, you may want to create some additional components for
you to use while writing your entries. This could be anything, including graphs,
tables, Gantt charts, or anything else your heart desires.

// TODO: define a standard set of components that themes should implement.

== Utility Functions

#let utils-module = tidy.parse-module(read("utils.typ"))
#show-module(utils-module)
