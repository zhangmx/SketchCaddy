// ============================================
// assembly.scad
// SketchCaddy 总装配文件
// 户外写生智能装备运输与工作平台
// ============================================

// 引入全局参数
use <libs/global_params.scad>
use <libs/utils.scad>

// 引入各模块
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
// 动画控制参数
// ============================================
// 使用 $t 进行动画 (0-1)
// 在OpenSCAD中：View -> Animate，设置FPS和Steps

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
// 主要尺寸常量
// ============================================
box_length = 520;
box_width = 520;
box_height = 750;
panel_t = 5;
extrusion = 10;

// ============================================
// 完整装配模块
// ============================================
module SketchCaddy_Assembly() {
    
    // === A. 框架系统 ===
    // 主框架
    translate([0, 0, 0] * explode_factor * 50)
    A01_Main_Frame();
    
    // 角码（8个角落）
    // 底部四角
    translate([extrusion, extrusion, extrusion] + [0, 0, -1] * explode_factor * 30)
    A02_Corner_Bracket();
    
    translate([box_length - extrusion, extrusion, extrusion] + [0, 0, -1] * explode_factor * 30)
    rotate([0, 0, 90])
    A02_Corner_Bracket();
    
    translate([extrusion, box_width - extrusion, extrusion] + [0, 0, -1] * explode_factor * 30)
    rotate([0, 0, -90])
    A02_Corner_Bracket();
    
    translate([box_length - extrusion, box_width - extrusion, extrusion] + [0, 0, -1] * explode_factor * 30)
    rotate([0, 0, 180])
    A02_Corner_Bracket();
    
    // 地脚（后部两角）
    translate([40, box_width - 40, 0] + [0, 0, -1] * explode_factor * 80)
    rotate([180, 0, 0])
    A03_Foot_Pad();
    
    translate([box_length - 40, box_width - 40, 0] + [0, 0, -1] * explode_factor * 80)
    rotate([180, 0, 0])
    A03_Foot_Pad();
    
    // === B. 面板系统 ===
    // 顶板
    translate([0, 0, box_height - panel_t] + [0, 0, 1] * explode_factor * 100)
    B01_Top_Panel();
    
    // 底板
    translate([0, 0, 0] + [0, 0, -1] * explode_factor * 100)
    B02_Bottom_Panel();
    
    // 前面板
    translate([0, -panel_t, 0] + [0, -1, 0] * explode_factor * 100)
    rotate([90, 0, 0])
    translate([0, 0, -panel_t])
    B03_Front_Panel();
    
    // 后面板
    translate([0, box_width, 0] + [0, 1, 0] * explode_factor * 100)
    rotate([90, 0, 0])
    B04_Rear_Panel();
    
    // 左侧板（可开门）
    translate([-panel_t, panel_t, 0] + [-1, 0, 0] * explode_factor * 100)
    rotate([0, 0, -90])
    rotate([90, 0, 0])
    translate([0, 0, -panel_t])
    rotate([0, 0, left_door_angle])
    B05_Left_Side_Panel();
    
    // 右侧板（可开门）
    translate([box_length, panel_t, 0] + [1, 0, 0] * explode_factor * 100)
    rotate([0, 0, 90])
    rotate([90, 0, 0])
    translate([0, 0, -panel_t])
    rotate([0, 0, -right_door_angle])
    B06_Right_Side_Panel();
    
    // 画板角度调节器（顶板两侧）
    translate([60, 30, box_height] + [0, 0, 1] * explode_factor * 120)
    B09_Panel_Angle_Adjuster(angle = 30);
    
    translate([box_length - 80, 30, box_height] + [0, 0, 1] * explode_factor * 120)
    B09_Panel_Angle_Adjuster(angle = 30);
    
    // === C. 移动系统 ===
    // 轮子支架和轮子（前部两角）
    translate([40, 40, -80] + [0, 0, -1] * explode_factor * 150)
    rotate([0, 0, 180]) {
        C01_Wheel_Bracket_Reinforced();
        translate([30, 15, -200])
        C02_Pneumatic_Wheel();
    }
    
    translate([box_length - 40, 40, -80] + [0, 0, -1] * explode_factor * 150)
    rotate([0, 0, 180]) {
        C01_Wheel_Bracket_Reinforced();
        translate([30, 15, -200])
        C02_Pneumatic_Wheel();
    }
    
    // 支撑腿（后部两角）
    translate([40, box_width - 40, -10] + [0, 0, -1] * explode_factor * 120)
    rotate([180, 0, 0])
    C03_Support_Leg(foot_extension = 5);
    
    translate([box_length - 40, box_width - 40, -10] + [0, 0, -1] * explode_factor * 120)
    rotate([180, 0, 0])
    C03_Support_Leg(foot_extension = 5);
    
    // === D. 操控与支撑系统 ===
    // 伸缩拉杆底座
    translate([box_length/2 - 40, box_width - 30, 50] + [0, 1, 0] * explode_factor * 80)
    rotate([90, 0, 0])
    D01_Telescoping_Handle_Base();
    
    // 伸缩拉杆
    translate([box_length/2, box_width - 20, 80] + [0, 1, 1] * explode_factor * 100)
    D02_Telescoping_Handle(extension = handle_extension);
    
    // === E. 核心功能集成 ===
    // 工具挂板（左侧门内侧）
    translate([panel_t + 5, 50, 80] + [-1, 0, 0] * explode_factor * 80)
    rotate([0, 0, 90])
    rotate([90, 0, 0])
    E02_Tool_Panel();
    
    // 抽屉单元
    translate([box_length/2 - 100, 50, 150] + [0, 0, 0] * explode_factor * 60)
    E03_Drawer_Unit(pull_out = drawer_pull);
    
    // 水具固定架
    translate([box_length - 100, box_width/2, panel_t + 10] + [1, 0, 0] * explode_factor * 80)
    E04_Water_Container_Holder();
}

// ============================================
// 爆炸视图装配
// ============================================
module SketchCaddy_Exploded() {
    // 临时设置爆炸因子为1
    explode_factor = 1;
    SketchCaddy_Assembly();
}

// ============================================
// 侧门打开演示
// ============================================
module SketchCaddy_Doors_Open() {
    left_door_angle = 90;
    right_door_angle = 90;
    SketchCaddy_Assembly();
}

// ============================================
// 画架模式演示
// ============================================
module SketchCaddy_Easel_Mode() {
    handle_extension = 300;
    SketchCaddy_Assembly();
    
    // 三合一大画板（展开状态）
    translate([box_length/2, -200, box_height + 100])
    rotate([60, 0, 0]) {
        // 中间面板（原前面板）
        translate([0, 0, 0])
        rotate([0, 0, 90])
        B03_Front_Panel();
        
        // 左侧面板
        translate([-box_width - 5, 0, 0])
        rotate([0, 0, 90])
        B05_Left_Side_Panel();
        
        // 右侧面板
        translate([box_width + 5, 0, 0])
        rotate([0, 0, 90])
        B06_Right_Side_Panel();
    }
}

// ============================================
// 渲染选择
// ============================================
// 取消注释以下行之一来查看不同状态：

// 正常组装状态
SketchCaddy_Assembly();

// 爆炸视图
// SketchCaddy_Exploded();

// 侧门打开
// SketchCaddy_Doors_Open();

// 画架模式
// SketchCaddy_Easel_Mode();

// ============================================
// 动画模式说明
// ============================================
// 要创建动画，在OpenSCAD中：
// 1. View -> Animate
// 2. 设置 FPS = 10, Steps = 100
// 3. 使用 $t 变量（0到1）控制动画
// 
// 示例：将 explode_factor = 0 改为 explode_factor = $t
// 这将创建从组装到爆炸的动画
