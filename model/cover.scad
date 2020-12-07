use <util/panel.scad>;
use <util/distribute.scad>;
use <case.scad>;
use <light_box.scad>;


$fa = 1;
$fs = 0.1;

OVERHANG = [2, 2];
OUTER_WALL = case_dimensions();
INNER_WALL = light_box_dimensions() - 2 * OVERHANG;

echo(OUTER_WALL);
cover();


module cover() {
  ring();

  attachment_points()
  hook();
}

module ring() {
  linear_extrude(2)
  difference() {
    rounded_panel(OUTER_WALL);

    translate((OUTER_WALL - INNER_WALL) / 2)
    rounded_panel(INNER_WALL);
  }
}

module hook() {
  translate([-5, -1, 0])
  union() {
    hull() {
      cube([10, 1, 10]);

      translate([0.5, -1, 9])
      cube([9, 1, 1]);
    }


    hull() {
      cube([10, 1, 1.5]);

      translate([0.5, 1.5, 0.5])
      cube([9, 0.5, 0.5]);
    }
  }
}
