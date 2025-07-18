import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../../routes/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 顶部搜索栏
            _buildTopSearchBar(),
            
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // 品牌区域
                    _buildBrandSection(),
                    
                    // 功能菜单
                    _buildFunctionMenu(),
                    
                    // 公告通知
                    _buildNoticeSection(),
                    
                    // 品牌展示图
                    _buildBrandShowcase(),
                    
                    // 财富观点
                    _buildWealthViewpoints(),
                    
                    // 行业板块
                    _buildIndustrySection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopSearchBar() {
    return Container(
      height: 60.h,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            AppTheme.primaryColor,
            AppTheme.primaryLightColor,
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            // Logo
            Container(
              width: 36.w,
              height: 36.w,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  'CITIC',
                  style: TextStyle(
                    fontSize: 8.sp,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ),
            
            SizedBox(width: 12.w),
            
            // 搜索框
            Expanded(
              child: GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.stockSearch),
                child: Container(
                  height: 36.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 16.w),
                      Icon(
                        Icons.search,
                        size: 18.sp,
                        color: Colors.grey[600],
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '输入股票代码/简拼',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            SizedBox(width: 12.w),
            
            // 客服和消息
            Row(
              children: [
                Icon(
                  Icons.headset_mic,
                  color: Colors.white,
                  size: 24.sp,
                ),
                SizedBox(width: 12.w),
                Icon(
                  Icons.email_outlined,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandSection() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppTheme.primaryColor,
            AppTheme.primaryLightColor,
          ],
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          
          // 主功能菜单
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMainMenuItem(
                  icon: Icons.person_add,
                  label: '交易开户',
                  onTap: () {},
                ),
                _buildMainMenuItem(
                  icon: Icons.trending_up,
                  label: '市场行情',
                  onTap: () {},
                ),
                _buildMainMenuItem(
                  icon: Icons.assessment,
                  label: '龙虎榜',
                  onTap: () {},
                ),
                _buildMainMenuItem(
                  icon: Icons.history,
                  label: '持仓记录',
                  onTap: () {},
                ),
              ],
            ),
          ),
          
          SizedBox(height: 30.h),
          
          // 品牌标语
          Text(
            '中信证券信e通',
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          
          SizedBox(height: 8.h),
          
          Text(
            '海量资讯 | 极速交易 | 精选理财 | 金牌顾问',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          
          SizedBox(height: 30.h),
        ],
      ),
    );
  }

  Widget _buildMainMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60.w,
        child: Column(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: Colors.white,
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
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFunctionMenu() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildFunctionItem(
            icon: Icons.new_releases,
            label: '新股申购',
            onTap: () {},
          ),
          _buildFunctionItem(
            icon: Icons.trending_down,
            label: '线下配售',
            onTap: () {},
          ),
          _buildFunctionItem(
            icon: Icons.compare_arrows,
            label: '询价转让',
            onTap: () {},
          ),
          _buildFunctionItem(
            icon: Icons.chat,
            label: '联系客服',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildFunctionItem({
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
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              size: 24.sp,
              color: Colors.grey[700],
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

  Widget _buildNoticeSection() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        height: 40.h,
        decoration: BoxDecoration(
          color: Colors.orange[50],
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            SizedBox(width: 12.w),
            Icon(
              Icons.volume_up,
              size: 20.sp,
              color: Colors.orange,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                '欢迎访问本平台！',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.orange[800],
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 20.sp,
              color: Colors.orange,
            ),
            SizedBox(width: 12.w),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandShowcase() {
    return Container(
      margin: EdgeInsets.all(16.w),
      height: 120.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF1976D2),
            Color(0xFF42A5F5),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 20.w,
            top: 20.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 32.w,
                      height: 32.w,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          'CITIC',
                          style: TextStyle(
                            fontSize: 8.sp,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      '中信证券',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  'CITIC SECURITIES',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          
          // 装饰图案
          Positioned(
            right: 20.w,
            top: 20.h,
            child: Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(40.r),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWealthViewpoints() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '财富',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                '观点',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                '全方位照顾您的财富每一天',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          
          SizedBox(height: 16.h),
          
          // 行业板块网格
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 12.h,
            crossAxisSpacing: 12.w,
            childAspectRatio: 1.2,
            children: [
              _buildIndustryCard('文化传媒', '+1.04%', AppTheme.riseColor),
              _buildIndustryCard('贵金属', '+3.43%', AppTheme.riseColor),
              _buildIndustryCard('多元金融', '+2.02%', AppTheme.riseColor),
              _buildIndustryCard('汽车整车', '+0.35%', AppTheme.riseColor),
              _buildIndustryCard('生物制品', '+0.41%', AppTheme.riseColor),
              _buildIndustryCard('医疗服务', '-0.12%', AppTheme.fallColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIndustryCard(String name, String change, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            change,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndustrySection() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '领涨概念',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.chevron_right,
                size: 20.sp,
                color: Colors.grey,
              ),
            ],
          ),
          
          SizedBox(height: 16.h),
          
          Container(
            height: 100.h,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: const Center(
              child: Text('概念板块数据加载中...'),
            ),
          ),
        ],
      ),
    );
  }
} 