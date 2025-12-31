// SketchCaddy - 通用工具函数库

include <global_params.scad>

// ============================================
// 1010铝型材截面模块
// ============================================
module extrusion_profile_1010(size = 10) {
    wall = 1.2;
    slot_width = 4;
    slot_depth = 2.5;
    
    difference() {
        // 外轮廓
        square(size, center = true);
        
        // 中心孔
        circle(d = size - 2 * wall);
        
        // 四个T槽
        for (angle = [0, 90, 180, 270]) {
            rotate([0, 0, angle])
            translate([0, size/2 - slot_depth/2])
            square([slot_width, slot_depth + 0.1], center = true);
        }
    }
}

// ============================================
// 铝型材拉伸模块
// ============================================
module extrusion_1010(length, size = 10) {
    color(color_frame)
    rotate([90, 0, 0])
    linear_extrude(height = length, center = false)
    extrusion_profile_1010(size);
}

// 沿X轴的型材
module extrusion_x(length, size = 10) {
    rotate([0, 90, 0])
    rotate([0, 0, 90])
    extrusion_1010(length, size);
}

// 沿Y轴的型材
module extrusion_y(length, size = 10) {
    rotate([0, 0, 0])
    extrusion_1010(length, size);
}

// 沿Z轴的型材
module extrusion_z(length, size = 10) {
    rotate([-90, 0, 0])
    extrusion_1010(length, size);
}

// ============================================
// 圆角矩形
// ============================================
module rounded_rect(size, radius, height) {
    linear_extrude(height = height)
    offset(r = radius)
    offset(r = -radius)
    square([size.x, size.y], center = true);
}

// ============================================
// 带圆角的面板
// ============================================
module panel(width, height, thickness, corner_radius = 3) {
    color(color_panel)
    translate([0, 0, thickness/2])
    rounded_rect([width, height], corner_radius, thickness);
}

// ============================================
// 螺丝孔
// ============================================
module screw_hole(diameter, depth, countersink = false) {
    union() {
        cylinder(d = diameter, h = depth + 0.1);
        if (countersink) {
            translate([0, 0, depth - diameter/2])
            cylinder(d1 = diameter, d2 = diameter * 2, h = diameter/2);
        }
    }
}

// ============================================
// 爆炸视图辅助
// ============================================
module explode(direction, distance, explode_factor = 0) {
    translate(direction * distance * explode_factor)
    children();
}
