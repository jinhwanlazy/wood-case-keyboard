use <list-comprehension-demos/sweep.scad>
use <scad-utils/transformations.scad>
use <scad-utils/shapes.scad>
include <common.scad>

render() base();

module base()
{
    linear_extrude(height=block_size[2]) block_profile();
}
