# 有限空间作业安全监控 App

## 功能说明

| 功能 | 描述 |
|------|------|
| 📷 实时摄像头 | 调用手机摄像头，实时监控作业现场（前/后置可切换） |
| ⏱ 15分钟倒计时 | 作业开始后自动计时，15分钟时触发报警 |
| 🚨 持续报警 | 倒计时结束弹出报警弹窗 + 持续蜂鸣声 + 震动，不确认就一直响 |
| ✅ 一键确认 | 点击"已完成检测"按钮，确认后自动重置倒计时进入下一轮 |
| ⏰ 贪睡模式 | 可延迟60秒后再次提醒 |
| 🌙 防息屏 | 使用 Wake Lock API 防止屏幕自动关闭 |

---

## 方案一：直接在手机浏览器使用（无需安装）

1. 将 `www/index.html` 文件上传到任意静态托管服务（如 GitHub Pages、Vercel、Netlify）
2. 用手机浏览器打开对应 URL
3. 点击"添加到主屏幕"即可像 App 一样使用
4. 推荐浏览器：Chrome for Android（最完整支持 Wake Lock + Web Audio）

---

## 方案二：打包成 APK（需要开发环境）

### 本地打包环境要求

- Node.js 18+
- JDK 17+
- Android SDK（通过 Android Studio 安装）
- 环境变量：`ANDROID_HOME` 指向 SDK 目录

### 本地打包步骤

```bash
# 1. 进入项目目录
cd confined-space-app

# 2. 安装依赖
npm install

# 3. 添加安卓平台
npx cap add android

# 4. 同步 Web 代码到安卓项目
npx cap sync android

# 5. 构建 Debug APK
cd android
./gradlew assembleDebug

# APK 位置：android/app/build/outputs/apk/debug/app-debug.apk
```

---

## 方案三：使用 GitHub Actions 自动打包（推荐，无需本地环境）

1. 将本项目推送到 GitHub 仓库
2. Actions 会自动触发构建
3. 构建完成后在 **Actions → Artifacts** 下载 APK

```bash
git init
git add .
git commit -m "init: confined space monitoring app"
git remote add origin https://github.com/你的用户名/confined-space-app.git
git push -u origin main
```

---

## 安卓权限配置

打包后需要在 `android/app/src/main/AndroidManifest.xml` 添加以下权限：

```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.VIBRATE" />
<uses-permission android:name="android.permission.WAKE_LOCK" />
<uses-feature android:name="android.hardware.camera" android:required="true" />
```

---

## 调试技巧

- 开发测试时可以把 `INTERVAL_SECONDS = 15 * 60` 改为 `INTERVAL_SECONDS = 15`（15秒触发一次）方便调试
- Chrome DevTools 远程调试：手机开启 USB 调试后，PC Chrome 打开 `chrome://inspect`

---

## 文件结构

```
confined-space-app/
├── www/
│   └── index.html          # 完整 App（单文件）
├── capacitor.config.json   # Capacitor 配置
├── package.json            # 依赖配置
├── .github/
│   └── workflows/
│       └── build-apk.yml   # GitHub Actions CI
└── README.md               # 本文档
```
