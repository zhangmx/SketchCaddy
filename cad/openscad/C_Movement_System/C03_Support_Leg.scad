// ============================================
// C03_Support_Leg.scad
// 支撑支腿 - 无轮端，带可调节脚垫
// ============================================

use <../libs/global_params.scad>
use <../libs/utils.scad>

// 支腿参数
leg_length = 100;            // 支腿长度
leg_diameter = 20;           // 支腿管径
wall_thickness = 2;          // 管壁厚

// 脚垫参数
foot_diameter = 40;          // 脚垫直径
foot_height = 15;            // 脚垫高度
rubber_thickness = 5;        // 橡胶层厚度

// 调节螺纹
thread_diameter = 10;        // M10螺纹
thread_length = 30;          // 可调节范围

// ============================================
// 支腿管模块
// ============================================
module C03_Leg_Tube() {
    color(color_frame)
    difference() {
        cylinder(d = leg_diameter, h = leg_length);
        translate([0, 0, -0.1])
        cylinder(d = leg_diameter - 2*wall_thickness, h = leg_length + 0.2);
    }
}

// ============================================
// 可调节脚垫模块
// ============================================
module C03_Adjustable_Foot(extension = 0) {
    translate([0, 0, -extension]) {
        // 橡胶底座
        color([0.2, 0.2, 0.2])
        cylinder(d1 = foot_diameter, d2 = foot_diameter - 5, h = rubber_thickness);
        
        // 金属调节盘
        color(color_frame)
        translate([0, 0, rubber_thickness]) {
            difference() {
                cylinder(d = foot_diameter - 8, h = foot_height - rubber_thickness);
                // 滚花纹理
                for (i = [0:20:360]) {
                    rotate([0, 0, i])
                    translate([(foot_diameter - 8)/2, 0, 0])
                    cylinder(d = 2, h = foot_height);
                }
            }
        }
        
        // 螺杆
        color(color_frame)
        translate([0, 0, foot_height])
        cylinder(d = thread_diameter, h = thread_length);
    }
}

// ============================================
// 支腿顶部安装法兰
// ============================================
module C03_Mounting_Flange() {
    flange_diameter = 50;
    flange_thickness = 5;
    
    color(color_frame)
    difference() {
        union() {
            // 法兰盘
            cylinder(d = flange_diameter, h = flange_thickness);
            // 连接管
            translate([0, 0, flange_thickness])
            cylinder(d = leg_diameter, h = 15);
        }
        
        // 中心孔（用于穿线或排水）
        translate([0, 0, -0.1])
        cylinder(d = 8, h = flange_thickness + 16);
        
        // 安装孔
        for (i = [0:90:360]) {
            rotate([0, 0, i + 45])
            translate([flange_diameter/2 - 8, 0, -0.1])
            cylinder(d = 5, h = flange_thickness + 0.2);
        }
    }
}

// ============================================
// 完整支撑支腿组件
// ============================================
module C03_Support_Leg(foot_extension = 0) {
    // 顶部安装法兰
    translate([0, 0, leg_length])
    rotate([180, 0, 0])
    C03_Mounting_Flange();
    
    // 支腿管
    C03_Leg_Tube();
    
    // 可调节脚垫
    C03_Adjustable_Foot(foot_extension);
}

// 预览
C03_Support_Leg(foot_extension = 10);
