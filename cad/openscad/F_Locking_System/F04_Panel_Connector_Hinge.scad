// ============================================
// F04_Panel_Connector_Hinge.scad
// 面板拼接铰链 - 用于三合一画板功能
// ============================================

include <../libs/global_params.scad>
include <../libs/utils.scad>

// 铰链参数
hinge_length = 100;          // 铰链长度
leaf_width = 25;             // 叶片宽度
leaf_thickness = 2;          // 叶片厚度
gap = 2;                     // 两板之间间隙

// 定位结构参数
pin_diameter = 6;
pin_length = 8;

// ============================================
// 铰链叶片
// ============================================
module F04_Hinge_Leaf() {
    color([0.75, 0.75, 0.75])
    difference() {
        cube([leaf_width, hinge_length, leaf_thickness]);
        
        // 安装孔
        for (y = [15, hinge_length/2, hinge_length - 15]) {
            translate([leaf_width/2, y, -0.1])
            cylinder(d = 4, h = leaf_thickness + 0.2);
        }
    }
}

// ============================================
// 连接轴套
// ============================================
module F04_Knuckle() {
    knuckle_outer = 8;
    knuckle_inner = 4;
    
    color([0.8, 0.8, 0.8])
    difference() {
        cylinder(d = knuckle_outer, h = hinge_length/5);
        translate([0, 0, -0.1])
        cylinder(d = knuckle_inner, h = hinge_length/5 + 0.2);
    }
}

// ============================================
// 平面定位销
// ============================================
module F04_Alignment_Pin() {
    color(color_frame)
    union() {
        // 销体
        cylinder(d = pin_diameter, h = pin_length);
        // 头部
        translate([0, 0, pin_length])
        cylinder(d = pin_diameter + 2, h = 2);
    }
}

// ============================================
// 完整拼接铰链
// ============================================
module F04_Panel_Connector_Hinge(angle = 0) {
    // 左侧叶片
    F04_Hinge_Leaf();
    
    // 轴套（交替排列）
    for (i = [0:4]) {
        translate([leaf_width, i * hinge_length/5, leaf_thickness/2])
        rotate([-90, 0, 0])
        F04_Knuckle();
    }
    
    // 右侧叶片（可旋转）
    translate([leaf_width + gap, 0, 0])
    rotate([0, -angle, 0])
    translate([0, 0, 0])
    F04_Hinge_Leaf();
    
    // 连接轴
    color([0.6, 0.6, 0.6])
    translate([leaf_width, 0, leaf_thickness/2])
    rotate([-90, 0, 0])
    cylinder(d = 3.5, h = hinge_length);
}

// ============================================
// 带定位功能的铰链组件
// ============================================
module F04_Panel_Connector_With_Alignment(angle = 0) {
    // 主铰链
    F04_Panel_Connector_Hinge(angle);
    
    // 定位销（确保180度时平面对齐）
    if (angle == 0 || angle == 180) {
        translate([leaf_width/2, hinge_length + 10, leaf_thickness])
        F04_Alignment_Pin();
        
        translate([leaf_width + gap + leaf_width/2, hinge_length + 10, leaf_thickness])
        rotate([180, 0, 0])
        translate([0, 0, -pin_length - 2])
        F04_Alignment_Pin();
    }
}

// 预览
if ($preview && is_undef($assembly_mode)) {
    F04_Panel_Connector_Hinge(angle = 0);
}
