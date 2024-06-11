#import "../colors.typ": *

/// Display information about your team.
///
/// Example Usage:
/// ```typ
/// #team(
///     (
///       name: "Random Person",
///       picture: image("./path-to-image.png", width: 90pt, height: 90pt),
///       about: [
///         Likes Coding
///       ],
///   ),
/// )
/// ```
/// - ..members (dictionary): A list of members in your team. Each dictionary must contain the following fields:
///   - name `<string>`: The name of the team member
///   - picture `<content>`: An image of the team member
///   - about `<content>`: About the team member
/// -> content
#let team(..members) = {
  set align(center)
  grid(
    columns: (1fr, 1fr),
    gutter: 20pt,
    ..for member in members.pos() {
      (
        rect(
          fill: surface-1,
          inset: 20pt,
          radius: 1.5pt,
        )[
          * #member.name *
          #line(
            length: 100%,
            stroke: (cap: "round", dash: "solid", thickness: 1.5pt),
          )
          #v(8pt)
          #grid(
            columns: (1fr, 1fr),
            gutter: 20pt,
            align(center, member.picture),
            align(left, member.about),
          )
        ],
      )
    },
  )
}
