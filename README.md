# SketchCaddy

**项目核心定义：** 一个基于模块化1010铝型材骨架、集成可拆卸便携画架、可变形为大型画板、专为户外写生设计的智能装备运输与工作平台。

## 项目结构

```
SketchCaddy/
├── README.md                 # 项目总览
├── .gitignore               # Git忽略文件
├── docs/                    # 设计文档
│   └── readme.md            # 详细产品规格
└── cad/                     # CAD设计文件
    └── openscad/            # OpenSCAD参数化设计
        ├── libs/            # 公共库和工具函数
        │   ├── global_params.scad   # 全局参数定义
        │   └── utils.scad           # 通用工具模块
        ├── A_Frame_System/          # 框架系统
        ├── B_Panel_System/          # 面板系统
        ├── C_Movement_System/       # 移动系统
        ├── D_Control_System/        # 操控支撑系统
        ├── E_Integration/           # 功能集成模块
        ├── F_Locking_System/        # 连接锁闭系统
        └── assembly.scad            # 总装配文件
```

## 快速开始

### 环境要求
- [OpenSCAD](https://openscad.org/) 2021.01 或更高版本

### 查看设计
1. 使用 OpenSCAD 打开 `cad/openscad/assembly.scad`
2. 按 F5 预览整体装配
3. 修改装配文件中的参数查看不同状态：
   - `explode_factor`: 爆炸视图 (0-1)
   - `left_door_angle` / `right_door_angle`: 侧门角度
   - `handle_extension`: 拉杆伸出长度
   - `drawer_pull`: 抽屉拉出距离

### 查看单个零件
每个模块文件都可以独立打开和预览。

## 核心尺寸

| 参数 | 数值 | 说明 |
|------|------|------|
| 箱体长度 | 520mm | X轴 |
| 箱体宽度 | 520mm | Y轴 |
| 箱体高度 | 750mm | Z轴 |
| 面板厚度 | 5mm | PP蜂窝板 |
| 铝型材规格 | 1010 | 10×10mm |

## 模块说明

### A - 框架系统
- `A01_Main_Frame`: 主箱体骨架
- `A02_Corner_Bracket`: 90度角码
- `A03_Foot_Pad`: 调平地脚

### B - 面板系统
- `B01_Top_Panel`: 顶板
- `B02_Bottom_Panel`: 底板
- `B03_Front_Panel`: 前面板
- `B04_Rear_Panel`: 后面板
- `B05_Left_Side_Panel`: 左侧板
- `B06_Right_Side_Panel`: 右侧板
- `B09_Panel_Angle_Adjuster`: 角度调节器
- `B10_Magnetic_Surface`: 磁性工作面

### C - 移动系统
- `C01_Wheel_Bracket`: 轮子支架
- `C02_Pneumatic_Wheel`: 8寸充气万向轮
- `C03_Support_Leg`: 支撑支腿

### D - 操控支撑系统
- `D01_Telescoping_Handle_Base`: 拉杆底座
- `D02_Telescoping_Handle`: 三节伸缩拉杆

### E - 功能集成
- `E02_Tool_Panel`: MOLLE工具挂板
- `E03_Drawer_Unit`: 储物抽屉
- `E04_Water_Container_Holder`: 水具固定架

### F - 连接锁闭系统
- `F01_Heavy_Duty_Hinge`: 重型合页
- `F02_Flip_Lock`: 翻板锁扣
- `F03_Panel_Quick_Release`: 快拆锁扣
- `F04_Panel_Connector_Hinge`: 面板拼接铰链
- `F06_Alignment_Pin_Slot`: 定位销槽

## 动画演示

在 OpenSCAD 中：
1. 菜单 View → Animate
2. 设置 FPS = 10, Steps = 100
3. 在代码中使用 `$t` 变量控制动画

## 许可证

[待定]

## 贡献

欢迎提交 Issue 和 Pull Request。
