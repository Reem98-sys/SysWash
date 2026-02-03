import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:syswash/bloc/bloc/adminhome_bloc.dart';
import 'package:syswash/bloc/bloc/report_bloc.dart';
import 'package:syswash/model/accounttype.dart';
import 'package:syswash/model/salesReport.dart';
import 'package:syswash/screens/bottomnavAdmin.dart';

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
  Map<String, double> accountWiseTotals = {};
  late List<AccountType> accountType;
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

  void _calculateTotals(List<SalesReport> report, List<AccountType> accounttype) {
  totalAmount = 0;
  totalDiscount = 0;
  totalPaid = 0;
  totalBalance = 0;
  totalCommission = 0;

  accountWiseTotals.clear();

  for (final acc in accounttype) {
      if (acc.acTypeName != null && acc.trash != true) {
        accountWiseTotals[acc.acTypeName!] = 0.0;
      }
    }

  for (final item in report) {
    totalAmount += _toDouble(item.subTotal);
    totalDiscount += _toDouble(item.discount);
    totalPaid += _toDouble(item.paidAmount);
    totalBalance += _toDouble(item.balance);
    totalCommission += (item.commission ?? 0).toDouble();

    /// Account-wise totals (using PAID amount)
    final accName = item.accountType;
      if (accName != null && accountWiseTotals.containsKey(accName)) {
        accountWiseTotals[accName] =
            accountWiseTotals[accName]! + _toDouble(item.subTotal);
      }
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        backgroundColor: Colors.white,
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
                accountType = state.accountType;
                _calculateTotals(salesReport,accountType);
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
                                        _tableText('Total Bill Amount'),
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
                                        _tableText('Total Commission'),
                                        _tableValue(
                                          totalCommission.toStringAsFixed(2),
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
                                'Account Wise Sales',
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
                                  children: 
                                    accountWiseTotals.isEmpty
                                          ? [
                                            TableRow(
                                              children: [
                                                _tableText('No Data'),
                                                _tableValue('0.00'),
                                              ],
                                            ),
                                          ]
                                          : accountWiseTotals.entries.map((
                                            entry,
                                          ) {
                                            return TableRow(
                                              children: [
                                                _tableText(entry.key),
                                                _tableValue(
                                                  entry.value.toStringAsFixed(
                                                    2,
                                                  ),
                                                ),
                                              ],
                                            );
                                          }).toList(),
                                  
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
