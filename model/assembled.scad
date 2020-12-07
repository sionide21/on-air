use <light_holder.scad>;
use <light_box.scad>;
use <face_plate.scad>;
use <case.scad>;
use <cover.scad>;
use <vitamins/rpi0.scad>;
use <vitamins/seesaw.scad>;

$fa = 1;
$fs = 0.1;

step(1)
color("darkgrey")
case();

translate([5.6, 5.6, 18.6]) {
  step(4)
  color("white")
  light_box();

  step(6)
  color("black")
  translate([0, 0, 18.5])
  face_plate();

  step(5)
  color("gray")
  lights();
}

step(7)
color("lightgrey")
translate([0, 0, case_height()])
cover();

step(2)
color("green")
translate([88.5, 15, 2.5 + 7])
rotate([0, 180, 0])
rpi0();

step(3)
color("green")
translate([160, 15, 2.5 + 14])
rotate([0, 180, 0])
seesaw();

echo(round($t * 7) + 1);

module step(number) {
  animating = false;
  if (!animating || round($t * 7) + 1 >= number) {
    children();
  }
}

module lights() {
  translate([90, 0, 9.5])
  fitted_light_holder();

  translate([180, 25, 9.5])
  rotate([0, 0, 90])
  fitted_light_holder();

  translate([90, 50, 9.5])
  rotate([0, 0, 180])
  fitted_light_holder();

  translate([0, 25, 9.5])
  rotate([0, 0, 270])
  fitted_light_holder();
}

module fitted_light_holder() {
  translate([0, 2, 0])
  rotate([90, 0, 0])
  light_holder();
}
