xz_plane = [0,1,0];
yz_plane = [1,0,0];
xy_plane = [0,0,1];

/**
 * Mirror a copy of the children across the plane
 *
 * @param plane 3-Vector that defines the plane on which to mirror
 */
module mirror_copy(plane = [0,0,0]) {
  for (m=[0:1]) mirror([
      m * plane[0],
      m * plane[1],
      m * plane[2]])
    children();
}
