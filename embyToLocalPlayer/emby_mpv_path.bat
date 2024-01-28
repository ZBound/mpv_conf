@echo off
setlocal EnableDelayedExpansion

:: ��λ���ű�����Ŀ¼�ĸ�Ŀ¼
set "BATCH_PATH=%~dp0"
cd /d "%BATCH_PATH%.."

set "configFile=%BATCH_PATH%embyToLocalPlayer_config.ini"
set "tempFile=%BATCH_PATH%temp.ini"
set /a "maxLines=25"
set /a "lineCount=0"

:: �� UTF-8 ����������ļ�ת��Ϊ GB18030 ����
PowerShell -Command "Get-Content '%configFile%' -Encoding UTF8 | Out-File -FilePath '%tempFile%' -Encoding Default"

:: ��ת�������ʱ�ļ��滻ԭʼ�����ļ�·��
move /y "%tempFile%" "%configFile%"

:: ��鸸Ŀ¼���Ƿ���� mpvnet.exe �� mpv.exe
if exist "mpvnet.exe" (
    set "keyToFindMpve=mpve ="
    set "newValueMpve= %CD%\mpvnet.exe"
    set "keyToFindPlayer=player ="
    set "newValuePlayer= mpve"
) else if exist "mpv.exe" (
    set "keyToFindMpve=mpv ="
    set "newValueMpve= %CD%\mpv.exe"
    set "keyToFindPlayer=player ="
    set "newValuePlayer= mpv"
) else (
    echo ����: δ�ҵ� mpvnet.exe �� mpv.exe��
    pause
    goto EndScript
)

:: ��������ļ��Ƿ����
if not exist "%configFile%" (
    echo ����: �����ļ� "%configFile%" δ�ҵ���
    goto EndScript
)

:: �����µ���ʱ�ļ�
>"%tempFile%" (
    for /f "delims=" %%a in ('type "%configFile%"') do (
        set "line=%%a"
        set /a "lineCount+=1"
        
        :: ֻ����ǰ25��
        if !lineCount! leq !maxLines! (
            :: ������Ƿ���� keyToFindMpve
            echo !line! | findstr /b /c:"!keyToFindMpve!" >nul
            if !errorlevel! equ 0 (
                echo !keyToFindMpve!!newValueMpve!
            ) else (
                :: ������� mpve�������Ƿ��� player
                echo !line! | findstr /b /c:"!keyToFindPlayer!" >nul
                if !errorlevel! equ 0 (
                    echo !keyToFindPlayer!!newValuePlayer!
                ) else (
                    echo !line!
                )
            )
        ) else (
            echo !line!
        )
    )
)

:: ɾ��ԭʼ�����ļ�
del "%configFile%"
if not exist "%configFile%" (
    echo mpv·��д��ɹ���
) else (
    echo ����: д��mpv·��ʧ�ܡ�
    goto EndScript
)

:: �� GB18030 �������ʱ�ļ�ת���� UTF-8 ����
PowerShell -Command "Get-Content '%tempFile%' -Encoding Default | Out-File -FilePath '%configFile%' -Encoding UTF8"

:: ɾ����ʱ�ļ�
del "%tempFile%"

:EndScript
endlocal
pause
