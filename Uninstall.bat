@ECHO OFF
SET mod-dir=%cd%
ECHO Version erkennen...
CD "%mod-dir%\..\..\..\.."
IF EXIST "common\" (
  ECHO Steam Version erkannt...
  CD common
) ELSE (
  IF EXIST "Games\Shortest Trip to Earth\" (
    ECHO GOG Version erkannt...
  ) ELSE (
    ECHO Konnte den Spiel-Ordner nicht finden...
    ECHO Ausstieg...
    TIMEOUT /t 8
    EXIT
  )
)
CD "Shortest Trip to Earth\Data"
ECHO Spieldateien wiederherstellen...
IF EXIST "data.unity3d.backup" (
  IF EXIST "data.unity3d" (
    DEL "data.unity3d"
  )
  RENAME data.unity3d.backup data.unity3d
)
ECHO Modifizierte Dateien entfernen...
FOR %%a IN (*.assets) DO DEL %%a
ECHO Mehr modifizierte Dateien entfernen...
FOR /l %%i IN (0,1,9) DO IF EXIST level%%i (DEL level%%i)
ECHO Noch mehr modifizierte Dateien entfernen...
IF EXIST "globalgamemanagers" (
  DEL "globalgamemanagers"
)
CD Resources
ECHO So viele modifizierte Dateien zu entfernen...
IF EXIST "unity_builtin_extra" (
  DEL "unity_builtin_extra"
)
CD "..\..\AssetBundles"
ECHO Haupt-Spieldateien wiederherstellen...
IF EXIST "base.ab.backup" (
  DEL "base.ab"
  RENAME "base.ab.backup" "base.ab"
)
ECHO DLC-Spieldateien - The Old Enemies wiederherstellen...
IF EXIST "dlc2.ab.backup" (
  DEL "dlc2.ab"
  RENAME "dlc2.ab.backup" "dlc2.ab"
)
ECHO DLC-Spieldateien - Supporters Pack wiederherstellen...
IF EXIST "sdlc.ab.backup" (
  DEL "sdlc.ab"
  RENAME "sdlc.ab.backup" "sdlc.ab"
)
CD %mod-dir%
ECHO Done!
TIMEOUT /t 8
