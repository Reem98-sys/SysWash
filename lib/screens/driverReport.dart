import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:syswash/bloc/bloc/collectionreport_bloc.dart';
import 'package:syswash/model/collectionReportModel.dart';
import 'package:syswash/screens/bottomnav.dart';

class DriverReportPage extends StatefulWidget {
  const DriverReportPage({super.key});

  @override
  State<DriverReportPage> createState() => _DriverReportPageState();
}

class _DriverReportPageState extends State<DriverReportPage> {
  final Color primaryPurple = const Color(0xFF68188B);
  final Color lightPurple = const Color(0xFFEDE2F3);
  final Color textColor = const Color(0xFF333333);

  String selectedFilter = 'Daily';
  DateTime selectedDate = DateTime.now();

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  String userId = '';
  String token = '';
  String companyCode = '';

  final List<Map<String, dynamic>> reportData = [];

  @override
  void initState() {
    super.initState();
    loadReportData();
  }

  Future<void> loadReportData() async {
    userId = await storage.read(key: 'login_id') ?? '';
    token = await storage.read(key: 'access_Token') ?? '';
    companyCode = await storage.read(key: 'company_Code') ?? '';

    if (!mounted) return;

    fetchCollectionReport(context);
  }

  DateTimeRange get selectedDateRange {
    final date = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
    );

    switch (selectedFilter) {
      case 'Daily':
        return DateTimeRange(start: date, end: date);

      case 'Yesterday':
        final yesterday = date.subtract(const Duration(days: 1));
        return DateTimeRange(start: yesterday, end: yesterday);

      case 'Weekly':
        final start = date.subtract(Duration(days: date.weekday - 1));

        return DateTimeRange(
          start: start,
          end: start.add(const Duration(days: 6)),
        );

      case 'Monthly':
        // Rolling one-month period
        final previousMonth = DateTime(date.year, date.month - 1, 1);

        final lastDay =
            DateTime(previousMonth.year, previousMonth.month + 1, 0).day;

        final start = DateTime(
          previousMonth.year,
          previousMonth.month,
          date.day > lastDay ? lastDay : date.day,
        );

        return DateTimeRange(start: start, end: date);

      case 'Yearly':
        // Rolling one-year period
        final previousYear = DateTime(date.year - 1, date.month, 1);

        final lastDay =
            DateTime(previousYear.year, previousYear.month + 1, 0).day;

        final start = DateTime(
          previousYear.year,
          previousYear.month,
          date.day > lastDay ? lastDay : date.day,
        );

        return DateTimeRange(start: start, end: date);

      case 'All':
        return DateTimeRange(start: DateTime(2000, 1, 1), end: date);

      default:
        return DateTimeRange(start: date, end: date);
    }
  }

  void fetchCollectionReport(BuildContext context) {
    if (userId.isEmpty || token.isEmpty || companyCode.isEmpty) {
      return;
    }

    final range = selectedDateRange;

    context.read<CollectionreportBloc>().add(
      FetchCollectionreportEvent(
        userId: userId,
        token: token,
        companyCode: companyCode,
        startDate: DateFormat('yyyy-MM-dd').format(range.start),
        endDate: DateFormat('yyyy-MM-dd').format(range.end),
      ),
    );
  }

  double parseAmount(String? amount) {
    return double.tryParse((amount ?? '0').replaceAll(',', '').trim()) ?? 0.0;
  }

  String formatAmount(double amount) {
    return amount.toStringAsFixed(2);
  }

  List<Map<String, dynamic>> get filteredData {
    return reportData.where((item) {
        final date = item['date'] as DateTime;

        switch (selectedFilter) {
          case 'Daily':
            return date.year == selectedDate.year &&
                date.month == selectedDate.month &&
                date.day == selectedDate.day;

          case 'Yesterday':
            final yesterday = DateTime(
              selectedDate.year,
              selectedDate.month,
              selectedDate.day,
            ).subtract(const Duration(days: 1));

            return date.year == yesterday.year &&
                date.month == yesterday.month &&
                date.day == yesterday.day;

          case 'Weekly':
            final startOfWeek = selectedDate.subtract(
              Duration(days: selectedDate.weekday - 1),
            );

            final endOfWeek = startOfWeek.add(const Duration(days: 7));

            return !date.isBefore(
                  DateTime(
                    startOfWeek.year,
                    startOfWeek.month,
                    startOfWeek.day,
                  ),
                ) &&
                date.isBefore(
                  DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day),
                );

          case 'Monthly':
            return date.year == selectedDate.year &&
                date.month == selectedDate.month;

          case 'Yearly':
            return date.year == selectedDate.year;

          case 'All':
            return true;

          default:
            return true;
        }
      }).toList()
      ..sort(
        (a, b) => (b['date'] as DateTime).compareTo(a['date'] as DateTime),
      );
  }

  double get totalAmount {
    return filteredData.fold(
      0.0,
      (sum, item) => sum + (item['amount'] as double),
    );
  }

  String get periodText {
    final range = selectedDateRange;

    switch (selectedFilter) {
      case 'Daily':
        return DateFormat('dd MMM yyyy').format(range.start);

      case 'Yesterday':
        return DateFormat('dd MMM yyyy').format(range.start);

      case 'Weekly':
      case 'Monthly':
      case 'Yearly':
      case 'All':
        return '${DateFormat('dd MMM yyyy').format(range.start)} - '
            '${DateFormat('dd MMM yyyy').format(range.end)}';

      default:
        return '';
    }
  }

  Future<void> selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(
            context,
          ).copyWith(colorScheme: ColorScheme.light(primary: primaryPurple)),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });

      fetchCollectionReport(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F8FB),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black87,
            size: 20,
          ),
          onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Bottomnav(currentIndex: 3),
                ),
              ),
        ),
        title: Text(
          'Collection Report',
          style: TextStyle(
            fontSize: 18.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),

      body: SafeArea(
        child: BlocBuilder<CollectionreportBloc, CollectionreportState>(
          builder: (context, state) {
            if (state is CollectionreportLoading) {
              return Center(
                child: CircularProgressIndicator(color: primaryPurple),
              );
            }

            if (state is CollectionreportError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Unable to load collection report'),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => fetchCollectionReport(context),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            if (state is CollectionreportLoaded) {
              final List<CollectionReportModel> filteredData =
                  state.collectionReportModel;
              debugPrint('UI TOTAL RECORDS: ${filteredData.length}');
              final double totalAmount = filteredData.fold(
                0.0,
                (sum, item) => sum + parseAmount(item.paidAmount),
              );
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(16.w),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // FILTER TITLE
                          Text(
                            'Filter Report',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              color: textColor,
                            ),
                          ),

                          SizedBox(height: 12.h),

                          // DAILY WEEKLY MONTHLY YEARLY
                          Container(
                            padding: EdgeInsets.all(5.w),
                            decoration: BoxDecoration(
                              color: lightPurple,
                              borderRadius: BorderRadius.circular(12.r),
                            ),

                            child: Row(
                              children:
                                  [
                                    'Daily',
                                    'Yesterday',
                                    'Weekly',
                                    'Monthly',
                                    'Yearly',
                                    'All',
                                  ].map((filter) {
                                    final isSelected = selectedFilter == filter;

                                    return Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedFilter = filter;
                                          });

                                          fetchCollectionReport(context);
                                        },

                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 11.h,
                                          ),

                                          decoration: BoxDecoration(
                                            color:
                                                isSelected
                                                    ? primaryPurple
                                                    : Colors.transparent,
                                            borderRadius: BorderRadius.circular(
                                              9.r,
                                            ),
                                          ),

                                          alignment: Alignment.center,

                                          child: Text(
                                            filter,
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  isSelected
                                                      ? Colors.white
                                                      : primaryPurple,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                            ),
                          ),

                          SizedBox(height: 18.h),

                          // DATE SELECTOR
                          GestureDetector(
                            onTap: selectDate,

                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 14.w,
                                vertical: 14.h,
                              ),

                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: lightPurple),
                              ),

                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: primaryPurple,
                                    size: 22.sp,
                                  ),

                                  SizedBox(width: 12.w),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Selected ${selectedFilter} Period',
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color: Colors.grey,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),

                                        SizedBox(height: 3.h),

                                        Text(
                                          periodText,
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w600,
                                            color: textColor,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: primaryPurple,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 20.h),

                          // TOTAL COLLECTION CARD
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(18.w),

                            decoration: BoxDecoration(
                              color: primaryPurple,
                              borderRadius: BorderRadius.circular(15.r),
                            ),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total Amount Collected',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins',
                                  ),
                                ),

                                // SizedBox(height: 8.h),
                                Text(
                                  formatAmount(totalAmount),
                                  style: TextStyle(
                                    fontSize: 25.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Poppins',
                                  ),
                                ),

                                SizedBox(height: 5.h),

                                Text(
                                  '${filteredData.length} Orders Collected',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: Colors.white70,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 22.h),

                          // COLLECTION DETAILS
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Collection Details',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                  color: textColor,
                                ),
                              ),

                              Text(
                                '${filteredData.length} Records',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: primaryPurple,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 12.h),

                          // DATA LIST
                          if (filteredData.isEmpty)
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 40.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.receipt_long_outlined,
                                    size: 38.sp,
                                    color: Colors.grey.shade400,
                                  ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    'No collection records found',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                            )
                          else
                            ...filteredData.map((item) {
                              final order = item.orderId ?? 0;
                              final customer =
                                  item.customerName ?? 'Unknown Customer';
                              final phone = item.customerPhno ?? 'N/A';

                              final parsedDate = DateTime.tryParse(
                                item.orderDate ?? '',
                              );

                              final dateText =
                                  parsedDate != null
                                      ? DateFormat(
                                        'dd MMM yyyy',
                                      ).format(parsedDate)
                                      : item.orderDate ?? 'N/A';

                              final timeText = item.orderTime ?? '--';

                              return Container(
                                margin: EdgeInsets.only(bottom: 10.h),
                                padding: EdgeInsets.all(14.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(13.r),
                                  border: Border.all(
                                    color: const Color(0xFFEDE7F2),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.025),
                                      blurRadius: 7,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),

                                child: Column(
                                  children: [
                                    // ORDER AND AMOUNT
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(8.w),
                                              decoration: BoxDecoration(
                                                color: lightPurple,
                                                borderRadius:
                                                    BorderRadius.circular(9.r),
                                              ),
                                              child: Icon(
                                                Icons.receipt_long_outlined,
                                                color: primaryPurple,
                                                size: 18.sp,
                                              ),
                                            ),

                                            SizedBox(width: 10.w),

                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'ORDER',
                                                  style: TextStyle(
                                                    fontSize: 9.sp,
                                                    color: Colors.grey,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),

                                                Text(
                                                  '#$order',
                                                  style: TextStyle(
                                                    fontSize: 13.sp,
                                                    color: textColor,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),

                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'COLLECTED',
                                              style: TextStyle(
                                                fontSize: 9.sp,
                                                color: Colors.grey,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),

                                            Text(
                                              formatAmount(
                                                parseAmount(item.paidAmount),
                                              ),
                                              style: TextStyle(
                                                fontSize: 15.sp,
                                                color: primaryPurple,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 12.h,
                                      ),
                                      child: Divider(
                                        height: 1,
                                        color: Colors.grey.shade200,
                                      ),
                                    ),

                                    // DATE/TIME AND CUSTOMER DETAILS IN SAME ROW
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // DATE AND TIME
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .calendar_month_outlined,
                                                    size: 15.sp,
                                                    color: primaryPurple,
                                                  ),
                                                  SizedBox(width: 5.w),
                                                  Text(
                                                    'DATE & TIME',
                                                    style: TextStyle(
                                                      fontSize: 9.sp,
                                                      color:
                                                          Colors.grey.shade600,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'Poppins',
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              SizedBox(height: 7.h),

                                              Text(
                                                dateText,
                                                style: TextStyle(
                                                  fontSize: 11.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: textColor,
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),

                                              SizedBox(height: 4.h),

                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.access_time,
                                                    size: 13.sp,
                                                    color: Colors.grey,
                                                  ),
                                                  SizedBox(width: 4.w),
                                                  Flexible(
                                                    child: Text(
                                                      timeText,
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        color:
                                                            Colors
                                                                .grey
                                                                .shade600,
                                                        fontFamily: 'Poppins',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),

                                        Container(
                                          width: 1,
                                          height: 55.h,
                                          color: Colors.grey.shade200,
                                        ),

                                        SizedBox(width: 12.w),

                                        // CUSTOMER DETAILS
                                        Expanded(
                                          flex: 6,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.person_outline,
                                                    size: 15.sp,
                                                    color: primaryPurple,
                                                  ),
                                                  SizedBox(width: 5.w),
                                                  Text(
                                                    'CUSTOMER',
                                                    style: TextStyle(
                                                      fontSize: 9.sp,
                                                      color:
                                                          Colors.grey.shade600,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'Poppins',
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              SizedBox(height: 7.h),

                                              Text(
                                                customer,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 11.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: textColor,
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),

                                              SizedBox(height: 4.h),

                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.phone_outlined,
                                                    size: 13.sp,
                                                    color: Colors.grey,
                                                  ),
                                                  SizedBox(width: 4.w),
                                                  Expanded(
                                                    child: Text(
                                                      phone,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        color:
                                                            Colors
                                                                .grey
                                                                .shade600,
                                                        fontFamily: 'Poppins',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
