// ============================================
// C01_Wheel_Bracket.scad
// 轮子安装支架 - L形钣金件
// ============================================

use <../libs/global_params.scad>
use <../libs/utils.scad>

// 支架参数
bracket_width = 60;          // 支架宽度
bracket_height = 80;         // 垂直部分高度
bracket_depth = 50;          // 水平部分深度
plate_thickness = 3;         // 钣金厚度
wheel_axle_diameter = 12;    // 轮轴孔直径

// ============================================
// L形轮子支架模块
// ============================================
module C01_Wheel_Bracket() {
    color(color_frame)
    difference() {
        union() {
            // 水平安装板（固定到底板）
            cube([bracket_width, bracket_depth, plate_thickness]);
            
            // 垂直支撑板
            translate([0, 0, 0])
            cube([bracket_width, plate_thickness, bracket_height]);
            
            // 加强筋
            translate([bracket_width/2 - plate_thickness/2, plate_thickness, plate_thickness])
            cube([plate_thickness, bracket_depth - plate_thickness, bracket_height/3]);
        }
        
        // 底板安装孔（4个）
        hole_spacing = 30;
        for (dx = [(bracket_width - hole_spacing)/2, (bracket_width + hole_spacing)/2]) {
            for (dy = [15, bracket_depth - 15]) {
                translate([dx, dy, -0.1])
                cylinder(d = 6, h = plate_thickness + 0.2);
            }
        }
        
        // 轮轴安装孔
        translate([bracket_width/2, -0.1, bracket_height - 25])
        rotate([-90, 0, 0])
        cylinder(d = wheel_axle_diameter, h = plate_thickness + 0.2);
    }
}

// 带加强肋的版本
module C01_Wheel_Bracket_Reinforced() {
    C01_Wheel_Bracket();
    
    // 三角形加强肋
    color(color_frame)
    translate([5, plate_thickness, plate_thickness])
    rotate([0, -90, 0])
    linear_extrude(height = 3)
    polygon([[0, 0], [30, 0], [0, 30]]);
    
    translate([bracket_width - 2, plate_thickness, plate_thickness])
    rotate([0, -90, 0])
    linear_extrude(height = 3)
    polygon([[0, 0], [30, 0], [0, 30]]);
}

// 预览
C01_Wheel_Bracket_Reinforced();
