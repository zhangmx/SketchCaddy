// ============================================
// G01_Folding_Stool.scad
// 集成式折叠凳 - 可从箱底抽出
// 户外写生专用便携折叠椅
// ============================================

include <../libs/global_params.scad>

// ============================================
// 折叠凳参数
// ============================================

// 座面尺寸
seat_width = 280;            // 座面宽度
seat_depth = 240;            // 座面深度
seat_thickness = 15;         // 座面厚度（铝框+布面）

// 腿部参数
leg_length = 400;            // 腿长
leg_width = 25;              // 腿宽（铝管）
leg_thickness = 2;           // 铝管壁厚
leg_spread_angle = 25;       // 腿展开角度

// 折叠后尺寸（需要能放入箱底）
folded_length = 480;         // 折叠后长度
folded_width = seat_width;   // 折叠后宽度
folded_height = 60;          // 折叠后高度

// 连接件参数
hinge_diameter = 8;          // 铰链直径
cross_bar_diameter = 15;     // 交叉杆直径

// ============================================
// 座面模块（铝框+布面）
// ============================================
module G01_Seat_Frame() {
    frame_tube = 20;  // 框架管径
    
    color(color_frame) {
        // 前边框
        translate([0, 0, 0])
        rotate([0, 90, 0])
        cylinder(d = frame_tube, h = seat_width, $fn = 24);
        
        // 后边框
        translate([0, seat_depth, 0])
        rotate([0, 90, 0])
        cylinder(d = frame_tube, h = seat_width, $fn = 24);
        
        // 左边框
        translate([0, 0, 0])
        rotate([-90, 0, 0])
        cylinder(d = frame_tube, h = seat_depth, $fn = 24);
        
        // 右边框
        translate([seat_width, 0, 0])
        rotate([-90, 0, 0])
        cylinder(d = frame_tube, h = seat_depth, $fn = 24);
        
        // 中间加强杆
        translate([seat_width/2, 0, 0])
        rotate([-90, 0, 0])
        cylinder(d = frame_tube * 0.8, h = seat_depth, $fn = 24);
    }
    
    // 布面
    color([0.2, 0.3, 0.5])
    translate([frame_tube/2, frame_tube/2, -2])
    cube([seat_width - frame_tube, seat_depth - frame_tube, 2]);
}

// ============================================
// 腿部模块（X形交叉）
// ============================================
module G01_Leg_Pair(spread_angle = 25) {
    // X形交叉腿设计
    
    color(color_frame) {
        // 腿A（从左前到右后）
        translate([0, 0, 0])
        rotate([spread_angle, 0, 0])
        rotate([0, -spread_angle, 0])
        cylinder(d = leg_width, h = leg_length, $fn = 24);
        
        // 腿B（从右前到左后）交叉
        translate([leg_width * 3, 0, 0])
        rotate([spread_angle, 0, 0])
        rotate([0, spread_angle, 0])
        cylinder(d = leg_width, h = leg_length, $fn = 24);
    }
    
    // 交叉连接轴
    color([0.5, 0.5, 0.55])
    translate([-leg_width, 0, leg_length * 0.4])
    rotate([0, 90, 0])
    cylinder(d = hinge_diameter, h = leg_width * 5, $fn = 20);
}

// ============================================
// 交叉杆模块（连接两侧腿）
// ============================================
module G01_Cross_Bar(length) {
    color(color_frame)
    rotate([0, 90, 0])
    cylinder(d = cross_bar_diameter, h = length, $fn = 24);
}

// ============================================
// 完整折叠凳（展开状态）
// ============================================
module G01_Folding_Stool(folded = false) {
    if (folded) {
        G01_Folding_Stool_Folded();
    } else {
        G01_Folding_Stool_Open();
    }
}

module G01_Folding_Stool_Open() {
    // 计算展开高度
    open_height = leg_length * cos(leg_spread_angle) - 20;
    
    // 座面
    translate([0, 0, open_height])
    G01_Seat_Frame();
    
    // 左侧腿组
    translate([30, seat_depth/2, 0])
    G01_Leg_Pair(leg_spread_angle);
    
    // 右侧腿组
    translate([seat_width - 80, seat_depth/2, 0])
    G01_Leg_Pair(leg_spread_angle);
    
    // 前交叉杆
    translate([30, 40, open_height * 0.3])
    G01_Cross_Bar(seat_width - 60);
    
    // 后交叉杆
    translate([30, seat_depth - 40, open_height * 0.3])
    G01_Cross_Bar(seat_width - 60);
    
    // 脚垫
    for (x = [30, seat_width - 60]) {
        for (y = [20, seat_depth - 20]) {
            translate([x, y, 0])
            G01_Foot_Pad();
        }
    }
}

// ============================================
// 折叠状态模块
// ============================================
module G01_Folding_Stool_Folded() {
    color(color_frame) {
        // 折叠后的座面框架
        translate([0, 0, 30])
        cube([folded_length, folded_width, 20]);
        
        // 折叠的腿（贴在座面下方）
        translate([10, 20, 0])
        cube([folded_length - 20, leg_width, 25]);
        
        translate([10, folded_width - 45, 0])
        cube([folded_length - 20, leg_width, 25]);
    }
    
    // 布面卷起
    color([0.2, 0.3, 0.5])
    translate([20, folded_width/2, 50])
    rotate([0, 90, 0])
    cylinder(d = 30, h = folded_length - 40, $fn = 24);
}

// ============================================
// 脚垫模块
// ============================================
module G01_Foot_Pad() {
    color([0.2, 0.2, 0.2])
    hull() {
        cylinder(d = leg_width + 10, h = 3, $fn = 24);
        translate([0, 0, 3])
        cylinder(d = leg_width + 5, h = 2, $fn = 24);
    }
}

// ============================================
// 便携折叠凳（轻量版）- 三角凳
// ============================================
module G01_Tripod_Stool(folded = false, height = 450) {
    seat_dia = 250;
    leg_dia = 20;
    
    if (folded) {
        // 折叠状态 - 三根腿并拢
        color(color_frame)
        for (i = [0:2]) {
            translate([i * (leg_dia + 5), 0, 0])
            cylinder(d = leg_dia, h = height, $fn = 24);
        }
        
        // 座面折叠
        translate([0, 0, height])
        color([0.2, 0.3, 0.5])
        cylinder(d = 60, h = 10, $fn = 32);
    } else {
        // 展开状态
        spread = 30;  // 腿展开角度
        
        // 三根腿
        for (i = [0:2]) {
            rotate([0, 0, i * 120])
            translate([0, 0, 0])
            rotate([spread, 0, 0])
            color(color_frame)
            cylinder(d = leg_dia, h = height, $fn = 24);
        }
        
        // 座面
        actual_height = height * cos(spread);
        translate([0, 0, actual_height])
        color([0.2, 0.3, 0.5])
        cylinder(d = seat_dia, h = 30, $fn = 48);
        
        // 布面
        translate([0, 0, actual_height + 30])
        color([0.15, 0.25, 0.45])
        cylinder(d1 = seat_dia, d2 = seat_dia - 20, h = 5, $fn = 48);
    }
}

// ============================================
// 收纳状态（放入箱底）
// ============================================
module G01_Stool_In_Storage() {
    // 显示折叠凳放入存储空间的状态
    color([0.5, 0.5, 0.5, 0.3])
    cube([500, 500, 80]);  // 存储空间轮廓
    
    translate([10, 110, 10])
    G01_Folding_Stool(folded = true);
}

// 预览
if ($preview && is_undef($assembly_mode)) {
    // 展开状态的X形折叠凳
    G01_Folding_Stool(folded = false);
    
    // 折叠状态
    translate([400, 0, 0])
    G01_Folding_Stool(folded = true);
    
    // 三角凳展开
    translate([0, 400, 0])
    G01_Tripod_Stool(folded = false);
    
    // 三角凳折叠
    translate([300, 400, 0])
    G01_Tripod_Stool(folded = true);
}
