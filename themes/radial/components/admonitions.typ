#import "../colors.typ": *
#import "../icons/icons.typ"
#import "/utils.typ"
#import "../metadata.typ": *
#import "/packages.typ": showybox
#import showybox: *

#let admonition = utils.make-admonition((type, body) => {
  let info = admonition-type-metadata.at(type)
  let colored-icon = utils.change-icon-color(
    raw-icon: info.icon,
    fill: info.color,
  )

  showybox(
    frame: (
      border-color: info.color,
      body-color: info.color.lighten(80%),
      thickness: (
        left: 4pt,
      ),
      radius: 1.5pt,
    ),
    [
      #text(
        size: 15pt,
        fill: info.color,
        [
          #box(baseline: 30%, image.decode(colored-icon, width: 1.5em)) *#info.title*
        ],
      )
      \
      #body
    ],
  )
})
