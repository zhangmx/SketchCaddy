// ============================================
// assembly.scad
// SketchCaddy 总装配文件
// 户外写生智能装备运输与工作平台
// ============================================

// 引入全局参数（必须用 include 导入变量）
include <libs/global_params.scad>
include <libs/utils.scad>

// 引入各模块（用 use 只导入模块定义，避免重复执行预览代码）
use <A_Frame_System/A01_Main_Frame.scad>
use <A_Frame_System/A02_Corner_Bracket.scad>
use <A_Frame_System/A03_Foot_Pad.scad>

use <B_Panel_System/B01_Top_Panel.scad>
use <B_Panel_System/B02_Bottom_Panel.scad>
use <B_Panel_System/B03_Front_Panel.scad>
use <B_Panel_System/B04_Rear_Panel.scad>
use <B_Panel_System/B05_Left_Side_Panel.scad>
use <B_Panel_System/B06_Right_Side_Panel.scad>
use <B_Panel_System/B09_Panel_Angle_Adjuster.scad>
use <B_Panel_System/B10_Magnetic_Surface.scad>

use <C_Movement_System/C01_Wheel_Bracket.scad>
use <C_Movement_System/C02_Pneumatic_Wheel.scad>
use <C_Movement_System/C03_Support_Leg.scad>

use <D_Control_System/D01_Telescoping_Handle_Base.scad>
use <D_Control_System/D02_Telescoping_Handle.scad>

use <E_Integration/E02_Tool_Panel.scad>
use <E_Integration/E03_Drawer_Unit.scad>
use <E_Integration/E04_Water_Container_Holder.scad>

use <F_Locking_System/F01_Heavy_Duty_Hinge.scad>
use <F_Locking_System/F02_Flip_Lock.scad>
use <F_Locking_System/F03_Panel_Quick_Release.scad>
use <F_Locking_System/F04_Panel_Connector_Hinge.scad>
use <F_Locking_System/F06_Alignment_Pin_Slot.scad>

// ============================================
// 装配模式标志（防止子模块自动渲染预览）
// ============================================
$assembly_mode = true;

// ============================================
// 动画控制参数
// ============================================
// 爆炸视图因子 (0 = 组装状态, 1 = 完全爆炸)
explode_factor = 0;  // 可调节 0-1

// 侧门开启角度
left_door_angle = 0;    // 0-110度
right_door_angle = 0;   // 0-110度

// 拉杆伸出长度
handle_extension = 0;   // 0-400mm

// 抽屉拉出距离
drawer_pull = 0;        // 0-200mm

// ============================================
// 从全局参数派生的常量
// ============================================
box_L = global_box_length;   // 520mm
box_W = global_box_width;    // 520mm
box_H = global_box_height;   // 750mm
panel_t = panel_thickness;   // 5mm
ext = extrusion_size;        // 10mm

// ============================================
// 爆炸偏移辅助函数
// ============================================
function explode_offset(dir, dist) = dir * dist * explode_factor;

// ============================================
// 完整装配模块
// ============================================
module SketchCaddy_Assembly() {
    
    // ========================================
    // A. 框架系统
    // ========================================
    
    // A01 主框架
    translate(explode_offset([0, 0, 0], 0))
    A01_Main_Frame();
    
    // A02 角码 - 底部四角
    corner_offset = ext;
    translate([corner_offset, corner_offset, corner_offset] + explode_offset([0, 0, -1], 30))
    A02_Corner_Bracket();
    
    translate([box_L - corner_offset, corner_offset, corner_offset] + explode_offset([0, 0, -1], 30))
    rotate([0, 0, 90])
    A02_Corner_Bracket();
    
    translate([corner_offset, box_W - corner_offset, corner_offset] + explode_offset([0, 0, -1], 30))
    rotate([0, 0, -90])
    A02_Corner_Bracket();
    
    translate([box_L - corner_offset, box_W - corner_offset, corner_offset] + explode_offset([0, 0, -1], 30))
    rotate([0, 0, 180])
    A02_Corner_Bracket();
    
    // A03 地脚 - 后部两角
    foot_offset = 50;
    translate([foot_offset, box_W - foot_offset, 0] + explode_offset([0, 0, -1], 60))
    rotate([180, 0, 0])
    A03_Foot_Pad();
    
    translate([box_L - foot_offset, box_W - foot_offset, 0] + explode_offset([0, 0, -1], 60))
    rotate([180, 0, 0])
    A03_Foot_Pad();
    
    // ========================================
    // B. 面板系统
    // ========================================
    
    // B01 顶板
    translate([0, 0, box_H - panel_t] + explode_offset([0, 0, 1], 80))
    B01_Top_Panel();
    
    // B02 底板
    translate([0, 0, 0] + explode_offset([0, 0, -1], 80))
    B02_Bottom_Panel();
    
    // B03 前面板 (Y=0 侧)
    translate([0, 0, 0] + explode_offset([0, -1, 0], 80))
    rotate([90, 0, 0])
    translate([0, 0, 0])
    B03_Front_Panel();
    
    // B04 后面板 (Y=box_W 侧)
    translate([0, box_W + panel_t, 0] + explode_offset([0, 1, 0], 80))
    rotate([90, 0, 0])
    B04_Rear_Panel();
    
    // B05 左侧板 (X=0 侧，可作为侧门)
    translate([0, 0, 0] + explode_offset([-1, 0, 0], 80))
    rotate([90, 0, -90])
    B05_Left_Side_Panel();
    
    // B06 右侧板 (X=box_L 侧，可作为侧门)
    translate([box_L + panel_t, 0, 0] + explode_offset([1, 0, 0], 80))
    rotate([90, 0, -90])
    B06_Right_Side_Panel();
    
    // B09 画板角度调节器 (顶板上)
    translate([80, 50, box_H] + explode_offset([0, 0, 1], 100))
    B09_Panel_Angle_Adjuster(angle = 30);
    
    translate([box_L - 100, 50, box_H] + explode_offset([0, 0, 1], 100))
    B09_Panel_Angle_Adjuster(angle = 30);
    
    // ========================================
    // C. 移动系统
    // ========================================
    
    // 轮子位置参数
    wheel_offset_x = 60;
    wheel_offset_y = 60;
    wheel_z = -20;  // 轮子安装在底板下方
    
    // C01+C02 前左轮
    translate([wheel_offset_x, wheel_offset_y, wheel_z] + explode_offset([0, 0, -1], 120))
    rotate([0, 0, 0]) {
        C01_Wheel_Bracket_Reinforced();
        translate([0, 0, -250])
        C02_Pneumatic_Wheel();
    }
    
    // C01+C02 前右轮
    translate([box_L - wheel_offset_x, wheel_offset_y, wheel_z] + explode_offset([0, 0, -1], 120))
    rotate([0, 0, 0]) {
        C01_Wheel_Bracket_Reinforced();
        translate([0, 0, -250])
        C02_Pneumatic_Wheel();
    }
    
    // C03 后左支撑腿
    translate([wheel_offset_x, box_W - wheel_offset_y, 0] + explode_offset([0, 0, -1], 100))
    rotate([180, 0, 0])
    C03_Support_Leg(foot_extension = 5);
    
    // C03 后右支撑腿
    translate([box_L - wheel_offset_x, box_W - wheel_offset_y, 0] + explode_offset([0, 0, -1], 100))
    rotate([180, 0, 0])
    C03_Support_Leg(foot_extension = 5);
    
    // ========================================
    // D. 操控与支撑系统
    // ========================================
    
    // D01 伸缩拉杆底座
    translate([box_L/2 - 40, box_W - 25, 50] + explode_offset([0, 1, 0], 60))
    rotate([90, 0, 0])
    D01_Telescoping_Handle_Base();
    
    // D02 伸缩拉杆
    translate([box_L/2, box_W + 10, 60] + explode_offset([0, 1, 0], 80))
    D02_Telescoping_Handle(extension = handle_extension);
    
    // ========================================
    // E. 核心功能集成
    // ========================================
    
    // E02 工具挂板 (左侧门内侧)
    translate([panel_t + 20, 60, 100] + explode_offset([-1, 0, 0], 60))
    rotate([0, 0, 90])
    rotate([90, 0, 0])
    scale([0.8, 0.8, 1])  // 缩放以适应内部空间
    E02_Tool_Panel();
    
    // E03 抽屉单元
    translate([box_L/2 - 100, 60, 200] + explode_offset([0, -1, 0], 60))
    E03_Drawer_Unit(pull_out = drawer_pull);
    
    // E04 水具固定架
    translate([box_L - 100, box_W/2, panel_t + 20] + explode_offset([1, 0, 0], 60))
    scale(0.8)  // 缩放以适应内部空间
    E04_Water_Container_Holder();
}

// ============================================
// 渲染选择
// ============================================

// 正常组装状态
SketchCaddy_Assembly();

// ============================================
// 动画模式说明
// ============================================
// 要创建动画，在OpenSCAD中：
// 1. View -> Animate
// 2. 设置 FPS = 10, Steps = 100
// 3. 将 explode_factor = 0 改为 explode_factor = $t
//    这将创建从组装到爆炸的动画
