module pin(rot) {
  rotate([0,0,rot]) {
    translate([11, 11, -1.5]) {
      rotate([0,0,-6]) {
        difference() {
          cylinder(r=4.8, h=18, center=false, $fs=2);
          cylinder(r=3.5, h=28, center=false, $fs=2);

          translate([1,1,-2])
          *cylinder(r=4.5, h=35, center=false, $fs=4);
          rotate([0,0,51]) translate([8,0,0]) {
            *cube([15, 15, 65], center=true);
            translate([-5,0,11])
            cube([7, 15, 9], center=true);
            *translate([-5,0,11.5])
            *cube([7, 15, 2], center=true);
            *translate([-5,0,14])
            *cube([7, 15, 2], center=true);
          }
        }
      }
    }
  }
}

difference() {
  difference() {
    cylinder(r=16, h=4, center=true);
    cylinder(r=11, h=15, center=true);
  }




}

difference() {
  for (i=[0, 60, 120, 180, 240, 300]) {
    pin(i);
  }
  difference() {
    cylinder(r=26, h=55, center=true);
    cylinder(r=16, h=55, center=true);
  }
}
