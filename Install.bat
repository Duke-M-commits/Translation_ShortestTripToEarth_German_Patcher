@ECHO OFF
SET mod-dir=%cd%
SET patch-dir=%cd%\Patch
SET patch-app=%patch-dir%\UnityEX.exe
ECHO Detecting version...
CD %mod-dir%\..\..\..\..
IF EXIST "common\" (
  ECHO Steam version detected...
  CD common
) ELSE (
  IF EXIST "Shortest Trip to Earth\" (
    ECHO GOG version detected...
  ) ELSE (
    ECHO Could not find game directory...
    ECHO Exiting...
    TIMEOUT /t 8
    EXIT
  )
)
CD Shortest Trip to Earth\Data
ECHO Exporting game data...
"%patch-app%" exportbundle "data.unity3d" -p "%cd%" >nul
IF EXIST "data.unity3d" (
  IF NOT EXIST "data.unity3d.backup" (
    RENAME "data.unity3d" "data.unity3d.backup"
  )
)
ECHO Patching...
FOR %%a IN (*.assets) DO "%patch-app%" import "%%a" -p "%patch-dir%" >nul
ECHO More patching...
FOR /l %%i IN (0,1,9) DO IF EXIST "level%%i" "%patch-app%" import "level%%i" -p "%patch-dir%" >nul
CD ..\AssetBundles
ECHO Importing patched base game...
IF EXIST "base.ab" (
  IF NOT EXIST "base.ab.backup" (
    COPY "base.ab" "base.ab.backup" >nul
  )
)
"%patch-app%" import "base.ab" -mb_new -ncomp -f "%patch-dir%" >nul
ECHO Importing patched DLC - The Old Enemies...
IF EXIST "dlc2.ab" (
  IF NOT EXIST "dlc2.ab.backup" (
    COPY "dlc2.ab" "dlc2.ab.backup" >nul
  )
)
"%patch-app%" import "dlc2.ab" -mb_new -f "%patch-dir%" >nul
ECHO Importing patched DLC - Supporters Pack...
IF EXIST "sdlc.ab" (
  IF NOT EXIST "sdlc.ab.backup" (
    COPY "sdlc.ab" "sdlc.ab.backup" >nul
  )
)
"%patch-app%" import "sdlc.ab" -mb_new -f "%patch-dir%" >nul
CD %mod-dir%
ECHO Done!
TIMEOUT /t 8
