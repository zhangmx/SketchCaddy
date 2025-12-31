// ============================================
// F02_Flip_Lock.scad
// 翻板式搭扣锁 - 使用 NopSCADlib door_latch 模块
// ============================================

include <../libs/global_params.scad>

// 引入 NopSCADlib 锁扣模块
include <../../../libraries/NopSCADlib/core.scad>
use <../../../libraries/NopSCADlib/printed/door_latch.scad>

// ============================================
// NopSCADlib 门锁扣
// ============================================
module F02_Door_Latch_NopSCAD(sheet_thickness = 5) {
    door_latch_assembly(sheet_thickness);
}

// ============================================
// 自定义翻板式搭扣锁（备用/更适合箱体）
// ============================================

// 锁扣参数
base_width = 40;
base_length = 60;
base_thickness = 3;
lever_length = 50;
lever_width = 30;
lever_thickness = 3;
keyhole_diameter = 8;

module F02_Lock_Base() {
    color([0.75, 0.75, 0.78])
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
            cylinder(d = 4, h = base_thickness + 0.2, $fn = 16);
        }
        
        // 铰链轴孔
        translate([base_width/2, base_length, base_thickness + 5])
        rotate([0, 90, 0])
        cylinder(d = 4, h = 20, center = true, $fn = 16);
    }
}

module F02_Lock_Lever() {
    color(color_accent)
    difference() {
        union() {
            // 杆身
            hull() {
                translate([lever_width/2, 0, 0])
                cylinder(d = lever_width, h = lever_thickness, $fn = 32);
                translate([lever_width/2, lever_length - lever_width/2, 0])
                cylinder(d = lever_width/2, h = lever_thickness, $fn = 24);
            }
            
            // 钩头
            translate([lever_width/2 - 5, lever_length - 10, lever_thickness])
            cube([10, 10, 8]);
        }
        
        // 铰链孔
        translate([lever_width/2, 0, -0.1])
        cylinder(d = 4.5, h = lever_thickness + 0.2, $fn = 16);
        
        // 钥匙孔
        translate([lever_width/2, 15, -0.1])
        cylinder(d = keyhole_diameter, h = lever_thickness + 0.2, $fn = 24);
        
        // 钩口
        translate([lever_width/2 - 3, lever_length, lever_thickness + 2])
        cube([6, 15, 6]);
    }
}

module F02_Lock_Catch() {
    // 锁扣钩（安装在另一侧面板上）
    color([0.75, 0.75, 0.78])
    difference() {
        union() {
            // 底板
            cube([25, 30, base_thickness]);
            // 钩柱
            translate([7.5, 10, base_thickness])
            cube([10, 10, 12]);
        }
        // 安装孔
        for (pos = [[12.5, 5], [12.5, 25]]) {
            translate([pos[0], pos[1], -0.1])
            cylinder(d = 4, h = base_thickness + 0.2, $fn = 16);
        }
        // 钩槽
        translate([7.5, 15, base_thickness + 6])
        cube([10, 10, 10]);
    }
}

// ============================================
// 完整翻板锁模块
// ============================================
module F02_Flip_Lock(locked = true) {
    // 底座
    F02_Lock_Base();
    
    // 杆（可动）
    translate([base_width/2 - lever_width/2, base_length - 5, base_thickness + 5])
    rotate([locked ? -90 : 0, 0, 0])
    translate([0, 0, -lever_thickness])
    F02_Lock_Lever();
    
    // 钩（需要安装在对面）
    // 这里只是展示位置
}

// ============================================
// 锁扣组件（包括钩）
// ============================================
module F02_Flip_Lock_Assembly(locked = true, show_catch = false) {
    F02_Flip_Lock(locked);
    
    if (show_catch) {
        // 钩安装在对面，偏移量取决于面板间距
        translate([base_width/2 - 12.5, base_length + 10, 0])
        F02_Lock_Catch();
    }
}

// 预览
if ($preview && is_undef($assembly_mode)) {
    // 锁定状态
    F02_Flip_Lock_Assembly(locked = true, show_catch = true);
    
    // 解锁状态
    translate([80, 0, 0])
    F02_Flip_Lock_Assembly(locked = false, show_catch = true);
    
    // NopSCADlib 版本
    translate([160, 0, 0])
    F02_Door_Latch_NopSCAD();
}
