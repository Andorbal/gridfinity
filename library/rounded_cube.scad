include <mirror_copy.scad>;
include <functions.scad>;

module rounded_cube(dims, radius) {
  dims_half = vec_scale(dims, 0.5);

  hull() {
    translate([dims_half.x, dims_half.y, 0]) {
      mirror_copy([0, 1, 0]) {
        mirror_copy([1, 0, 0]) {
          translate([-dims_half.x + radius, -dims_half.y + radius, radius]) {
            sphere(radius);
          }
        }
      }

      translate([0, 0, dims.z - radius]) {
        mirror_copy([0, 1, 0]) {
          mirror_copy([1, 0, 0]) {
            translate([-dims_half.x + radius, -dims_half.y + radius, radius]) {
              sphere(radius);
            }
          }
        }
      }
    }
  }
}
