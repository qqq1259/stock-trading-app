import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // 中信证券品牌颜色配置
  static const Color primaryColor = Color(0xFFD32F2F);      // 中信红主色
  static const Color primaryLightColor = Color(0xFFFF5252); // 中信红浅色
  static const Color primaryDarkColor = Color(0xFFB71C1C);  // 中信红深色
  static const Color secondaryColor = Color(0xFFFF9800);    // 橙色辅助色
  static const Color successColor = Color(0xFF4CAF50);      // 成功绿色
  static const Color warningColor = Color(0xFFFF9800);      // 警告橙色
  static const Color errorColor = Color(0xFFE53935);        // 错误红色
  static const Color infoColor = Color(0xFF2196F3);         // 信息蓝色
  
  // 股票相关颜色
  static const Color riseColor = Color(0xFFE53935);    // 涨红色
  static const Color fallColor = Color(0xFF4CAF50);    // 跌绿色
  static const Color flatColor = Color(0xFF9E9E9E);    // 平盘灰色
  
  // 背景颜色
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color darkBackground = Color(0xFF141414);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color darkCardBackground = Color(0xFF1F1F1F);
  
  // 文字颜色
  static const Color primaryTextColor = Color(0xFF262626);
  static const Color secondaryTextColor = Color(0xFF595959);
  static const Color hintTextColor = Color(0xFF8C8C8C);
  static const Color disabledTextColor = Color(0xFFBFBFBF);
  
  // 深色模式文字颜色
  static const Color darkPrimaryTextColor = Color(0xFFFFFFFF);
  static const Color darkSecondaryTextColor = Color(0xFFD9D9D9);
  static const Color darkHintTextColor = Color(0xFF8C8C8C);
  
  // 分割线颜色
  static const Color dividerColor = Color(0xFFF0F0F0);
  static const Color darkDividerColor = Color(0xFF434343);
  
  // 浅色主题
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: MaterialColor(primaryColor.value, {
      50: primaryColor.withOpacity(0.1),
      100: primaryColor.withOpacity(0.2),
      200: primaryColor.withOpacity(0.3),
      300: primaryColor.withOpacity(0.4),
      400: primaryColor.withOpacity(0.5),
      500: primaryColor,
      600: primaryColor.withOpacity(0.7),
      700: primaryColor.withOpacity(0.8),
      800: primaryColor.withOpacity(0.9),
      900: primaryColor,
    }),
    primaryColor: primaryColor,
    scaffoldBackgroundColor: lightBackground,
    cardColor: cardBackground,
    dividerColor: dividerColor,
    fontFamily: 'PingFang',
    
    // AppBar主题
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: primaryTextColor,
      elevation: 0,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      titleTextStyle: TextStyle(
        color: primaryTextColor,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: 'PingFang',
      ),
    ),
    
    // 底部导航栏主题
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: primaryColor,
      unselectedItemColor: secondaryTextColor,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    
    // 输入框主题
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: dividerColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: primaryColor),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    
    // 按钮主题
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    
    // 文字主题
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
        fontFamily: 'PingFang',
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
        fontFamily: 'PingFang',
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
        fontFamily: 'PingFang',
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        fontFamily: 'PingFang',
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        fontFamily: 'PingFang',
      ),
      titleLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        fontFamily: 'PingFang',
      ),
      titleMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: primaryTextColor,
        fontFamily: 'PingFang',
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: primaryTextColor,
        fontFamily: 'PingFang',
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: secondaryTextColor,
        fontFamily: 'PingFang',
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: hintTextColor,
        fontFamily: 'PingFang',
      ),
    ),
  );
  
  // 深色主题
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: MaterialColor(primaryColor.value, {
      50: primaryColor.withOpacity(0.1),
      100: primaryColor.withOpacity(0.2),
      200: primaryColor.withOpacity(0.3),
      300: primaryColor.withOpacity(0.4),
      400: primaryColor.withOpacity(0.5),
      500: primaryColor,
      600: primaryColor.withOpacity(0.7),
      700: primaryColor.withOpacity(0.8),
      800: primaryColor.withOpacity(0.9),
      900: primaryColor,
    }),
    primaryColor: primaryColor,
    scaffoldBackgroundColor: darkBackground,
    cardColor: darkCardBackground,
    dividerColor: darkDividerColor,
    fontFamily: 'PingFang',
    
    // AppBar主题
    appBarTheme: const AppBarTheme(
      backgroundColor: darkCardBackground,
      foregroundColor: darkPrimaryTextColor,
      elevation: 0,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      titleTextStyle: TextStyle(
        color: darkPrimaryTextColor,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: 'PingFang',
      ),
    ),
    
    // 底部导航栏主题
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: darkCardBackground,
      selectedItemColor: primaryColor,
      unselectedItemColor: darkSecondaryTextColor,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    
    // 输入框主题
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: darkDividerColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: primaryColor),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    
    // 按钮主题
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    
    // 文字主题
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: darkPrimaryTextColor,
        fontFamily: 'PingFang',
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: darkPrimaryTextColor,
        fontFamily: 'PingFang',
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: darkPrimaryTextColor,
        fontFamily: 'PingFang',
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: darkPrimaryTextColor,
        fontFamily: 'PingFang',
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: darkPrimaryTextColor,
        fontFamily: 'PingFang',
      ),
      titleLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: darkPrimaryTextColor,
        fontFamily: 'PingFang',
      ),
      titleMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: darkPrimaryTextColor,
        fontFamily: 'PingFang',
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: darkPrimaryTextColor,
        fontFamily: 'PingFang',
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: darkSecondaryTextColor,
        fontFamily: 'PingFang',
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: darkHintTextColor,
        fontFamily: 'PingFang',
      ),
    ),
  );
} 