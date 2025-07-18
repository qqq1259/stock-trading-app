import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../routes/app_routes.dart';
import '../providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
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
              SizedBox(height: 60.h),
              
              // Logo和标题
              _buildHeader(),
              
              SizedBox(height: 60.h),
              
              // 登录表单
              _buildLoginForm(),
              
              SizedBox(height: 32.h),
              
              // 登录按钮
              _buildLoginButton(),
              
              SizedBox(height: 24.h),
              
              // 忘记密码
              _buildForgotPassword(),
              
              SizedBox(height: 40.h),
              
              // 注册链接
              _buildRegisterLink(),
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
        SizedBox(height: 8.h),
        Text(
          AppConstants.appSubtitle,
          style: TextStyle(
            fontSize: 16.sp,
            color: AppTheme.secondaryTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // 手机号输入框
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: '手机号',
              hintText: '请输入手机号',
              prefixIcon: const Icon(Icons.phone),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
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
              labelText: '密码',
              hintText: '请输入密码',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
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
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return SizedBox(
          width: double.infinity,
          height: 48.h,
          child: ElevatedButton(
            onPressed: authProvider.isLoading ? null : _handleLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
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
                    '登录',
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

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          Get.toNamed(AppRoutes.forgotPassword);
        },
        child: Text(
          '忘记密码？',
          style: TextStyle(
            fontSize: 14.sp,
            color: AppTheme.primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '还没有账户？',
          style: TextStyle(
            fontSize: 14.sp,
            color: AppTheme.secondaryTextColor,
          ),
        ),
        TextButton(
          onPressed: () {
            Get.toNamed(AppRoutes.register);
          },
          child: Text(
            '立即注册',
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

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    final success = await authProvider.login(
      _phoneController.text.trim(),
      _passwordController.text,
    );

    if (success) {
      Get.offAllNamed(AppRoutes.main);
    }
  }
} 