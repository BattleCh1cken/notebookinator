#import "./globals.typ"
#import "./themes/themes.typ"

#let fallback-to-default(key, theme) = {
  let component = theme.at(key, default: none)
  if component == none {
    return themes.default.default-theme.at(key)
  } else {
    return component
  }
}

/// Internal function used by the template to print out the cover
///
/// - theme (theme):
/// - context (dictionary):
/// -> content
#let print-cover(theme: (:), context: (:)) = {
  let cover-func = fallback-to-default("cover", theme)
  cover-func(context: context)
}

/// Internal function used by the template to print out all of the entries
///
/// - theme (theme):
/// -> content
#let print-entries(theme: (:), cover-context: (:)) = {
  let print-helper(section, state) = {
    locate(loc => {
      for entry in state.final(loc) [
        #let entry-func = fallback-to-default(section + "-entry", theme)
        #let body = [] + entry.body
        #entry-func(body, context: entry.context + cover-context)
      ]
    })
  }

  print-helper("frontmatter", globals.frontmatter-entries)
  print-helper("body", globals.entries)
  print-helper("appendix", globals.appendix-entries)
}
