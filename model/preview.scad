include<common.scad>
use <base.scad>
use <top_cutout.scad>
use <bottom_cutout.scad>
use <plate.scad>

render()
preview();

module preview() {
    cutout_depth = lip_depth + 4.5 + 1.6 + 4;
    echo("cutout_depth: ", cutout_depth);
    difference() {
        base();
        translate((block_size[2]+0.2)*z)
        mirror(z) linear_extrude(height=cutout_depth+0.2) top_cutout_2D();
    }
}
