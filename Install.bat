@ECHO OFF
SET mod-dir=%cd%
SET patch-dir=%cd%\Patch
SET patch-app=%patch-dir%\UnityEX.exe
CD %mod-dir%\..\..\..\..\common\Shortest Trip to Earth\Data
ECHO Exporting game data...
FOR %%a IN (*.unity3D) DO "%patch-app%" exportbundle "%%a" -p "%cd%" >nul
IF EXIST "data.unity3d" (
  IF NOT EXIST "data.unity3d.backup" (
    RENAME data.unity3d data.unity3d.backup
  )
)
ECHO Patching...
FOR %%a IN (*.assets) DO "%patch-app%" import "%%a" -p "%patch-dir%" >nul
ECHO More patching...
FOR /l %%i IN (0,1,1) DO IF EXIST level%%i "%patch-app%" import "level%%i" -p "%patch-dir%" >nul
CD ..\AssetBundles
IF EXIST "base.ab" (
  IF NOT EXIST "base.ab.backup" (
    COPY base.ab base.ab.backup >nul
  )
)
ECHO Importing patched base game...
FOR %%a IN (base.ab) DO "%patch-app%" import "%%a" -mb_new -ncomp -f "%patch-dir%" >nul
IF EXIST "dlc2.ab" (
  IF NOT EXIST "dlc2.ab.backup" (
    COPY dlc2.ab dlc2.ab.backup >nul
  )
)
ECHO Importing patched DLC - The Old Enemies...
FOR %%a IN (dlc2.ab) DO "%patch-app%" import "%%a" -mb_new -f "%patch-dir%" >nul
IF EXIST "sdlc.ab" (
  IF NOT EXIST "sdlc.ab.backup" (
    COPY sdlc.ab sdlc.ab.backup >nul
  )
)
ECHO Importing patched DLC - Supporters Pack...
FOR %%a IN (sdlc.ab) DO "%patch-app%" import "%%a" -mb_new -f "%patch-dir%" >nul
CD %mod-dir%
ECHO Done!
TIMEOUT /t 8
