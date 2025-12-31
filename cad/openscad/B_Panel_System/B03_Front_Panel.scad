// ============================================
// B03_Front_Panel.scad
// 前面板 - 750x520mm，内侧带磁性白板安装槽
// 可与侧板组合成三合一大画板
// ============================================

include <../libs/global_params.scad>
include <../libs/utils.scad>

// 面板尺寸
panel_height = global_box_height;  // 750mm
panel_width = global_box_width;    // 520mm
thickness = panel_thickness;        // 5mm

// 磁性表面安装槽
magnetic_surface_width = 480;
magnetic_surface_height = 700;
magnetic_slot_depth = 1.5;

// 铰链安装孔
hinge_hole_diameter = 5;
hinge_spacing = 200;               // 铰链间距

// 锁扣安装孔
lock_hole_diameter = 6;

// ============================================
// 前面板模块
// ============================================
module B03_Front_Panel() {
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
        
        // 左侧铰链安装孔（与左侧板连接）
        for (y = [panel_height/2 - hinge_spacing, panel_height/2, panel_height/2 + hinge_spacing]) {
            translate([5, y, -0.1])
            cylinder(d = hinge_hole_diameter, h = thickness + 0.2);
        }
        
        // 右侧铰链安装孔（与右侧板连接）
        for (y = [panel_height/2 - hinge_spacing, panel_height/2, panel_height/2 + hinge_spacing]) {
            translate([panel_width - 5, y, -0.1])
            cylinder(d = hinge_hole_diameter, h = thickness + 0.2);
        }
        
        // 顶部锁扣安装孔
        for (x = [panel_width/3, 2*panel_width/3]) {
            translate([x, panel_height - 20, -0.1])
            cylinder(d = lock_hole_diameter, h = thickness + 0.2);
        }
        
        // 底部锁扣安装孔
        for (x = [panel_width/3, 2*panel_width/3]) {
            translate([x, 20, -0.1])
            cylinder(d = lock_hole_diameter, h = thickness + 0.2);
        }
        
        // 面板拼接定位孔（三合一画板功能）
        for (y = [100, panel_height - 100]) {
            // 左侧
            translate([8, y, -0.1])
            cylinder(d = 4, h = thickness + 0.2);
            // 右侧
            translate([panel_width - 8, y, -0.1])
            cylinder(d = 4, h = thickness + 0.2);
        }
    }
}

// 预览
if ($preview && is_undef($assembly_mode)) {
    B03_Front_Panel();
}
