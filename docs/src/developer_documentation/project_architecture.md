# Project Architecture

The Notebookinator is split into two sections, the base template, and the
themes. The base template functions as the backend of the project. It handles
all of the information processing, keeps track of global state, makes sure page
numbers are correct, and so on. It exposes the main API that the user interacts
for creating entries and creating glossary entries.

The themes act as the frontend to the project, and are what the user actually
sees. The themes expose an API for components that need to be called directly
inside of entries. This could include things like admonitions, charts, and
decision matrices.

## File Structure

- `lib.typ`: The entrypoint for the whole template.
- `internals.typ`: All of the internal function calls that should not be used by
  theme authors or users.
- `entries.typ`: Contains the user facing API for entries, as well as the internal
  template functions for printing out the entries and cover.
- `glossary.typ`: Contains the user facing API for the glossary.
- `globals.typ`: Contains all of the global variables for the entire project.
- `utils.typ`: Utility functions intended to help implement themes. Imports all of the functions located in `utils`.
- `utils/`
  - `misc.typ`: Contains miscellaneous utility functions that don't fit in other categories
  - `components.typ`: Contains the constructors used by themes to implement components
  - `theme.typ`: Contains the constructors used to create themes
- `themes/`: The folder containing all of the themes.
  - `themes.typ`: An index of all the themes are contained in the template
- `docs.typ`: The entry point for the project documentation.
- `docs-template.typ`: The template for the project documentation.
