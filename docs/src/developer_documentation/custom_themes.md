# Making Your Own Theme

If you're unhappy with the existing themes, or just want to add your own flair to your notebook, the Notebookinator supports custom themes. We highly recommend you familiarize yourself with the [Typst Documentation](typst.app/docs) before trying to implement one yourself.

Themes consist of two different parts, the theme itself, and its corresponding components.

The theme is just a dictionary containing functions. These functions specify how the entries and cover should look, as well as global rules for the whole document. We'll cover the required structure of this variable in a [later](#the-theme-variable) section.

Components are simply functions stored in a module. These functions contain things like pro/con tables and decision-matrices. Most components are just standalone, but the Notebookinator does supply some utility functions to help with implementing harder components. Implementing components will be covered in [this](#writing-components) section.

## File Structure

The first thing you'll need to do is create a folder for your theme, somewhere in your notebook. As an example, lets create a theme called `foo`. The first thing we'll want to do is create a folder called `foo/`. Then, inside that folder, we'll want to create a file called `foo.typ` inside the `foo/` folder. This will be the entry point for your theme, and will contain your theme variable.

Then, we'll want to create a `foo/components/components.typ` file. This file will contain all of your components. We recommend having each component inside of its own file. For example, an `example-component` might be defined in `foo/components/example-component.typ`.

You'll also want to create an `entries.typ` file to contain all of your entry functions for your theme variable, and a `rules.typ` to store your global rules.

Your final file structure should look like this:

- `foo/`
  - `foo.typ`
  - `entries.typ`
  - `rules.typ`
  - `components/`
    - `components.typ`

```admonish info
This is just the recommended file structure, as long as you expose a theme variable and components, your theme will work just like all the others. You can also add any additional files as you wish.
```

## The Theme Variable

The first thing you should do is create a theme variable. Going back to our `foo` example, lets create a `foo-theme` variable in our `foo/foo.typ` file.

```typ
// foo/foo.typ

// use this if you're developing inside the notebookinator
#import "/utils.typ"

// use this if you're developing a private theme
#import "@local/notebookinator:1.0.1": *

#let foo-theme = utils.make-theme() // will not currently compile
```

Themes are defined with the `make-theme` function found in the `utils` namespace. This function verifies that all of your inputs are correct, and will return a correctly structured theme. However, it requires that all of your theme functions are specified in order to compile, so that's the next thing we'll be doing.

### Creating The Entries

Now that we actually have a place to put our theme functions, we can start implementing our entry functions.

Each of these functions has 2 requirements:

- it must return a `page` function as output
- it must take a dictionary parameter named `ctx` as input, and a parameter called body.

The `ctx` argument provides context about the current entry being created. This dictionary contains the following fields:

- `title`: `str`
- `type`: `str`
- `date`: `datetime`
- `author`: `str`
- `witness`: `str`

`body` contains the content the user has written. It should be passed into the `page` function in some shape or form.

We'll write these functions in the `foo/entries.typ` file. Below are some minimal starting examples:

### Frontmatter

```typ
// foo/entries.typ

// to import utils, see The Theme Variable section

#let frontmatter-entry = utils.make-frontmatter-entry((ctx, body) => {
  show: page.with( // pass the entire function scope into the `page` function
    header: [ = ctx.title ],
    footer: context counter(page).display("i")
  )

  body // display the users's written content
})
```

### Body

```typ
// foo/entries.typ

// to import utils, see The Theme Variable section

#let body-entry = utils.make-body-entry((ctx, body) => {
  show: page.with( // pass the entire function scope into the `page` function
    header: [ = ctx.title ],
    footer: context counter(page).display("i")
  )

  body // display the users's written content
})
```

### Appendix

```typ
// foo/entries.typ

// to import utils, see The Theme Variable section

#let appendix-entry = utils.make-appendix-entry((ctx, body) => {
  show: page.with( // pass the entire function scope into the `page` function
    header: [ = ctx.title ],
    footer: context counter(page).display("i")
  )

  body // display the users's written content
})

```

With the entry functions written, we can now add them to the theme variable.

```typ
// foo/foo.typ

// to import utils, see The Theme Variable section

// import the entry functions
#import "./entries.typ": frontmatter-entry, body-entry, appendix-entry

// add the entry functions to the theme
#let foo-theme = utils.make-theme(
  frontmatter-entry: frontmatter-entry,
  body-entry: body-entry,
  appendix-entry: appendix-entry,
)
```

### Creating a Cover

Then you'll have to implement a cover. The only required parameter here is a
context variable, which stores information like team number, game season and
year.

Here's an example cover:

```typ
// foo/entries.typ

// to import utils, see The Theme Variable section

#let cover = utils.make-cover(ctx => [
  #set align(center + horizon)
  *Default Cover*
])

```

Then, we'll update the theme variable accordingly:

```typ
// foo/foo.typ

// to import utils, see The Theme Variable section

// import the cover along with the entry functions
#import "./entries.typ": cover frontmatter-entry, body-entry, appendix-entry

#let foo-theme = utils.make-theme(
  cover: cover, // add the cover to the theme
  frontmatter-entry: frontmatter-entry,
  body-entry: body-entry,
  appendix-entry: appendix-entry,
)
```

### Rules

Next you'll have to define the rules. This function defines all of the global
configuration and styling for your entire theme. This function must take a doc
parameter, and then return that parameter. The entire document will be passed
into this function, and then returned. Here's and example of what this could
look like:

```typ
// foo/rules.typ

// to import utils, see The Theme Variable section

#let rules = utils.make-rules((doc) => {
  set text(fill: red) // Make all of the text red, across the entire document

  doc // Return the entire document
}
```

Then, we'll update the theme variable accordingly:

```typ
// foo/foo.typ
#import "./rules.typ": rules // import the rules
#import "./entries.typ": cover frontmatter-entry, body-entry, appendix-entry

// to import utils, see The Theme Variable section

#let foo-theme = utils.make-theme(
  rules: rules, // store the rules in the theme variable
  cover: cover,
  frontmatter-entry: frontmatter-entry,
  body-entry: body-entry,
  appendix-entry: appendix-entry,
)
```

## Writing Components

With your base theme done, you may want to create some additional components for you to use while writing your entries. This could be anything, including graphs, tables, Gantt charts, or anything else your heart desires. We recommend including the following components by default:

- Table of contents `toc`
- Decision matrix: `decision-matrix`
- Pros and cons table: `pro-con`
- Glossary: `glossary`

We recommend creating a file for each of these components. After doing so, your file structure should look like this:

- `foo/components/`
  - `components.typ`
  - `toc.typ`
  - `decision-matrix.typ`
  - `pro-con.typ`
  - `glossary.typ`

Once you make those files, import them all in your `components.typ` file:

```typ
// foo/components.typ

// make sure to glob import every file
#import "./toc.typ": *
#import "./glossary.typ": *
#import "./pro-con.typ": *
#import "./decision-matrix.typ": *
```

Then, import your `components.typ` into your theme's entry point:

```typ
// foo/foo.typ

#import "./components/components.typ" // make sure not to glob import here
```

All components are defined with constructors from the `utils` module.

### Pro / Con Component

Pro / con components tend to be extremely simple. Define a function called `pro-con` inside your `foo/components/pro-con.typ` file with the `make-pro-con` from `utils`:

```typ
// foo/components/pro-con.typ

// to import utils, see The Theme Variable section

#let pro-con = utils.make-pro-con((pros, cons) => {
    // return content here
})
```

This syntax might look a little weird if you aren't familiar with functional programming. `make-pro-con` takes a [`lambda`](https://typst.app/docs/reference/foundations/function/#unnamed) function as input, which is just a function without a name. This function takes two inputs: `pros` and `cons`, which are available inside the scope of the function like normal arguments would be on a named function.

For examples on how to create a pro / con table, check out how [other themes](https://github.com/The-Notebookinator/notebookinator/tree/main/themes) implement them.

### TOC Component

The next three components are a bit more complicated, so we'll be spending a little more time explaining how they work. Each of these components requires some information about the document itself (things like the page numbers of entries, etc.). Normally fetching this data can be rather annoying, but fortunately the Notebookinator's constructors fetch this data for you.

To get started with your table of contents, first define a function called `toc` in your `foo/components/toc.typ` file with the `make-toc` constructor.

Using the `make-toc` constructor we can make a `toc` like this:

```typ
// foo/components/toc.typ

// to import utils, see The Theme Variable section

#let toc = utils.make-toc((frontmatter, body, appendix) => {
 // ...
}
```

Using the constructor gives us access to three variables, `frontmatter`, `body`, and `appendix`. These variables are all [arrays](https://typst.app/docs/reference/foundations/array/), which are dictionaries that all contain the same information as the `ctx` variables from [this](#creating-the-entries) section, with the addition of a `page-number` field, which is an [integer](https://typst.app/docs/reference/foundations/int/).

With these variables, we can simply loop over each one, and print out another entry in the table of contents each time.

Here's what that looks like for the frontmatter entries:

```typ
// foo/components/toc.typ

// to import utils, see The Theme Variable section

#let toc = utils.make-toc((_, body, appendix) => {
    // We replace the 'frontmatter' parameter with _ to indicate that we will not use it.
  // _ replaces frontmatter to indicate we aren't using it
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

  // You'll need to do something similar for the
  // appendix entries as well, if you want to display them
})
```

### Decision Matrix Component

The decision matrix code works similarly. You can define one like this:

```typ
#let decision-matrix = utils.make-decision-matrix((properties, data) => {
    // ...
})
```

Inside of the function you have access to two variables, `properties`, and `data`. Properties contains a list of the properties the choices are being rated by, while `data` contains the choices alongside the scores for those choices. You can run a [`repr()`](https://typst.app/docs/reference/foundations/repr/) on either of those variables to get a better understanding of how they're structured.

Here's a simple example to get you started, copied from the `default-theme`:

```typ
// to import utils, see The Theme Variable section

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
```

### Glossary Component

The glossary component is similar to the table of components in that it requires information about the document to function.

To get access to the glossary entries, you can use the `make-glossary` function provided by the `utils` to fetch all of the glossary terms, in alphabetical order.

The function passed into the `print-glossary` function has access to the `glossary` variable, which is an [array](https://typst.app/docs/reference/foundations/array/). Each entry in the array is a dictionary containing a `word` field and a `definition` field. Both are [strings](https://typst.app/docs/reference/foundations/str/).

Here's an example from the `default-theme`:

```typ
// foo/components/glossary.typ

// to import utils, see The Theme Variable section

#let glossary() = utils.print-glossary(glossary => {
  stack(spacing: 0.5em, ..for entry in glossary {
    ([
      = #entry.word

      #entry.definition
    ],)
  })
}
```

## Using the Theme

Now that you've written the theme, you can apply it to your notebook.

In the entry point of your notebook (most likely `main.typ`), import your theme like this:

```typ
// main.typ

#import "foo/foo.typ": foo-theme, components
```

Once you do that, change the theme to `foo-theme`:

```
// main.typ

#show: notebook.with(
  theme: foo-theme
)
```
