@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title DocLeaf 本地阅读器
cd /d "%~dp0"

echo [DocLeaf] 正在检查运行环境...
where node >nul 2>nul || goto :no_node
where npm >nul 2>nul || goto :no_node
where cargo >nul 2>nul || goto :no_rust

for /f %%v in ('node -p "Number(process.versions.node.split('.')[0])"') do set NODE_MAJOR=%%v
if %NODE_MAJOR% LSS 22 goto :old_node

if not exist "node_modules\" (
  echo [DocLeaf] 首次运行，正在安装网页依赖...
  call npm install || goto :failed
)

powershell -NoProfile -Command "try { Invoke-WebRequest -UseBasicParsing -TimeoutSec 2 http://127.0.0.1:8787/health ^| Out-Null; exit 0 } catch { exit 1 }"
if errorlevel 1 (
  echo [DocLeaf] 正在启动番茄书源，首次编译可能需要几分钟...
  start "DocLeaf 番茄书源" cmd /k "cd /d ""%~dp0"" && cargo run --manifest-path integrations/fqapp/rust/Cargo.toml --bin docleaf_bridge"
) else (
  echo [DocLeaf] 番茄书源已经运行。
)

powershell -NoProfile -Command "try { Invoke-WebRequest -UseBasicParsing -TimeoutSec 2 http://localhost:3000/ ^| Out-Null; exit 0 } catch { exit 1 }"
if errorlevel 1 (
  echo [DocLeaf] 正在启动阅读器...
  start "DocLeaf 网页服务" cmd /k "cd /d ""%~dp0"" && npm run dev"
) else (
  echo [DocLeaf] 阅读器已经运行。
)

echo [DocLeaf] 正在等待服务就绪...
for /l %%i in (1,1,120) do (
  powershell -NoProfile -Command "try { Invoke-WebRequest -UseBasicParsing -TimeoutSec 2 http://localhost:3000/ ^| Out-Null; Invoke-WebRequest -UseBasicParsing -TimeoutSec 2 http://127.0.0.1:8787/health ^| Out-Null; exit 0 } catch { exit 1 }"
  if not errorlevel 1 goto :ready
  timeout /t 1 /nobreak >nul
)
echo [DocLeaf] 启动超时，请查看另外两个命令窗口中的日志。
pause
exit /b 1

:ready
echo [DocLeaf] 启动完成：http://localhost:3000/
start "" http://localhost:3000/
echo 可以关闭此窗口；停止服务请关闭另外两个 DocLeaf 命令窗口。
pause
exit /b 0

:no_node
echo [DocLeaf] 未找到 Node.js，请安装 Node.js 22 或更高版本：https://nodejs.org/
pause
exit /b 1

:old_node
echo [DocLeaf] Node.js 版本过低，需要 22 或更高版本。当前主版本：%NODE_MAJOR%
pause
exit /b 1

:no_rust
echo [DocLeaf] 未找到 Rust，请先安装：https://rustup.rs/
pause
exit /b 1

:failed
echo [DocLeaf] 依赖安装失败，请查看上方错误信息。
pause
exit /b 1
