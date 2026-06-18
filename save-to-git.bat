@echo off
setlocal enabledelayedexpansion

echo ==============================================
echo  Сохранение изменений в Git
echo ==============================================
echo.

:: Проверка, что мы в Git-репозитории
if not exist ".git" (
    echo Ошибка: Папка .git не найдена. Убедитесь, что вы запускаете скрипт в корне репозитория.
    pause
    exit /b
)

:: Показать статус
echo Текущий статус:
git status

:: Запросить сообщение коммита
set /p commit_msg="Введите описание изменений (или нажмите Enter для автогенерации): "
if "%commit_msg%"=="" set commit_msg="Автоматический коммит %date% %time%"

:: Добавить все изменения
echo.
echo Добавляем все файлы...
git add .

:: Создать коммит
echo.
echo Создаём коммит...
git commit -m %commit_msg%

:: Отправить на GitHub
echo.
echo Отправляем на GitHub...
git push

:: Проверка результата
if %errorlevel% equ 0 (
    echo.
    echo ✅ Успешно! Изменения отправлены в GitHub.
) else (
    echo.
    echo ❌ Ошибка при отправке. Проверьте консоль выше.
)

echo.
pause