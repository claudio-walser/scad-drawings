
include <./config.scad>
include <./grateFrame.scad>

//use <./frame.scad>


grateFrameMeasuermentLinesWidth();
rotate([0, 0, -90])  translate([0, grateWidth, 0]) grateFrameMeasermentLinesHeight();
drawGrateFrameSideProjection();

// color([65/255, 75/255, 95/255])
// translate([1, 500, 0])
// drawFrameSideProjection();


// frameMeasuermentLinesWidth();
// rotate([0, 0, -90]) translate([0, outerDepth, 0]) frameMeasermentLinesHeight();
// drawFrameSideProjection();
// drawGrateFrameFrontProjection();
