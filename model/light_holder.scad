use <vitamins/neopixel.scad>;
/* use <vitamins/rpi0.scad>;
use <vitamins/seesaw.scad>; */


$fa = 1;
$fs = 0.1;

HOLE = 7.2;
HEIGHT = 2.5;
ID = 13.4;
OD = 15;
WALL = (OD - ID) / 2;
NOTCH = [0.75, 1];
OVERHANG = 0.6;


light_holder();


module light_holder() {
  rotate_extrude()
  light_holder_profile();
}

module light_holder_outline() {
  rotate_extrude()
  union() {
    light_holder_profile();
    hull() {
      square([ID / 2, HEIGHT]);
      square([ID / 2 - OVERHANG, HEIGHT + 0.7]);
    }
  }
}

module light_holder_profile() {
  translate([HOLE / 2, 0])
  square([(ID - HOLE) / 2, 0.5]);

  translate([ID / 2, 0])
  square([WALL, HEIGHT]);

  translate([ID / 2, HEIGHT])
  hull() {
    square([WALL, 0.2]);

    translate([-OVERHANG, 0.5])
    square([WALL, 0.2]);
  }

  translate([OD / 2, 0])
  square(NOTCH);
}

/* translate([20, 20]) */
/* translate([0, 0, 2])
mirror([0, 0, 1])
color("PaleGreen")
neopixel(); */
