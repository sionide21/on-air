use <util/panel.scad>;
use <util/distribute.scad>;
use <case.scad>;
use <light_box.scad>;


$fa = 1;
$fs = 0.1;

OVERHANG = [2, 2];
OUTER_WALL = case_dimensions();
INNER_WALL = light_box_dimensions() - 2 * OVERHANG;

MOUNT_RING = light_box_dimensions() + [1.6, 1.6];

cover();


module cover() {
  ring(outer=OUTER_WALL, inner=INNER_WALL, depth=2);

  translate([0, 0, -1])
  ring(outer=OUTER_WALL, inner=OUTER_WALL - [1, 1], depth=1);

  translate([0, 0, -1])
  translate((OUTER_WALL - MOUNT_RING)/2)
  ring(outer=MOUNT_RING, inner=MOUNT_RING - [1, 1], depth=1);

  translate([0, 0, -1])
  attachment_points()
  hook();
}

module ring(outer, inner, depth) {
  linear_extrude(depth)
  difference() {
    rounded_panel(outer);

    translate((outer - inner) / 2)
    rounded_panel(inner);
  }
}

module hook() {
  HEIGHT = 11;
  translate([-5, -1, 0])
  union() {
    hull() {
      cube([10, 1, HEIGHT]);

      translate([0.5, -1, HEIGHT - 1])
      cube([9, 1, 1]);
    }


    hull() {
      cube([10, 1, 1.5]);

      translate([0.5, 1.5, 0.5])
      cube([9, 0.5, 0.5]);
    }
  }
}
