@ECHO OFF &:: Clean output and hide path of running command

ECHO **** Irfanview ****
powershell scoop install irfranview
ASSOC .bmp=Image.BMP
FTYPE Image.BMP="%SCOOP%\apps\irfanview\current\i_view64.exe" "%%1"
ASSOC .gif=Image.GIF
FTYPE Image.GIF="%SCOOP%\apps\irfanview\current\i_view64.exe" "%%1"
ASSOC .jpg=Image.JPG
FTYPE Image.JPG="%SCOOP%\apps\irfanview\current\i_view64.exe" "%%1"
ASSOC .jpeg=Image.JPEG
FTYPE Image.JPEG="%SCOOP%\apps\irfanview\current\i_view64.exe" "%%1"
ASSOC .png=Image.PNG
FTYPE Image.PNG="%SCOOP%\apps\irfanview\current\i_view64.exe" "%%1"
ASSOC .TIF=Image.TIF
FTYPE Image.TIF="%SCOOP%\apps\irfanview\current\i_view64.exe" "%%1"

ECHO **** MPV ****
powershell scoop install mpv
mpv --version
:: Dependency for subtitles script
python -m pip install --upgrade --user subliminal
:: Video file associations
ASSOC .!qB=!qBfile
FTYPE !qBfile="%SCOOP%\apps\mpv\current\mpv.exe" "%%1"
REG ADD "HKEY_CLASSES_ROOT\!qBfile\DefaultIcon" /ve /t REG_EXPAND_SZ /d "C:\WINDOWS\System32\SHELL32.dll,129" /f
ASSOC .part=PARTfile
FTYPE PARTfile.ART="%SCOOP%\apps\mpv\current\mpv.exe" "%%1"
ASSOC .3gp=Video.3GP
FTYPE Video.3GP="%SCOOP%\apps\mpv\current\mpv.exe" "%%1"
ASSOC .avi=Video.AVI
FTYPE Video.AVI="%SCOOP%\apps\mpv\current\mpv.exe" "%%1"
ASSOC .flv=Video.FLV
FTYPE Video.FLV="%SCOOP%\apps\mpv\current\mpv.exe" "%%1"
ASSOC .mkv=Video.MKV
FTYPE Video.MKV="%SCOOP%\apps\mpv\current\mpv.exe" "%%1"
ASSOC .mov=Video.MOV
FTYPE Video.MOV="%SCOOP%\apps\mpv\current\mpv.exe" "%%1"
ASSOC .mp4=Video.MP4
FTYPE Video.MP4="%SCOOP%\apps\mpv\current\mpv.exe" "%%1"
ASSOC .mpg=Video.MPG
FTYPE Video.MPG="%SCOOP%\apps\mpv\current\mpv.exe" "%%1"
ASSOC .webm=Video.WEBM
FTYPE Video.WEBM="%SCOOP%\apps\mpv\current\mpv.exe" "%%1"
ASSOC .wmv=Video.WMV
FTYPE Video.WMV="%SCOOP%\apps\mpv\current\mpv.exe" "%%1"
:: Audio file associations
ASSOC .aac=Audio.AAC
FTYPE Audio.AAC="%SCOOP%\apps\mpv\current\mpv.exe" "%%1"
ASSOC .amr=Audio.AMR
FTYPE Audio.AMR="%SCOOP%\apps\mpv\current\mpv.exe" "%%1"
ASSOC .flac=FAudio.FLAC
FTYPE Audio.FLAC="%SCOOP%\apps\mpv\current\mpv.exe" "%%1"
ASSOC .mp3=Audio.MP3
FTYPE Audio.MP3="%SCOOP%\apps\mpv\current\mpv.exe" "%%1"
ASSOC .M4A=Audio.M4A &:: audiobooks 1
FTYPE Audio.M4A="%SCOOP%\apps\mpv\current\mpv.exe" "%%1"
ASSOC .M4B=Audio.M4B &:: audiobooks 2
FTYPE Audio.M4B="%SCOOP%\apps\mpv\current\mpv.exe" "%%1"
ASSOC .ogg=Audio.OGG
FTYPE Audio.OGG="%SCOOP%\apps\mpv\current\mpv.exe" "%%1"
ASSOC .opus=Audio.OPUS
FTYPE Audio.OPUS="%SCOOP%\apps\mpv\current\mpv.exe" "%%1"
ASSOC .vob=Audio.VOB
FTYPE Audio.VOB="%SCOOP%\apps\mpv\current\mpv.exe" "%%1"
ASSOC .wav=Audio.WAV
FTYPE Audio.WAV="%SCOOP%\apps\mpv\current\mpv.exe" "%%1"
ASSOC .wma=Audio.WMA
FTYPE Audio.WMA="%SCOOP%\apps\mpv\current\mpv.exe" "%%1"

ECHO **** Spotify ****
MKLINK /J "%APPDATA%\Spotify" "%USER_BAK%\AppData\Roaming\Spotify"
MKLINK /J "%LOCALAPPDATA%\Spotify" "%USER_BAK%\AppData\Local\Spotify"

ECHO **** yt-dlp and ffmpeg ****
powershell scoop install yt-dlp
yt-dlp --version
powershell scoop install ffmpeg
ffmpeg
