#import "template.typ": *

#let title = "HW 1"
#let author = "Kaleb Burris"
#let course_id = "CS-371"
#let instructor = "Arghya Das"
#let semester = "Fall 2024"
#let due_time = "09/04/2024"

#set page(
    paper: "us-letter", header: align(right, [*#author* | *#course_id: #title*]), footer: locate(loc => {
      let page_number = counter(page).at(loc).first()
      align(center)[Page #page_number]
    }),
  )

#set text(size: 12pt, font: "Times New Roman", spacing: 6pt)
#set par(justify: true, first-line-indent: 0.5in)

#align(center)[= Impact of Computers on Productivity]

// Necessary to indent first paragraph
#h(1.5in) 

#lorem(100)

#lorem(50)
@test1

#pagebreak()

#bibliography("HW1.bib", style: "mla", full: true)
