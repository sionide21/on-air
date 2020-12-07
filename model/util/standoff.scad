$fn = 50;

standoff(height=3, board_size=1.57);

translate([20, 20])
positive_standoff(height=3, board_size=1.57);


color("white")
translate([0, 0, 5.4])
mirror([0, 0, 1])
standoff_pin(height=3, board_size=1.57);

module standoff(height, board_size) {
  difference() {
    union() {
      cylinder(h=height, d=3.5);
    }

    translate([0, 0, .2])
    cylinder(h=height + board_size, d=2.1);

  }
  fillet(width=3.5, r=2);
}

module positive_standoff(height, board_size) {
  union() {
    cylinder(h=height, d=3.5);
    cylinder(h=height + board_size, d=2.5);
  }
  fillet(width=3.5, r=2);
}

module fillet(width, r) {
  rotate_extrude()
  translate([width/2, 0])
  difference() {
    square(r);

    translate([r, r])
    circle(r);
  }
}
