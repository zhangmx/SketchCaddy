// ============================================
// F01_Heavy_Duty_Hinge.scad
// 重型平面合页 - 使用 NopSCADlib flat_hinge 模块
// ============================================

include <../libs/global_params.scad>

// 引入 NopSCADlib 铰链模块
include <../../../libraries/NopSCADlib/core.scad>
use <../../../libraries/NopSCADlib/printed/flat_hinge.scad>

// ============================================
// 铰链类型定义
// flat_hinge(name, size, pin_d, knuckle_d, knuckles, screw, screws, clearance, margin)
// size = [width, depth, thickness]
// ============================================

// 重型合页参数（适用于面板门）
heavy_hinge_width = 80;      // 铰链宽度
heavy_hinge_depth = 35;      // 单侧深度
heavy_hinge_thickness = 3;   // 厚度
heavy_pin_diameter = 4;      // 铰链销直径（使用3D打印线材）
heavy_knuckle_diameter = 10; // 铰链节直径
heavy_knuckles = 5;          // 铰链节数量

// 定义重型合页类型
heavy_duty_hinge = flat_hinge(
    "heavy_duty_80",
    [heavy_hinge_width, heavy_hinge_depth, heavy_hinge_thickness],
    heavy_pin_diameter,
    heavy_knuckle_diameter,
    heavy_knuckles,
    M4_cap_screw,  // 使用M4螺丝
    3,             // 3个螺丝孔
    0.5,           // 间隙
    5              // 边距
);

// 中型合页（用于小门或面板）
medium_hinge_width = 50;
medium_hinge = flat_hinge(
    "medium_50",
    [medium_hinge_width, 25, 2.5],
    3,    // 3mm销
    8,    // 8mm铰链节
    3,    // 3个铰链节
    M3_cap_screw,
    2,
    0.4,
    3
);

// ============================================
// 重型合页模块（使用NopSCADlib）
// ============================================
module F01_Heavy_Duty_Hinge(angle = 0, type = heavy_duty_hinge) {
    // 使用 NopSCADlib 的 hinge_fastened_assembly
    // 但由于我们不需要完整装配，这里使用简化版本
    
    color([0.75, 0.75, 0.78]) {
        // 固定侧（male）
        hinge_male(type);
        
        // 活动侧（female），可旋转
        translate([0, -hinge_depth(type), 0])
        rotate([angle, 0, 0])
        translate([0, hinge_depth(type), 0])
        hinge_female(type);
    }
}

// ============================================
// 简化的重型合页模块（自定义版本，备用）
// ============================================
module F01_Heavy_Duty_Hinge_Simple(angle = 0) {
    hinge_length = 80;
    leaf_width = 30;
    leaf_thickness = 2.5;
    pin_diameter = 5;
    knuckle_count = 3;
    
    color([0.75, 0.75, 0.78]) {
        // 固定侧叶片
        F01_Hinge_Leaf_Simple(hinge_length, leaf_width, leaf_thickness, pin_diameter, knuckle_count, 0);
        
        // 活动侧叶片
        translate([leaf_width, 0, leaf_thickness/2])
        rotate([0, angle, 0])
        translate([-leaf_width, 0, -leaf_thickness/2])
        F01_Hinge_Leaf_Simple(hinge_length, leaf_width, leaf_thickness, pin_diameter, knuckle_count, 1);
        
        // 转轴
        translate([leaf_width, 0, leaf_thickness/2])
        rotate([-90, 0, 0])
        cylinder(d = pin_diameter, h = hinge_length, $fn = 20);
    }
}

module F01_Hinge_Leaf_Simple(length, width, thickness, pin_d, knuckles, side) {
    difference() {
        union() {
            // 叶片主体
            cube([width, length, thickness]);
            
            // 转轴套筒（交替排列）
            knuckle_length = length / knuckles;
            for (i = [side:2:knuckles-1]) {
                translate([width, i * knuckle_length, thickness/2])
                rotate([-90, 0, 0])
                cylinder(d = pin_d + 3, h = knuckle_length - 0.5, $fn = 20);
            }
        }
        
        // 转轴孔
        translate([width, -0.1, thickness/2])
        rotate([-90, 0, 0])
        cylinder(d = pin_d + 0.5, h = length + 0.2, $fn = 20);
        
        // 安装孔
        for (y = [length * 0.25, length * 0.5, length * 0.75]) {
            translate([width * 0.4, y, -0.1])
            cylinder(d = 4, h = thickness + 0.2, $fn = 16);
            // 沉头
            translate([width * 0.4, y, thickness - 1])
            cylinder(d1 = 4, d2 = 8, h = 1.1, $fn = 16);
        }
    }
}

// 预览
if ($preview && is_undef($assembly_mode)) {
    // 展示不同角度的合页
    F01_Heavy_Duty_Hinge_Simple(angle = 0);
    
    translate([0, 100, 0])
    F01_Heavy_Duty_Hinge_Simple(angle = 90);
    
    translate([0, 200, 0])
    F01_Heavy_Duty_Hinge_Simple(angle = 180);
}
