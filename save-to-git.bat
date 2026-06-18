@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:start
cls
echo ============================================================
echo           УНИВЕРСАЛЬНЫЙ ПОМОЩНИК GIT
echo ============================================================
echo  1. Статус (показать изменения)
echo  2. Добавить файлы (git add)
echo  3. Создать коммит с комментарием
echo  4. Отправить изменения на GitHub (push)
echo  5. Получить изменения с GitHub (pull)
echo  6. Создать новую ветку
echo  7. Переключиться на ветку
echo  8. Слить ветку в текущую (merge)
echo  9. Показать историю коммитов (лог)
echo 10. Отменить последний коммит (reset)
echo 11. Открыть репозиторий на GitHub
echo 12. Выйти
echo ============================================================
set /p choice="Выберите номер действия (1-12): "

if "%choice%"=="1" goto status
if "%choice%"=="2" goto add
if "%choice%"=="3" goto commit
if "%choice%"=="4" goto push
if "%choice%"=="5" goto pull
if "%choice%"=="6" goto branch_new
if "%choice%"=="7" goto branch_switch
if "%choice%"=="8" goto merge
if "%choice%"=="9" goto log
if "%choice%"=="10" goto reset
if "%choice%"=="11" goto open_github
if "%choice%"=="12" exit
echo Неверный выбор. Нажмите любую клавишу...
pause >nul
goto start

:status
cls
echo ============================================================
echo  СТАТУС ТЕКУЩИХ ИЗМЕНЕНИЙ
echo ============================================================
git status
echo.
pause
goto start

:add
cls
echo ============================================================
echo  ДОБАВЛЕНИЕ ФАЙЛОВ
echo ============================================================
echo Введите имена файлов для добавления (через пробел) или нажмите Enter, чтобы добавить всё:
set /p files="Файлы: "
if "%files%"=="" (
    git add .
) else (
    git add %files%
)
echo.
echo Готово. Текущий статус:
git status
echo.
pause
goto start

:commit
cls
echo ============================================================
echo  СОЗДАНИЕ КОММИТА
echo ============================================================
echo Текущий статус:
git status
echo.
set /p msg="Введите комментарий к коммиту: "
if "%msg%"=="" (
    echo Комментарий не может быть пустым! Попробуйте снова.
    pause
    goto start
)
git commit -m "%msg%"
echo.
pause
goto start

:push
cls
echo ============================================================
echo  ОТПРАВКА НА GITHUB
echo ============================================================
echo Отправляем изменения на сервер...
git push
if %errorlevel% equ 0 (
    echo ✅ Отправка выполнена успешно.
) else (
    echo ❌ Ошибка при отправке. Проверьте соединение или наличие конфликтов.
)
echo.
pause
goto start

:pull
cls
echo ============================================================
echo  ПОЛУЧЕНИЕ ИЗМЕНЕНИЙ С GITHUB
echo ============================================================
echo Скачиваем и объединяем изменения...
git pull
if %errorlevel% equ 0 (
    echo ✅ Обновление выполнено.
) else (
    echo ❌ Ошибка при получении. Возможно, есть конфликты.
    echo Разрешите их вручную, затем сделайте коммит.
)
echo.
pause
goto start

:branch_new
cls
echo ============================================================
echo  СОЗДАНИЕ НОВОЙ ВЕТКИ
echo ============================================================
set /p branch_name="Введите имя новой ветки: "
if "%branch_name%"=="" (
    echo Имя не может быть пустым!
    pause
    goto start
)
git checkout -b %branch_name%
echo ✅ Ветка '%branch_name%' создана и переключена на неё.
echo.
pause
goto start

:branch_switch
cls
echo ============================================================
echo  ПЕРЕКЛЮЧЕНИЕ НА ВЕТКУ
echo ============================================================
echo Список веток:
git branch
echo.
set /p branch_name="Введите имя ветки для переключения: "
if "%branch_name%"=="" (
    echo Имя не может быть пустым!
    pause
    goto start
)
git checkout %branch_name%
if %errorlevel% equ 0 (
    echo ✅ Переключились на ветку '%branch_name%'.
) else (
    echo ❌ Ошибка. Возможно, ветки не существует или есть незакоммиченные изменения.
)
echo.
pause
goto start

:merge
cls
echo ============================================================
echo  СЛИЯНИЕ ВЕТКИ В ТЕКУЩУЮ
echo ============================================================
echo Текущая ветка: 
git branch --show-current
echo.
echo Список всех веток:
git branch -a
echo.
set /p branch_name="Введите имя ветки, которую хотите влить в текущую: "
if "%branch_name%"=="" (
    echo Имя не может быть пустым!
    pause
    goto start
)
echo Выполняется слияние %branch_name% -> текущая ветка...
git merge %branch_name%
if %errorlevel% equ 0 (
    echo ✅ Слияние выполнено успешно.
) else (
    echo ❌ Возникли конфликты при слиянии.
    echo Откройте файлы с конфликтами (git status покажет их), исправьте вручную,
    echo затем добавьте их (git add) и сделайте коммит.
)
echo.
pause
goto start

:log
cls
echo ============================================================
echo  ИСТОРИЯ КОММИТОВ (последние 10)
echo ============================================================
git log --oneline --graph --decorate -10
echo.
pause
goto start

:reset
cls
echo ============================================================
echo  ОТМЕНА ПОСЛЕДНЕГО КОММИТА (soft reset)
echo ============================================================
echo Внимание! Это отменит последний коммит, но оставит изменения в рабочей директории.
set /p confirm="Вы уверены? (y/n): "
if /i not "%confirm%"=="y" goto start
git reset --soft HEAD~1
if %errorlevel% equ 0 (
    echo ✅ Последний коммит отменён. Изменения остались в индексе.
    echo Вы можете снова добавить их и закоммитить.
) else (
    echo ❌ Ошибка при сбросе.
)
echo.
pause
goto start

:open_github
cls
echo ============================================================
echo  ОТКРЫТИЕ РЕПОЗИТОРИЯ НА GITHUB
echo ============================================================
start https://github.com/MrPelmeha/BUG_ROT
echo ✅ Страница репозитория открыта в браузере.
echo.
pause
goto start