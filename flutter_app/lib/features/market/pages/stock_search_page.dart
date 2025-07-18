import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/storage_service.dart';

class StockSearchPage extends StatefulWidget {
  const StockSearchPage({super.key});

  @override
  State<StockSearchPage> createState() => _StockSearchPageState();
}

class _StockSearchPageState extends State<StockSearchPage> {
  final _searchController = TextEditingController();
  List<String> _searchHistory = [];
  List<Map<String, String>> _hotSearches = [
    {'code': '000001', 'name': '平安银行'},
    {'code': '600036', 'name': '招商银行'},
    {'code': '000002', 'name': '万科A'},
    {'code': '600519', 'name': '贵州茅台'},
    {'code': '000858', 'name': '五粮液'},
  ];

  @override
  void initState() {
    super.initState();
    _loadSearchHistory();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadSearchHistory() async {
    final history = StorageService.getSearchHistory();
    setState(() {
      _searchHistory = history;
    });
  }

  Future<void> _addToHistory(String keyword) async {
    await StorageService.addSearchHistory(keyword);
    await _loadSearchHistory();
  }

  Future<void> _clearHistory() async {
    await StorageService.clearSearchHistory();
    setState(() {
      _searchHistory = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        title: const Text('股票搜索'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 搜索框
          _buildSearchBar(),
          
          // 搜索结果或历史记录
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_searchHistory.isNotEmpty) ...[
                    _buildHistorySection(),
                    SizedBox(height: 20.h),
                  ],
                  _buildHotSearchSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40.h,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: '输入股票代码/简拼',
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 20.sp,
                    color: Colors.grey[600],
                  ),
                ),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    _handleSearch(value);
                  }
                },
              ),
            ),
          ),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: () {
              final query = _searchController.text.trim();
              if (query.isNotEmpty) {
                _handleSearch(query);
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                '搜索',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistorySection() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '历史搜索',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  _showClearHistoryDialog();
                },
                child: Icon(
                  Icons.delete_outline,
                  size: 20.sp,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 12.w,
            runSpacing: 8.h,
            children: _searchHistory.map((keyword) {
              return GestureDetector(
                onTap: () => _handleSearch(keyword),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Text(
                    keyword,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHotSearchSection() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '热门搜索',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.local_fire_department,
                size: 20.sp,
                color: Colors.orange,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _hotSearches.length,
            separatorBuilder: (context, index) => Divider(
              height: 1.h,
              color: Colors.grey[200],
            ),
            itemBuilder: (context, index) {
              final stock = _hotSearches[index];
              return GestureDetector(
                onTap: () => _handleSearch('${stock['code']} ${stock['name']}'),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Row(
                    children: [
                      Container(
                        width: 20.w,
                        height: 20.w,
                        decoration: BoxDecoration(
                          color: index < 3 ? AppTheme.primaryColor : Colors.grey[400],
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              stock['name']!,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              stock['code']!,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.trending_up,
                        size: 20.sp,
                        color: AppTheme.riseColor,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showClearHistoryDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('清空历史记录'),
        content: const Text('确定要清空所有搜索历史记录吗？'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              _clearHistory();
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

  void _handleSearch(String keyword) async {
    await _addToHistory(keyword);
    
    // TODO: 实现搜索逻辑，跳转到股票详情页
    Get.snackbar(
      '搜索',
      '搜索: $keyword',
      snackPosition: SnackPosition.TOP,
    );
    
    // 这里应该跳转到股票详情页
    // Get.toNamed(AppRoutes.stockDetail, parameters: {'code': keyword});
  }
} 