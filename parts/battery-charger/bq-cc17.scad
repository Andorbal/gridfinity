include <../../gridfinity-rebuilt-openscad/gridfinity-rebuilt-utility.scad>

// ===== INFORMATION ===== //
/*
 IMPORTANT: rendering will be better for analyzing the model if fast-csg is enabled. As of writing, this feature is only available in the development builds and not the official release of OpenSCAD, but it makes rendering only take a couple seconds, even for comically large bins. Enable it in Edit > Preferences > Features > fast-csg
 the magnet holes can have an extra cut in them to make it easier to print without supports
 tabs will automatically be disabled when gridz is less than 3, as the tabs take up too much space
 base functions can be found in "gridfinity-rebuilt-utility.scad"
 examples at end of file

 BIN HEIGHT
 the original gridfinity bins had the overall height defined by 7mm increments
 a bin would be 7*u millimeters tall
 the lip at the top of the bin (3.8mm) added onto this height
 The stock bins have unit heights of 2, 3, and 6:
 Z unit 2 -> 7*2 + 3.8 -> 17.8mm
 Z unit 3 -> 7*3 + 3.8 -> 24.8mm
 Z unit 6 -> 7*6 + 3.8 -> 45.8mm

https://github.com/kennetek/gridfinity-rebuilt-openscad

*/

// ===== PARAMETERS ===== //

/* [Setup Parameters] */

/* [General Settings] */
// number of bases along x-axis
gridx = 3;  
// number of bases along y-axis   
gridy = 2;  
// bin height. See bin height information and "gridz_define" below.  
gridz = 3;

// /* [Linear Compartments] */
// // number of X Divisions (set to zero to have solid bin)
// divx = 0;
// // number of Y Divisions (set to zero to have solid bin)
// divy = 0;

/* [Height] */
// determine what the variable "gridz" applies to based on your use case
gridz_define = 0; // [0:gridz is the height of bins in units of 7mm increments - Zack's method,1:gridz is the internal height in millimeters, 2:gridz is the overall external height of the bin in millimeters]
// overrides internal block height of bin (for solid containers). Leave zero for default height. Units: mm
height_internal = 0; 
// snap gridz height to nearest 7mm increment
enable_zsnap = false;

/* [Features] */
// the type of tabs
style_tab = 1; //[0:Full,1:Auto,2:Left,3:Center,4:Right,5:None]
// how should the top lip act
style_lip = 0; //[0: Regular lip, 1:remove lip subtractively, 2: remove lip and retain height]
// scoop weight percentage. 0 disables scoop, 1 is regular scoop. Any real number will scale the scoop. 
scoop = 1; //[0:0.1:1]
// only cut magnet/screw holes at the corners of the bin to save uneccesary print time
only_corners = false;

/* [Base] */
style_hole = 1; // [0:no holes, 1:magnet holes only, 2: magnet and screw holes - no printable slit, 3: magnet and screw holes - printable slit, 4: Gridfinity Refined hole - no glue needed]
// number of divisions per 1 unit of base along the X axis. (default 1, only use integers. 0 means automatically guess the right division)
div_base_x = 0;
// number of divisions per 1 unit of base along the Y axis. (default 1, only use integers. 0 means automatically guess the right division)
div_base_y = 0; 


charger = [105, 65, 100];

side_notch_base = [20, 30];
side_notch_stretch = 40;


// ===== IMPLEMENTATION ===== //
module notch() {
  rotate([90,0,0])
    linear_extrude(height = 180, center = true)
      polygon(points=[
        [side_notch_base.x,0],
        [side_notch_base.x + side_notch_stretch,side_notch_base.y],
        [-side_notch_base.x - side_notch_stretch,side_notch_base.y],
        [-side_notch_base.x,0]]);
}

module bq_cc17() { // make me
  $fa = 8;
  $fs = 0.25;

  color("tomato") {
    difference() {
      gridfinityInit(gridx, gridy, 
          height(gridz, gridz_define, style_lip, enable_zsnap), 
          height_internal);

      translate([0,0,7]) {
        cube([105,65,100], center = true);

        notch();
        rotate([0,0,90])
          scale([0.6,1,1])
            notch();
      }
    }

    gridfinityBase(gridx, gridy, l_grid, div_base_x, 
        div_base_y, style_hole, only_corners=only_corners);
  }
}

bq_cc17();
