import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../routes/app_routes.dart';
import '../../auth/providers/auth_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 用户信息头部
              _buildUserHeader(),
              
              SizedBox(height: 12.h),
              
              // 我的资产
              _buildAssetSection(),
              
              SizedBox(height: 12.h),
              
              // 常用服务
              _buildServiceSection(),
              
              SizedBox(height: 12.h),
              
              // 更多功能
              _buildMoreSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserHeader() {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        final userInfo = authProvider.userInfo;
        final isLoggedIn = authProvider.isLoggedIn;
        
        return Container(
          color: Colors.white,
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              // 头像
              Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person,
                  size: 30.sp,
                  color: Colors.grey[600],
                ),
              ),
              
              SizedBox(width: 16.w),
              
              // 用户信息
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isLoggedIn && userInfo != null 
                          ? (userInfo['nickname'] ?? 'T61387479')
                          : 'T61387479',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      isLoggedIn && userInfo != null 
                          ? (userInfo['phone'] ?? '188****0001')
                          : '188****0001',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              
              // 设置按钮
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.settings);
                },
                child: Icon(
                  Icons.settings,
                  size: 24.sp,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAssetSection() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          // 资产操作按钮
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildAssetButton(
                icon: Icons.account_balance_wallet,
                label: '银证转入',
                onTap: () {},
              ),
              _buildAssetButton(
                icon: Icons.account_balance_wallet_outlined,
                label: '银证转出',
                onTap: () {},
              ),
              _buildAssetButton(
                icon: Icons.history,
                label: '持仓记录',
                onTap: () {},
              ),
              _buildAssetButton(
                icon: Icons.analytics,
                label: '集合资产',
                onTap: () {},
              ),
            ],
          ),
          
          SizedBox(height: 20.h),
          
          // 我的资产
          Row(
            children: [
              Text(
                '我的资产',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.visibility_off,
                size: 20.sp,
                color: Colors.grey[600],
              ),
            ],
          ),
          
          SizedBox(height: 16.h),
          
          // 资产数据
          Row(
            children: [
              Expanded(
                child: _buildAssetItem('总资产', '0.00'),
              ),
              Expanded(
                child: _buildAssetItem('总市值', '0.00'),
              ),
              Expanded(
                child: _buildAssetItem('占用资金', '0.00'),
              ),
            ],
          ),
          
          SizedBox(height: 12.h),
          
          Row(
            children: [
              Expanded(
                child: _buildAssetItem('可用资金', '0.00'),
              ),
              Expanded(
                child: _buildAssetItem('可取资金', '0.00'),
              ),
              Expanded(
                child: _buildAssetItem('提现中', '0.00'),
              ),
            ],
          ),
          
          SizedBox(height: 12.h),
          
          Row(
            children: [
              Expanded(
                child: _buildAssetItem('浮动盈亏', '0.00'),
              ),
              SizedBox(width: 100.w), // 占位
              Expanded(
                child: _buildAssetItem('总盈亏', '0.00'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAssetButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              icon,
              size: 24.sp,
              color: AppTheme.primaryColor,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssetItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildServiceSection() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '常用服务',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildServiceItem(
                icon: Icons.verified_user,
                label: '实名认证',
                onTap: () {
                  Get.toNamed(AppRoutes.authentication);
                },
              ),
              _buildServiceItem(
                icon: Icons.lock,
                label: '登录密码',
                onTap: () {
                  Get.toNamed(AppRoutes.changePassword);
                },
              ),
              _buildServiceItem(
                icon: Icons.security,
                label: '提现密码',
                onTap: () {
                  Get.toNamed(AppRoutes.changeTradingPassword);
                },
              ),
              _buildServiceItem(
                icon: Icons.receipt_long,
                label: '资金记录',
                onTap: () {
                  Get.toNamed(AppRoutes.fundHistory);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              icon,
              size: 24.sp,
              color: AppTheme.primaryColor,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoreSection() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Text(
              '更多功能',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          _buildMenuItem(
            icon: Icons.receipt,
            title: '交易记录',
            onTap: () {
              Get.toNamed(AppRoutes.orderHistory);
            },
          ),
          _buildMenuItem(
            icon: Icons.credit_card,
            title: '银行卡',
            onTap: () {
              Get.toNamed(AppRoutes.bankCard);
            },
          ),
          _buildMenuItem(
            icon: Icons.person,
            title: '个人资料',
            onTap: () {
              Get.toNamed(AppRoutes.accountInfo);
            },
          ),
          _buildMenuItem(
            icon: Icons.logout,
            title: '退出',
            onTap: () {
              _showLogoutDialog();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[200]!,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24.sp,
              color: AppTheme.primaryColor,
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 20.sp,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('确认退出'),
        content: const Text('确定要退出登录吗？'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              final authProvider = Get.find<AuthProvider>();
              authProvider.logout();
            },
            child: Text(
              '确定',
              style: TextStyle(color: AppTheme.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
} 