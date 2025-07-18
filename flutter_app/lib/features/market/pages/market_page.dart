import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_theme.dart';
import '../../../routes/app_routes.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> with TickerProviderStateMixin {
  late TabController _tabController;
  
  // 模拟指数数据
  final List<Map<String, dynamic>> _indices = [
    {'name': '上证指数', 'value': '--', 'change': '--', 'percent': '--'},
    {'name': '深证成指', 'value': '--', 'change': '--', 'percent': '--'},
    {'name': '北证50', 'value': '--', 'change': '--', 'percent': '--'},
    {'name': '创业板指', 'value': '--', 'change': '--', 'percent': '--'},
  ];

  // 模拟股票数据
  final List<Map<String, dynamic>> _stocks = [
    {
      'code': '600519',
      'name': '贵州茅台',
      'price': 1412.82,
      'change': -9.40,
      'percent': -0.66,
      'volume': 0.09,
    },
    {
      'code': '688256',
      'name': '寒武纪-U',
      'price': 542.71,
      'change': -4.76,
      'percent': -0.87,
      'volume': 0.42,
    },
    {
      'code': '832982',
      'name': '锦波生物',
      'price': 368.88,
      'change': -12.12,
      'percent': -3.18,
      'volume': 0.72,
    },
    {
      'code': '002371',
      'name': '北方华创',
      'price': 335.71,
      'change': 0.56,
      'percent': 0.17,
      'volume': 0.27,
    },
    {
      'code': '002594',
      'name': '比亚迪',
      'price': 329.00,
      'change': -2.00,
      'percent': -0.60,
      'volume': 0.36,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 顶部标签栏
            _buildTopTabBar(),
            
            // 指数区域
            _buildIndicesSection(),
            
            // 市场概况
            _buildMarketOverview(),
            
            // 股票排行榜
            Expanded(
              child: _buildStockRanking(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopTabBar() {
    return Container(
      height: 50.h,
      decoration: const BoxDecoration(
        color: AppTheme.primaryColor,
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        indicatorColor: Colors.white,
        indicatorWeight: 3,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white.withOpacity(0.7),
        labelStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.normal,
        ),
        tabs: const [
          Tab(text: '行情'),
          Tab(text: '自选'),
          Tab(text: '新股申购'),
          Tab(text: '线下配售'),
          Tab(text: '询价转让'),
        ],
      ),
    );
  }

  Widget _buildIndicesSection() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.trending_up,
                size: 20.sp,
                color: AppTheme.primaryColor,
              ),
              SizedBox(width: 8.w),
              Text(
                '指数',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: _indices.map((index) {
              return Expanded(
                child: Column(
                  children: [
                    Text(
                      index['name'],
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      index['value'],
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    Text(
                      '${index['change']} ${index['percent']}',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketOverview() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.pie_chart,
                size: 20.sp,
                color: AppTheme.primaryColor,
              ),
              SizedBox(width: 8.w),
              Text(
                '市场概况',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          
          // 涨跌分布图
          Row(
            children: [
              _buildMarketItem('涨停', 0, AppTheme.riseColor),
              _buildMarketItem('>7%', 41, AppTheme.riseColor),
              _buildMarketItem('5-7', 80, AppTheme.riseColor),
              _buildMarketItem('3-5', 61, AppTheme.riseColor),
              _buildMarketItem('0-3', 194, AppTheme.riseColor),
              _buildMarketItem('平', 204, Colors.grey),
              _buildMarketItem('0-3', 1832, AppTheme.fallColor),
              _buildMarketItem('3-5', 84, AppTheme.fallColor),
              _buildMarketItem('5-7', 15, AppTheme.fallColor),
              _buildMarketItem('>7%', 13, AppTheme.fallColor),
              _buildMarketItem('跌停', 0, AppTheme.fallColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMarketItem(String label, int count, Color color) {
    final maxCount = 2800;
    final height = count == 0 ? 10.h : (count / maxCount * 60.h).clamp(10.h, 60.h);
    
    return Expanded(
      child: Column(
        children: [
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 4.h),
          Container(
            width: double.infinity,
            height: height,
            margin: EdgeInsets.symmetric(horizontal: 2.w),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStockRanking() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Icon(
                  Icons.bar_chart,
                  size: 20.sp,
                  color: AppTheme.primaryColor,
                ),
                SizedBox(width: 8.w),
                Text(
                  '股票排行榜',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          
          // 表头
          Container(
            color: Colors.grey[50],
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              children: [
                SizedBox(
                  width: 80.w,
                  child: Text(
                    '名称',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    '现价',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    '涨跌额',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    '涨跌幅',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                SizedBox(
                  width: 50.w,
                  child: Text(
                    '换手',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // 股票列表
          Expanded(
            child: ListView.separated(
              itemCount: _stocks.length,
              separatorBuilder: (context, index) => Divider(
                height: 1.h,
                color: Colors.grey[200],
              ),
              itemBuilder: (context, index) {
                final stock = _stocks[index];
                final isRise = stock['change'] > 0;
                final isFlat = stock['change'] == 0;
                final textColor = isFlat 
                    ? Colors.grey 
                    : (isRise ? AppTheme.riseColor : AppTheme.fallColor);
                
                return GestureDetector(
                  onTap: () {
                    // TODO: 跳转到股票详情页
                    Get.toNamed(AppRoutes.stockDetail, parameters: {
                      'code': stock['code'],
                      'name': stock['name'],
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 80.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                stock['name'],
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                stock['code'],
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${stock['price']}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${stock['change'] > 0 ? '+' : ''}${stock['change']}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: textColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${stock['percent'] > 0 ? '+' : ''}${stock['percent']}%',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: textColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 50.w,
                          child: Text(
                            '${stock['volume']}%',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 