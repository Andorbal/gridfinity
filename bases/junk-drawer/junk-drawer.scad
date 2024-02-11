include <../../gridfinity-rebuilt-openscad/standard.scad>;
include <../../gridfinity-rebuilt-openscad/gridfinity-rebuilt-baseplate.scad>;

function add_vector(v, i = 0, r = 0) = i < len(v) ? add_vector(v, i + 1, r + v[i]) : r;

eps = 0.01;
drawer_size = [330, 495];
total_boxes = [
  floor(drawer_size.x / l_grid),
  floor(drawer_size.y / l_grid)
];
leftover = [
  drawer_size.x - total_boxes.x * l_grid,
  drawer_size.y - total_boxes.y * l_grid,
];

y_parts = [
  4 * l_grid + leftover.y / 2,
  3 * l_grid,
  4 * l_grid + leftover.y / 2
];

x_parts = [
  4 * l_grid + leftover.x / 2,
  3 * l_grid + leftover.x / 2
];

front = 0;
middle = 1;
back = 2;
left = 0;
right = 1;

module render_part(x, y) {
  intersection() {
    gridfinityBaseplate(0, 0, l_grid, 
        330,
        495,
        0, false, 0, 
        0, 
        0);

    translate([-drawer_size.x/2, -drawer_size.y/2,eps]) {
      offset = [
        add_vector([ for (i=[0:x]) i > 0 ? x_parts[i - 1] : 0 ]),
        add_vector([ for (i=[0:y]) i > 0 ? y_parts[i - 1] : 0 ]),
        0
      ];

      translate(offset)
        cube([x_parts[x], y_parts[y], 40]);
    }
  }
}

module front_left() { // make me
  render_part(left, front);
}

module front_right() { // make me
  render_part(right, front);
}

module middle_left() { // make me
  render_part(left, middle);
}

module middle_right() { // make me
  render_part(right, middle);
}

module back_left() { // make me
  render_part(left, back);
}

module back_right() { // make me
  render_part(right, back);
}
