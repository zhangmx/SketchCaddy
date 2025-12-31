// ============================================
// B05_Left_Side_Panel.scad
// 左侧板 - 750x520mm，可作为侧门和三合一画板组件
// ============================================

use <../libs/global_params.scad>
use <../libs/utils.scad>

// 面板尺寸
panel_height = global_box_height;  // 750mm
panel_width = global_box_width;    // 520mm
thickness = panel_thickness;        // 5mm

// 磁性表面安装槽
magnetic_surface_width = 480;
magnetic_surface_height = 700;
magnetic_slot_depth = 1.5;

// 铰链安装孔（与前面板连接）
hinge_hole_diameter = 5;
hinge_spacing = 200;

// 快拆锁扣位置
quick_release_positions = [[30, 100], [30, panel_height - 100],
                           [panel_width - 30, 100], [panel_width - 30, panel_height - 100]];

// ============================================
// 左侧板模块
// ============================================
module B05_Left_Side_Panel() {
    color(color_panel)
    difference() {
        // 主面板
        translate([panel_width/2, panel_height/2, 0])
        rounded_rect([panel_width - 10, panel_height - 10], 3, thickness);
        
        // 磁性白板安装槽（内侧）
        translate([(panel_width - magnetic_surface_width)/2,
                   (panel_height - magnetic_surface_height)/2,
                   thickness - magnetic_slot_depth])
        cube([magnetic_surface_width, magnetic_surface_height, magnetic_slot_depth + 0.1]);
        
        // 前边铰链孔（与B03_Front_Panel通过F04连接）
        for (y = [panel_height/2 - hinge_spacing, panel_height/2, panel_height/2 + hinge_spacing]) {
            translate([panel_width - 5, y, -0.1])
            cylinder(d = hinge_hole_diameter, h = thickness + 0.2);
        }
        
        // 后边铰链孔（与框架通过F01连接，可开门）
        for (y = [100, panel_height/2, panel_height - 100]) {
            translate([5, y, -0.1])
            cylinder(d = hinge_hole_diameter, h = thickness + 0.2);
        }
        
        // 快拆锁扣安装孔
        for (pos = quick_release_positions) {
            translate([pos[0], pos[1], -0.1])
            cylinder(d = 8, h = thickness + 0.2);
        }
        
        // 面板拼接定位销孔（三合一画板）
        for (y = [100, panel_height - 100]) {
            translate([panel_width - 8, y, -0.1])
            cylinder(d = 4, h = thickness + 0.2);
        }
        
        // 锁扣安装孔（与顶板底板连接）
        for (x = [panel_width/3, 2*panel_width/3]) {
            translate([x, panel_height - 15, -0.1])
            cylinder(d = 6, h = thickness + 0.2);
            translate([x, 15, -0.1])
            cylinder(d = 6, h = thickness + 0.2);
        }
    }
}

// 预览
B05_Left_Side_Panel();
