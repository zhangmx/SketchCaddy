// ============================================
// A02_Corner_Bracket.scad
// 铝型材角码连接件
// 使用 NopSCADlib 库的标准角码模块
// ============================================

include <../libs/global_params.scad>

// 引入 NopSCADlib 角码模块
// 注意：需要将 libraries 目录添加到 OpenSCAD 的库路径中
use <../../../libraries/NopSCADlib/vitamins/extrusion_bracket.scad>
include <../../../libraries/NopSCADlib/vitamins/extrusion_brackets.scad>

// ============================================
// 角码类型选择
// ============================================
// NopSCADlib 提供的角码类型:
// - E20_inner_corner_bracket: 20系列内角码
// - E20_corner_bracket: 20系列外角码
// - E40_inner_corner_bracket: 40系列内角码
// - E40_corner_bracket: 40系列外角码
// - extrusion_corner_bracket_3D_2020: 2020三维角码
// - extrusion_corner_bracket_3D_3030: 3030三维角码
// - extrusion_corner_bracket_3D_4040: 4040三维角码

// 由于我们使用 Makerbeam (10x10)，选择最小的 E20 角码
// （NopSCADlib 没有专门的 10x10 角码，使用 20 系列兼容）
default_bracket_type = E20_corner_bracket;
default_inner_bracket_type = E20_inner_corner_bracket;

// ============================================
// 2D 平面角码模块（外角码）
// ============================================
module A02_Corner_Bracket(type = default_bracket_type) {
    extrusion_corner_bracket(type);
}

// ============================================
// 2D 平面内角码模块
// ============================================
module A02_Inner_Corner_Bracket(type = default_inner_bracket_type, grub_screws = true) {
    extrusion_inner_corner_bracket(type, grub_screws);
}

// ============================================
// 3D 三维角码模块（用于三轴交汇的角落）
// ============================================
module A02_Corner_Bracket_3D(type = extrusion_corner_bracket_3D_2020) {
    extrusion_corner_bracket_3D(type);
}

// 带螺丝装配的完整角码
module A02_Corner_Bracket_Assembly(type = default_bracket_type) {
    extrusion_corner_bracket_assembly(type);
}

// ============================================
// 角落安装用的三向角码（自定义简化版）
// 用于 10x10 型材框架角落
// ============================================
module A02_Corner_Bracket_3Way_Simple() {
    bracket_size = 20;
    bracket_thickness = 3;
    bracket_width = 10;
    hole_diameter = 4;
    hole_offset = 10;
    
    color(color_accent)
    difference() {
        union() {
            // 三个方向的臂
            cube([bracket_size, bracket_width, bracket_thickness]);
            cube([bracket_thickness, bracket_width, bracket_size]);
            rotate([0, 0, 90])
            translate([0, -bracket_width, 0])
            cube([bracket_size, bracket_width, bracket_thickness]);
        }
        
        // X方向孔
        translate([hole_offset, bracket_width/2, -0.1])
        cylinder(d = hole_diameter, h = bracket_thickness + 0.2, $fn = 16);
        
        // Z方向孔
        translate([-0.1, bracket_width/2, hole_offset])
        rotate([0, 90, 0])
        cylinder(d = hole_diameter, h = bracket_thickness + 0.2, $fn = 16);
        
        // Y方向孔
        translate([bracket_width/2, hole_offset, -0.1])
        cylinder(d = hole_diameter, h = bracket_thickness + 0.2, $fn = 16);
    }
}

// 预览（仅在直接打开此文件时显示）
if ($preview && is_undef($assembly_mode)) {
    // 展示不同类型的角码
    translate([0, 0, 0]) 
    A02_Corner_Bracket();
    
    translate([50, 0, 0]) 
    A02_Inner_Corner_Bracket();
    
    translate([100, 0, 0]) 
    A02_Corner_Bracket_3Way_Simple();
}
