rem @echo off

REM CHANGE to your download directory (if needed)
set SELF="D:\Michal\Work\Fykos\makra2\texmf\"
REM CHANGE this to your user texmf dir (with MiKTeX it's its main dir) (if needed)
set TEXMF=%programfiles%\MiKTeX 2.8\


REM path to store fykosx macros
set LATEX=tex\latex\fykosx
REM path to metapost macros
set MPOST=metapost\fykos

if exist "%TEXMF%%LATEX%" if "%1%" neq "-f" (
echo "Macros 'fykosx' already installed. Use -f to reinstall."
exit 1
)

rem prepare directories
if exist "%TEXMF%%LATEX%" rd /s /q "%TEXMF%%LATEX%"
if exist "%TEXMF%%MPOST%" rd /s /q "%TEXMF%%MPOST%"

xcopy /s /i /q "%SELF%%latex%" "%TEXMF%%LATEX%"
xcopy /s /i /q "%SELF%%mpost%" "%TEXMF%%MPOST%"

REM -- update filename database--
initexmf --update-fndb

pause -1