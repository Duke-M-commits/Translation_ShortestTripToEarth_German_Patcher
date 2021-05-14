@ECHO OFF
SET mod-dir=%cd%
SET patch-dir=%cd%\Patch
CD %patch-dir%
IF EXIST "UnityEX.exe" (
  SET patch-app=%patch-dir%\UnityEX.exe
) ELSE (
  ECHO Anscheinend hat dein Antivirus den Patcher gegessen...
  ECHO Ausstieg...
  TIMEOUT /t 8
  EXIT
)
ECHO Version erkennen...
CD %mod-dir%\..\..\..\..\..
IF EXIST "common\" (
  ECHO Steam Version erkannt...
  CD common
) ELSE (
  IF EXIST "Shortest Trip to Earth\" (
    ECHO GOG Version erkannt...
  ) ELSE (
    ECHO Konnte den Spiel-Ordner nicht finden...
    ECHO Ausstieg...
    TIMEOUT /t 8
    EXIT
  )
)
CD Shortest Trip to Earth\Data
ECHO Spieldateien exportieren...
IF EXIST "data.unity3d" (
  IF NOT EXIST "data.unity3d.backup" (
    RENAME "data.unity3d" "data.unity3d.backup"
  )
)
"%patch-app%" exportbundle "data.unity3d.backup" -p "%cd%" >nul
ECHO Spieldateien modifizieren...
FOR %%a IN (*.assets) DO "%patch-app%" import "%%a" -p "%patch-dir%" >nul
ECHO Mehr Modifikationen...
FOR /l %%i IN (0,1,9) DO IF EXIST "level%%i" "%patch-app%" import "level%%i" -p "%patch-dir%" >nul
CD ..\AssetBundles
ECHO Importiere modifizierte Haupt-Spieldateien
IF EXIST "base.ab" (
  IF NOT EXIST "base.ab.backup" (
    COPY "base.ab" "base.ab.backup" >nul
  )
)
"%patch-app%" import "base.ab" -mb_new -ncomp -f "%patch-dir%" >nul
ECHO Importiere modifizierte DLC-Spieldateien - The Old Enemies...
IF EXIST "dlc2.ab" (
  IF NOT EXIST "dlc2.ab.backup" (
    COPY "dlc2.ab" "dlc2.ab.backup" >nul
  )
)
"%patch-app%" import "dlc2.ab" -mb_new -f "%patch-dir%" >nul
ECHO Importiere modifizierte DLC-Spieldateien - Supporters Pack...
IF EXIST "sdlc.ab" (
  IF NOT EXIST "sdlc.ab.backup" (
    COPY "sdlc.ab" "sdlc.ab.backup" >nul
  )
)
"%patch-app%" import "sdlc.ab" -mb_new -f "%patch-dir%" >nul
CD %mod-dir%
ECHO Done!
TIMEOUT /t 8
