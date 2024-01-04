#import "./docs-template.typ": *

#import "@preview/tidy:0.1.0"

#let version = toml("/typst.toml").package.version
#let import-statement = "#import \"@preview/tidy:" + version + "\""

#show: docs-template.with(
  title: "The Notebookinator", subtitle: "Easy formatting for robotics notebooks.", abstract: [
    Welcome to the Notebookinator, a Typst package meant to simplify the notebooking
    process for the Vex Robotics Competition. Its theming capabilities handle all of
    the styling for you, letting you jump right into writing documentation.

    While it was designed with VRC in mind, it could just as easily be used for
    other competitor systems such as the First Robotics Competition and the First
    Tech Challenge.
  ], version: version, url: "https://github.com/BattleCh1cken/notebookinator",
)

#outline(indent: true, depth: 3)
#pagebreak(weak: true)

= Installation

The best way to install the Notebookinator is as a local package. Make sure you
have the following software installed on your computer:

- Typst
- Git
- VSCode

Once you have those, find the matching command for you operating system, and
then run it:

*Linux:*
```bash
git clone https://github.com/BattleCh1cken/notebookinator \
~/.local/share/typst/packages/local/
```

*MacOS:*
```zsh
git clone https://github.com/BattleCh1cken/notebookinator \
~/Library/Application Support/typst/packages/local/
```

*Windows:*
// FIXME: find the correct syntax highlighting for powershell
```pwsh
git clone https://github.com/BattleCh1cken/notebookinator %APPDATA%\typst\packages\local\
```

= Basic Usage

Once the template is installed, you can import it into your project like this:

```typ
#import "@local/notebookinator": *
```
Once you've done that you can begin to write your notebook:
```typ
#import themes.default: default_theme, components

#show: notebook.with(theme: default_theme)

#create_body_entry(title: "My Entry")[
  #lorem(200)
]
```

You can then compile your notebook with the Typst CLI:
```bash
typst compile your_notebook_file.typ
```

= API Reference

== Template

#let template_module = tidy.parse-module(read("lib.typ"))
#show-module(template_module)

== Entries

#let entries_module = tidy.parse-module(read("entries.typ"))
#show-module(entries_module)

== Glossary

#let glossary_module = tidy.parse-module(read("glossary.typ"))
#show-module(glossary_module)

== Additional Datatypes

=== Theme <theme>

Themes are stored as dictionaries with a set number of fields.

#def-arg(
  "rules", [`<function>`], default: none, [ The show and set rules that will be applied to the document ],
)
#def-arg(
  "cover", [`<function>`], default: none, [ A function that returns the cover of the notebook. Must take context as input. ],
)
#def-arg(
  "frontmatter_entry", [`<function>`], default: none, [ A function that returns a frontmatter entry. Must take context and body as
    input. ],
)
#def-arg(
  "body_entry", [`<function>`], default: none, [ A function that returns a body entry. Must take context and body as input. ],
)
#def-arg(
  "appendix_entry", [`<function>`], default: none, [ A function that returns a appendix entry. Must take context and body as input. ],
)

=== Context <context>

Provides information to a callback about how it's being called.

Context is stored as a dictionary with the following fields:

#def-arg("title", [`<string>`], default: none, [The title of the entry])
#def-arg(
  "type", [`<string>` or `<none>`], default: none, [The type of the entry. This value is used differently by different templates.
    Refer to the template level documentation to see what this means for your theme.],
)
#def-arg(
  "start_date", [`<datetime>`], default: none, [The date at which the entry started.],
)
#def-arg(
  "end_date", [`<datetime>`], default: none, [The date at which the entry ended.],
)
#def-arg(
  "page_number", [`<integer>` or `<none>`], default: none, [The page number of the first page of the entry. Only available while using the `print_toc()` utility
  function. ],
)

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
#create_frontmatter_entry(title: "Table of Contents")[
  #components.toc()
]

#create_body_entry(
  title: "Sample Entry", type: "identify", start_date: datetime(year: 1984, month: 1, day: 1),
)[

= Top Level heading

#lorem(20)

#components.admonition(type: "note")[
  #lorem(20)
]

#components.pro_con(pros: [
  #lorem(50)
], cons: [
  #lorem(20)
])

#components.decision_matrix(
  properties: ("Flavor", "Versatility", "Crunchiness"), ("Sweet Potato", 5, 3, 1), ("White Potato", 1, 2, 3), ("Purple Potato", 2, 2, 2),
)
]

#create_appendix_entry(title: "Glossary")[
  #components.glossary()
]

```

=== Components

#let radial_toc_module = tidy.parse-module(read("./themes/radial/components/toc.typ"))
#show-module(radial_toc_module)

#let radial_glossary_module = tidy.parse-module(read("./themes/radial/components/glossary.typ"))
#show-module(radial_glossary_module)

#let radial_admonitions_module = tidy.parse-module(read("./themes/radial/components/admonitions.typ"))
#show-module(radial_admonitions_module)

#let radial_pro_con_module = tidy.parse-module(read("./themes/radial/components/pro-con.typ"))
#show-module(radial_pro_con_module)

#let radial_decision_matrix_module = tidy.parse-module(read("./themes/radial/components/decision-matrix.typ"))
#show-module(radial_decision_matrix_module)

#let radial_tournament_module = tidy.parse-module(read("./themes/radial/components/tournament.typ"))
#show-module(radial_tournament_module)

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
source file inside of that directory. For example, if you had a theme called `foo`,
the path to your entry point would look like this: `themes/foo/foo.typ`.

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
#let frontmatter_entry(context: (:), body) = {
  show: page.with(
    header: [ = Frontmatter header ],
    footer: counter(page).display("i")
  )

  body
}
```

```typ
#let body_entry(context: (:), body) = {
  show: page.with(
    header: [ = Body header ],
    footer: counter(page).display("1")
  )

  body
}
```

```typ
#let appendix_entry(context: (:), body) = {
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

The theme should be defined in your theme's entry point (`themes/foo/foo.typ` for
this example).

Here's what the theme would look like in this scenario:

```typ
#let foo_theme = (
  // Global show and set rules
  rules: rules,

  cover: cover,

  // Entry pages
  frontmatter_entry: frontmatter_entry,
  body_entry: body_entry,
  appendix_entry: appendix_entry
)
```

=== Creating Components

With your base theme done, you may want to create some additional components for
you to use while writing your entries. This could be anything, including graphs,
tables, Gantt charts, or anything else your heart desires.

// TODO: define a standard set of components that themes should implement.

== Utility Functions

#let utils_module = tidy.parse-module(read("utils.typ"))
#show-module(utils_module)
