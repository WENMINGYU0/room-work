@echo off
chcp 65001 >nul
echo.
echo ====================================================
echo   有限空间作业监控 App - 一键推送到 GitHub 打包
echo ====================================================
echo.

set /p GITHUB_USER="请输入你的 GitHub 用户名: "
set REPO_NAME=confined-space-monitor

echo.
echo [1/5] 进入项目目录...
cd /d "C:\Users\Klaus\WorkBuddy\2026-06-04-08-58-00\confined-space-app"

echo [2/5] 初始化 Git 仓库...
git init
git add .
git commit -m "feat: confined space safety monitoring app v1.0"

echo.
echo [3/5] 准备创建 GitHub 仓库...
echo.
echo 请在浏览器中打开以下链接，创建一个名为 "%REPO_NAME%" 的 **空仓库**：
echo.
echo   https://github.com/new
echo.
echo   - Repository name: %REPO_NAME%
echo   - 选择 Public 或 Private 均可
echo   - 【重要】不要勾选 "Add a README file"，保持空仓库
echo.
pause

echo [4/5] 推送代码到 GitHub...
git branch -M main
git remote remove origin 2>nul
git remote add origin https://github.com/%GITHUB_USER%/%REPO_NAME%.git
git push -u origin main

echo.
echo [5/5] 完成！
echo.
echo ====================================================
echo   APK 下载地址：
echo   https://github.com/%GITHUB_USER%/%REPO_NAME%/actions
echo.
echo   等待约 5-10 分钟构建完成后：
echo   点击最新的 workflow run → 滚动到底部 Artifacts
echo   下载 "有限空间监控-debug-apk" 即可
echo ====================================================
echo.
pause
