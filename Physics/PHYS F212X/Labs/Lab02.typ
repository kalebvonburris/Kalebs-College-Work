#import "@preview/cetz:0.2.2"

= Lab 02 - Heat engines

1. - Isobaric
   #cetz.canvas({
      import cetz.draw: *
      line(
        (0, 0), (0, 5), label: "Name"
      )
      
   })
   - Isobaric
   - Isothermal
2. The pressure is going to increase quickly and the temperature will stay the same.

3. Yes. The pressure increased by ~23 kPa.

8. Hot water: $73 degree$ C, Cold: $20.3 degree$ C

9.

#let vals = (0.048, 0.01543, 0.01235, 0.01389)

#table(align: center, columns: 2, 
  [Mass], [$Delta h$],
  [97g], [0.048m],
  [147g], [0.01543m],
  [97g], [0.01235m],
  [97g], [0.01389m],
)

$
  m g Delta h = g * m/s^2 * m = (g m^2) / s^2
$

#align(center)[#table(align: center, columns: 4, 
  [Run \#], [Work Done by Gas (J)], [Work Done on Mass (J)], [Percent Difference],
  [1, 97g], [0.0012040 J], [-0.004562 J], [-135.9%],
  [2, 147g], [0.0003925 J], [−0.001467 J], [-2663.1%],
  [3, 197g], [0.0003695 J], [−0.01174 J], [-3004.2%],
  [4, 247g], [0.0005720 J], [−0.0132 J], [-2207.7%],
)]


== Questions

1.  The volume was decreased and no other changes were made to the system, thus the pressure must have increased.
2.  The temperature decreased as the pressure decreased, proportional to one another. 
3.  Moving slowly gives the gas time to exchange heat with the environment, which allows it to maintain temperature.
4.  Position is going to move in the negative direction, so we add a negative sign to get a positive increase in volume.



15. 0.6836

Max pressure: 107.3