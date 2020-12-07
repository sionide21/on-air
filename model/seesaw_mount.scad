use <util/panel.scad>;
use <util/standoff.scad>;

$fa = 1;
$fs = 0.1;

translate([2.5, 2.5, 1])
seesaw_mount();

linear_extrude(1)
rounded_panel([45, 30]);

module seesaw_mount() {
  module hole(pos) {
    translate(pos)
    standoff(height=13, board_size=1.57);
  }

  translate([(40 - 36.5) / 2, 2.5])
  union() {
    hole([0, 0]);
    hole([36.5, 0]);
  }
}
