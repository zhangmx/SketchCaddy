// ============================================
// A03_Foot_Pad.scad
// 支腿/调平地脚 - 安装在底部四角
// ============================================

use <../libs/global_params.scad>
use <../libs/utils.scad>

// 地脚参数
foot_diameter = 30;          // 底部直径
foot_height = 15;            // 总高度
thread_diameter = 8;         // 螺纹直径
thread_length = 20;          // 螺纹长度
rubber_thickness = 5;        // 橡胶垫厚度

// ============================================
// 调平地脚模块
// ============================================
module A03_Foot_Pad() {
    // 橡胶底座
    color([0.2, 0.2, 0.2])
    cylinder(d1 = foot_diameter, d2 = foot_diameter - 4, h = rubber_thickness);
    
    // 金属调节螺杆
    color(color_frame)
    translate([0, 0, rubber_thickness]) {
        // 螺杆头（可调节部分，带滚花）
        difference() {
            cylinder(d = 15, h = foot_height - rubber_thickness);
            // 滚花纹理
            for (i = [0:15:360]) {
                rotate([0, 0, i])
                translate([7.5, 0, 0])
                cylinder(d = 1, h = foot_height);
            }
        }
        
        // 螺纹杆
        translate([0, 0, foot_height - rubber_thickness])
        cylinder(d = thread_diameter, h = thread_length);
    }
}

// 可调高度的地脚组件
module A03_Foot_Pad_Adjustable(extension = 0) {
    translate([0, 0, -extension])
    A03_Foot_Pad();
}

// 预览
A03_Foot_Pad();
