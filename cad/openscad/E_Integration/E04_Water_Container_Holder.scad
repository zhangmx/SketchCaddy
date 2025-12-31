// ============================================
// E04_Water_Container_Holder.scad
// 水具/水桶固定架
// ============================================

use <../libs/global_params.scad>
use <../libs/utils.scad>

// 固定架参数
holder_diameter = 120;       // 适配常见水桶直径
holder_height = 100;
wall_thickness = 4;

// 固定带参数
strap_width = 25;
strap_thickness = 2;

// 底座参数
base_width = 150;
base_depth = 150;
base_thickness = 5;

// ============================================
// 环形固定架模块
// ============================================
module E04_Ring_Holder() {
    color(color_frame)
    difference() {
        cylinder(d = holder_diameter + 2*wall_thickness, h = holder_height);
        translate([0, 0, -0.1])
        cylinder(d = holder_diameter, h = holder_height + 0.2);
        
        // 开口（方便放入/取出）
        translate([-holder_diameter/2 - wall_thickness - 1, 0, -0.1])
        cube([holder_diameter + 2*wall_thickness + 2, 
              holder_diameter/2 + wall_thickness + 1, 
              holder_height + 0.2]);
    }
}

// ============================================
// 固定带模块
// ============================================
module E04_Securing_Strap() {
    color([0.2, 0.2, 0.2])
    difference() {
        // 弧形带体
        rotate_extrude(angle = 180)
        translate([holder_diameter/2 + wall_thickness/2, 0, 0])
        square([strap_thickness, strap_width]);
        
        // 如需卡扣孔可在此添加
    }
    
    // 卡扣
    color(color_accent)
    translate([0, holder_diameter/2 + wall_thickness + 5, strap_width/2])
    cube([20, 10, strap_width], center = true);
}

// ============================================
// 底座模块
// ============================================
module E04_Base_Plate() {
    color(color_panel)
    difference() {
        // 底座板
        translate([0, 0, 0])
        cube([base_width, base_depth, base_thickness], center = true);
        
        // 排水孔
        for (x = [-30, 0, 30]) {
            for (y = [-30, 0, 30]) {
                translate([x, y, 0])
                cylinder(d = 8, h = base_thickness + 1, center = true);
            }
        }
        
        // 安装孔
        for (x = [-base_width/2 + 15, base_width/2 - 15]) {
            for (y = [-base_depth/2 + 15, base_depth/2 - 15]) {
                translate([x, y, 0])
                cylinder(d = 6, h = base_thickness + 1, center = true);
            }
        }
    }
}

// ============================================
// 安装支架
// ============================================
module E04_Mounting_Bracket() {
    bracket_height = 30;
    
    color(color_frame)
    difference() {
        union() {
            // 垂直板
            translate([-base_width/2, -wall_thickness/2, 0])
            cube([base_width, wall_thickness, bracket_height]);
            
            // 底部法兰
            translate([-base_width/2, -15, 0])
            cube([base_width, 15, wall_thickness]);
        }
        
        // 安装孔
        for (x = [-base_width/2 + 20, 0, base_width/2 - 20]) {
            translate([x, -7.5, -0.1])
            cylinder(d = 5, h = wall_thickness + 0.2);
        }
    }
}

// ============================================
// 完整水具固定架
// ============================================
module E04_Water_Container_Holder() {
    // 底座
    translate([0, 0, base_thickness/2])
    E04_Base_Plate();
    
    // 环形固定架
    translate([0, 0, base_thickness])
    E04_Ring_Holder();
    
    // 固定带
    translate([0, 0, base_thickness + holder_height/2])
    E04_Securing_Strap();
    
    // 后部安装支架
    translate([0, -base_depth/2 + wall_thickness, base_thickness])
    E04_Mounting_Bracket();
}

// 预览
E04_Water_Container_Holder();
