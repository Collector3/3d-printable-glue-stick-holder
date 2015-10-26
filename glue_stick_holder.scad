// Kossel 1515 extrusion glue stick holder
// Designed around an elmer's glue stick
// Note that this is design toleranced around a FFF printer,
// and prints slightly larger on tolerances for fit

$fn = 100;
plate_length = 15;
plate_height = 20;

plate_width  = 20;
plate_thickness = 2;

num_drills = 1;
inset_depth = 1.5;
drill_depth = 4;

wall_length = 19;

// Polyholes from: http://hydraraptor.blogspot.com/2011/02/polyholes.html
module polyhole(h, d) {
    n = max(round(2 * d),3);
    rotate([0,0,180])
        cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n);
}

module openbeam() {
    linear_extrude(rotate = 90, height = 100, center = true, convexity = 10) import (file = "openbeam.dxf");
}


module inset_drills(distance, drill_size, inset_depth) {
    translate([0, distance*20, -drill_depth]) cylinder(r=drill_size/2, h=drill_depth);
    translate([0, distance*20, -1]) cylinder(r=drill_size/1.2, h=inset_depth);
}

module glue_stick_slot() {
    translate([15, 26, 10]) {
        difference() {
        // Glue stick holder
            rotate([90, 0, 0]) {
                cylinder(d=24, h=26);
        
            }
            rotate([90, 0, 0]) cylinder(d=22, h=25);
        }      
    }
}

module plate() {
    difference() {
      union() {
        cube([plate_thickness, plate_length, plate_height]);
        
        difference() {
            cube([plate_width-8, plate_length, plate_thickness]);
            translate([15, 25, 10]) rotate([90, 0, 0]) cylinder(d=23, h=26);
        }
        
        difference() {
            translate([19-wall_length, 0, plate_height-2]) cube([plate_width-8, plate_length, plate_thickness]);  
            translate([15, 25, 10]) rotate([90, 0, 0]) cylinder(d=23, h=26);
        }
        

        translate([-(wall_length), 0, 10]) cube([wall_length, plate_length, plate_height - 10]); 
        translate([-(wall_length), 0, 0]) cube([wall_length, plate_length, plate_height - 10]);
         
        glue_stick_slot(); 
      }
            
      translate([2,  -32, 10]) rotate([0,90,0]) inset_drills(2, 3.75, 42);
      
      translate([-(wall_length-2.5), 0, 2]) cube([(wall_length-3), plate_length, 16]);

      translate([-wall_length, 0, 2.5]) cube([2.8, plate_length, 15]);
      

    }
}

rotate([0, 90, 180]) {
    rotate([0, 0, 90]) translate([9, 0, -10]) plate();
    //rotate([0, 90, 180]) translate([0, 0, 0]) openbeam();
}