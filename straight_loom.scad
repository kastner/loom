include <utils/build_plate.scad>

//CUSTOMIZER VARIABLES
// Standard rainbow loom sizes:
// measured pin radius (including wall) == 7mm
//

mount_inner_radius = 7;
mount_thickness = 2;

// Number of pins
pins = 3; //  [3,4,5,6,7,8,9,10,11,12,13,14,15]

// notches on pins
notches = 1; // [0,1,2,3,4]

notch_depth = 1.1;

notch_height = 9;

// Pin height
pin_height = 18; // [5:30]

pin_radius = 5;

// pin wall size in mm
pin_wall_thickness = 2;

// space between pins
space_between_pins = 20;

//  This section is creates the build plates for scale
//  for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//  when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//  when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]


//CUSTOMIZER VARIABLES END

//  This is just a Build Plate for scale
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

module pin(rot) {
  rotate([0,0,rot]) {
    translate([0, 0, (pin_height / 2)]) {
      difference() {
        scale([1,0.8,1]) cylinder(r=pin_radius, h=pin_height, center=true, $fs=1);

        // drill out the pin
        scale([1,0.8,1]) cylinder(r=pin_radius - pin_wall_thickness, h=pin_height * 1.1, center=true, $fs=1);

        // notches
        for (p=[notches/2 * -1 + 1:notches/2]) {
          translate([0, 0, p * ring_height]) {
            translate([notch_depth,0,0]) cube([notch_depth*2, pin_radius*2, notch_height], center=true);
          }
          translate([pin_radius*0.8,0,0]) cube([pin_radius,pin_radius*1.8,pin_height+1], center=true);
        }
      }
    }
  }
}

translate([0,0,10]) {
  difference() {
    for (i=[pins/2 * -1 + 1:pins/2]) {
      translate([i*space_between_pins, 0, 0]) {
        pin(0);
        translate([0,0,-5])
        difference() {
          cylinder(r=mount_inner_radius/2+mount_thickness, h=10, center=true);
          cylinder(r=mount_inner_radius/2, h=12, center=true);
        }
        if (i<pins/2) {
          translate([space_between_pins/2,0,-5])
          difference() {
            cylinder(r=mount_inner_radius/2+mount_thickness, h=10, center=true);
            cylinder(r=mount_inner_radius/2, h=12, center=true);
          }
        }
      }
    }

    translate([10,0,-10]) cube([pins*space_between_pins,4,10], center=true);

    // outer ring to shear off the pins
    *translate([0,0,(ring_height + pin_height) / 2.2]) {
      difference() {
        cylinder(r=size*2, h=ring_height + pin_height, center=true);
        cylinder(r=size, h=ring_height + pin_height, center=true);
      }
    }
  }
}
