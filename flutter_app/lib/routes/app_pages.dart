import 'package:get/get.dart';
import 'app_routes.dart';

// 导入页面
import '../features/splash/pages/splash_page.dart';
import '../features/auth/pages/login_page.dart';
import '../features/auth/pages/register_page.dart';
import '../features/main/pages/main_page.dart';
import '../features/market/pages/market_page.dart';
import '../features/market/pages/stock_search_page.dart';
import '../features/trading/pages/trading_page.dart';
import '../features/portfolio/pages/portfolio_page.dart';
import '../features/profile/pages/profile_page.dart';

class AppPages {
  static final routes = [
    // 启动页
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
    ),
    
    // 登录注册
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterPage(),
      transition: Transition.rightToLeft,
    ),
    
    // 主页面
    GetPage(
      name: AppRoutes.main,
      page: () => const MainPage(),
      transition: Transition.noTransition,
    ),
    
    // 行情
    GetPage(
      name: AppRoutes.market,
      page: () => const MarketPage(),
    ),
    
    // 股票搜索
    GetPage(
      name: AppRoutes.stockSearch,
      page: () => const StockSearchPage(),
      transition: Transition.rightToLeft,
    ),
    
    // 交易
    GetPage(
      name: AppRoutes.trading,
      page: () => const TradingPage(),
    ),
    
    // 持仓
    GetPage(
      name: AppRoutes.portfolio,
      page: () => const PortfolioPage(),
    ),
    
    // 个人中心
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfilePage(),
    ),
  ];
} 