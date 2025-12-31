// ============================================
// C02_Pneumatic_Wheel.scad
// 充气万向轮 - 8英寸，带刹车
// ============================================

use <../libs/global_params.scad>
use <../libs/utils.scad>

// 轮子参数
wheel_diameter = 203.2;      // 8英寸 = 203.2mm
wheel_width = 50;            // 轮宽
hub_diameter = 60;           // 轮毂直径
axle_diameter = 12;          // 轴径
tire_thickness = 25;         // 轮胎厚度

// 万向轮底座参数
base_length = 100;
base_width = 80;
base_height = 25;
fork_height = 80;            // 叉架高度

// ============================================
// 充气轮胎模块
// ============================================
module C02_Tire() {
    color([0.15, 0.15, 0.15])
    rotate_extrude()
    translate([wheel_diameter/2 - tire_thickness, 0, 0])
    circle(d = wheel_width);
}

// ============================================
// 轮毂模块
// ============================================
module C02_Hub() {
    color(color_frame)
    difference() {
        cylinder(d = hub_diameter, h = wheel_width, center = true);
        // 轴孔
        cylinder(d = axle_diameter + 1, h = wheel_width + 1, center = true);
        // 辐条镂空
        for (i = [0:5]) {
            rotate([0, 0, i * 60])
            translate([hub_diameter/4, 0, 0])
            cylinder(d = 15, h = wheel_width + 1, center = true);
        }
    }
}

// ============================================
// 完整轮子模块
// ============================================
module C02_Wheel() {
    rotate([90, 0, 0]) {
        C02_Tire();
        C02_Hub();
    }
}

// ============================================
// 万向轮叉架
// ============================================
module C02_Caster_Fork() {
    color(color_frame)
    difference() {
        union() {
            // 左叉臂
            translate([-wheel_width/2 - 5, 0, 0])
            cube([5, 30, fork_height]);
            
            // 右叉臂
            translate([wheel_width/2, 0, 0])
            cube([5, 30, fork_height]);
            
            // 顶部连接板
            translate([-wheel_width/2 - 5, 0, fork_height - 5])
            cube([wheel_width + 10, 30, 5]);
        }
        
        // 轮轴孔
        translate([-wheel_width/2 - 6, 15, 30])
        rotate([0, 90, 0])
        cylinder(d = axle_diameter, h = wheel_width + 12);
    }
}

// ============================================
// 万向轮底座（带刹车）
// ============================================
module C02_Caster_Base() {
    color([0.3, 0.3, 0.3])
    difference() {
        // 底座主体
        translate([-base_width/2, -base_length/2, 0])
        cube([base_width, base_length, base_height]);
        
        // 转轴孔
        translate([0, 0, -0.1])
        cylinder(d = 20, h = base_height + 0.2);
        
        // 安装孔
        for (dx = [-base_width/2 + 10, base_width/2 - 10]) {
            for (dy = [-base_length/2 + 10, base_length/2 - 10]) {
                translate([dx, dy, -0.1])
                cylinder(d = 8, h = base_height + 0.2);
            }
        }
    }
    
    // 刹车踏板
    color([0.8, 0.2, 0.1])
    translate([base_width/2 + 2, -15, base_height/2])
    cube([20, 30, 5]);
}

// ============================================
// 完整万向轮组件
// ============================================
module C02_Pneumatic_Wheel() {
    // 底座
    translate([0, 0, fork_height + base_height + wheel_diameter/2 + 10])
    C02_Caster_Base();
    
    // 叉架
    translate([0, -15, wheel_diameter/2 + 10])
    C02_Caster_Fork();
    
    // 轮子
    translate([0, 15, wheel_diameter/2])
    C02_Wheel();
}

// 预览
C02_Pneumatic_Wheel();
