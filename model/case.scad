use <util/panel.scad>;
use <util/distribute.scad>;
use <light_box.scad>;
use <rpi0_mount.scad>;
use <seesaw_mount.scad>;
use <vitamins/mounting_screw.scad>;
use <vitamins/rpi0.scad>;

$fa = 1;
$fs = 0.1;

WALLS = [2, 2];
GAP = [3.5, 3.5];
HOLDERS = [6, 6];                                                                                                                           ;
INNER_CLEARANCE = light_box_dimensions() + [0.2, 0.2];
INNER_WALL = INNER_CLEARANCE + 2 * GAP;
OUTER_WALL = INNER_WALL + 2 * WALLS;

BACK_THICKNESS = 2.5;
ELECTRONICS_CLEARANCE = 16;


RPI_OFFSET = 13.5;


case();

/* color("green")
translate([75 + RPI_OFFSET, 15, 2 + 7])
rotate([0, 180, 0])
rpi0(); */

function case_dimensions() = OUTER_WALL;

function case_height() = ELECTRONICS_CLEARANCE + BACK_THICKNESS + light_box_height() + 1;

module case() {
  translate([0, 0, ELECTRONICS_CLEARANCE + BACK_THICKNESS])
  case_top();

  difference() {
    case_bottom();

    translate([15 + RPI_OFFSET, -1, BACK_THICKNESS + 1])
    cube([25, 5, 7.5]);
  }

  translate([10 + RPI_OFFSET, 15, BACK_THICKNESS])
  rpi0_mount();

  translate([120, 15, BACK_THICKNESS])
  seesaw_mount();
}

module case_top() {
  difference() {
    linear_extrude(light_box_height() + 1)
    union() {
      case_wall();
      insets(depth=GAP);
    }

    attachment_points()
    translate([0, 0, light_box_height() + 1])
    latch();
  }
}

module case_bottom() {
  translate([0, 0, BACK_THICKNESS])
  linear_extrude(ELECTRONICS_CLEARANCE)
  union() {
    case_wall();

    insets(depth=HOLDERS);
  }

  linear_extrude(BACK_THICKNESS)
  difference() {
    rounded_panel(OUTER_WALL);

    translate(INNER_WALL)
    translate([-14, -15])
    mounting_screw_hole();

    translate([WALLS[0], INNER_WALL[1]])
    translate([14, -15])
    mounting_screw_hole();
  }
}

module latch() {
  translate([-5, -1, 0])
  hull() {
    cube([10, 1, 1.5]);

    translate([0.5, 1.5, 0.5])
    cube([9, 0.5, 0.5]);
  }
}

module insets(depth) {
  module long_wall_insets() {
    translate([0, WALLS[1]])
    distribute(count=6, width=OUTER_WALL[0])
    translate([-1, 0, 0])
    square([2, depth[1]]);
  }

  module short_wall_insets() {
    translate([WALLS[0], OUTER_WALL[1]])
    rotate([0, 0, 270])
    distribute(count=2, width=OUTER_WALL[1])
    translate([-1, 0, 0])
    square([2, depth[0]]);
  }

  long_wall_insets();

  translate([0, OUTER_WALL[1]])
  mirror([0, 1, 0])
  long_wall_insets();

  short_wall_insets();

  translate([OUTER_WALL[0], 0])
  mirror([1, 0, 0])
  short_wall_insets();
}

module attachment_points() {
  module long_wall_points() {
    EXTRA = 14;
    translate([-EXTRA, OUTER_WALL[1] - WALLS[1], -10])
    distribute(count=3, width=OUTER_WALL[0] + 2 * EXTRA)
    children();
  }

  module short_wall_points() {
    translate([WALLS[0], 0, -10])
    rotate([0, 0, 90])
    distribute(count=1, width=OUTER_WALL[1])
    children();
  }

  long_wall_points()
  children();

  short_wall_points()
  children();

  rotate([0, 0, 180])
  translate(-OUTER_WALL)
  union() {
    long_wall_points()
    children();

    short_wall_points()
    children();
  }
}

module case_wall() {
  difference() {
    rounded_panel(OUTER_WALL);

    translate((OUTER_WALL - INNER_WALL) / 2)
    rounded_panel(INNER_WALL);
  }
}
