#import "../colors.typ": *

/// A Series of tables displaying match data from a tournament. Useful for tournament analysis entries.
/// - ..matches (dictionary): A list of all of the matches at the tournament.
/// Each dictionary must contain the following fields:
/// - match (string) The name of the match
/// - red-alliance `<dictionary>` The red alliance
///   - teams `<array>`
///   - score `<integer>`
/// - blue-alliance `<dictionary>` The blue alliance
///   - teams `<array>`
///   - score `<integer>`
/// - won `<boolean>` Whether you won the match
/// - auton `<boolean>` Whether you got the autonomous bonus
/// - awp `<boolean>` Whether you scored the autonomous win point
/// - notes `<content>` Any additional notes you have about the match
/// -> content
#let tournament(..matches) = {
  for match in matches.pos() {
    let color = if match.won {
      green
    } else {
      red
    }
    let cell = rect.with(fill: color.lighten(80%), width: 100%, height: 30pt)
    let header-cell = cell.with(fill: color, height: 20pt)
    let alliance-info(alliance: none) = {
      cell[
        #grid(
          columns: (1fr, 1fr),
          [
            #alliance.teams.at(0) \
            #alliance.teams.at(1) \
          ], [
            #set text(size: 15pt)
            #set align(horizon + center)
            #alliance.score
          ],

        )
      ]
    }

    let bool-icon(input) = {
      cell[
        #set align(horizon + center)
        #if input {
          image("../icons/check.svg", width: 1.5em)
        } else {
          image("../icons/x.svg", width: 1.5em)
        }
      ]
    }

    box(
      grid(
        columns: (1fr, 1fr, 1fr, 1fr, 1fr),
        header-cell(radius: (top-left: 1.5pt))[*Match*],
        header-cell[*Red Alliance*],
        header-cell[*Blue Alliance*],
        header-cell[*Auton Bonus*],
        header-cell(radius: (top-right: 1.5pt))[*AWP*],
        cell[#match.match],
        alliance-info(alliance: match.red-alliance),
        alliance-info(alliance: match.blue-alliance),
        bool-icon(match.auton),
        bool-icon(match.awp),
      ),
    )

    if not match.at("notes", default: none) == none [
      === Notes

      #match.notes
    ] else [

    ]
  }
}
