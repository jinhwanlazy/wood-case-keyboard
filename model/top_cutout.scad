include <common.scad>
use <scad-utils/morphology.scad>

invert_2D() top_cutout_2D();

module top_cutout_2D()
{
    translate(layout_pos+plate_size[1]*y)
    outset(r=0.5, $fn=17)
    for (sw = switch_info) {
        pos = sw[0];
        rot = sw[1];
        u = sw[2];
        translate(pos) rotate(rot) square([u, 1]*unit, true);
    }
}
