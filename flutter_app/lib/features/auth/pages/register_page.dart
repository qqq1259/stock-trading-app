import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../../routes/app_routes.dart';
import '../providers/auth_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _inviteCodeController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeTerms = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _inviteCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 40.h),
              
              // Logo和标题
              _buildHeader(),
              
              SizedBox(height: 40.h),
              
              // 注册表单
              _buildRegisterForm(),
              
              SizedBox(height: 24.h),
              
              // 注册按钮
              _buildRegisterButton(),
              
              SizedBox(height: 20.h),
              
              // 用户协议
              _buildTermsSection(),
              
              SizedBox(height: 30.h),
              
              // 登录链接
              _buildLoginLink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // 中信证券Logo
        Container(
          width: 90.w,
          height: 90.w,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.primaryColor, width: 3),
            ),
            child: Center(
              child: Text(
                'CITIC',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          AppConstants.appName,
          style: TextStyle(
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryTextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // 手机号输入框
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: '请输入11位手机号',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.grey[100],
              filled: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请输入手机号';
              }
              if (!RegExp(r'^1[3-9]\d{9}$').hasMatch(value)) {
                return '请输入正确的手机号';
              }
              return null;
            },
          ),
          
          SizedBox(height: 16.h),
          
          // 密码输入框
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              hintText: '请输入登录密码',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.grey[100],
              filled: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey[600],
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请输入密码';
              }
              if (value.length < 6) {
                return '密码长度不能少于6位';
              }
              return null;
            },
          ),
          
          SizedBox(height: 16.h),
          
          // 确认密码输入框
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: _obscureConfirmPassword,
            decoration: InputDecoration(
              hintText: '请再次输入登录密码',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.grey[100],
              filled: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey[600],
                ),
                onPressed: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请再次输入密码';
              }
              if (value != _passwordController.text) {
                return '两次输入的密码不一致';
              }
              return null;
            },
          ),
          
          SizedBox(height: 16.h),
          
          // 邀请码输入框
          TextFormField(
            controller: _inviteCodeController,
            decoration: InputDecoration(
              hintText: '请输入邀请码',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.grey[100],
              filled: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return SizedBox(
          width: double.infinity,
          height: 48.h,
          child: ElevatedButton(
            onPressed: authProvider.isLoading ? null : _handleRegister,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: authProvider.isLoading
                ? SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    '注册',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget _buildTermsSection() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _agreeTerms = !_agreeTerms;
            });
          },
          child: Container(
            width: 20.w,
            height: 20.w,
            decoration: BoxDecoration(
              color: _agreeTerms ? AppTheme.primaryColor : Colors.transparent,
              border: Border.all(
                color: _agreeTerms ? AppTheme.primaryColor : Colors.grey,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: _agreeTerms
                ? Icon(
                    Icons.check,
                    size: 14.sp,
                    color: Colors.white,
                  )
                : null,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '我已阅读并同意',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                ),
                TextSpan(
                  text: '《用户服务协议》',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppTheme.primaryColor,
                  ),
                ),
                TextSpan(
                  text: '《平台隐私政策》',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppTheme.primaryColor,
                  ),
                ),
                TextSpan(
                  text: '。',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '已有账号？',
          style: TextStyle(
            fontSize: 14.sp,
            color: AppTheme.secondaryTextColor,
          ),
        ),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text(
            '去登录',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_agreeTerms) {
      Get.snackbar(
        '提示',
        '请先同意用户协议',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    final success = await authProvider.register(
      phone: _phoneController.text.trim(),
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
      inviteCode: _inviteCodeController.text.trim().isEmpty 
          ? null 
          : _inviteCodeController.text.trim(),
    );

    if (success) {
      Get.offNamed(AppRoutes.login);
    }
  }
} 