// ============================================
// D01_Telescoping_Handle_Base.scad
// 伸缩拉杆底座 - 金属冲压件，固定于后面板
// ============================================

use <../libs/global_params.scad>
use <../libs/utils.scad>

// 底座参数
base_width = 80;
base_height = 100;
base_depth = 25;
plate_thickness = 2;

// 拉杆管参数
tube_outer_diameter = 20;
tube_spacing = 40;           // 两根管间距

// ============================================
// 拉杆底座模块
// ============================================
module D01_Telescoping_Handle_Base() {
    color(color_frame)
    difference() {
        union() {
            // 底板
            cube([base_width, base_depth, plate_thickness]);
            
            // 两个管套
            translate([base_width/2 - tube_spacing/2, base_depth/2, plate_thickness])
            D01_Tube_Socket();
            
            translate([base_width/2 + tube_spacing/2, base_depth/2, plate_thickness])
            D01_Tube_Socket();
            
            // 加强肋
            translate([base_width/2 - 2, 0, plate_thickness])
            cube([4, base_depth, 20]);
        }
        
        // 底板安装孔
        for (x = [15, base_width - 15]) {
            for (y = [8, base_depth - 8]) {
                translate([x, y, -0.1])
                cylinder(d = 5, h = plate_thickness + 0.2);
            }
        }
    }
}

// 管套模块
module D01_Tube_Socket() {
    socket_height = 40;
    
    difference() {
        cylinder(d = tube_outer_diameter + 8, h = socket_height);
        translate([0, 0, -0.1])
        cylinder(d = tube_outer_diameter + 0.5, h = socket_height + 0.2);
        
        // 锁定槽
        translate([-1, -tube_outer_diameter/2 - 5, socket_height - 15])
        cube([2, tube_outer_diameter + 10, 10]);
    }
}

// 预览
D01_Telescoping_Handle_Base();
