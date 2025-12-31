// ============================================
// B10_Magnetic_Surface.scad
// 磁性工作表面 - 柔性磁白板，带背胶
// ============================================

include <../libs/global_params.scad>
include <../libs/utils.scad>

// 磁性表面尺寸
surface_width = 480;         // 略小于面板宽度
surface_height = 700;        // 略小于面板高度
surface_thickness = 0.8;     // 柔性磁白板厚度

// ============================================
// 磁性表面模块
// ============================================
module B10_Magnetic_Surface() {
    color([0.95, 0.95, 0.95])  // 白色
    translate([surface_width/2, surface_height/2, 0])
    rounded_rect([surface_width, surface_height], 2, surface_thickness);
}

// 带边框的磁性表面（可选装饰边框）
module B10_Magnetic_Surface_Framed() {
    frame_width = 5;
    
    difference() {
        // 边框
        color([0.3, 0.3, 0.3])
        translate([surface_width/2, surface_height/2, 0])
        rounded_rect([surface_width + 2*frame_width, surface_height + 2*frame_width], 
                     3, surface_thickness + 0.5);
        
        // 中间镂空
        translate([frame_width, frame_width, -0.1])
        cube([surface_width, surface_height, surface_thickness + 0.7]);
    }
    
    // 白板表面
    translate([frame_width, frame_width, 0])
    B10_Magnetic_Surface();
}

// 预览
if ($preview && is_undef($assembly_mode)) {
    B10_Magnetic_Surface();
}
