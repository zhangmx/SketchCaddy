// ============================================
// A01_Main_Frame.scad
// 主箱体骨架 - 由铝型材构成的长方体框架
// 使用 NopSCADlib 库的标准铝型材模块
// ============================================

include <../libs/global_params.scad>

// 引入 NopSCADlib 铝型材模块
// 注意：需要将 libraries 目录添加到 OpenSCAD 的库路径中
// File -> Show Library Folder，或在命令行使用 --lib-path
use <../../../libraries/NopSCADlib/vitamins/extrusion.scad>
include <../../../libraries/NopSCADlib/vitamins/extrusions.scad>

// 框架尺寸（使用全局参数）
frame_length = global_box_length;  // X轴 520mm
frame_width = global_box_width;    // Y轴 520mm  
frame_height = global_box_height;  // Z轴 750mm

// 选择型材类型 - Makerbeam 是 10x10mm 的型材
// 可选: Makerbeam(10x10), E1515(15x15), E2020(20x20), E3030(30x30), E4040(40x40)
extrusion_type = Makerbeam;  // 10x10mm

// 获取型材尺寸
profile_size = extrusion_width(extrusion_type);  // 10mm

// 计算型材实际长度
// X方向横梁：需要减去两端立柱占用的空间
beam_length_x = frame_length - 2 * profile_size;
// Y方向横梁：全长
beam_length_y = frame_width;
// Z方向立柱：需要减去顶部和底部横梁占用的空间
beam_length_z = frame_height - 2 * profile_size;

// ============================================
// 主框架模块
// ============================================
module A01_Main_Frame() {
    
    // ========================================
    // 底部矩形框架 (4根)
    // ========================================
    
    // 底部前边 (沿Y轴，全长)
    translate([0, 0, 0])
    rotate([-90, 0, 0])
    extrusion(extrusion_type, beam_length_y, center = false);
    
    // 底部后边 (沿Y轴，全长)
    translate([frame_length - profile_size, 0, 0])
    rotate([-90, 0, 0])
    extrusion(extrusion_type, beam_length_y, center = false);
    
    // 底部左边 (沿X轴，减去两端)
    translate([profile_size, 0, 0])
    rotate([0, 90, 0])
    extrusion(extrusion_type, beam_length_x, center = false);
    
    // 底部右边 (沿X轴，减去两端)
    translate([profile_size, frame_width - profile_size, 0])
    rotate([0, 90, 0])
    extrusion(extrusion_type, beam_length_x, center = false);
    
    // ========================================
    // 顶部矩形框架 (4根)
    // ========================================
    
    // 顶部前边 (沿Y轴，全长)
    translate([0, 0, frame_height - profile_size])
    rotate([-90, 0, 0])
    extrusion(extrusion_type, beam_length_y, center = false);
    
    // 顶部后边 (沿Y轴，全长)
    translate([frame_length - profile_size, 0, frame_height - profile_size])
    rotate([-90, 0, 0])
    extrusion(extrusion_type, beam_length_y, center = false);
    
    // 顶部左边 (沿X轴，减去两端)
    translate([profile_size, 0, frame_height - profile_size])
    rotate([0, 90, 0])
    extrusion(extrusion_type, beam_length_x, center = false);
    
    // 顶部右边 (沿X轴，减去两端)
    translate([profile_size, frame_width - profile_size, frame_height - profile_size])
    rotate([0, 90, 0])
    extrusion(extrusion_type, beam_length_x, center = false);
    
    // ========================================
    // 四根垂直立柱
    // ========================================
    
    // 前左立柱
    translate([0, 0, profile_size])
    extrusion(extrusion_type, beam_length_z, center = false);
    
    // 前右立柱
    translate([frame_length - profile_size, 0, profile_size])
    extrusion(extrusion_type, beam_length_z, center = false);
    
    // 后左立柱
    translate([0, frame_width - profile_size, profile_size])
    extrusion(extrusion_type, beam_length_z, center = false);
    
    // 后右立柱
    translate([frame_length - profile_size, frame_width - profile_size, profile_size])
    extrusion(extrusion_type, beam_length_z, center = false);
}

// 单独渲染预览（仅在直接打开此文件时显示）
if ($preview && is_undef($assembly_mode)) {
    A01_Main_Frame();
}
