#import "./globals.typ"
#import "./themes/themes.typ"

/// Internal function used by the template to print out all of the entries
///
/// - theme (theme):
/// -> content
#let print-entries(theme: (:)) = {
  let print-helper(section, state) = context {
    for entry in state.final() {
      let entry-func = theme.at(section + "-entry")
      entry-func(entry.body, ctx: entry.ctx)
    }
  }

  print-helper("frontmatter", globals.frontmatter-entries)
  print-helper("body", globals.entries)
  print-helper("appendix", globals.appendix-entries)
}
