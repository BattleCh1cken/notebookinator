#import "./internals.typ": *
#import "./entries.typ": *
#import "./utils.typ"
#import "./themes/themes.typ"
#import "./glossary.typ"

/// The base notebook template. This function is meant to be applied to your entire document as a show rule.
///
/// *Example Usage:*
///
/// ```typ
/// #import themes.default: default-theme
///
/// #show: notebook.with(
///   theme: default-theme
/// )
/// ```
/// - team-name (string): The name of your team.
/// - season (string): The name of the current season.
/// - year (string): The years in which the notebook is being written.
/// - theme (theme): The theme that will be applied to all of the entries. If no theme is specified, it will fall back on the default theme.
/// - cover (content): The title page of the notebook.
/// - body (content): The content of the notebook. This will be ignored. Use the create-entry functions instead.
/// -> content
#let notebook(
  team-name: "",
  season: "",
  year: "",
  cover: none,
  theme: (:),
  body,
) = {
  let rules = theme.rules
  show: doc => rules(doc)

  let cover-content = if cover == none {
    let ctx = (
      team-name: team-name,
      season: season,
      year: year,
    )

    (theme.cover)(ctx: ctx)
  } else {
    cover
  }
  page(
    margin: 0pt,
    cover-content,
  )

  // Filler page
  page[]

  print-entries(theme: theme)
  body
  // FIXME: this should be ignored, but the document doesn't properly render without it.
}
