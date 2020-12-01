use <vitamins/neopixel.scad>;
/* use <vitamins/rpi0.scad>;
use <vitamins/seesaw.scad>; */


$fa = 1;
$fs = 0.1;

light_fixture();

module light_fixture() {
  reflector();

  for (angle = [0:4]) {
    rotate([0, 0, 90 * angle ])
    translate([13/2 + .25, 0, -2])
    clip();
  }
}

module reflector() {
  rotate_extrude()
  hull() {
    translate([10, 3])
    circle(d=1);

    translate([4, 1.5])
    circle(d=0.5);

    translate([13/2, .5])
    circle(d=1);
  }
}

module clip() {
  translate([0, -1, 0])
  cube([1, 3, 3.5]);

  hull() {
    translate([-1.5, 0, 0])
    cube([1.5, 1, 1]);

    translate([0, -1, 0])
    cube([1, 3, 1]);
  }
}




/* translate([20, 20]) */
/* translate([0, 0, -.78])
color("PaleGreen")
neopixel(); */
