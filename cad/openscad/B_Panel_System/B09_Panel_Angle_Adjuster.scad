// ============================================
// B09_Panel_Angle_Adjuster.scad
// 画板角度调节器 - 5档位，带弹簧卡珠
// ============================================

use <../libs/global_params.scad>
use <../libs/utils.scad>

// 调节器参数
bracket_length = 80;
bracket_width = 20;
bracket_thickness = 3;
hole_spacing = 15;           // 档位间距
num_positions = 5;           // 5档位
pivot_hole_diameter = 6;     // 转轴孔
position_hole_diameter = 5;  // 定位孔

// ============================================
// 固定支架（安装在顶板上）
// ============================================
module B09_Fixed_Bracket() {
    color(color_frame)
    difference() {
        union() {
            // 底座
            cube([bracket_width, bracket_length, bracket_thickness]);
            // 立柱
            translate([0, 0, 0])
            cube([bracket_thickness, bracket_length, 30]);
        }
        
        // 转轴孔
        translate([-0.1, bracket_length - 15, 20])
        rotate([0, 90, 0])
        cylinder(d = pivot_hole_diameter, h = bracket_thickness + 0.2);
        
        // 底座固定孔
        for (y = [20, bracket_length - 20]) {
            translate([bracket_width/2, y, -0.1])
            cylinder(d = 4, h = bracket_thickness + 0.2);
        }
    }
}

// ============================================
// 可调臂（连接画板）
// ============================================
module B09_Adjustable_Arm() {
    arm_length = 100;
    
    color(color_accent)
    difference() {
        union() {
            // 主臂
            cube([bracket_thickness, arm_length, bracket_width]);
            // 画板夹持端加宽
            translate([0, arm_length - 10, 0])
            cube([bracket_thickness, 10, bracket_width + 10]);
        }
        
        // 转轴孔（与固定支架连接）
        translate([-0.1, 15, bracket_width/2])
        rotate([0, 90, 0])
        cylinder(d = pivot_hole_diameter, h = bracket_thickness + 0.2);
        
        // 多档位定位孔
        for (i = [0:num_positions-1]) {
            translate([-0.1, 30 + i * hole_spacing, bracket_width/2])
            rotate([0, 90, 0])
            cylinder(d = position_hole_diameter, h = bracket_thickness + 0.2);
        }
        
        // 画板固定槽
        translate([-0.1, arm_length - 5, bracket_width + 2])
        rotate([0, 90, 0])
        cylinder(d = 8, h = bracket_thickness + 0.2);
    }
}

// ============================================
// 弹簧卡珠组件
// ============================================
module B09_Spring_Ball_Plunger() {
    plunger_diameter = 4;
    plunger_length = 10;
    
    color([0.8, 0.8, 0.8])
    union() {
        cylinder(d = plunger_diameter, h = plunger_length);
        translate([0, 0, plunger_length])
        sphere(d = 3);
    }
}

// ============================================
// 完整角度调节器组件
// ============================================
module B09_Panel_Angle_Adjuster(angle = 0) {
    // 固定支架
    B09_Fixed_Bracket();
    
    // 可调臂（可旋转）
    translate([bracket_thickness, bracket_length - 15, 20])
    rotate([angle, 0, 0])
    translate([0, -15, -bracket_width/2])
    B09_Adjustable_Arm();
}

// 预览
B09_Panel_Angle_Adjuster(angle = 30);
