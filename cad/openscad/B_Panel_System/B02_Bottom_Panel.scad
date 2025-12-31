// ============================================
// B02_Bottom_Panel.scad
// 底板 - 520x520mm，集成轮子支架和地脚安装位
// ============================================

use <../libs/global_params.scad>
use <../libs/utils.scad>

// 面板尺寸
panel_length = global_box_length;  // 520mm
panel_width = global_box_width;    // 520mm
thickness = panel_thickness;        // 5mm

// 轮子安装参数
wheel_mount_offset = 40;           // 轮子安装孔距边缘
wheel_mount_hole_diameter = 8;

// 地脚安装参数
foot_mount_offset = 40;
foot_mount_hole_diameter = 10;     // M8螺纹孔

// ============================================
// 底板模块
// ============================================
module B02_Bottom_Panel() {
    color(color_panel)
    difference() {
        // 主面板
        translate([panel_length/2, panel_width/2, 0])
        rounded_rect([panel_length - 20, panel_width - 20], 5, thickness);
        
        // 前侧轮子安装孔（2个轮子）
        translate([wheel_mount_offset, wheel_mount_offset, -0.1])
        B02_wheel_mount_holes();
        
        translate([panel_length - wheel_mount_offset, wheel_mount_offset, -0.1])
        B02_wheel_mount_holes();
        
        // 后侧地脚安装孔（2个地脚）
        translate([foot_mount_offset, panel_width - foot_mount_offset, -0.1])
        cylinder(d = foot_mount_hole_diameter, h = thickness + 0.2);
        
        translate([panel_length - foot_mount_offset, panel_width - foot_mount_offset, -0.1])
        cylinder(d = foot_mount_hole_diameter, h = thickness + 0.2);
        
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
        
        // 排水/通风孔
        for (x = [panel_length/3, 2*panel_length/3]) {
            for (y = [panel_width/3, 2*panel_width/3]) {
                translate([x, y, -0.1])
                cylinder(d = 15, h = thickness + 0.2);
            }
        }
    }
}

// 轮子支架安装孔组（四孔固定）
module B02_wheel_mount_holes() {
    hole_spacing = 30;
    for (dx = [-hole_spacing/2, hole_spacing/2]) {
        for (dy = [-hole_spacing/2, hole_spacing/2]) {
            translate([dx, dy, 0])
            cylinder(d = wheel_mount_hole_diameter, h = thickness + 0.2);
        }
    }
}

// 预览
B02_Bottom_Panel();
