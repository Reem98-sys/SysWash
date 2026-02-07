import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:syswash/bloc/bloc/adminhome_bloc.dart';
import 'package:syswash/bloc/bloc/report_bloc.dart';
import 'package:syswash/helper/date_range_popup.dart';
import 'package:syswash/model/cashLedger.dart';
import 'package:syswash/screens/bottomnavAdmin.dart';

class Admincashlegder extends StatefulWidget {
  const Admincashlegder({super.key});

  @override
  State<Admincashlegder> createState() => _AdmincashlegderState();
}

class _AdmincashlegderState extends State<Admincashlegder> {
  final storage = const FlutterSecureStorage();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  late List<CashLedger> cashLedger;
  String? username;
  double totalAmount = 0.0;
  @override
  void initState() {
    super.initState();
    _loadAndFetchData();
  }

  String formatApiDateToUi(String apiDate) {
    if (apiDate.isEmpty) return '';

    final parts = apiDate.split('-'); // yyyy-MM-dd
    if (parts.length != 3) return apiDate;

    return '${parts[2]}-${parts[1]}-${parts[0]}';
  }

  String _apiDateFromUI(String uiDate) {
    final parts = uiDate.split('-'); // dd-MM-yyyy
    return "${parts[2]}-${parts[1]}-${parts[0]}";
  }

  void _openDatePopup() {
    showDateRangePopup(
      context: context,
      startDateController: startDateController,
      endDateController: endDateController,
      onSave: () async {
        final companyCode = await storage.read(key: 'company_Code');
        final token = await storage.read(key: 'access_Token');

        if (companyCode != null && token != null) {
          context.read<AdminhomeBloc>().add(
            FetchcompanyEvent(token: token, companyCode: companyCode),
          );

          context.read<ReportBloc>().add(
            FetchCashLedgerEvent(
              token: token,
              companyCode: companyCode,
              startDate: _apiDateFromUI(startDateController.text),
              endDate: _apiDateFromUI(endDateController.text),
            ),
          );
        }
      },
    );
  }

  double _toDouble(String? value) {
    if (value == null || value.isEmpty) return 0.0;
    return double.tryParse(value) ?? 0.0;
  }

  void _calculateTotals(List<CashLedger> report) {
    final list = report ?? [];

    for (final item in list) {
      totalAmount += item.paidAmount!.toDouble();
    }
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
        FetchCashLedgerEvent(
          token: token,
          companyCode: companyCode,
          startDate: format(dateNow),
          endDate: format(dateNow),
        ),
      );
    } else {
      debugPrint('Missing userId or companyCode in storage');
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
              if (state is CashLedgerReportLoaded) {
                cashLedger = state.cashLedger;
                for (final item in cashLedger ?? []) {
                  totalAmount += item.paidAmount;
                }
                return Column(
                  children: [
                    Container(
                      width: 362.w,
                      child: Column(
                        children: [
                          SizedBox(height: 30.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Cash Ledger Report',
                                style: TextStyle(
                                  color: const Color(0xFF150A33),
                                  fontSize: 16.sp,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.filter_alt_outlined),
                                onPressed: _openDatePopup,
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            width: 362.w,
                            // height: 230.h,
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
                                padding: const EdgeInsets.all(20),
                                child: Table(
                                  border: TableBorder.all(
                                    color: const Color(0xFFE7E7E7),
                                    width: 1,
                                  ),
                                  children: [
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                            15,
                                            10,
                                            15,
                                            10,
                                          ),
                                          child: Text(
                                            'Total Amount',
                                            style: TextStyle(
                                              color: const Color(0xFF150A33),
                                              fontSize: 14.sp,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                            15,
                                            10,
                                            15,
                                            10,
                                          ),
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              totalAmount.toString(),
                                              style: TextStyle(
                                                color: const Color(0xFF150A33),
                                                fontSize: 14.sp,
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
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
                    SizedBox(height: 20.h),

                    Container(
                      width: 362.w,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Color(0xFFF0F0F0)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            headingRowColor: MaterialStateProperty.all(
                              const Color(0xFFF5F5F5),
                            ),
                            columns: const [
                              DataColumn(label: Text('Order')),
                              DataColumn(label: Text('Date')),
                              DataColumn(label: Text('Customer')),
                              DataColumn(label: Text('Mode')),
                              DataColumn(label: Text('Receiver')),
                              DataColumn(label: Text('Amount')),
                            ],
                            rows:
                                cashLedger.map((item) {
                                  return DataRow(
                                    cells: [
                                      DataCell(Text(item.order.toString())),
                                      DataCell(Text(formatApiDateToUi(item.paymentDate.toString()) ?? '')),
                                      DataCell(Text(item.customerName ?? '')),
                                      DataCell(Text(item.paymentMode ?? '')),
                                      DataCell(Text(item.billReceiver ?? '')),
                                      DataCell(
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            item.paidAmount.toString(),
                                          ),
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
