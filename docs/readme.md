#  SketchCaddy
**项目核心定义：** 一个基于模块化1010铝型材骨架、集成可拆卸便携画架、可变形为大型画板、专为户外写生设计的智能装备运输与工作平台。

#### **1. 全局参数与尺寸**
```openscad
// 所有单位：毫米 (mm)
// 核心箱体尺寸
global_box_length = 520;   // 长 (X轴)
global_box_width = 520;    // 宽 (Y轴)
global_box_height = 750;   // 高 (Z轴)

// 面板厚度
panel_thickness = 5; // 推荐PP蜂窝板或航空板厚度

// 铝型材规格
extrusion_type = 1010; // 10mm x 10mm 轻型铝型材
extrusion_slot_width = 8; // 型材T型槽宽度，用于选连接件
extrusion_wall_thickness = 1.2; // 型材壁厚

// 画架参数 (依据图片)
easel_bag_length = 750; // 画架袋长度
easel_bag_diameter = 100; // 画架袋直径
easel_height_max = 1500; // 画架最大展开高度
// 画架折叠后尺寸 ≈ 750x100x100mm 的长条
```

#### **2. 核心模块与零件列表 (BOM结构)**

每个模块都是一个独立的`.scad`文件或组件，可参数化生成。

- **`A_框架系统`**
  - `A01_Main_Frame`: 主箱体骨架。由1010铝型材通过`A02_Corner_Bracket`（90度角码）连接而成的72x50x50cm长方体。
  - `A02_Corner_Bracket`: 90度直角连接件（标准件）。
  - `A03_Foot_Pad`: 支腿/调平地脚（安装在底部四角，非轮子端）。

- **`B_面板系统`**
  - `B01_Top_Panel`: 顶板 (520x520mm)。固定于`A01_Main_Frame`顶部，带有`D02_Telescoping_Handle`（伸缩拉杆）安装孔。
  - `B02_Bottom_Panel`: 底板 (520x520mm)。集成`C01_Wheel_Bracket`安装孔。并有四个`A03_Foot_Pad`安装位置。提供安装到`A01_Main_Frame`的固定结构。
  - `B03_Front_Panel`: 前面板 (750x520mm)。内侧预设`B10_Magnetic_Surface`（磁性白板贴）安装槽。通过`F01_Heavy_Duty_Hinge`（重型合页）与`B05_Left_Side_Panel`和`B06_Right_Side_Panel`连接，装有`F02_Flip_Lock`（翻板锁扣）x4与`B01_Top_Panel`和`B02_Bottom_Panel`锁扣。
  - `B04_Rear_Panel`: 后面板 (750x520mm)。集成`D01_Telescoping_Handle_Base`（伸缩拉杆底座）的加固安装结构。
  - `B05_Left_Side_Panel`: 左侧板 (750x520mm)。内侧预设`B10_Magnetic_Surface`（磁性白板贴）安装槽。属于“三合一画板”模块。边缘有`F04_Panel_Connector_Hinge`（面板拼接铰链）和`F03_Panel_Quick_Release`（面板快拆锁扣）接口，可以作为侧门打开。
  - `B06_Right_Side_Panel`: 右侧板 (750x520mm)。内侧预设`B10_Magnetic_Surface`（磁性白板贴）安装槽。属于“三合一画板”模块。边缘有`F04_Panel_Connector_Hinge`（面板拼接铰链）和`F03_Panel_Quick_Release`（面板快拆锁扣）接口，可以作为侧门打开。同左侧板，镜像对称。
  - `B07_Easel_Access_Panel`: 画架专用存取板 (520x520mm)。可快速拆卸，方便取放画架内胆。也属于“三合一画板”模块。
  - `B08_Panel_Seal_Gasket`: 面板密封胶条（EVA材质，截面为矩形或D形）。
  - `B09_Panel_Angle_Adjuster`: 画板角度调节器（位于顶板`B01_Top_Panel`两侧，5档位，带弹簧卡珠）。
  - `B10_Magnetic_Surface`: 磁性工作表面（柔性磁白板，尺寸约600x400mm，带背胶）。

- **`C_移动系统`**
  - `C01_Wheel_Bracket`: 轮子安装支架（钣金件，L形）。
  - `C02_Pneumatic_Wheel`: 充气万向轮（8英寸，带刹车，标准件）。
  - `C03_Support_Leg`: 支撑支腿（无轮端，带可调节脚垫）。

- **`D_操控与支撑系统`**
  - `D01_Telescoping_Handle_Base`: 伸缩拉杆底座（金属冲压件，固定于后面板）。
  - `D02_Telescoping_Handle`: 三节式伸缩拉杆总成（标准件，带符合人机工学手柄）。**手柄需有`D03_Canvas_Notch`（画板卡槽）**。
  - `D03_Canvas_Notch`: 位于拉杆手柄处的突出卡槽，用于卡住画板上缘。

- **`E_核心功能集成`**
  - `E01_Easel_Cradle`: 便携画架专属内胆。由高密度EVA海绵雕刻而成，完美贴合画架拆卸后的每一根型材（75cm长条x若干短杆）。通过魔术贴或卡扣固定在箱内。
  - `E02_Tool_Panel`: 工具挂板。安装在主存取门内侧，集成MOLLE织带、弹力绳、网兜。
  - `E03_Drawer_Unit`: 可抽拉储物抽屉单元（用于颜料、笔刷）。
  - `E04_Water_Container_Holder`: 水具/水桶固定架。

- **`F_连接与锁闭系统`**
  - `F01_Heavy_Duty_Hinge`: 重型平面合页（用于门板，不锈钢）。
  - `F02_Flip_Lock`: 翻板式搭扣锁（用于门板锁闭，带钥匙孔）。
  - `F03_Panel_Quick_Release`: 面板快拆锁扣（用于可拆卸侧板，按压式，如`SouthCo`品牌类似款）。
  - `F04_Panel_Connector_Hinge`: 面板拼接铰链（用于“三合一画板”功能，连接三块750x520mm面板的侧面）。
  - `F05_Support_Strut`: 面板支撑杆（“三合一画板”展开后，用于背部支撑的可折叠三角架或撑杆）。
  - `F06_Alignment_Pin_Slot`: 定位销与滑槽（在侧板与相邻板连接处，防止面板错位和脱落）。

- **`G_扩展功能模块`**（可选，后续迭代）
  - `G01_Integrated_Stool`: 集成式折叠凳（从箱底抽出）。
  - `G02_Umbrella_Mount`: 遮阳伞安装座（多位置插孔，带角度调节旋钮）。
  - `G03_LED_Light_Bar`: LED照明灯条（集成在顶板内侧边缘，USB充电）。
  - `G04_Backpack_Harness`: 双肩背带系统（可拆卸，重型织带，带胸扣和腰扣）。

#### **3. 装配关系与动画逻辑**
- **爆炸图动画**：所有模块沿其法线方向（面板向外，内部零件向上）平移分离，展示所有零件。
- **搭建画架动画**：
  1.  打开`B03_Front_Panel`（主存取门）。
  2.  取出`E01_Easel_Cradle`内胆。
  3.  从内胆中取出画架零件，模拟组装成完整画架的过程。
  4.  将`B10_Magnetic_Surface`（或独立磁吸毛毡布）安装到画架上。
- **侧边门打开动画**：
  1.  解锁`F02_Flip_Lock` x2。
  2.  `B03_Front_Panel`绕`F01_Heavy_Duty_Hinge`轴旋转打开。
  3.  展示内部`E01_Easel_Cradle`, `E02_Tool_Panel`等。
- **“三合一画板”变形动画**：
  1.  解锁`B05`, `B06`, `B07`三块侧板的`F03_Panel_Quick_Release`。
  2.  将三块板从框架上取下。
  3.  通过`F04_Panel_Connector_Hinge`将三块板沿长边（700mm）首尾相连，形成1500x700mm大面板。
  4.  安装`F05_Support_Strut`到面板背面。

#### **4. 关键细节与约束**
1.  **公差与配合**：所有面板与框架的配合间隙预留1mm。锁扣、铰链的安装孔位需精确。
2.  **结构强度**：伸缩拉杆底座`D01`和轮子支架`C01`必须与主框架`A01`及铝型材有**金属加强板**连接，力直接传递到框架，不经由面板。
3.  **重量分布**：最重的物品（颜料、水）应放在靠近轮子的一侧，确保拖行时稳定。
4.  **“三合一画板”平面度**：拼接铰链`F04`需有定位结构，确保三块板展开后在同一平面，背部支撑杆`F05`是必需的。

---

### 第二部分：Git仓库结构建议

作为程序员，您可以像管理代码一样管理这个硬件项目，实现版本控制和协作。

```
ArtCase/                          # 项目根目录
├── README.md                     # 项目总览，设计理念，使用说明
├── docs/                         # 设计文档
│   ├── Product_Specification.md  # 详细产品规格 (就是上面Prompt的文本版)
│   ├── BOM_Detailed.xlsx         # 完整物料清单 (含零件号、供应商、预估成本)
│   ├── Sketches/                 # 手绘草图、灵感图片
│   └── References/               # 参考图片、标准件手册
├── cad/                          # 所有设计文件
│   ├── openscad/                 # OpenSCAD 参数化设计
│   │   ├── libs/                 # 自定义库和工具函数
│   │   ├── A_Frame_System/       # 对应模块A
│   │   ├── B_Panel_System/       # 对应模块B
│   │   └── ...                   # 其他模块
│   │   └── assembly.scad         # 总装配文件
│   └── freecad/                  # FreeCAD 设计文件 (可并行)
│       └── ... (类似结构)
├── hardware/                     # 生产相关文件
│   ├── stl/                      # 用于3D打印的STL文件 (如定制连接件、内胆模型)
│   ├── dxf/                      # 用于激光切割/钣金的DXF文件 (如面板、支架)
│   └── gerber/                   # PCB文件 (如果未来有电路)
├── software/                     # 如果未来有智能功能 (照明、称重)
│   └── firmware/                 # 单片机代码
└── .gitignore                    # 忽略大文件、临时文件
```


