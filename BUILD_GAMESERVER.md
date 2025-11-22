# How to Build GameServer.exe

## Prerequisites

- Visual Studio (version compatible with the project)
- All project dependencies must be built first
- StructParser tool available at `utilities/bin/structparser`

## Build Output Location

According to `PropertySheets/CrypticApplication.props`, the compiled GameServer.exe will be placed in:
```
I:\gp5\bin\GameServer.exe
```

## Build Steps

### Option 1: Build with Visual Studio

1. Open the solution file:
   ```
   GameServer\NNOGameServer.sln
   ```

2. Select configuration:
   - **Debug** → Output: `GameServer.exe`
   - **Full Debug** → Output: `GameServerFD.exe`

3. Build dependencies first (if not already built):
   - Right-click on `GameServerLib` → Rebuild
   - Build other required libraries (AILib, ServerLib, UtilitiesLib, WorldLib, etc.)

4. Build GameServer:
   - Right-click on `GameServer` project → Rebuild
   - Or: Build → Rebuild Solution

### Option 2: Build with MSBuild (Command Line)

```batch
cd I:\gp5

# Build GameServerLib first (contains pvp_common.c)
msbuild CrossRoads\GameServerLib\GameServerLib.vcxproj /t:Rebuild /p:Configuration=Debug

# Build GameServer.exe
msbuild GameServer\NNOGameServer.vcxproj /t:Rebuild /p:Configuration=Debug
```

Or build the entire solution:
```batch
cd I:\gp5\GameServer
msbuild NNOGameServer.sln /t:Rebuild /p:Configuration=Debug
```

## Important Notes

### Required Pre-build Step

The project uses StructParser as a pre-build event. Make sure:
- `utilities\bin\structparser.exe` exists
- The pre-build command will run automatically:
  ```
  ..\..\utilities\bin\structparser X $(ProjectDir) X $(ProjectFileName) X $(Platform) X $(Configuration) X $(VCInstallDir) X $(SolutionPath)
  ```

### Dependencies

GameServer.exe depends on these libraries (must be built first):
- GameServerLib.lib (contains our modified pvp_common.c)
- AILib.lib
- ContentLib.lib
- HttpLib.lib
- PatchClientLib.lib
- ServerLib.lib
- StructParserStub.lib
- UtilitiesLib.lib
- WorldLib.lib

### System Libraries

The linker will use these Windows system libraries:
- ws2_32.lib (Windows Socket API)
- kernel32.lib (Windows Kernel)
- Imm32.lib (Input Method Manager)
- Msacm32.lib (Audio Compression Manager)

## After Building

After successful compilation, GameServer.exe will be located at:
```
I:\gp5\bin\GameServer.exe
```

## Troubleshooting

### If GameServerLib fails to build:
- Ensure `CrossRoads\Common\pvp_common.c` is in place with the modifications
- Check that all include directories are correct
- Verify StructParser ran successfully

### If linking fails:
- Ensure all dependency libraries are built
- Check library paths in PropertySheets
- Verify system libraries are accessible

### If pre-build fails:
- Check StructParser path: `utilities\bin\structparser.exe`
- Verify StructParser has correct permissions
- Check project file paths are correct

## Verify the Modification

After building, the modified `entity_PVP_GetRelation` function in `pvp_common.c` should be compiled into GameServerLib.lib, which is then linked into GameServer.exe.

You can verify by:
1. Checking build output for any errors related to pvp_common.c
2. Testing PvP functionality in-game (all players should be able to attack each other)


