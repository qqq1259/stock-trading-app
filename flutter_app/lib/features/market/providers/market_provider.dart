import 'package:flutter/material.dart';

class MarketProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<Map<String, dynamic>> _marketData = [];
  String _errorMessage = '';

  // Getters
  bool get isLoading => _isLoading;
  List<Map<String, dynamic>> get marketData => _marketData;
  String get errorMessage => _errorMessage;

  // 获取市场数据
  Future<void> fetchMarketData() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      // TODO: 实现API调用
      await Future.delayed(const Duration(seconds: 1));
      
      // 模拟数据
      _marketData = [
        {
          'code': '000001',
          'name': '平安银行',
          'price': 15.67,
          'change': 0.36,
          'changePercent': 2.34,
        },
        {
          'code': '600036',
          'name': '招商银行',
          'price': 42.15,
          'change': -0.53,
          'changePercent': -1.23,
        },
      ];
      
      _errorMessage = '';
    } catch (e) {
      _errorMessage = '获取市场数据失败';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
} 