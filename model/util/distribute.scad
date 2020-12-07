module distribute(count, width, debug=false) {
  GAP = width / (count + 1);

  if (debug) {
    #square([width, 1]);
  }

  for (i = [1:count]) {
    translate([GAP * i, 0])
    children();
  }
}
