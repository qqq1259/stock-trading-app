class AppConstants {
  // 应用基本信息
  static const String appName = '信e通';
  static const String appSubtitle = '中信证券';
  static const String appVersion = '1.0.0';
  
  // API配置
  static const String baseUrl = 'https://api.hxcszy888.com/';
  static const String webSocketUrl = 'wss://api.hxcszy888.com/ws';
  
  // 存储Key
  static const String userTokenKey = 'user_token';
  static const String userInfoKey = 'user_info';
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language';
  static const String biometricKey = 'biometric_enabled';
  
  // 页面大小
  static const int pageSize = 20;
  
  // 刷新时间间隔（秒）
  static const int marketRefreshInterval = 3;
  static const int tradingRefreshInterval = 1;
  
  // 图片配置
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
  static const List<String> supportedImageFormats = ['jpg', 'jpeg', 'png'];
  
  // 交易时间配置
  static const String marketOpenTime = '09:30:00';
  static const String marketCloseTime = '15:00:00';
  static const String marketLunchStartTime = '11:30:00';
  static const String marketLunchEndTime = '13:00:00';
  
  // 数值格式化
  static const int priceDecimalPlaces = 2;
  static const int percentDecimalPlaces = 2;
  static const int volumeDecimalPlaces = 0;
  
  // 中信证券品牌颜色配置
  static const String primaryRedValue = '#D32F2F';     // 中信红
  static const String primaryRedGradientValue = '#FF5252'; // 渐变红
  static const String redColorValue = '#F44336';       // 涨红色
  static const String greenColorValue = '#4CAF50';     // 跌绿色
  static const String primaryColorValue = '#D32F2F';   // 主色调
  
  // 错误消息
  static const String networkErrorMessage = '网络连接失败，请检查网络设置';
  static const String serverErrorMessage = '服务器错误，请稍后重试';
  static const String dataFormatErrorMessage = '数据格式错误';
  static const String authErrorMessage = '登录已过期，请重新登录';
  
  // 成功消息
  static const String loginSuccessMessage = '登录成功';
  static const String registerSuccessMessage = '注册成功';
  static const String orderSubmitSuccessMessage = '订单提交成功';
  static const String orderCancelSuccessMessage = '订单取消成功';
  
  // 正则表达式
  static const String phoneRegex = r'^1[3-9]\d{9}$';
  static const String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const String passwordRegex = r'^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d@$!%*?&]{6,}$';
  
  // 股票代码格式
  static const String shStockCodeRegex = r'^6\d{5}$';
  static const String szStockCodeRegex = r'^(0|3)\d{5}$';
  static const String hkStockCodeRegex = r'^\d{5}$';
  static const String usStockCodeRegex = r'^[A-Z]{1,5}$';
  
  // WebView User Agent
  static const String webViewUserAgent = 'StockTradingApp/1.0.0 (Mobile)';
  
  // 推送通知
  static const String fcmTopicMarket = 'market_updates';
  static const String fcmTopicTrading = 'trading_notifications';
  static const String fcmTopicNews = 'news_updates';
} 