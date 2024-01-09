#import "../colors.typ": *
#import "../icons/icons.typ": *
#import "@preview/timeliney:0.0.1"

#let gantt_chart(
  months: ((
    month: [],
    length: 1
    ),
  ),
  dates: ((
    date: [],
    length: 1
    ),
  ),
  tasks: ((
    task: [],
    time: (0,1),
    color: blue
    ),
  ),
  goals: ((
    goal: [],
    position: 0
  ))
) = {
  timeliney.timeline(
    spacing: 5pt,
    
    show-grid: true,
    grid-style: (stroke: (dash: "dashed", thickness: .5pt, paint: gray)),

    tasks-vline: true,
    line-style: (stroke: 0pt),

    milestone-overhang: 1pt,
    milestone-layout: "in-place",
    box-milestones: true,
    milestone-line-style: (stroke: (dash: "dashed", thickness: 1pt, paint: black)),
    {
      import timeliney: *

      if months.at(0).month != "" {
        let months_array = ()
        for m in months{
          months_array.push(group((m.month, m.length)))
        }
        headerline(..months_array)
      }

      let dates_array = ()
      for d in dates{
        dates_array.push(group((d.date, d.length)))
      }
      headerline(..dates_array)

      if goals.at(0).position != [] {
        for g in goals {
          milestone(g.goal, at: g.position)
        }
      }
  
      taskgroup({
        for t in tasks {
          task(t.task, t.time, style: (stroke: (paint: t.color, thickness: 5pt, cap: "butt")))
        }
      })
    }
  )
}

// Example
#gantt_chart(
  months: (
    (month: [January], length: 4),
    (month: [February], length: 4),
  ),
  dates: (
    (date : [Week 1], length: 1),
    (date : [Week 2], length: 1),
    (date : [Week 3], length: 1),
    (date : [Week 4], length: 1),
    (date : [Week 1], length: 1),
    (date : [Week 2], length: 1),
    (date : [Week 3], length: 1),
    (date : [Week 4], length: 1),
  ),
  tasks: (
    (
      task: [Build Robot],
      time: (0,3),
      color: blue
    ),
    (
      task: [Drive Robot],
      time: (3,7),
      color: green
    ),
    (
      task: [Code Robot],
      time: (2,6),
      color: yellow
    ),
    (
      task: [Destroy Robot],
      time: (7,8),
      color: red
    ),
  ),
  goals: (
    (
      goal: [*Tournament*],
      position: 7
    ),
  )
)