use <util/panel.scad>;
use <util/standoff.scad>;

$fa = 1;
$fs = 0.1;

translate([2.5, 2.5, 1])
rpi0_mount();

linear_extrude(1)
rounded_panel([70, 35]);

module rpi0_mount() {
  module hole(pos, screw=false) {
    translate(pos)
    if (screw) {
      standoff(height=5, board_size=1.57);
    } else {
      positive_standoff(height=5, board_size=1.57);
    }
  }

  hole([3.5, 3.5], screw=true);
  hole([58 + 3.5, 3.5]);
  hole([58 + 3.5, 30 - 3.5], screw=true);
  hole([3.5, 30 - 3.5]);
}
