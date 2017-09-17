include <common.scad>

invert_2D() mounting_holes();

module mounting_holes() {
    translate(layout_pos)
    for (pos = mounting_hole_pos) {
        translate(pos) circle(d=3, $fn=11);
    }
}

echo(mounting_hole_pos);
