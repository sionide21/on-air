$fa = 1;
$fs = 0.5;

BOARD_THICKNESS = 1.57;

seesaw();

module seesaw() {
  difference() {
    union() {
      cube([40, 5, BOARD_THICKNESS]);

      translate([0, 5, 0])
      cube([40, 25, 15]);
    }

    translate([(40 - 36.5) / 2, 2.5])
    union() {
      hole([0, 0]);
      hole([36.5, 0]);
    }
  }
}


module hole(pos) {
  translate(pos)
  translate([0, 0, -1])
  cylinder(d=2.5, h=3);
}
