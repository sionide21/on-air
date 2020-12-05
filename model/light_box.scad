use <util/panel.scad>;
use <light_holder.scad>;

$fa = 1;
$fs = 0.1;

OUTDER_DIMENSIONS = [180, 50];
WALLS = [2, 2];
HEIGHT = 18;
FLOOR = 0.5;

light_box();

module light_box() {
  translate([0, 0, FLOOR])
  shell();

  linear_extrude(FLOOR)
  rounded_panel(OUTDER_DIMENSIONS);
}



module light_cutout() {
  OVERHANG = 4;
  translate([0, 2, 0])
  rotate([90, 0, 0])
  union() {
    light_holder_outline();

    // Make the base taller so it can sit flush when cut out
    translate([0, 0, -0.5])
    light_holder_outline();

    translate([0, 50, WALLS[0] / 2])
    cube([15 - OVERHANG, 100, 2 * WALLS[0]], center = true);
  }
}

module shell() {
  difference() {
    linear_extrude(HEIGHT)
    difference() {
      rounded_panel(OUTDER_DIMENSIONS);

      translate(WALLS)
      rounded_panel(OUTDER_DIMENSIONS - 2 * WALLS);
    }

    union() {
      translate([OUTDER_DIMENSIONS[0] / 2, 0, HEIGHT / 2])
      light_cutout();

      translate([OUTDER_DIMENSIONS[0], OUTDER_DIMENSIONS[1] / 2, HEIGHT / 2])
      rotate([0, 0, 90])
      light_cutout();

      translate([OUTDER_DIMENSIONS[0] / 2, OUTDER_DIMENSIONS[1], HEIGHT / 2])
      rotate([0, 0, 180])
      light_cutout();

      translate([0, OUTDER_DIMENSIONS[1] / 2, HEIGHT / 2])
      rotate([0, 0, 270])
      light_cutout();
    }
  }
}
