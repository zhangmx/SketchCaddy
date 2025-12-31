// ============================================
// B01_Top_Panel.scad
// 顶板 - 520x520mm，集成拉杆安装孔和画架角度调节器
// ============================================

use <../libs/global_params.scad>
use <../libs/utils.scad>

// 面板尺寸
panel_length = global_box_length;  // 520mm
panel_width = global_box_width;    // 520mm
thickness = panel_thickness;        // 5mm

// 拉杆孔参数
handle_hole_width = 40;
handle_hole_length = 25;
handle_hole_offset_y = 50;         // 距后边

// 角度调节器安装孔
adjuster_hole_diameter = 6;
adjuster_spacing = 400;             // 两侧调节器间距

// ============================================
// 顶板模块
// ============================================
module B01_Top_Panel() {
    color(color_panel)
    difference() {
        // 主面板
        translate([panel_length/2, panel_width/2, 0])
        rounded_rect([panel_length - 20, panel_width - 20], 5, thickness);
        
        // 拉杆穿孔
        translate([panel_length/2 - handle_hole_width/2, 
                   panel_width - handle_hole_offset_y - handle_hole_length/2,
                   -0.1])
        cube([handle_hole_width, handle_hole_length, thickness + 0.2]);
        
        // 左侧角度调节器安装孔组
        translate([(panel_length - adjuster_spacing)/2, 30, 0])
        B01_adjuster_holes();
        
        // 右侧角度调节器安装孔组
        translate([(panel_length + adjuster_spacing)/2, 30, 0])
        B01_adjuster_holes();
        
        // 边缘固定孔（与框架连接）
        for (x = [30, panel_length/2, panel_length - 30]) {
            for (y = [15, panel_width - 15]) {
                translate([x, y, -0.1])
                cylinder(d = 4, h = thickness + 0.2);
            }
        }
        for (y = [30, panel_width/2, panel_width - 30]) {
            for (x = [15, panel_length - 15]) {
                translate([x, y, -0.1])
                cylinder(d = 4, h = thickness + 0.2);
            }
        }
    }
}

// 角度调节器安装孔组
module B01_adjuster_holes() {
    hole_spacing = 15;  // 5档位
    for (i = [0:4]) {
        translate([0, i * hole_spacing, -0.1])
        cylinder(d = adjuster_hole_diameter, h = thickness + 0.2);
    }
}

// 预览
B01_Top_Panel();
