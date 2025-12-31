// ============================================
// F02_Flip_Lock.scad
// 翻板式搭扣锁 - 用于门板锁闭，带钥匙孔
// ============================================

include <../libs/global_params.scad>
include <../libs/utils.scad>

// 锁扣参数
base_width = 40;
base_length = 60;
base_thickness = 3;
lever_length = 50;
lever_width = 30;
lever_thickness = 3;

// 钥匙孔参数
keyhole_diameter = 8;

// ============================================
// 锁扣底座模块
// ============================================
module F02_Lock_Base() {
    color([0.8, 0.8, 0.8])
    difference() {
        union() {
            // 底板
            cube([base_width, base_length, base_thickness]);
            
            // 铰链耳
            translate([base_width/2 - 8, base_length - 5, base_thickness])
            cube([16, 5, 10]);
        }
        
        // 安装孔
        for (y = [15, base_length - 20]) {
            translate([base_width/2, y, -0.1])
            cylinder(d = 4, h = base_thickness + 0.2);
        }
        
        // 铰链轴孔
        translate([base_width/2, base_length, base_thickness + 5])
        rotate([0, 90, 0])
        cylinder(d = 4, h = 20, center = true);
    }
}

// ============================================
// 锁扣杆模块
// ============================================
module F02_Lock_Lever() {
    color(color_accent)
    difference() {
        union() {
            // 杆身
            hull() {
                translate([lever_width/2, 0, 0])
                cylinder(d = lever_width, h = lever_thickness);
                translate([lever_width/2, lever_length - lever_width/2, 0])
                cylinder(d = lever_width/2, h = lever_thickness);
            }
            
            // 钩头
            translate([lever_width/2 - 5, lever_length - 10, lever_thickness])
            cube([10, 10, 8]);
        }
        
        // 铰链孔
        translate([lever_width/2, 0, -0.1])
        cylinder(d = 4.5, h = lever_thickness + 0.2);
        
        // 钥匙孔
        translate([lever_width/2, 15, -0.1])
        cylinder(d = keyhole_diameter, h = lever_thickness + 0.2);
        
        // 钩口
        translate([lever_width/2 - 3, lever_length, lever_thickness + 2])
        cube([6, 15, 6]);
    }
}

// ============================================
// 钩环（安装在另一侧）
// ============================================
module F02_Hook_Loop() {
    loop_width = 20;
    loop_height = 15;
    
    color([0.8, 0.8, 0.8])
    difference() {
        union() {
            // 底座
            cube([loop_width + 10, 25, base_thickness]);
            // 环体
            translate([5, 5, base_thickness])
            cube([loop_width, 5, loop_height]);
            translate([5, 15, base_thickness])
            cube([loop_width, 5, loop_height]);
        }
        
        // 安装孔
        translate([loop_width/2 + 5, 12.5, -0.1])
        cylinder(d = 4, h = base_thickness + 0.2);
    }
}

// ============================================
// 完整锁扣组件
// ============================================
module F02_Flip_Lock(locked = true) {
    angle = locked ? 0 : 90;
    
    // 底座
    F02_Lock_Base();
    
    // 锁扣杆
    translate([base_width/2 - lever_width/2, base_length, base_thickness + 5])
    rotate([angle, 0, 0])
    translate([0, 0, -lever_thickness/2])
    F02_Lock_Lever();
    
    // 钩环（偏移显示）
    translate([70, 0, 0])
    F02_Hook_Loop();
}

// 预览
if ($preview && is_undef($assembly_mode)) {
    F02_Flip_Lock(locked = true);
}
