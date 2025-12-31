// ============================================
// F03_Panel_Quick_Release.scad
// 面板快拆锁扣 - 按压式，用于可拆卸侧板
// ============================================

include <../libs/global_params.scad>
include <../libs/utils.scad>

// 锁扣参数
body_diameter = 25;
body_length = 30;
button_diameter = 20;
button_depth = 5;

// 锁舌参数
latch_width = 8;
latch_length = 15;
latch_thickness = 3;

// ============================================
// 快拆锁扣本体
// ============================================
module F03_Quick_Release_Body() {
    color([0.3, 0.3, 0.3])
    difference() {
        union() {
            // 主体圆柱
            cylinder(d = body_diameter, h = body_length);
            
            // 安装法兰
            translate([0, 0, body_length - 5])
            cylinder(d = body_diameter + 10, h = 5);
        }
        
        // 按钮腔
        translate([0, 0, -0.1])
        cylinder(d = button_diameter, h = button_depth + 0.1);
        
        // 锁舌滑槽
        translate([-latch_width/2, -body_diameter/2 - 1, body_length/2])
        cube([latch_width, body_diameter + 2, body_length/2 + 1]);
        
        // 安装孔
        for (angle = [45, 135, 225, 315]) {
            rotate([0, 0, angle])
            translate([body_diameter/2 + 3, 0, body_length - 2.5])
            cylinder(d = 3, h = 6);
        }
    }
}

// ============================================
// 按钮
// ============================================
module F03_Button() {
    color(color_accent)
    difference() {
        cylinder(d = button_diameter - 1, h = button_depth);
        // 防滑纹
        for (i = [0:30:360]) {
            rotate([0, 0, i])
            translate([button_diameter/2 - 2, 0, -0.1])
            cylinder(d = 1, h = button_depth + 0.2);
        }
    }
}

// ============================================
// 锁舌
// ============================================
module F03_Latch() {
    color([0.7, 0.7, 0.7])
    translate([0, 0, 0])
    union() {
        // 舌体
        translate([-latch_width/2, 0, 0])
        cube([latch_width, latch_length, latch_thickness]);
        
        // 斜面引导
        translate([-latch_width/2, latch_length, 0])
        rotate([30, 0, 0])
        cube([latch_width, 5, latch_thickness]);
    }
}

// ============================================
// 接收座（安装在框架侧）
// ============================================
module F03_Receiver() {
    receiver_size = 35;
    receiver_depth = 20;
    
    color(color_frame)
    difference() {
        cube([receiver_size, receiver_size, receiver_depth], center = true);
        
        // 锁扣插入孔
        translate([0, 0, 0])
        cylinder(d = body_diameter + 1, h = receiver_depth + 1, center = true);
        
        // 锁舌卡槽
        translate([0, 0, -receiver_depth/2])
        cube([latch_width + 2, body_diameter + 20, latch_thickness + 2], center = true);
        
        // 安装孔
        for (x = [-receiver_size/2 + 5, receiver_size/2 - 5]) {
            for (y = [-receiver_size/2 + 5, receiver_size/2 - 5]) {
                translate([x, y, 0])
                cylinder(d = 4, h = receiver_depth + 1, center = true);
            }
        }
    }
}

// ============================================
// 完整快拆锁扣组件
// ============================================
module F03_Panel_Quick_Release(engaged = true) {
    // 锁扣本体
    F03_Quick_Release_Body();
    
    // 按钮
    translate([0, 0, 0.5])
    F03_Button();
    
    // 锁舌
    latch_extend = engaged ? latch_length/2 : 0;
    translate([0, body_diameter/2 + latch_extend, body_length/2 + latch_thickness/2])
    rotate([90, 0, 0])
    F03_Latch();
    
    // 接收座（偏移显示）
    translate([60, 0, body_length/2])
    F03_Receiver();
}

// 预览
if ($preview && is_undef($assembly_mode)) {
    F03_Panel_Quick_Release(engaged = true);
}
