@echo OFF

:BEGIN
cls

    echo ����������
    echo 1: �����״������У���������
    echo 2: ���ÿ����޴���������
    echo 3: ���������ļ���
    echo 4: ����·��ת������
    echo 5: ����embyToLocalPlayer.py·����������
    echo 6: д��mpv·���������ļ���ѡ��mpv��Ϊemby������
    choice /N /C:123456 /M "����������"%1
    IF ERRORLEVEL ==6 GOTO SIX
    IF ERRORLEVEL ==5 GOTO FIVE
    IF ERRORLEVEL ==4 GOTO FOUR
    IF ERRORLEVEL ==3 GOTO THREE
    IF ERRORLEVEL ==2 GOTO TWO
    IF ERRORLEVEL ==1 GOTO ONE
    GOTO END
) else (
    GOTO END
)

:SIX
echo �㰴���� 6
 emby_mpv_path.bat
GOTO END




:FIVE
echo �㰴���� 5
set mainCmd=python "%cd%\embyToLocalPlayer.py"
echo %mainCmd%
echo �Ѹ��ƣ�ճ�������� "Ctrl + V"
echo %mainCmd%|clip
GOTO END


:FOUR
echo �㰴���� 4
python utils/conf_helper.py
GOTO END


:THREE
echo �㰴���� 3
explorer shell:startup
GOTO END


:TWO
echo �㰴���� 2
set "startupVbs=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\embyToLocalPlayer.vbs"
(echo CreateObject^("Wscript.Shell"^).Run chr^(34^) ^& "%cd%\embyToLocalPlayer.bat" ^& chr^(34^), 0, True) > "%startupVbs%"
echo ���ֶ��ر��������
wscript.exe "%startupVbs%"
GOTO END



:ONE
echo �㰴���� 1
 embyToLocalPlayer.bat
GOTO END


:END
echo ������������ɡ�
pause
