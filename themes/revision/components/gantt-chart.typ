#import "/packages.typ": timeliney
#import "../colors.typ": *

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

      for value in range(int((difference.days())/date-interval)+1) {
        next = start + duration(days: (value*date-interval))
        dates-array.push(group(((next).display(date-format),1)))
        if next.month() == last-month {
          month-len += 1
          last-month = next.month() 
        } else {
          months-array.push(group(((datetime(year: next.year(), month: last-month, day: 1)).display("[month repr:long]"),month-len)))
          month-len = 1
          last-month = next.month() 
        }
      }
      months-array.push(group(((datetime(year: next.year(), month: last-month, day: 1)).display("[month repr:long]"),month-len)))

      headerline(..months-array)
      headerline(..dates-array)

      let goal-color

      if goals != none {
        for goal in goals {
          if goal.len() == 2 {
            goal-color = none
          } else {
            goal-color = goal.at(2)
          }
          milestone(
            at: goal.at(1),
            style: (stroke: 0pt),
            [
              #place(center, dy: -8pt)[#line(angle: 90deg, length: 6pt)]
              #box(fill: goal-color, outset: 3pt, radius: 1.5pt)[#goal.at(0)]
            ],
          )
        }
      }

      let colors = (red, orange, yellow, green, blue, violet)
      let index = 0
      let size = difference.days()/date-interval
      let pos = ()
      
      taskgroup({
        for item in tasks {
          pos = (item.at(1).at(0)+0.054, item.at(1).at(1)-0.054)
          if item.len() == 2 {
            if index == colors.len()-1 {
              index = 0
            }
            task(item.at(0), pos, style: (stroke: (paint: colors.at(index), thickness: 5pt, cap: "square")))
            index += 1
          } else {
            task(item.at(0), pos, style: (stroke: (paint: item.at(2), thickness: 5pt, cap: "square")))
          }
        }
      })
    }
  )
}
