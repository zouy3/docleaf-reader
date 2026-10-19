# DocLeaf 本地阅读器

一个伪装成 Word 风格的本地网页阅读器。支持导入 EPUB、PDF、TXT、DOCX、Markdown、HTML、FB2、RTF，并可通过本地桥接服务读取番茄小说。

## 功能

- 本地书架与阅读进度记忆
- 中文目录识别、章节跳转、上一章/下一章
- 字体、字号、行距和纸张宽度调整
- 番茄小说搜索、按章在线读取和断点缓存
- 章节评论、段落评论及评论图片
- 番茄排行榜与书籍简介推荐
- 阅读文件保存在当前浏览器的 IndexedDB 中

## 一键运行

首次运行会自动执行 `npm install` 并编译本地书源，完成后自动打开：

```text
http://localhost:3000/
```

### macOS

双击 `一键启动.command`。如果 macOS 阻止首次打开，请右键文件，选择“打开”。关闭启动器的终端窗口或按 `Control+C` 即可停止服务。

### Windows 10/11

#### 推荐：下载预编译版

打开仓库右侧的 [Releases](https://github.com/zouy3/docleaf-reader/releases)，下载 **DocLeaf-Windows-x64.zip** 并完整解压。该版本已经包含番茄书源 `.exe`，不需要安装 Rust，也不需要安装约 1.7 GB 的 Visual Studio C++ Build Tools。

在解压后的项目文件夹地址栏输入 `cmd` 并回车，然后运行：

```bat
一键启动-Windows.bat
```

脚本只会在缺少时通过 Windows 自带的 `winget` 安装 Node.js LTS，随后安装网页依赖并启动 DocLeaf。也可以直接双击这个 `.bat` 文件，效果相同。

如果提示找不到 `winget`，请先从 Microsoft Store 安装或更新 **应用安装程序（App Installer）**。

下面的 Rust 和 C++ 安装步骤仅供源码开发者使用；普通用户不需要安装。

#### 源码版说明

GitHub 页面中 `Code` → `Download ZIP` 得到的是源码版，不包含预编译 `.exe`。源码版仍需要以下完整开发环境。普通用户请下载 Releases 中的 Windows 包。

#### 第二步：安装 Node.js

1. 打开 [Node.js 官网](https://nodejs.org/)，下载 Node.js 22 LTS 或更高版本的 Windows 安装包（`.msi`）。
2. 运行安装程序，保持默认选项，并确保 Node.js 被添加到 `PATH`。
3. 安装完成后关闭之前打开的命令行窗口，再打开新的“命令提示符”。
4. 分别运行以下命令确认安装成功：

```bat
node -v
npm -v
```

`node -v` 应显示 `v22` 或更高版本。如果仍显示“不是内部或外部命令”，请重启 Windows 后再试。

#### 第三步：安装 Rust

1. 打开 [Rust 安装页面](https://rustup.rs/)，下载并运行 `rustup-init.exe`。
2. 在安装窗口输入 `1`，使用默认安装方式。
3. 安装完成后关闭命令行窗口并重新打开，然后运行：

```bat
cargo -V
```

能够显示 Cargo 版本号即表示安装成功。

#### 第四步：安装 C++ 编译工具（建议首次运行前安装）

1. 下载并运行 [Visual Studio Build Tools](https://visualstudio.microsoft.com/visual-cpp-build-tools/)。
2. 在“工作负载”中勾选 **使用 C++ 的桌面开发**。
3. 保持右侧默认组件，确认其中包含 MSVC 编译工具和 Windows SDK，然后点击安装。
4. 安装完成后建议重启 Windows。

这是编译番茄书源所需的本地组件；如果缺少它，Cargo 通常会提示找不到 `link.exe` 或链接器。

#### 第五步：启动 DocLeaf

进入解压后的项目文件夹，双击 `一键启动-Windows.bat`，或在该文件夹的命令提示符中运行它。脚本将：

1. 检查预编译番茄书源和 Node.js；
2. 首次运行时自动下载网页依赖；
3. 打开番茄书源和网页服务两个命令窗口；
4. 服务就绪后自动打开 `http://localhost:3000/`。

首次安装网页依赖可能需要几分钟，请保持窗口开启。以后启动会快很多。关闭两个 DocLeaf 命令窗口即可停止服务。

#### Windows 常见问题

- **`Node.js was not found`**：尚未安装 Node.js，或安装后的终端没有刷新。安装 Node.js 22+ 后关闭所有命令行窗口，必要时重启电脑。
- **仍提示需要 Rust**：下载的是源码 ZIP；请改为下载 Releases 中的 `DocLeaf-Windows-x64.zip`。
- **找不到 `link.exe` / linker**：安装 Visual Studio Build Tools，并勾选“使用 C++ 的桌面开发”。
- **端口被占用**：关闭旧的 DocLeaf、Node 或 Cargo 窗口后重新运行。
- **浏览器没有自动打开**：手动访问 `http://localhost:3000/`。
- **PowerShell 安全提示**：请从完整解压的项目中运行 `.bat`；启动器会仅为本次运行使用 `Bypass`，不会永久修改系统执行策略。

## 命令行运行

```bash
npm install
npm run dev:full
```

构建检查：

```bash
npm run build
```

## GitHub 打包

运行：

```bash
bash scripts/package-github.sh
```

会在 `release/` 生成 `docleaf-reader-github.zip`，其中不包含依赖、编译缓存、设备数据或嵌套 Git 历史，可直接解压后上传到新的 GitHub 仓库。

## 说明

番茄相关功能通过集成的 [ch6vip/fqapp](https://github.com/ch6vip/fqapp) 本地核心实现，仅建议用于个人阅读与技术学习。请尊重内容版权及平台规则。该集成项目的原始许可证位于 `integrations/fqapp/LICENSE`。
