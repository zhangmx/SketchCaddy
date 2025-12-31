// ============================================
// E03_Drawer_Unit.scad
// 可抽拉储物抽屉单元 - 用于颜料、笔刷
// ============================================

include <../libs/global_params.scad>
include <../libs/utils.scad>

// 抽屉参数
drawer_width = 200;
drawer_depth = 450;
drawer_height = 80;
wall_thickness = 3;

// 滑轨参数
rail_width = 15;
rail_height = 10;

// 把手参数
handle_width = 80;
handle_height = 20;

// ============================================
// 抽屉本体模块
// ============================================
module E03_Drawer_Body() {
    color([0.4, 0.4, 0.4])
    difference() {
        // 外壳
        cube([drawer_width, drawer_depth, drawer_height]);
        
        // 内腔
        translate([wall_thickness, wall_thickness, wall_thickness])
        cube([drawer_width - 2*wall_thickness, 
              drawer_depth - 2*wall_thickness, 
              drawer_height]);
        
        // 前面板把手孔
        translate([drawer_width/2, -0.1, drawer_height/2])
        rotate([-90, 0, 0])
        hull() {
            translate([-handle_width/2 + 10, 0, 0]) 
            cylinder(d = handle_height, h = wall_thickness + 0.2);
            translate([handle_width/2 - 10, 0, 0]) 
            cylinder(d = handle_height, h = wall_thickness + 0.2);
        }
    }
    
    // 分隔板
    E03_Dividers();
}

// 抽屉分隔板
module E03_Dividers() {
    divider_height = drawer_height - wall_thickness - 5;
    
    color([0.5, 0.5, 0.5])
    // 纵向分隔
    for (x = [drawer_width/3, 2*drawer_width/3]) {
        translate([x - 1.5, wall_thickness + 10, wall_thickness])
        cube([3, drawer_depth - 2*wall_thickness - 20, divider_height]);
    }
    
    // 横向分隔
    translate([wall_thickness + 10, drawer_depth/2 - 1.5, wall_thickness])
    cube([drawer_width - 2*wall_thickness - 20, 3, divider_height]);
}

// ============================================
// 抽屉滑轨模块
// ============================================
module E03_Drawer_Rail(length) {
    color(color_frame)
    difference() {
        cube([rail_width, length, rail_height]);
        // 滑槽
        translate([rail_width/2, -0.1, rail_height/2])
        rotate([-90, 0, 0])
        cylinder(d = 6, h = length + 0.2);
    }
}

// ============================================
// 抽屉把手模块
// ============================================
module E03_Handle() {
    color([0.2, 0.2, 0.2])
    translate([drawer_width/2, -15, drawer_height/2])
    rotate([0, 90, 0])
    linear_extrude(height = handle_width, center = true)
    hull() {
        circle(d = 15);
        translate([0, 15]) circle(d = 10);
    }
}

// ============================================
// 完整抽屉单元（含滑轨）
// ============================================
module E03_Drawer_Unit(pull_out = 0) {
    // 左滑轨
    translate([-rail_width - 5, 0, 0])
    E03_Drawer_Rail(drawer_depth + 50);
    
    // 右滑轨
    translate([drawer_width + 5, 0, 0])
    E03_Drawer_Rail(drawer_depth + 50);
    
    // 抽屉本体（可抽出）
    translate([0, -pull_out, rail_height]) {
        E03_Drawer_Body();
        E03_Handle();
    }
}

// 预览
if ($preview && is_undef($assembly_mode)) {
    E03_Drawer_Unit(pull_out = 100);
}
