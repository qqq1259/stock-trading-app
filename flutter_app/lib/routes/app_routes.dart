class AppRoutes {
  // 启动页
  static const String splash = '/splash';
  
  // 认证相关
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  
  // 主页面
  static const String main = '/main';
  static const String home = '/home';
  
  // 行情相关
  static const String market = '/market';
  static const String stockDetail = '/stock-detail';
  static const String klineChart = '/kline-chart';
  static const String stockSearch = '/stock-search';
  static const String favoriteStocks = '/favorite-stocks';
  
  // 交易相关
  static const String trading = '/trading';
  static const String buyStock = '/buy-stock';
  static const String sellStock = '/sell-stock';
  static const String orderHistory = '/order-history';
  static const String orderDetail = '/order-detail';
  
  // 持仓相关
  static const String portfolio = '/portfolio';
  static const String positionDetail = '/position-detail';
  static const String profitLoss = '/profit-loss';
  
  // 资金管理
  static const String funds = '/funds';
  static const String deposit = '/deposit';
  static const String withdraw = '/withdraw';
  static const String fundHistory = '/fund-history';
  static const String bankCard = '/bank-card';
  static const String addBankCard = '/add-bank-card';
  
  // 新股申购
  static const String newStock = '/new-stock';
  static const String newStockDetail = '/new-stock-detail';
  static const String newStockHistory = '/new-stock-history';
  
  // 用户相关
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String accountInfo = '/account-info';
  static const String securitySettings = '/security-settings';
  static const String changePassword = '/change-password';
  static const String changeTradingPassword = '/change-trading-password';
  static const String authentication = '/authentication';
  static const String biometricSettings = '/biometric-settings';
  
  // 新闻资讯
  static const String news = '/news';
  static const String newsDetail = '/news-detail';
  
  // 帮助中心
  static const String help = '/help';
  static const String helpDetail = '/help-detail';
  static const String feedback = '/feedback';
  static const String about = '/about';
  
  // WebView
  static const String webView = '/webview';
  
  // 其他
  static const String qrCode = '/qr-code';
  static const String camera = '/camera';
  static const String imagePicker = '/image-picker';
} 