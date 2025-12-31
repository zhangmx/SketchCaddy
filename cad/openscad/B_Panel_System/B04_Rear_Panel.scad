// ============================================
// B04_Rear_Panel.scad
// 后面板 - 750x520mm，集成伸缩拉杆底座加固结构
// ============================================

use <../libs/global_params.scad>
use <../libs/utils.scad>

// 面板尺寸
panel_height = global_box_height;  // 750mm
panel_width = global_box_width;    // 520mm
thickness = panel_thickness;        // 5mm

// 拉杆底座安装区域
handle_base_width = 80;
handle_base_height = 120;
handle_base_offset_y = 50;         // 距底部

// 加强板参数
reinforcement_thickness = 3;

// ============================================
// 后面板模块
// ============================================
module B04_Rear_Panel() {
    color(color_panel)
    union() {
        difference() {
            // 主面板
            translate([panel_width/2, panel_height/2, 0])
            rounded_rect([panel_width - 10, panel_height - 10], 3, thickness);
            
            // 拉杆穿孔
            translate([(panel_width - 45)/2, handle_base_offset_y, -0.1])
            cube([45, 30, thickness + 0.2]);
            
            // 拉杆底座安装孔
            translate([panel_width/2, handle_base_offset_y + handle_base_height/2, 0])
            B04_handle_base_holes();
            
            // 边缘固定孔
            for (y = [30, panel_height/3, 2*panel_height/3, panel_height - 30]) {
                for (x = [15, panel_width - 15]) {
                    translate([x, y, -0.1])
                    cylinder(d = 4, h = thickness + 0.2);
                }
            }
        }
        
        // 拉杆底座加强板
        color([0.5, 0.5, 0.5])
        translate([(panel_width - handle_base_width)/2, 
                   handle_base_offset_y,
                   thickness])
        difference() {
            cube([handle_base_width, handle_base_height, reinforcement_thickness]);
            
            // 拉杆管穿孔
            translate([(handle_base_width - 45)/2, -0.1, -0.1])
            cube([45, 35, reinforcement_thickness + 0.2]);
            
            // 安装孔
            translate([handle_base_width/2, handle_base_height/2, 0])
            B04_handle_base_holes();
        }
    }
}

// 拉杆底座安装孔组
module B04_handle_base_holes() {
    hole_offset_x = 30;
    hole_offset_y = 40;
    
    for (dx = [-hole_offset_x, hole_offset_x]) {
        for (dy = [-hole_offset_y, 0, hole_offset_y]) {
            translate([dx, dy, -0.1])
            cylinder(d = 5, h = thickness + reinforcement_thickness + 0.4);
        }
    }
}

// 预览
B04_Rear_Panel();
