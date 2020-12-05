module rounded_panel(size, r=3) {
  panel(size[0] - 2*r, size[1] - 2*r)
  translate([r, r])
  circle(r);
}

module panel(w, l) {
  hull() {
    for (x=[0, w]) {
      for (y=[0, l]) {
        translate([x, y])
        children();
      }
    }
  }
}
