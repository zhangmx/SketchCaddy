// ============================================
// D02_Telescoping_Handle.scad
// 三节式伸缩拉杆总成 - 带人机工学手柄
// ============================================

include <../libs/global_params.scad>
include <../libs/utils.scad>

// 拉杆参数
section1_length = 350;       // 第一节（最粗）
section2_length = 300;       // 第二节
section3_length = 250;       // 第三节（最细）

tube1_diameter = 20;         // 第一节直径
tube2_diameter = 16;         // 第二节直径
tube3_diameter = 12;         // 第三节直径

tube_spacing = 40;           // 两根管间距
wall_thickness = 1.5;

// 手柄参数
handle_width = 200;          // 手柄宽度
handle_diameter = 30;        // 手柄直径
handle_height = 40;          // 手柄高度

// ============================================
// 单根伸缩管模块
// ============================================
module D02_Telescoping_Tube(d1, d2, d3, l1, l2, l3, extension = 0) {
    // 第一节
    color(color_handle)
    difference() {
        cylinder(d = d1, h = l1);
        translate([0, 0, wall_thickness])
        cylinder(d = d1 - 2*wall_thickness, h = l1);
    }
    
    // 第二节（可伸出）
    color([0.35, 0.35, 0.4])
    translate([0, 0, l1 - 30 + extension * 0.6])
    difference() {
        cylinder(d = d2, h = l2);
        translate([0, 0, wall_thickness])
        cylinder(d = d2 - 2*wall_thickness, h = l2);
    }
    
    // 第三节（可伸出）
    color([0.4, 0.4, 0.45])
    translate([0, 0, l1 + l2 - 60 + extension])
    difference() {
        cylinder(d = d3, h = l3);
        translate([0, 0, wall_thickness])
        cylinder(d = d3 - 2*wall_thickness, h = l3);
    }
}

// ============================================
// 人机工学手柄模块
// ============================================
module D02_Handle() {
    color([0.2, 0.2, 0.2]) {
        // 主握把
        translate([0, 0, 0])
        rotate([0, 90, 0])
        linear_extrude(height = handle_width, center = true)
        hull() {
            translate([0, 0]) circle(d = handle_diameter);
            translate([handle_height - handle_diameter/2, 0]) 
            circle(d = handle_diameter - 5);
        }
        
        // 防滑纹理（简化表示）
        for (x = [-handle_width/2 + 20 : 10 : handle_width/2 - 20]) {
            translate([x, 0, handle_height/2])
            rotate([0, 90, 0])
            cylinder(d = 2, h = 5, center = true);
        }
    }
}

// ============================================
// D03 画板卡槽（集成在手柄上）
// ============================================
module D03_Canvas_Notch() {
    notch_width = 15;
    notch_depth = 20;
    notch_height = 8;
    
    color(color_accent)
    translate([0, -handle_diameter/2 - notch_depth/2, handle_height])
    difference() {
        cube([notch_width, notch_depth, notch_height], center = true);
        // V形槽
        translate([0, 0, notch_height/2])
        rotate([0, 0, 0])
        linear_extrude(height = notch_height + 1, center = true)
        polygon([[-notch_width/2 - 1, 0], 
                 [notch_width/2 + 1, 0], 
                 [0, -notch_depth + 5]]);
    }
}

// ============================================
// 完整伸缩拉杆总成
// ============================================
module D02_Telescoping_Handle(extension = 0) {
    total_height = section1_length + section2_length + section3_length - 60 + extension;
    
    // 左侧拉杆管
    translate([-tube_spacing/2, 0, 0])
    D02_Telescoping_Tube(tube1_diameter, tube2_diameter, tube3_diameter,
                         section1_length, section2_length, section3_length, extension);
    
    // 右侧拉杆管
    translate([tube_spacing/2, 0, 0])
    D02_Telescoping_Tube(tube1_diameter, tube2_diameter, tube3_diameter,
                         section1_length, section2_length, section3_length, extension);
    
    // 手柄
    translate([0, 0, total_height])
    D02_Handle();
    
    // 画板卡槽
    translate([0, 0, total_height])
    D03_Canvas_Notch();
}

// 预览
if ($preview && is_undef($assembly_mode)) {
    D02_Telescoping_Handle(extension = 200);
}
