@ECHO OFF
SET mod-dir=%cd%
CD %mod-dir%\..\..\..\..\common\Shortest Trip to Earth\Data
ECHO Reverting Game Data...
IF EXIST "data.unity3d.backup" (
  DEL "data.unity3d"
  RENAME data.unity3d.backup data.unity3d
)
ECHO Deleting patchfiles...
FOR %%a in (*.assets) DO DEL %%a
ECHO Deleting more patchfiles...
FOR /l %%i in (0,1,1) DO IF EXIST level%%i (DEL level%%i)
ECHO Deleting even more patchfiles...
IF EXIST "globalgamemanagers" (
  DEL "globalgamemanagers"
)
IF EXIST "Resources\" (
  RMDIR "Resources\" /s /q
)
CD ..\AssetBundles
ECHO Reverting patched Base Game...
IF EXIST "base.ab.backup" (
  DEL "base.ab"
  RENAME base.ab.backup base.ab
)
ECHO Reverting patched DLC - The Old Enemies...
IF EXIST "dlc2.ab.backup" (
  DEL "dlc2.ab"
  RENAME dlc2.ab.backup dlc2.ab
)
ECHO Reverting patched DLC - Supporters Pack...
IF EXIST "sdlc.ab.backup" (
  DEL "sdlc.ab"
  RENAME sdlc.ab.backup sdlc.ab
)
CD %mod-dir%
ECHO Done!
TIMEOUT /t 8
