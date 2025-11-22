# 全地图强制PVP修改包

## 修改说明

此修改包实现了全地图强制PVP功能，使所有玩家之间都可以互相攻击，无需PVP标志。

## 修改内容

**修改文件：** `CrossRoads/Common/pvp_common.c`

**修改位置：** `entity_PVP_GetRelation` 函数 (第76-83行)

**修改内容：**
- 当两个实体都没有PVP标志时，如果两个实体都是玩家，则返回敌对关系 (`kEntityRelation_Foe`)
- 这样实现了全地图强制PVP，所有玩家之间默认处于敌对状态

## 重要说明 ⚠️

**本仓库仅包含修改后的源代码文件，不包含完整的项目文件。**

要编译 GameServer.exe，您需要：
1. **完整的源代码库**（包含所有 .vcxproj 和项目文件）
2. 将本仓库的 `CrossRoads/Common/pvp_common.c` 替换到您的完整项目
3. 在本地使用 Visual Studio 编译

## 安装方法

### 步骤 1: 下载修改后的文件
从本仓库下载 `CrossRoads/Common/pvp_common.c`

### 步骤 2: 替换到您的项目
将下载的文件复制到您的完整源代码库：
```
您的项目路径/CrossRoads/Common/pvp_common.c
```

### 步骤 3: 编译项目
在 Visual Studio 中：
1. 打开 `GameServer/NNOGameServer.sln`
2. 先编译 `GameServerLib`（包含修改后的 pvp_common.c）
3. 再编译 `GameServer` 项目
4. 编译完成后，GameServer.exe 位于 `bin/GameServer.exe`

详细步骤请参阅 `BUILD_GAMESERVER.md`

### 编译顺序（重要）

由于 `pvp_common.c` 被 GameServerLib 引用，编译 GameServer.exe 需要：

1. **首先编译 GameServerLib**（包含 pvp_common.c）
2. 编译其他依赖库（AILib, ServerLib, UtilitiesLib 等）
3. 最后链接生成 GameServer.exe

### 影响的项目

修改此文件会影响以下项目，都需要重新编译：
- GameServerLib (必需，用于编译 GameServer.exe)
- AppServerLib
- GameClientLib
- 其他引用此文件的项目

详情请参阅 `DEPENDENCIES.md`

## 文件结构

```
_upload_pvp/
├── CrossRoads/
│   └── Common/
│       └── pvp_common.c  (修改后的文件)
├── README.md              (本说明文件)
├── DEPENDENCIES.md        (依赖分析文档)
├── CHANGELOG.txt          (变更日志)
├── INSTALL.txt            (安装说明)
└── patch.diff             (Git补丁文件)
```

## 注意事项

1. 此修改只影响玩家实体之间的关系，不影响玩家与NPC的关系
2. 由于PVP关系优先于队伍/帮派/派系关系，同一队伍的玩家也可能互相攻击
3. 已有PVP标志的玩家仍按原有PVP规则处理

## 代码变更详情

### 修改前：
```c
if(!flag1 && !flag2 && !teamFlag1 && !teamFlag2)
    return kEntityRelation_Unknown;
```

### 修改后：
```c
// 强制PVP：如果两个实体都是玩家且都没有PVP标志，则返回敌对关系
if(!flag1 && !flag2 && !teamFlag1 && !teamFlag2)
{
    // 检查是否都是玩家，如果是则强制PVP
    if(e1->pPlayer && e2->pPlayer)
        return kEntityRelation_Foe;
    return kEntityRelation_Unknown;
}
```

