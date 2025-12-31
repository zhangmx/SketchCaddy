// ============================================
// E02_Tool_Panel.scad
// 工具挂板 - 集成MOLLE织带、弹力绳、网兜
// ============================================

use <../libs/global_params.scad>
use <../libs/utils.scad>

// 挂板参数
panel_width = 450;
panel_height = 600;
panel_thickness = 3;

// MOLLE织带参数
molle_width = 25;
molle_spacing = 38;          // 标准MOLLE间距
molle_slot_length = 30;
molle_slot_width = 3;

// ============================================
// 工具挂板模块
// ============================================
module E02_Tool_Panel() {
    color([0.3, 0.35, 0.3])  // 军绿色
    difference() {
        // 主面板
        translate([panel_width/2, panel_height/2, 0])
        rounded_rect([panel_width, panel_height], 5, panel_thickness);
        
        // MOLLE槽孔阵列
        for (row = [0:7]) {
            for (col = [0:8]) {
                x_offset = 40 + col * molle_spacing;
                y_offset = 50 + row * (molle_spacing * 2);
                
                // 交错排列
                stagger = (row % 2) * molle_spacing/2;
                
                if (x_offset + stagger < panel_width - 40) {
                    translate([x_offset + stagger, y_offset, -0.1])
                    cube([molle_slot_width, molle_slot_length, panel_thickness + 0.2]);
                }
            }
        }
        
        // 边缘安装孔
        for (x = [20, panel_width - 20]) {
            for (y = [30, panel_height/2, panel_height - 30]) {
                translate([x, y, -0.1])
                cylinder(d = 5, h = panel_thickness + 0.2);
            }
        }
    }
    
    // 弹力绳固定点
    E02_Elastic_Cord_Points();
    
    // 网兜区域标识
    E02_Mesh_Pocket_Area();
}

// 弹力绳固定点
module E02_Elastic_Cord_Points() {
    color(color_accent)
    for (x = [60, panel_width - 60]) {
        for (y = [100, 250, 400]) {
            translate([x, y, panel_thickness])
            cylinder(d = 8, h = 5);
        }
    }
}

// 网兜区域（底部）
module E02_Mesh_Pocket_Area() {
    pocket_width = 200;
    pocket_height = 150;
    
    color([0.2, 0.2, 0.2, 0.5])
    translate([(panel_width - pocket_width)/2, 30, panel_thickness])
    cube([pocket_width, pocket_height, 0.5]);
}

// ============================================
// 弹力绳模块（装饰用）
// ============================================
module E02_Elastic_Cord(start, end, diameter = 4) {
    color([0.1, 0.1, 0.1])
    hull() {
        translate(start) sphere(d = diameter);
        translate(end) sphere(d = diameter);
    }
}

// 预览
E02_Tool_Panel();
