$fa = 1;
$fs = 0.5;


color("silver", 0.5)
translate([0, 6.5, -2.25])
mounting_screw();

linear_extrude(2)
difference() {
  square(30, center=true);
  mounting_screw_hole();
}
translate([30, 0, 0])
linear_extrude(2.5)
difference() {
  square(30, center=true);
  mounting_screw_hole();
}

module mounting_screw() {
  cylinder(h=2, d=8);

  translate([0, 0, 2]) {
    cylinder(h=2.5, d=4);

    translate([0, 0, 2.5]) {
      cylinder(h=1.5, d=8);
    }
  }

  hull() {
    cylinder(h=23, d=4);

    translate([0, 0, 28.5])
    sphere(0.01);
  }
}

module mounting_screw_hole() {
  circle(d=9.5);

  hull() {
    square(center=true, 4.25);
    translate([0, (9.5 + 4.25) / 2, 0])
    circle(d=4.25);
  }
}
