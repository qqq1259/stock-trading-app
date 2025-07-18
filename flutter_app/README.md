# 📱 信e通 - 中信证券股票交易APP

一个基于Flutter开发的专业股票交易移动应用，完美还原中信证券官方APP的设计风格和用户体验。

## 🎯 项目概述

本项目是中信证券股票交易系统的移动端实现，采用Flutter跨平台框架开发，支持Android和iOS双平台。

### ✨ 应用特色

- 🎨 **专业设计**: 100%还原中信证券官方APP设计风格
- 🏢 **品牌一致性**: 采用中信证券官方品牌色和Logo
- 📱 **响应式界面**: 适配各种屏幕尺寸的Android设备
- 🚀 **流畅体验**: 原生性能的移动应用体验
- 🔒 **安全可靠**: 企业级安全标准和数据保护

## 📋 功能特性

### ✅ 已实现功能

- **用户认证系统**
  - 用户登录/注册
  - 密码管理
  - 用户协议确认

- **行情展示**
  - 股票实时行情
  - 指数数据展示
  - 市场概况可视化
  - 涨跌分布图表

- **智能搜索**
  - 股票代码/名称搜索
  - 搜索历史记录
  - 热门股票推荐

- **个人中心**
  - 用户资产展示
  - 账户信息管理
  - 功能服务入口

- **品牌展示**
  - 启动页动画
  - 品牌Logo展示
  - 官方配色应用

### 🚧 计划中功能

- **交易功能**
  - 股票买入/卖出
  - 订单管理
  - 交易历史

- **资金管理**
  - 银证转账
  - 充值提现
  - 资金流水

- **高级功能**
  - K线图表
  - 技术指标
  - 价格预警
  - 推送通知

## 🛠 技术栈

- **框架**: Flutter 3.10+
- **语言**: Dart 3.0+
- **状态管理**: Provider + GetX
- **网络请求**: Dio
- **本地存储**: SharedPreferences + FlutterSecureStorage
- **UI组件**: Material Design + 自定义组件
- **图表**: FL Chart + Syncfusion Charts

## 📁 项目结构

```
lib/
├── core/                    # 核心功能
│   ├── constants/          # 常量配置
│   ├── theme/             # 主题配置
│   └── services/          # 服务类
├── features/               # 功能模块
│   ├── auth/              # 认证模块
│   ├── market/            # 行情模块
│   ├── trading/           # 交易模块
│   ├── portfolio/         # 持仓模块
│   └── profile/           # 个人中心
├── routes/                # 路由配置
├── main.dart              # 应用入口
└── ...
```

## 🚀 快速开始

### 环境要求

- Flutter SDK 3.10 或更高版本
- Dart SDK 3.0 或更高版本
- Android Studio / VS Code
- Android SDK API 21+ (Android 5.0+)

### 安装步骤

1. **克隆项目**
   ```bash
   git clone [项目地址]
   cd flutter_app
   ```

2. **安装依赖**
   ```bash
   flutter pub get
   ```

3. **运行应用**
   ```bash
   flutter run
   ```

4. **构建APK**
   ```bash
   # 调试版
   flutter build apk --debug
   
   # 发布版
   flutter build apk --release
   ```

### 快速构建

Windows用户可以使用项目根目录的 `quick_build.bat` 脚本一键构建APK：

```bash
# 在项目根目录执行
quick_build.bat
```

## 📱 应用信息

- **应用名称**: 信e通
- **包名**: com.citic.stock_trading_app
- **版本**: 1.0.0
- **最低Android版本**: API 21 (Android 5.0)
- **目标Android版本**: API 33 (Android 13)

## 🎨 设计规范

### 品牌色彩

- **主色调**: `#D32F2F` (中信红)
- **辅助色**: `#FF5252` (渐变红)
- **涨色**: `#E53935` (涨红)
- **跌色**: `#4CAF50` (跌绿)

### 字体

- **中文**: PingFang SC
- **英文**: San Francisco / Roboto

## 📖 开发文档

- [构建指南](../BUILD_GUIDE.md)
- [API文档](docs/API.md)
- [设计规范](docs/DESIGN.md)
- [部署指南](docs/DEPLOY.md)

## 🤝 贡献

欢迎提交Issue和Pull Request来改进这个项目。

### 开发规范

1. 遵循Flutter官方编码规范
2. 使用有意义的提交信息
3. 添加必要的注释和文档
4. 确保代码通过所有测试

## 📄 许可证

本项目仅用于学习和演示目的。

## 📞 联系支持

如有技术问题或建议，请通过以下方式联系：

- 提交Issue到项目仓库
- 查看项目文档和FAQ
- 参考Flutter官方文档

---

## 🎉 特别鸣谢

感谢中信证券提供的设计参考和Flutter社区的技术支持。

**立即体验专业的股票交易应用！** 🚀 