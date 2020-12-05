// From: https://www.raspberrypi.org/documentation/hardware/raspberrypi/mechanical/rpi_MECH_Zero_1p3.pdf
use <../util/panel.scad>;

$fa = 1;
$fs = 0.5;


// This appears to be a standard circuit board size
BOARD_THICKNESS = 1.57;

rpi0();

module rpi0() {
  difference() {
    translate([3, 3])
    panel(l=30 - 6, w=65 - 6)
    cylinder(r=3, h=BOARD_THICKNESS);


    hole([3.5, 3.5]);
    hole([58 + 3.5, 3.5]);
    hole([58 + 3.5, 30 - 3.5]);
    hole([3.5, 30 - 3.5]);
  }

  place(x=41.1)
  usb();

  place(x=54)
  usb();

  place(y=16.9)
  microsd();

  place(x=12.4)
  hdmi();

  place(y=15, x=65)
  mirror([1, 0, 0])
  ribbon();
}

module place(x=0, y=0) {
  translate([x, y, BOARD_THICKNESS])
  children();
}

module hole(pos) {
  translate(pos)
  translate([0, 0, -1])
  cylinder(d=2.5, h=3);
}

module usb() {
  translate([-4, -1.5, 0])
  cube([8, 6, 3]);
}

module microsd() {
  translate([-2.5, -6, 0])
  cube([15.5, 12, 1.4]);
}

module hdmi() {
  translate([-11.25/2, -0.5, 0])
  cube([11.25, 7.75, 3.5]);
}

module ribbon() {
  translate([-1.25, -17/2, 0])
  cube([4.5, 17, 1.25]);
}
