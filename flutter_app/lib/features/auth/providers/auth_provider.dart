import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/services/network_service.dart';
import '../../../routes/app_routes.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isLoggedIn = false;
  Map<String, dynamic>? _userInfo;
  String _errorMessage = '';

  // Getters
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;
  Map<String, dynamic>? get userInfo => _userInfo;
  String get errorMessage => _errorMessage;

  AuthProvider() {
    _checkLoginStatus();
  }

  // 检查登录状态
  Future<void> _checkLoginStatus() async {
    try {
      final isLoggedIn = await StorageService.isUserLoggedInAsync();
      _isLoggedIn = isLoggedIn;
      
      if (isLoggedIn) {
        _userInfo = StorageService.getUserInfo();
      }
      
      notifyListeners();
    } catch (e) {
      _isLoggedIn = false;
      notifyListeners();
    }
  }

  // 登录
  Future<bool> login(String phone, String password) async {
    try {
      _setLoading(true);
      _clearError();

      final response = await NetworkService.post(
        '/api/user/login.do',
        data: {
          'phone': phone,
          'userPwd': password,
        },
      );

      if (response.data['status'] == 0) {
        // 登录成功
        final userData = response.data['data'];
        final token = userData['token'] ?? '';
        
        // 保存用户信息和token
        await StorageService.saveUserToken(token);
        await StorageService.saveUserInfo(userData);
        
        _userInfo = userData;
        _isLoggedIn = true;
        
        Get.snackbar(
          '登录成功',
          '欢迎回来！',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        
        notifyListeners();
        return true;
      } else {
        // 登录失败
        _setError(response.data['msg'] ?? '登录失败');
        return false;
      }
    } catch (e) {
      _setError('网络错误，请稍后重试');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // 注册
  Future<bool> register({
    required String phone,
    required String password,
    required String confirmPassword,
    String? inviteCode,
  }) async {
    try {
      _setLoading(true);
      _clearError();

      // 验证密码
      if (password != confirmPassword) {
        _setError('两次输入的密码不一致');
        return false;
      }

      final response = await NetworkService.post(
        '/api/user/reg.do',
        data: {
          'phone': phone,
          'userPwd': password,
          'userPwd2': confirmPassword,
          if (inviteCode != null) 'recomPhone': inviteCode,
        },
      );

      if (response.data['status'] == 0) {
        // 注册成功
        Get.snackbar(
          '注册成功',
          '请登录您的账户',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        
        // 跳转到登录页
        Get.offNamed(AppRoutes.login);
        return true;
      } else {
        // 注册失败
        _setError(response.data['msg'] ?? '注册失败');
        return false;
      }
    } catch (e) {
      _setError('网络错误，请稍后重试');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // 退出登录
  Future<void> logout() async {
    try {
      _setLoading(true);
      
      // 调用退出登录API
      await NetworkService.post('/api/user/logout.do');
    } catch (e) {
      // 即使API调用失败，也要清除本地数据
    } finally {
      // 清除本地数据
      await StorageService.clearUserToken();
      await StorageService.clearUserInfo();
      
      _isLoggedIn = false;
      _userInfo = null;
      
      Get.snackbar(
        '退出成功',
        '已安全退出登录',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
      
      // 跳转到登录页
      Get.offAllNamed(AppRoutes.login);
      
      _setLoading(false);
      notifyListeners();
    }
  }

  // 忘记密码
  Future<bool> forgotPassword(String phone) async {
    try {
      _setLoading(true);
      _clearError();

      final response = await NetworkService.post(
        '/api/user/forgetPwd.do',
        data: {
          'phone': phone,
        },
      );

      if (response.data['status'] == 0) {
        Get.snackbar(
          '成功',
          '重置密码链接已发送到您的手机',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        return true;
      } else {
        _setError(response.data['msg'] ?? '发送失败');
        return false;
      }
    } catch (e) {
      _setError('网络错误，请稍后重试');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // 获取用户信息
  Future<void> fetchUserInfo() async {
    try {
      final response = await NetworkService.get('/api/user/getUserInfo.do');
      
      if (response.data['status'] == 0) {
        _userInfo = response.data['data'];
        await StorageService.saveUserInfo(_userInfo!);
        notifyListeners();
      }
    } catch (e) {
      // 获取用户信息失败，可能token已过期
      await logout();
    }
  }

  // 更新用户信息
  Future<bool> updateUserInfo(Map<String, dynamic> userInfo) async {
    try {
      _setLoading(true);
      
      final response = await NetworkService.post(
        '/api/user/update.do',
        data: userInfo,
      );
      
      if (response.data['status'] == 0) {
        _userInfo = {..._userInfo!, ...userInfo};
        await StorageService.saveUserInfo(_userInfo!);
        
        Get.snackbar(
          '更新成功',
          '用户信息已更新',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        
        notifyListeners();
        return true;
      } else {
        _setError(response.data['msg'] ?? '更新失败');
        return false;
      }
    } catch (e) {
      _setError('网络错误，请稍后重试');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // 修改密码
  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      _setLoading(true);
      _clearError();

      if (newPassword != confirmPassword) {
        _setError('两次输入的新密码不一致');
        return false;
      }

      final response = await NetworkService.post(
        '/api/user/updatePwd.do',
        data: {
          'oldPwd': oldPassword,
          'newPwd': newPassword,
        },
      );

      if (response.data['status'] == 0) {
        Get.snackbar(
          '修改成功',
          '密码已更新，请重新登录',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        
        // 修改密码后需要重新登录
        await logout();
        return true;
      } else {
        _setError(response.data['msg'] ?? '修改失败');
        return false;
      }
    } catch (e) {
      _setError('网络错误，请稍后重试');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // 实名认证
  Future<bool> authentication({
    required String realName,
    required String idCard,
    required String img1Key,
    required String img2Key,
    required String img3Key,
  }) async {
    try {
      _setLoading(true);
      _clearError();

      final response = await NetworkService.post(
        '/api/user/auth.do',
        data: {
          'realName': realName,
          'idCard': idCard,
          'img1Key': img1Key,
          'img2Key': img2Key,
          'img3Key': img3Key,
        },
      );

      if (response.data['status'] == 0) {
        Get.snackbar(
          '提交成功',
          '实名认证信息已提交，请等待审核',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        
        // 更新用户信息
        await fetchUserInfo();
        return true;
      } else {
        _setError(response.data['msg'] ?? '提交失败');
        return false;
      }
    } catch (e) {
      _setError('网络错误，请稍后重试');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // 设置加载状态
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // 设置错误信息
  void _setError(String error) {
    _errorMessage = error;
    Get.snackbar(
      '错误',
      error,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    notifyListeners();
  }

  // 清除错误信息
  void _clearError() {
    _errorMessage = '';
    notifyListeners();
  }
} 