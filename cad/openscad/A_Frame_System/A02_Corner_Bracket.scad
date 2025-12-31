// ============================================
// A02_Corner_Bracket.scad
// 90度直角连接件 - 用于连接铝型材
// ============================================

include <../libs/global_params.scad>
include <../libs/utils.scad>

// 角码参数
bracket_size = 20;           // 角码臂长
bracket_thickness = 3;       // 壁厚
bracket_width = 10;          // 宽度（匹配型材）
hole_diameter = 4;           // 螺丝孔直径
hole_offset = 10;            // 孔距边缘

// ============================================
// 90度角码模块
// ============================================
module A02_Corner_Bracket() {
    color(color_accent)
    difference() {
        union() {
            // L形主体
            // 水平臂
            cube([bracket_size, bracket_width, bracket_thickness]);
            // 垂直臂  
            cube([bracket_thickness, bracket_width, bracket_size]);
            // 加强筋（三角形）
            translate([bracket_thickness, 0, bracket_thickness])
            rotate([0, 0, 0])
            linear_extrude(height = bracket_width)
            rotate([0, 0, -90])
            polygon([
                [0, 0],
                [bracket_size - bracket_thickness, 0],
                [0, bracket_size - bracket_thickness]
            ]);
        }
        
        // 水平臂螺丝孔
        translate([hole_offset, bracket_width/2, -0.1])
        cylinder(d = hole_diameter, h = bracket_thickness + 0.2);
        
        // 垂直臂螺丝孔
        translate([-0.1, bracket_width/2, hole_offset])
        rotate([0, 90, 0])
        cylinder(d = hole_diameter, h = bracket_thickness + 0.2);
    }
}

// 角落安装用的三向角码
module A02_Corner_Bracket_3Way() {
    color(color_accent)
    difference() {
        union() {
            // 三个方向的臂
            cube([bracket_size, bracket_width, bracket_thickness]);
            cube([bracket_thickness, bracket_width, bracket_size]);
            cube([bracket_width, bracket_size, bracket_thickness]);
        }
        
        // X方向孔
        translate([hole_offset, bracket_width/2, -0.1])
        cylinder(d = hole_diameter, h = bracket_thickness + 0.2);
        
        // Z方向孔
        translate([-0.1, bracket_width/2, hole_offset])
        rotate([0, 90, 0])
        cylinder(d = hole_diameter, h = bracket_thickness + 0.2);
        
        // Y方向孔
        translate([bracket_width/2, hole_offset, -0.1])
        cylinder(d = hole_diameter, h = bracket_thickness + 0.2);
    }
}

// 预览（仅在直接打开此文件时显示）
if ($preview && is_undef($assembly_mode)) {
    translate([0, 0, 0]) A02_Corner_Bracket();
    translate([40, 0, 0]) A02_Corner_Bracket_3Way();
}
