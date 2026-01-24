import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:syswash/bloc/bloc/adminhome_bloc.dart';
import 'package:syswash/bloc/bloc/report_bloc.dart';
import 'package:syswash/model/salesReport.dart';

class Adminsalesreport extends StatefulWidget {
  const Adminsalesreport({super.key});

  @override
  State<Adminsalesreport> createState() => _AdminsalesreportState();
}

class _AdminsalesreportState extends State<Adminsalesreport> {
  final storage = const FlutterSecureStorage();
  late List<SalesReport> salesReport;
  double totalAmount = 0.0;
  double totalDiscount = 0.0;
  double totalPaid = 0.0;
  double totalBalance = 0.0;
  double totalCommission = 0.0;
  double wml = 0.0;
  double qserve = 0.0;
  double aldobi = 0.0;
  double walkin = 0.0;
  double walkincash = 0.0;
  String? username;
  @override
  void initState() {
    super.initState();
    _loadAndFetchData();
  }

  Future<void> _loadAndFetchData() async {
    final userId = await storage.read(key: 'login_id');
    final companyCode = await storage.read(key: 'company_Code');
    final token = await storage.read(key: 'access_Token');
    final storedUsername = await storage.read(key: 'user_name');
    String format(DateTime d) =>
        "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
    final dateNow = DateTime.now();
    if (mounted) {
      setState(() {
        username = storedUsername ?? 'User';
      });
    }
    print('userId : ${userId}');
    print('companyCode : ${companyCode}');
    print('token : ${token}');
    if (userId != null && companyCode != null && token != null) {
      context.read<AdminhomeBloc>().add(
        FetchcompanyEvent(token: token, companyCode: companyCode),
      );
      context.read<ReportBloc>().add(
        FetchSalesReportEvent(token: token, companyCode: companyCode, datenow: format(dateNow)),
      );
    } else {
      debugPrint('Missing userId or companyCode in storage');
    }
  }
  double _toDouble(String? value) {
  if (value == null || value.isEmpty) return 0.0;
  return double.tryParse(value) ?? 0.0;
}

  void _calculateTotals(List<SalesReport> report) {
  totalAmount = 0;
  totalDiscount = 0;
  totalPaid = 0;
  totalBalance = 0;
  totalCommission = 0;

  wml = 0;
  qserve = 0;
  aldobi = 0;
  walkin = 0;
  walkincash = 0;

  

  for (final item in report) {
    totalAmount += _toDouble(item.totalAmount);
    totalDiscount += _toDouble(item.discount);
    totalPaid += _toDouble(item.paidAmount);
    totalBalance += _toDouble(item.balance);
    totalCommission += (item.commission ?? 0).toDouble();

    /// Account-wise totals (using PAID amount)
    switch (item.accountType?.toUpperCase()) {
      case 'WML':
        wml += _toDouble(item.paidAmount);
        break;
      case 'QSERVE':
        qserve += _toDouble(item.paidAmount);
        break;
      case 'ALDOBI':
        aldobi += _toDouble(item.paidAmount);
        break;
      case 'CR.(WALKIN)':
        walkin += _toDouble(item.paidAmount);
        break;
      case 'WALK IN CASH':
        walkincash += _toDouble(item.paidAmount);
        break;
    }
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, ${username}!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Welcome',
              style: TextStyle(
                color: const Color(0xFFBFBFBF),
                fontSize: 14.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          BlocBuilder<AdminhomeBloc, AdminhomeState>(
            builder: (context, state) {
              if (state is AdmincompanyLoaded &&
                  state.companyDetails.imageLightMode != null &&
                  state.companyDetails.imageLightMode!.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Image.network(
                    state.companyDetails.imageLightMode!,
                    width: 115.w,
                    height: 35.h,
                  ),
                );
              }
              return SizedBox();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: BlocBuilder<ReportBloc, ReportState>(
            builder: (context, state) {
              if (state is ReportLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is ReportError) {
                return Center(child: Text('Failed to load data'));
              }
              if (state is SalesReportLoaded) {
                salesReport = state.salesReport;
                _calculateTotals(salesReport);
                return Column(
                  children: [
                    Container(
                      width: 362.w,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Sales Report',
                                style: TextStyle(
                                  color: const Color(0xFF150A33),
                                  fontSize: 16.sp,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            width: 362.w,
                            height: 230.h,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  color: const Color(0xFFF0F0F0),
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                ),
                                child: Table(
                                  border: TableBorder.all(
                                    color: const Color(0xFFE7E7E7),
                                    width: 1,
                                  ),
                                  children: [
                                    TableRow(
                                      children: [
                                        _tableText('Total Amount'),
                                        _tableValue(
                                          totalAmount.toStringAsFixed(2),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        _tableText('Total Discount'),
                                        _tableValue(
                                          totalDiscount.toStringAsFixed(2),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        _tableText('Total Paid'),
                                        _tableValue(
                                          totalPaid.toStringAsFixed(2),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        _tableText('Total Balance'),
                                        _tableValue(
                                          totalBalance.toStringAsFixed(2),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        _tableText('Total Commission'),
                                        _tableValue(
                                          totalCommission.toStringAsFixed(2),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 21.h),
                    Container(
                      width: 362.w,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Account Wise',
                                style: TextStyle(
                                  color: const Color(0xFF150A33),
                                  fontSize: 16.sp,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            width: 362.w,
                            height: 230.h,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  color: const Color(0xFFF0F0F0),
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                ),
                                child: Table(
                                  border: TableBorder.all(
                                    color: const Color(0xFFE7E7E7),
                                    width: 1,
                                  ),
                                  children: [
                                    TableRow(
                                      children: [
                                        _tableText('WML'),
                                        _tableValue(wml.toStringAsFixed(2)),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        _tableText('QSERVE'),
                                        _tableValue(qserve.toStringAsFixed(2)),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        _tableText('ALDOBI'),
                                        _tableValue(aldobi.toStringAsFixed(2)),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        _tableText('CR.(WALKIN)'),
                                        _tableValue(walkin.toStringAsFixed(2)),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        _tableText('WALK IN CASH'),
                                        _tableValue(
                                          walkincash.toStringAsFixed(2),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
Widget _tableText(String data) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
    child: Text(
      data,
      style: TextStyle(
        color: const Color(0xFF150A33),
        fontSize: 14.sp,
        fontFamily: 'DM Sans',
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

Widget _tableValue(String data) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
    child: Align(
      alignment: Alignment.centerRight,
      child: Text(
        data,
        style: TextStyle(
          color: const Color(0xFF150A33),
          fontSize: 14.sp,
          fontFamily: 'DM Sans',
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}
