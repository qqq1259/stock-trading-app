import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'core/services/storage_service.dart';
import 'core/services/network_service.dart';
import 'features/auth/providers/auth_provider.dart';
import 'features/market/providers/market_provider.dart';
import 'features/trading/providers/trading_provider.dart';
import 'routes/app_routes.dart';
import 'routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 初始化存储服务
  await StorageService.init();
  
  // 初始化网络服务
  NetworkService.init();
  
  // 设置系统UI
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  
  runApp(const StockTradingApp());
}

class StockTradingApp extends StatelessWidget {
  const StockTradingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone X设计尺寸
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => MarketProvider()),
            ChangeNotifierProvider(create: (_) => TradingProvider()),
          ],
          child: GetMaterialApp(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,
            initialRoute: AppRoutes.splash,
            getPages: AppPages.routes,
            translations: AppTranslations(),
            locale: const Locale('zh', 'CN'),
            fallbackLocale: const Locale('en', 'US'),
            builder: (context, widget) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
              );
            },
          ),
        );
      },
    );
  }
}

// 国际化配置
class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'zh_CN': {
      'app_name': '股票交易',
      'login': '登录',
      'register': '注册',
      'market': '行情',
      'trading': '交易',
      'portfolio': '持仓',
      'profile': '我的',
      'welcome': '欢迎使用股票交易系统',
    },
    'en_US': {
      'app_name': 'Stock Trading',
      'login': 'Login',
      'register': 'Register',
      'market': 'Market',
      'trading': 'Trading',
      'portfolio': 'Portfolio',
      'profile': 'Profile',
      'welcome': 'Welcome to Stock Trading System',
    },
  };
} 