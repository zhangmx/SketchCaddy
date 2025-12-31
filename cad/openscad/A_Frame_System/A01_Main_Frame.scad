// ============================================
// A01_Main_Frame.scad
// 主箱体骨架 - 由1010铝型材构成的长方体框架
// ============================================

include <../libs/global_params.scad>
include <../libs/utils.scad>

// 框架尺寸（使用全局参数）
frame_length = global_box_length;  // X轴 520mm
frame_width = global_box_width;    // Y轴 520mm  
frame_height = global_box_height;  // Z轴 750mm

// 型材尺寸
profile_size = extrusion_size;     // 10mm

// 计算型材实际长度（减去角落连接处的重叠）
length_x = frame_length - 2 * profile_size;
length_y = frame_width - 2 * profile_size;
length_z = frame_height - 2 * profile_size;

// ============================================
// 主框架模块
// ============================================
module A01_Main_Frame() {
    color(color_frame) {
        // 底部矩形框架 (4根)
        // 底部前边
        translate([profile_size, 0, profile_size/2])
        extrusion_x(length_x);
        
        // 底部后边
        translate([profile_size, frame_width, profile_size/2])
        extrusion_x(length_x);
        
        // 底部左边
        translate([0, profile_size, profile_size/2])
        extrusion_y(length_y);
        
        // 底部右边
        translate([frame_length, profile_size, profile_size/2])
        extrusion_y(length_y);
        
        // 顶部矩形框架 (4根)
        // 顶部前边
        translate([profile_size, 0, frame_height - profile_size/2])
        extrusion_x(length_x);
        
        // 顶部后边
        translate([profile_size, frame_width, frame_height - profile_size/2])
        extrusion_x(length_x);
        
        // 顶部左边
        translate([0, profile_size, frame_height - profile_size/2])
        extrusion_y(length_y);
        
        // 顶部右边
        translate([frame_length, profile_size, frame_height - profile_size/2])
        extrusion_y(length_y);
        
        // 四根垂直立柱 (4根)
        // 前左立柱
        translate([profile_size/2, profile_size/2, profile_size])
        extrusion_z(length_z);
        
        // 前右立柱
        translate([frame_length - profile_size/2, profile_size/2, profile_size])
        extrusion_z(length_z);
        
        // 后左立柱
        translate([profile_size/2, frame_width - profile_size/2, profile_size])
        extrusion_z(length_z);
        
        // 后右立柱
        translate([frame_length - profile_size/2, frame_width - profile_size/2, profile_size])
        extrusion_z(length_z);
    }
}

// 单独渲染预览（仅在直接打开此文件时显示）
if ($preview && is_undef($assembly_mode)) {
    A01_Main_Frame();
}
