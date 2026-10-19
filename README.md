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

运行前需安装：

- [Node.js](https://nodejs.org/) 22 或更高版本
- [Rust](https://rustup.rs/)

首次运行会自动执行 `npm install` 并编译本地书源，完成后自动打开：

```text
http://localhost:3000/
```

### macOS

双击 `一键启动.command`。如果 macOS 阻止首次打开，请右键文件，选择“打开”。关闭启动器的终端窗口或按 `Control+C` 即可停止服务。

### Windows 10/11

双击 `一键启动-Windows.bat`。脚本会分别打开“DocLeaf 番茄书源”和“DocLeaf 网页服务”两个命令窗口；关闭这两个窗口即可停止服务。

Windows 首次编译 Rust 时可能需要安装 Microsoft C++ Build Tools。如果 Cargo 提示缺少链接器，请安装 [Visual Studio Build Tools](https://visualstudio.microsoft.com/visual-cpp-build-tools/) 并勾选“使用 C++ 的桌面开发”。

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
