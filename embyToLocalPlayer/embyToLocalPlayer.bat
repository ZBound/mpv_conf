@echo off
setlocal

:: ��λ���������ļ����ڵ��ϼ�Ŀ¼
set "BATCH_PATH=%~dp0"
cd /d "%BATCH_PATH%.."

if %ERRORLEVEL% neq 0 (
    echo �޷����ĵ��������ļ����ϼ�Ŀ¼��
    goto EndScript
)

:: ����Python��������·��
set "PYTHON_EXE=%CD%\python.exe"

:: ���Python�������Ƿ����
if not exist "%PYTHON_EXE%" (
    echo �� "%PYTHON_EXE%" δ�ҵ�Python�����򣬳���ʹ��ϵͳ�����еĽ�������
    where python >nul 2>&1
    if %ERRORLEVEL% neq 0 (
        echo ��ϵͳ������Ҳδ�ҵ�Python������
        goto EndScript
    ) else (
        set "PYTHON_EXE=python"
    )
)

:: ����Python�ű���·��
set "PYTHON_SCRIPT=%CD%\embyToLocalPlayer\embyToLocalPlayer.py"

:: ���Python�ű��Ƿ����
if not exist "%PYTHON_SCRIPT%" (
    echo �� "%PYTHON_SCRIPT%" δ�ҵ�Python�ű���
    goto EndScript
)

:: ����Python�ű�
"%PYTHON_EXE%" "%PYTHON_SCRIPT%"
if %ERRORLEVEL% neq 0 (
    echo ����Python�ű�ʧ�ܡ�
) else (
    echo �ɹ�����Python�ű���
)

:EndScript
:: �ڽű�����ǰ��ͣ���������Կ���������
pause
endlocal

exit /b
