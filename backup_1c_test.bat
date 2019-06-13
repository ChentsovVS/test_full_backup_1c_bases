chcp 1251 >nul
SetLocal EnableDelayedExpansion

rem ������ ࠡ��� - ��⠭�������� ��६���� � ᮧ���� ��⠫��� 
rem � ������� forfiles - ������ �롮�� � 㤠����� ������ ���� 10 ����
rem del - ���� 㤠��塞 ��⠫���. 


set 1c_base="E:\Base"
set 1sbdb="E:\Base\1SBDB"		rem ������������ ��⠫��� ����
set 1sbmdb="E:\Base\1SBMDB"		rem ������������ ��⠫��� ����
set db2010="E:\Base\DB2010"		rem ������������ ��⠫��� ����
set 7zip="C:\Program Files\7-Zip"

mkdir g:\backup_1c\
mkdir g:\backup_1c\1SBDB
mkdir g:\backup_1c\1SBMDB
mkdir g:\backup_1c\DB2010


set backup="g:\backup_1c"
echo %date% > %backup%\log.txt
echo %date% > %backup%\tmp.txt
set log="%backup%\log.txt"
set tmp="%backup%\tmp.txt"

set 1SBDB_back="g:\backup_1c\1SBDB"
set 1SBMDB_back="g:\backup_1c\1SBMDB"
set DB2010_back="g:\backup_1c\DB2010"

forfiles /p %backup% /m *.7z /s /d -10 /c <cmd /c del @path /q> 2>%log%
"C:\Program Files\7-Zip\7z.exe" a -tzip "g:\backup_1c\1SBDB_%date%.7z" "E:\Base\1SBDB\*.*" 2>>%log%
"C:\Program Files\7-Zip\7z.exe" a -tzip "g:\backup_1c\1SBMDB_%date%.7z" "E:\Base\1SBMDB\*.*" 2>>%log%
"C:\Program Files\7-Zip\7z.exe" a -tzip "g:\backup_1c\DB2010_%date%.7z" "E:\Base\DB2010\*.*" 2>>%log%

del /q %DB2010_back%\*.*
del /q %1SBMDB_back%\*.*
del /q %1SBDB_back%\*.* 

forfiles /p %backup% /m *.7z /d 0 /c "cmd /c echo @file" > %tmp% 
set /p buffer="" < %tmp% 


if "%buffer%"=="" (
	echo "䠩�� �� �����㦥���! %time%" >> %log% 
	echo "�஡�� �१ xcopy � ��᫥���饩 ��娢�樥� %time%" >> %log% 
	xcopy %1sbdb%\*.* %1SBDB_back%\
	xcopy %1sbmdb%\*.* %1SBMDB_back%\
	xcopy %db2010%\*.* %DB2010_back%\
	"%7zip%\7z.exe" a -tzip "%backup%\1SBDB_%date%.7z" "%1SBDB_back%\*.*" 2>>%log%
	"%7zip%\7z.exe" a -tzip "%backup%\1SBMDB_%date%.7z" "%1SBMDB_back%\*.*" 2>>%log%
	"%7zip%\7z.exe" a -tzip "%backup%\DB2010_%date%.7z" "%DB2010_back%\*.*" 2>>%log%
	del /q %DB2010_back%\*.*
	del /q %1SBMDB_back%\*.*
	del /q %1SBDB_back%\*.* 
	forfiles /p %backup% /m *.7z /d 0 /c "cmd /c echo @file" > %tmp% 
		set /p buffer="" < %tmp%
		if "%buffer%"=="" (
			echo "Alarma - archive not found %time%" >> %log 
			break
		)
	) else ( 
	echo "archives found, i'm need stopped %date%, %time%" 
	break
	
rem �. 0.2 - ������� if \ else, ������� �஢��� �� ���� (������ 䠩���) 
rem - �ࠫ ��譨� ᫥� (����⭮ ��� ��蠫� ��ଠ�쭮� ࠡ��) 
rem - ������� ��६���� tmp � buffer ��� ��ࠡ�⪨ ������ 䠩���
rem - ������� ������� ������ ��� "����". 
rem - ������� xcopy ��� �᪫�祭�� "�������" 䠩���, �᫥��⢨� 祣� ����� �� �������� ��娢

	


