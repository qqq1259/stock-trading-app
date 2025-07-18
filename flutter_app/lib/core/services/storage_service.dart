import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/app_constants.dart';

class StorageService {
  static late SharedPreferences _prefs;
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: IOSAccessibility.first_unlock_this_device,
    ),
  );
  
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  
  // ==================== 普通存储 ====================
  
  // 存储字符串
  static Future<bool> setString(String key, String value) {
    return _prefs.setString(key, value);
  }
  
  // 获取字符串
  static String getString(String key, {String defaultValue = ''}) {
    return _prefs.getString(key) ?? defaultValue;
  }
  
  // 存储整数
  static Future<bool> setInt(String key, int value) {
    return _prefs.setInt(key, value);
  }
  
  // 获取整数
  static int getInt(String key, {int defaultValue = 0}) {
    return _prefs.getInt(key) ?? defaultValue;
  }
  
  // 存储布尔值
  static Future<bool> setBool(String key, bool value) {
    return _prefs.setBool(key, value);
  }
  
  // 获取布尔值
  static bool getBool(String key, {bool defaultValue = false}) {
    return _prefs.getBool(key) ?? defaultValue;
  }
  
  // 存储双精度浮点数
  static Future<bool> setDouble(String key, double value) {
    return _prefs.setDouble(key, value);
  }
  
  // 获取双精度浮点数
  static double getDouble(String key, {double defaultValue = 0.0}) {
    return _prefs.getDouble(key) ?? defaultValue;
  }
  
  // 存储字符串列表
  static Future<bool> setStringList(String key, List<String> value) {
    return _prefs.setStringList(key, value);
  }
  
  // 获取字符串列表
  static List<String> getStringList(String key) {
    return _prefs.getStringList(key) ?? [];
  }
  
  // 存储对象（JSON格式）
  static Future<bool> setObject(String key, Map<String, dynamic> value) {
    return setString(key, jsonEncode(value));
  }
  
  // 获取对象
  static Map<String, dynamic>? getObject(String key) {
    final jsonString = getString(key);
    if (jsonString.isEmpty) return null;
    
    try {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }
  
  // 删除指定key
  static Future<bool> remove(String key) {
    return _prefs.remove(key);
  }
  
  // 清空所有数据
  static Future<bool> clear() {
    return _prefs.clear();
  }
  
  // 检查是否包含指定key
  static bool containsKey(String key) {
    return _prefs.containsKey(key);
  }
  
  // ==================== 安全存储 ====================
  
  // 安全存储字符串
  static Future<void> setSecureString(String key, String value) {
    return _secureStorage.write(key: key, value: value);
  }
  
  // 安全获取字符串
  static Future<String> getSecureString(String key, {String defaultValue = ''}) async {
    final value = await _secureStorage.read(key: key);
    return value ?? defaultValue;
  }
  
  // 安全删除
  static Future<void> deleteSecure(String key) {
    return _secureStorage.delete(key: key);
  }
  
  // 清空安全存储
  static Future<void> deleteAllSecure() {
    return _secureStorage.deleteAll();
  }
  
  // ==================== 用户相关存储 ====================
  
  // 保存用户Token
  static Future<void> saveUserToken(String token) {
    return setSecureString(AppConstants.userTokenKey, token);
  }
  
  // 获取用户Token
  static String getUserToken() {
    // 这里使用同步方法，在实际应用中可能需要异步处理
    return getString(AppConstants.userTokenKey);
  }
  
  // 异步获取用户Token
  static Future<String> getUserTokenAsync() {
    return getSecureString(AppConstants.userTokenKey);
  }
  
  // 清除用户Token
  static Future<void> clearUserToken() async {
    await deleteSecure(AppConstants.userTokenKey);
    await remove(AppConstants.userTokenKey);
  }
  
  // 保存用户信息
  static Future<bool> saveUserInfo(Map<String, dynamic> userInfo) {
    return setObject(AppConstants.userInfoKey, userInfo);
  }
  
  // 获取用户信息
  static Map<String, dynamic>? getUserInfo() {
    return getObject(AppConstants.userInfoKey);
  }
  
  // 清除用户信息
  static Future<bool> clearUserInfo() {
    return remove(AppConstants.userInfoKey);
  }
  
  // 检查用户是否已登录
  static bool isUserLoggedIn() {
    final token = getString(AppConstants.userTokenKey);
    return token.isNotEmpty;
  }
  
  // 异步检查用户是否已登录
  static Future<bool> isUserLoggedInAsync() async {
    final token = await getSecureString(AppConstants.userTokenKey);
    return token.isNotEmpty;
  }
  
  // ==================== 应用设置相关 ====================
  
  // 保存主题模式
  static Future<bool> saveThemeMode(String themeMode) {
    return setString(AppConstants.themeKey, themeMode);
  }
  
  // 获取主题模式
  static String getThemeMode() {
    return getString(AppConstants.themeKey, defaultValue: 'system');
  }
  
  // 保存语言设置
  static Future<bool> saveLanguage(String language) {
    return setString(AppConstants.languageKey, language);
  }
  
  // 获取语言设置
  static String getLanguage() {
    return getString(AppConstants.languageKey, defaultValue: 'zh');
  }
  
  // 保存生物识别设置
  static Future<bool> saveBiometricEnabled(bool enabled) {
    return setBool(AppConstants.biometricKey, enabled);
  }
  
  // 获取生物识别设置
  static bool isBiometricEnabled() {
    return getBool(AppConstants.biometricKey);
  }
  
  // ==================== 交易相关存储 ====================
  
  // 保存自选股列表
  static Future<bool> saveFavoriteStocks(List<String> stockCodes) {
    return setStringList('favorite_stocks', stockCodes);
  }
  
  // 获取自选股列表
  static List<String> getFavoriteStocks() {
    return getStringList('favorite_stocks');
  }
  
  // 添加自选股
  static Future<bool> addFavoriteStock(String stockCode) {
    final favorites = getFavoriteStocks();
    if (!favorites.contains(stockCode)) {
      favorites.add(stockCode);
      return saveFavoriteStocks(favorites);
    }
    return Future.value(true);
  }
  
  // 移除自选股
  static Future<bool> removeFavoriteStock(String stockCode) {
    final favorites = getFavoriteStocks();
    favorites.remove(stockCode);
    return saveFavoriteStocks(favorites);
  }
  
  // 保存交易密码（如果需要）
  static Future<void> saveTradingPassword(String password) {
    return setSecureString('trading_password', password);
  }
  
  // 获取交易密码
  static Future<String> getTradingPassword() {
    return getSecureString('trading_password');
  }
  
  // 清除交易密码
  static Future<void> clearTradingPassword() {
    return deleteSecure('trading_password');
  }
  
  // ==================== 缓存相关 ====================
  
  // 保存行情数据缓存
  static Future<bool> saveMarketCache(Map<String, dynamic> data) {
    return setObject('market_cache', data);
  }
  
  // 获取行情数据缓存
  static Map<String, dynamic>? getMarketCache() {
    return getObject('market_cache');
  }
  
  // 清除行情数据缓存
  static Future<bool> clearMarketCache() {
    return remove('market_cache');
  }
  
  // 保存最后更新时间
  static Future<bool> saveLastUpdateTime(String key, DateTime time) {
    return setString('${key}_last_update', time.toIso8601String());
  }
  
  // 获取最后更新时间
  static DateTime? getLastUpdateTime(String key) {
    final timeString = getString('${key}_last_update');
    if (timeString.isEmpty) return null;
    
    try {
      return DateTime.parse(timeString);
    } catch (e) {
      return null;
    }
  }
  
  // ==================== 搜索历史 ====================
  
  // 保存搜索历史
  static Future<bool> saveSearchHistory(List<String> history) {
    return setStringList('search_history', history);
  }
  
  // 获取搜索历史
  static List<String> getSearchHistory() {
    return getStringList('search_history');
  }
  
  // 添加搜索记录
  static Future<bool> addSearchHistory(String keyword) {
    final history = getSearchHistory();
    history.remove(keyword); // 先移除已存在的
    history.insert(0, keyword); // 添加到首位
    
    // 限制历史记录数量
    if (history.length > 20) {
      history.removeRange(20, history.length);
    }
    
    return saveSearchHistory(history);
  }
  
  // 清除搜索历史
  static Future<bool> clearSearchHistory() {
    return remove('search_history');
  }
} 