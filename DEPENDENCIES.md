# GameServer.exe 编译依赖分析

## 修改文件对 GameServer.exe 的影响

### 直接依赖
- **文件**: `CrossRoads/Common/pvp_common.c`
- **引用位置**: `CrossRoads/GameServerLib/GameServerLib.vcxproj` (第443行)
- **编译依赖**: GameServerLib 静态库包含此文件

### 依赖链分析

#### GameServer.exe 的依赖关系
```
GameServer.exe
├── GameServerLib.lib (静态库)
│   ├── pvp_common.c (已修改)
│   ├── pvp_common.h (头文件，未修改)
│   └── 其他 GameServerLib 文件
├── AILib.lib
├── ContentLib.lib
├── HttpLib.lib
├── PatchClientLib.lib
├── ServerLib.lib
├── StructParserStub.lib
├── UtilitiesLib.lib
└── WorldLib.lib
```

### 系统库依赖
- `ws2_32.lib` - Windows Socket API
- `kernel32.lib` - Windows Kernel API
- `Imm32.lib` - Input Method Manager
- `Msacm32.lib` - Microsoft Audio Compression Manager

### 最小上传包内容

#### 必需文件
1. **CrossRoads/Common/pvp_common.c** - 修改后的源代码文件

#### 可选但建议包含
2. **CrossRoads/Common/pvp_common.h** - 头文件（检查是否需要同步修改）

### 编译说明

#### 编译顺序
1. 编译 GameServerLib（会编译 pvp_common.c）
2. 编译其他依赖库
3. 链接生成 GameServer.exe

#### 注意事项
- 修改 `pvp_common.c` 后需要重新编译 **GameServerLib**
- GameServer.exe 依赖 GameServerLib，所以需要先编译库
- 如果其他项目也引用了 `pvp_common.c`，也需要重新编译那些项目

### 其他引用 pvp_common.c 的项目
（可能也需要重新编译）

1. `CrossRoads/AppServerLib/AppServerLib.vcxproj`
2. `CrossRoads/GameClientLib/GameClientLib.vcxproj`
3. `Utilities/LoginHammer/LoginHammer.vcxproj`
4. `Core/GameLogReporter/GameLogReporter.vcxproj`
5. `Core/LogParser/LogParser.vcxproj`
6. `Utilities/ShardMerge/ShardMerge.vcxproj`

### 推荐的最小上传包

```
_upload_pvp/
├── CrossRoads/
│   └── Common/
│       ├── pvp_common.c     (必需，已修改)
│       └── pvp_common.h     (可选，头文件检查)
├── README.md
├── DEPENDENCIES.md          (本文件)
├── CHANGELOG.txt
├── INSTALL.txt
└── patch.diff
```


