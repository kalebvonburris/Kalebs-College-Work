#import "template.typ": *
#import "@preview/cetz:0.2.2"
#import cetz.plot

#let title = "HW 1"
#let author = "Kaleb Burris"
#let course_id = "MATH-253"
#let instructor = "David Maxwell"
#let semester = "Fall 2024"
#let due_time = "09/03/2024"
#set enum(numbering: "a)")

= Section 10.2

#prob(11)[
  Given: $arrow(u) = vector(1, -2)$ and $arrow(v) = vector(1,1)$

  + Problem: Find $arrow(u) + arrow(v), arrow(u) - arrow(v), 2 arrow(u) - 3 arrow(v)$

      $ arrow(u) + arrow(v) = vector(1, -2) + vector(1, 1) = #rect[$vector(2, -1)$] $

      $ arrow(u) - arrow(v) = vector(1, -2) - vector(1, 1) = #rect[$vector(0, -3)$] $

      $ 2 arrow(u) - 3 arrow(v) = 2 vector(1, -2) - 3 vector(1, 1) = #rect[$vector(-1, -7)$] $

  + Problem: Sketch the above vectors on the same axes, along with $vector(u)$ and $vector(v)$
  
    #align(center)[#cetz.canvas({
        import cetz.draw: *
        import cetz.plot
        //set-style(mark: (end: "o"))
        plot.plot(size: (5, 5), x-tick-step: 1, y-tick-step: 1, axis-style: "school-book", name: "plot",
          {
            plot.add(
              ((0, 0), (1, -2)), 
              label: $arrow(u)$
            )

            plot.add(
              ((0, 0), (1, 2)),
              label: $arrow(v)$
            )
        })

    })]
]