#let vec(..x) = $ lr(angle.l #x.pos().join(",") angle.r) $

#let prob(question, body) = {
  [== #question]
  block(width: 100%, inset: 8pt, radius: 4pt, stroke: black, body)
}

// Some math operators
#let prox = [#math.op("prox")]
#let proj = [#math.op("proj")]
#let argmin = [#math.arg] + [#math.min]


// Initiate the document title, author...
#let assignment_class(title, author, course_id, professor, semester, due_time, body) = {
  set document(title: title, author: author)
  set page(
    paper: "us-letter", header: align(right, [*#author* | *#course_id: #title*]), footer: locate(loc => {
      let page_number = counter(page).at(loc).first()
      let total_pages = counter(page).final(loc).last()
      align(center)[Page #page_number of #total_pages]
    }),
  )
  block(height: 25%, fill: none)
  align(center, text(17pt)[
    *#course_id: #title*
  ])
  align(center, text(10pt)[
    Due on #due_time
  ])
  align(center, [#emph[Prof. #professor], #semester, #due_time])
  block(height: 35%, fill: none)
  align(center)[*#author*]
   
  pagebreak(weak: false)
  body
}