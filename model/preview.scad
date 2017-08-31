include<common.scad>
use <base.scad>
use <top_cutout.scad>
use <bottom_cutout.scad>
use <plate.scad>

render()
preview();

module preview() {
    difference() {
        base();
        translate((block_size[2]+0.2)*z)
        mirror(z) linear_extrude(height=lip_depth+0.2) top_cutout_2D();
    }
}
