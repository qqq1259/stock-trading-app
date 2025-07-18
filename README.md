# 信e通 - 中信证券股票交易APP

[![Build APK](https://github.com/qqq1259/stock-trading-app/actions/workflows/build-apk.yml/badge.svg)](https://github.com/qqq1259/stock-trading-app/actions/workflows/build-apk.yml)

完整的股票交易移动应用，采用Flutter开发，完美还原中信证券移动端体验。

## 📱 应用特性

### 🏠 首页功能
- 股票搜索
- 快捷功能菜单  
- 行业板块
- 市场资讯

### 📈 行情功能
- 实时股价
- K线图表
- 技术指标
- 股票排行

### 💰 交易功能
- 买入卖出
- 持仓管理
- 资金查询
- 交易记录

### ⭐ 自选功能
- 股票收藏
- 价格提醒
- 自定义分组

### 👤 个人中心
- 账户信息
- 安全设置
- 客服支持

## 🎨 UI设计

- 🔴 中信证券官方红色主题 (#D32F2F)
- 📱 完全还原CITIC Securities移动端界面
- 🌟 Material Design 3.0设计语言
- 📊 专业金融数据图表展示

## 🔧 技术栈

- **Framework**: Flutter 3.16.5
- **语言**: Dart
- **UI组件**: Material Design 3.0
- **图表**: Syncfusion Charts + FL Chart
- **状态管理**: Provider + GetX
- **网络**: Dio
- **存储**: Flutter Secure Storage + Hive

## 📦 APK下载

### 自动构建
项目配置了GitHub Actions自动构建，每次推送代码后会自动生成APK文件。

在 [Actions页面](https://github.com/qqq1259/stock-trading-app/actions) 下载最新构建的APK。

### APK信息
- **应用名称**: 信e通
- **包名**: com.citic.stock_trading_app
- **版本**: 1.0.0
- **最低Android版本**: Android 5.0 (API 21)
- **文件大小**: 约25-35MB

## 🚀 快速开始

### 前置要求
- Flutter 3.16.5+
- Android SDK
- Dart 3.0+

### 构建步骤

1. **克隆项目**
   ```bash
   git clone https://github.com/qqq1259/stock-trading-app.git
   cd stock-trading-app/flutter_app
   ```

2. **安装依赖**
   ```bash
   flutter pub get
   ```

3. **构建APK**
   ```bash
   flutter build apk --release
   ```

## 📂 项目结构

```
flutter_app/
├── lib/
│   ├── core/                 # 核心服务
│   │   ├── constants/        # 常量定义
│   │   ├── services/         # 网络、存储服务
│   │   └── theme/           # 主题配置
│   ├── features/            # 功能模块
│   │   ├── auth/            # 登录认证
│   │   ├── main/            # 主页
│   │   ├── market/          # 行情
│   │   ├── trading/         # 交易
│   │   ├── portfolio/       # 持仓
│   │   └── profile/         # 个人中心
│   ├── routes/              # 路由配置
│   └── main.dart           # 应用入口
├── android/                 # Android配置
└── pubspec.yaml            # 依赖管理
```

## 📱 安装说明

1. 下载对应的APK文件：
   - `信e通-arm64-v8a.apk` (推荐，适合大多数现代手机)
   - `信e通-armeabi-v7a.apk` (适合较老的32位手机)

2. 在Android设备上启用"未知来源"应用安装权限

3. 点击APK文件进行安装

4. 首次启动时授予必要的权限

## 🔧 开发

### 本地开发
```bash
flutter run
```

### 代码分析
```bash
flutter analyze
```

### 测试
```bash
flutter test
```

## 📄 开源协议

本项目仅供学习和参考使用。

## 🤝 贡献

欢迎提交Issues和Pull Requests来改进项目。

## 📧 联系

如有问题或建议，请通过GitHub Issues联系。 