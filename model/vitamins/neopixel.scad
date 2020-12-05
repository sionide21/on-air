$fa = 1;
$fs = 0.5;

// This appears to be a standard circuit board size
BOARD_THICKNESS = 0.78;

neopixel();

module neopixel() {
  // Board
  cylinder(d=12.7, h=BOARD_THICKNESS);

  // LED
  linear_extrude(2.5)
  square([5, 5], center=true);
}
