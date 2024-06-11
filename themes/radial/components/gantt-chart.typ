#import "/packages.typ": timeliney
#import "../colors.typ": *

/// A gantt chart for task management
///
/// Example Usage:
///
/// ```typ
/// #gantt-chart(
///   start: datetime(year: 2024, month: 1, day: 27),
///   end: datetime(year: 2024, month: 2, day: 3),
///   tasks: (
///     ("Build Robot", (0,4)),
///     ("Code Robot", (3,6)),
///     ("Drive Robot", (5,7)),
///     ("Destroy Robot", (7,8)),
///   ),
///   goals: (
///     ("Tournament", 4),
///   )
/// )
/// ```
/// - start (datetime): Start date using datetime object
///   - year: `<integer>`
///   - month: `<integer>`
///   - day: `<integer>`
/// Example usage: ```typ datetime(year: 2024, month: 7, day: 16)```
/// - end (datetime): End date using datetime object
///   - year: `<integer>`
///   - month: `<integer>`
///   - day: `<integer>`
/// Example usage: ```typ datetime(year: 2024, month: 5, day: 2)```
/// - date-interval (integer): The interval between dates, seven would make it weekly
/// - date-format (string): The way the date is formatted using the `<datetime.display()>` method
/// - tasks (array): Specify tasks using an array of arrays that have three fields each
///   + `<string>` or `<content>` The name of the task
///   + `<array>`(`<integer>` or `<float>`, `<integer>` or `<float>`) The start and end point of the task
///   + `<color>` The color of the task line (optional)
/// Example sub-array: ```typ ("Build Catapult", (1,5), red)```
/// - goals (array): Add goal markers using an array of arrays that have three fields each
///   + `<string>` or `<content>` The name of the goal
///   + `<integer>` or `<float>` The position of the goal
///   + `<color>` The color of the goal box (optional)
///       - Default is grey, but put none for no box
/// Example sub-array: ```typ ("Worlds", 6, red)```
/// -> content
#let gantt-chart(
  start: datetime,
  end: datetime,
  date-interval: 1,
  date-format: "[month]/[day]",
  tasks: (),
  goals: none,
) = {
  timeliney.timeline(
    spacing: 5pt,
    show-grid: true,
    grid-style: (stroke: (dash: none, thickness: .2pt, paint: black)),
    tasks-vline: true,
    line-style: (stroke: 0pt),
    milestone-overhang: 3pt,
    milestone-layout: "in-place",
    box-milestones: true,
    milestone-line-style: (stroke: (dash: none, thickness: 1pt, paint: black)),
    {
      import timeliney: *

      let difference = end - start
      let dates-array = ()
      let months-array = ()
      let month-len = 0
      let last-month = start.month()
      let next

      for value in range(int((difference.days()) / date-interval) + 1) {
        next = start + duration(days: (value * date-interval))
        dates-array.push(group(((next).display(date-format), 1)))
        if next.month() == last-month {
          month-len += 1
          last-month = next.month()
        } else {
          months-array.push(
            group((
              (
                datetime(year: next.year(), month: last-month, day: 1)
              ).display("[month repr:long]"),
              month-len,
            )),
          )
          month-len = 1
          last-month = next.month()
        }
      }
      months-array.push(
        group((
          (
            datetime(year: next.year(), month: last-month, day: 1)
          ).display("[month repr:long]"),
          month-len,
        )),
      )

      headerline(..months-array)
      headerline(..dates-array)

      let goal-color

      if goals != none {
        for goal in goals {
          if goal.len() == 2 {
            goal-color = surface-2
          } else {
            goal-color = goal.at(2)
          }
          milestone(
            [#box(fill: goal-color, outset: 3pt, radius: 1.5pt)[#goal.at(0)]],
            at: goal.at(1),
          )
        }
      }

      let colors = (red, orange, yellow, green, blue, violet)
      let index = 0
      let size = difference.days() / date-interval
      let pos = ()

      taskgroup({
        for item in tasks {
          pos = (
            item.at(1).at(0) + size * 0.007,
            item.at(1).at(1) - size * 0.007,
          )
          if item.len() == 2 {
            if index == colors.len() - 1 {
              index = 0
            }
            task(
              item.at(0),
              pos,
              style: (
                stroke: (paint: colors.at(index), thickness: 5pt, cap: "round"),
              ),
            )
            index += 1
          } else {
            task(
              item.at(0),
              pos,
              style: (
                stroke: (paint: item.at(2), thickness: 5pt, cap: "round"),
              ),
            )
          }
        }
      })
    },
  )
}
