use <Saira_Stencil_One/SairaStencilOne-Regular.ttf>;
use <util/panel.scad>;

$fa = 1;
$fs = 0.5;

face_plate();

module face_plate() {
  linear_extrude(1)
  difference() {
    panel(180 - 6, 50 - 6)
    translate([3, 3])
    circle(3);

    translate([90, 24, 0])
    text("ON AIR", font="SairaStencilOne", size=38, halign="center", valign="center");
  }
}
