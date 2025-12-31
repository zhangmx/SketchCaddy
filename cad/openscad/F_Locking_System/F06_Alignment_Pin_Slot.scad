// ============================================
// F06_Alignment_Pin_Slot.scad
// 定位销与滑槽 - 防止面板错位和脱落
// ============================================

use <../libs/global_params.scad>
use <../libs/utils.scad>

// 定位销参数
pin_diameter = 8;
pin_length = 15;
pin_head_diameter = 12;
pin_head_height = 3;

// 滑槽参数
slot_width = 10;             // 略大于销径
slot_length = 25;            // 允许一定滑动
slot_depth = 12;

// 底座参数
base_size = 30;
base_thickness = 5;

// ============================================
// 定位销模块
// ============================================
module F06_Alignment_Pin() {
    color(color_frame)
    union() {
        // 销体（带锥形引导）
        cylinder(d1 = pin_diameter - 2, d2 = pin_diameter, h = 3);
        translate([0, 0, 3])
        cylinder(d = pin_diameter, h = pin_length - 3);
        
        // 销头
        translate([0, 0, -pin_head_height])
        cylinder(d = pin_head_diameter, h = pin_head_height);
    }
    
    // 安装底座
    color(color_panel)
    translate([0, 0, -pin_head_height - base_thickness])
    difference() {
        cylinder(d = base_size, h = base_thickness);
        // 安装孔
        for (angle = [0, 90, 180, 270]) {
            rotate([0, 0, angle])
            translate([base_size/2 - 5, 0, -0.1])
            cylinder(d = 4, h = base_thickness + 0.2);
        }
    }
}

// ============================================
// 滑槽模块
// ============================================
module F06_Slot_Receiver() {
    color(color_frame)
    difference() {
        // 槽体
        cube([slot_width + 10, slot_length + 10, slot_depth + base_thickness]);
        
        // 滑槽腔
        translate([5, 5, base_thickness])
        hull() {
            cylinder(d = slot_width, h = slot_depth + 0.1);
            translate([0, slot_length, 0])
            cylinder(d = slot_width, h = slot_depth + 0.1);
        }
        
        // 入口倒角
        translate([5 + slot_width/2, 5, slot_depth + base_thickness - 2])
        hull() {
            cylinder(d1 = slot_width, d2 = slot_width + 4, h = 2.1);
            translate([0, slot_length, 0])
            cylinder(d1 = slot_width, d2 = slot_width + 4, h = 2.1);
        }
        
        // 安装孔
        for (x = [2, slot_width + 8]) {
            for (y = [2, slot_length + 8]) {
                translate([x, y, -0.1])
                cylinder(d = 4, h = base_thickness + 0.2);
            }
        }
    }
}

// ============================================
// 弹簧锁定滑槽（高级版本）
// ============================================
module F06_Spring_Loaded_Slot() {
    color(color_frame)
    difference() {
        F06_Slot_Receiver();
        
        // 弹簧球凹槽（锁定位置）
        translate([5 + slot_width/2, 5, base_thickness + slot_depth/2])
        rotate([90, 0, 0])
        cylinder(d = 5, h = 3);
        
        translate([5 + slot_width/2, 5 + slot_length, base_thickness + slot_depth/2])
        rotate([90, 0, 0])
        cylinder(d = 5, h = 3);
    }
    
    // 弹簧球指示
    color(color_accent)
    translate([5 + slot_width/2, 3, base_thickness + slot_depth/2])
    sphere(d = 4);
}

// ============================================
// 完整定位组件
// ============================================
module F06_Alignment_Pin_Slot() {
    // 定位销
    F06_Alignment_Pin();
    
    // 对应滑槽（偏移显示）
    translate([50, -5, -pin_head_height - base_thickness])
    F06_Slot_Receiver();
}

// 预览
F06_Alignment_Pin_Slot();
