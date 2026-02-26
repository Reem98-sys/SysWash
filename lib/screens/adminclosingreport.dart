import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:syswash/bloc/bloc/adminhome_bloc.dart';
import 'package:syswash/bloc/bloc/report_bloc.dart';
import 'package:syswash/helper/date_range_popup.dart';
import 'package:syswash/model/adminclosingreport.dart';
import 'package:syswash/model/serviceDetails.dart';

class Adminclosingreport extends StatefulWidget {
  const Adminclosingreport({super.key});

  @override
  State<Adminclosingreport> createState() => _AdminclosingreportState();
}

class _AdminclosingreportState extends State<Adminclosingreport> {
  final storage = const FlutterSecureStorage();
  late AdminClosingReport adminClosingReport;
  late List<ServiceDetailsModel> serviceDetails;
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  String? username;
  int itemTotalQty = 0;
  double itemTotalSale = 0;
  int serviceTotalQty = 0;
  double serviceTotalSale = 0;
  @override
  void initState() {
    super.initState();
    _loadAndFetchData();
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
            FetchCloseEvent(
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
        FetchCloseEvent(
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
              if (state is ClosingReportLoaded) {
                adminClosingReport = state.adminClosingReport;
                serviceDetails = state.servicedetail;
                itemTotalQty = 0;
                itemTotalSale = 0;
                serviceTotalQty = 0;
                serviceTotalSale = 0;
                final Map<String, String> serviceNameMap = {
                  for (final service in serviceDetails)
                    if (service.posView == true)
                      service.serviceCode!:
                          service.serviceName ?? service.serviceCode!,
                };

                if (adminClosingReport.clothcount != null) {
                  for (var e in adminClosingReport.clothcount!) {
                    itemTotalQty += e.count ?? 0;
                    itemTotalSale += e.price ?? 0;
                  }
                }

                if (adminClosingReport.serviceWiseCounts != null) {
                  adminClosingReport.serviceWiseCounts!.forEach((key, value) {
                    if (serviceNameMap.containsKey(key)) {
                      serviceTotalQty += value.count ?? 0;
                      serviceTotalSale += value.totalPrice ?? 0;
                    }
                  });
                }

                return SingleChildScrollView(
                  child: Column(
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
                                  'Closing Report',
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
                              // height: 600.h,
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
                                    vertical: 20,
                                  ),
                                  child: Table(
                                    border: TableBorder.all(
                                      color: const Color(0xFFE7E7E7),
                                      width: 1,
                                    ),
                                    children: [
                                      TableRow(
                                        children: [
                                          _tableText('Total Sale'),
                                          _tableValue(
                                            adminClosingReport.totalGrossSale
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          _tableText('Total Cash Sale'),
                                          _tableValue(
                                            adminClosingReport.totalCashSale
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          _tableText('Total Bank Sale'),
                                          _tableValue(
                                            adminClosingReport.totalBankSale
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          _tableText('Total Card Sale'),
                                          _tableValue(
                                            adminClosingReport.totalCardSale
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          _tableText('Wallet In Amount'),
                                          _tableValue(
                                            adminClosingReport.walletaddamount
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          _tableText('Wallet Balance'),
                                          _tableValue(
                                            adminClosingReport.walletBalance
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          _tableText('Total Discount'),
                                          _tableValue(
                                            adminClosingReport.totalDiscount
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          _tableText('Total Commission'),
                                          _tableValue(
                                            adminClosingReport.totalCommission
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          _tableText('Other Expenses'),
                                          _tableValue(
                                            (adminClosingReport.totalExpense! -
                                                    adminClosingReport
                                                        .totalCommission!)
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          _tableText('Cash In'),
                                          _tableValue(
                                            adminClosingReport.cashIn
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          _tableText('Cash Out'),
                                          _tableValue(
                                            adminClosingReport.cashOut
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          _tableText('Cash in Hand'),
                                          _tableValue(
                                            (adminClosingReport.totalCashSale! -
                                                    adminClosingReport
                                                        .cashexpense! +
                                                    adminClosingReport
                                                        .walletBalance!)
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          _tableText('Bank Balance'),
                                          _tableValue(
                                            adminClosingReport.bankbalance
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          _tableText('Card Balance'),
                                          _tableValue(
                                            adminClosingReport.cardbalance
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          _tableText('Outstanding Amount'),
                                          _tableValue(
                                            adminClosingReport.outstandingamount
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          _tableText('Pending Amount'),
                                          _tableValue(
                                            adminClosingReport.debtamount
                                                .toString(),
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

                      // Item Wise Report
                      Container(
                        width: 362.w,
                        child: Column(
                          children: [
                            SizedBox(height: 21.h),
                            Row(
                              children: [
                                Text(
                                  'Item Wise Report',
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
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 25,
                                    vertical: 20,
                                  ),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        minWidth: MediaQuery.of(context).size.width,
                                      ),
                                    child: Table(
                                      border: TableBorder.all(
                                        color: const Color(0xFFE7E7E7),
                                        width: 1,
                                      ),
                                      children: [
                                        TableRow(
                                          children: [
                                            _tableText('Item Name'),
                                            _tableText('Quantity'),
                                            _tableText('Gross Sales'),
                                          ],
                                        ),
                                        if (adminClosingReport.clothcount ==
                                                null ||
                                            adminClosingReport
                                                .clothcount!
                                                .isEmpty)
                                          TableRow(
                                            children: [
                                              _tableText('-'),
                                              _tableValue('-'),
                                              _tableValue('-'),
                                            ],
                                          ),
                                    
                                        // Data rows
                                        if (adminClosingReport.clothcount != null)
                                          ...adminClosingReport.clothcount!.map((
                                            entry,
                                          ) {
                                            return TableRow(
                                              children: [
                                                _tableText(
                                                  entry.cloth.toString(),
                                                ),
                                                _tableValue(
                                                  entry.count.toString(),
                                                ),
                                                _tableValue(
                                                  entry.price.toString(),
                                                ),
                                              ],
                                            );
                                          }).toList(),
                                          TableRow(
                                            decoration: BoxDecoration(
                                            ),
                                            children: [
                                              _tableText('Total'),
                                              _tableValue(itemTotalQty.toString()),
                                              _tableValue(itemTotalSale.toStringAsFixed(2)),
                                            ],
                                          ),
                                      ],
                                    ),)
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Service Wise Report
                      Container(
                        width: 362.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 21.h),
                            Text(
                              'Service Wise Report',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
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
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 25,
                                    vertical: 20,
                                  ),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        minWidth: MediaQuery.of(context).size.width,
                                      ),
                                    child: Table(
                                      border: TableBorder.all(
                                        color: Colors.grey.shade300,
                                      ),
                                      children: [
                                        TableRow(
                                          children: [
                                            _tableText('Service'),
                                            _tableText('Quantity'),
                                            _tableText('Gross Sales'),
                                          ],
                                        ),
                                        if (adminClosingReport
                                                    .serviceWiseCounts ==
                                                null ||
                                            adminClosingReport
                                                .serviceWiseCounts!
                                                .isEmpty)
                                          TableRow(
                                            children: [
                                              _tableText('-'),
                                              _tableValue('-'),
                                              _tableValue('-'),
                                            ],
                                          ),
                                    
                                        if (adminClosingReport
                                                .serviceWiseCounts !=
                                            null)
                                          ...adminClosingReport
                                              .serviceWiseCounts!
                                              .entries
                                              .map((entry) {
                                                final serviceCode = entry.key;
                                                final data = entry.value;
                                    
                                                if (!serviceNameMap.containsKey(
                                                  serviceCode,
                                                )) {
                                                  return null;
                                                }
                                    
                                                return TableRow(
                                                  children: [
                                                    _tableText(
                                                      serviceNameMap[serviceCode]!,
                                                    ), 
                                                    _tableValue(
                                                      data.count.toString(),
                                                    ),
                                                    _tableValue(
                                                      data.totalPrice
                                                          .toStringAsFixed(
                                                            2,
                                                          ), 
                                                    ),
                                                  ],
                                                );
                                              })
                                              .whereType<TableRow>()
                                              .toList(),
                                              TableRow(
                                                decoration: BoxDecoration(
                                                ),
                                                children: [
                                                  _tableText('Total'),
                                                  _tableValue(serviceTotalQty.toString()),
                                                  _tableValue(serviceTotalSale.toStringAsFixed(2)),
                                                ],
                                              ),
                                      ],
                                    ),)
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
      softWrap: true,
      maxLines: null,
      overflow: TextOverflow.visible,
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
        textAlign: TextAlign.right,
        softWrap: true,
        maxLines: null,
        overflow: TextOverflow.visible,
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
