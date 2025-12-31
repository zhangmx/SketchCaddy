// ============================================
// F01_Heavy_Duty_Hinge.scad
// 重型平面合页 - 用于门板，不锈钢
// ============================================

include <../libs/global_params.scad>
include <../libs/utils.scad>

// 合页参数
hinge_length = 80;           // 合页总长
leaf_width = 30;             // 单侧叶片宽度
leaf_thickness = 2;          // 叶片厚度
pin_diameter = 5;            // 转轴直径
knuckle_count = 3;           // 转轴节数

// ============================================
// 合页叶片模块
// ============================================
module F01_Hinge_Leaf() {
    color([0.8, 0.8, 0.8])
    difference() {
        union() {
            // 叶片主体
            cube([leaf_width, hinge_length, leaf_thickness]);
            
            // 转轴套筒（交替排列）
            for (i = [0:2:knuckle_count-1]) {
                knuckle_length = hinge_length / knuckle_count;
                translate([leaf_width, i * knuckle_length, leaf_thickness/2])
                rotate([-90, 0, 0])
                cylinder(d = pin_diameter + 2, h = knuckle_length);
            }
        }
        
        // 转轴孔
        translate([leaf_width, -0.1, leaf_thickness/2])
        rotate([-90, 0, 0])
        cylinder(d = pin_diameter + 0.5, h = hinge_length + 0.2);
        
        // 安装孔
        for (y = [hinge_length/4, hinge_length/2, 3*hinge_length/4]) {
            translate([leaf_width/2, y, -0.1])
            cylinder(d = 4, h = leaf_thickness + 0.2);
            // 沉头
            translate([leaf_width/2, y, leaf_thickness - 1])
            cylinder(d1 = 4, d2 = 8, h = 1.1);
        }
    }
}

// ============================================
// 完整合页模块
// ============================================
module F01_Heavy_Duty_Hinge(angle = 0) {
    // 固定侧叶片
    F01_Hinge_Leaf();
    
    // 活动侧叶片
    translate([leaf_width, 0, leaf_thickness/2])
    rotate([0, angle, 0])
    translate([-leaf_width, 0, -leaf_thickness/2])
    mirror([1, 0, 0])
    translate([-leaf_width * 2, 0, 0])
    F01_Hinge_Leaf();
    
    // 转轴
    color([0.7, 0.7, 0.7])
    translate([leaf_width, 0, leaf_thickness/2])
    rotate([-90, 0, 0])
    cylinder(d = pin_diameter, h = hinge_length);
}

// 预览
if ($preview && is_undef($assembly_mode)) {
    F01_Heavy_Duty_Hinge(angle = 45);
}
