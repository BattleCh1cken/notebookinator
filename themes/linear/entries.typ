#import "format.typ": *
#import "./colors.typ": *

#let cover(context: (:)) = {
  v(50pt)

  line(length: 100%, stroke: 2pt)
  h(5pt)
  rect(inset: 30pt, fill: surface-0, width: 100%)[
    #grid(columns: (1fr, 3fr), gutter: 2fr, [
      #set text(72pt)
      #context.team-name
    ], 
    [
      #align(right, [
        #set text(20pt)
        #context.season
        
        Engineering Design Notebook
      ])
    ])
  ]
  h(5pt)
  line(length: 100%, stroke: 2pt)

  place(center + bottom, dy: -50pt, [
    #set text(20pt)
    #box(
      width: 150pt,
      stroke: (top: white, bottom: white, left: black, right: black),
      context.year
    )
  ])
}

#let frontmatter-entry(context: (:), body) = {
  show: page.with(
    //margin: (top: 8em),
    header: [ 
      #set align(center)
      #set text(size: 25pt)
       
      #context.title
       
    ],
    background: set-margins(8%, 8%),
  )
  body
}

#let body-entry(context: (:), body) = {
  show: page.with(margin: (top: 88pt), 
  header: [ 
    #set align(center)
    #set text(size: 30pt) 
    #box(
      //baseline: 2pt,
      fill: entry-type-metadata.at(context.type),
      width: 300pt,
      inset: 10pt,
      [#context.title],
    )
  ], 
  footer: [
    #grid(
      columns: (2fr, 2fr, 1fr),
      [
        Written by: #h(10pt) #context.author
      ],
      [
        Witnessed by: #h(10pt) #context.witness
      ],
      [
        #align(right, box(fill: surface-1, outset: 8pt, counter(page).display()))
      ]
    )
  ], 
  background: set-margins(8%, 8%))
   
  show heading: it => {
    set-heading(it, context.type)
  }

  show raw.where(block: false): box.with(
    fill: surface-1,
    inset: (x: 4pt, y: 0pt),
    outset: (x: 0pt, y: 4pt),
  )
  show raw.where(block: true): block.with(
    fill: surface-1,
    inset: 8pt,
    width: 100%
  )
  
  body
}

#let appendix-entry(context: (:), body) = {
  show: page.with(header: [
    #set align(center)
    #set text(size: 25pt)
    #context.title 
     
  ], background: set-margins(8%, 8%))
  body
}
