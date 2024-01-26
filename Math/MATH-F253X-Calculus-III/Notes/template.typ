#let vector(..x) = $ lr(angle.l #x.pos().join(",") angle.r) $
#let side-bracket(inp, br1, br2) = style(styles => {
  let half-height = measure(inp, styles).height / 2
  $
  inp
  #stack(dir: ttb, spacing: 1em, $ lr(}, size: #half-height) #br1$, $ lr(}, size: #half-height) #br2$)
  $
}) 
