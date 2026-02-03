import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syswash/bloc/bloc/adminhome_bloc.dart';
import 'package:syswash/bloc/bloc/reportlist_bloc.dart';
import 'package:syswash/screens/adminCashLegder.dart';
import 'package:syswash/screens/adminExpense.dart';
import 'package:syswash/screens/adminOutstanding.dart';
import 'package:syswash/screens/adminSalesReport.dart';
import 'package:syswash/screens/adminTransaction.dart';
import 'package:syswash/screens/admindriverreport.dart';
import 'package:syswash/screens/adminemployeereport.dart';
import 'package:syswash/screens/adminitemwise.dart';
import 'package:syswash/screens/adminreportdetail.dart';

class Adminreport extends StatefulWidget {
  const Adminreport({super.key});

  @override
  State<Adminreport> createState() => _AdminreportState();
}

class _AdminreportState extends State<Adminreport> {
  final List<Map<String, String>> data = [
    {"icon": "assets/Report.svg", "title": "Order Report", "type": "order"},
    {"icon": "assets/saleperson.svg", "title": "Sales Report", "type": "sales"},
    {"icon": "assets/cash.svg", "title": "Cash Ledger", "type": "cash"},
    {
      "icon": "assets/expense.svg",
      "title": "Expense Report",
      "type": "expense",
    },
    {
      "icon": "assets/Report.svg",
      "title": "Transaction Report",
      "type": "transcation",
    },
    {
      "icon": "assets/Report.svg",
      "title": "Outstanding Report",
      "type": "debtors",
    },
    {
      "icon": "assets/customer.svg",
      "title": "Customer Report",
      "type": "customer",
    },
    {
      "icon": "assets/customer.svg",
      "title": "Employee Report",
      "type": "employee",
    },
    {"icon": "assets/customer.svg", "title": "Driver Report", "type": "driver"},
    {
      "icon": "assets/Report.svg",
      "title": "Item Wise Report",
      "type": "itemwise",
    },
    {"icon": "assets/Report.svg", "title": "Closing Report", "type": "closing"},
    {"icon": "assets/Report.svg", "title": "Plant Report", "type": "plant"},
    {
      "icon": "assets/Report.svg",
      "title": "Edit History Report",
      "type": "edit",
    },
    {"icon": "assets/Report.svg", "title": "Service Report", "type": "service"},
  ];

  final Map<String, String> reportPermissionMap = {
    "order": "orderReport",
    "sales": "salesReport",
    "cash": "cashLedgerReport",
    "expense": "expenseReport",
    "transcation": "transactionReport",
    "debtors": "deptorsReport",
    "customer": "customerReport",
    "employee": "employeeReport",
    "driver": "driverReport",
    "itemwise": "itemWisReport",
    "closing": "closingReport",
    "plant": "plantWiseReport",
    "edit": "editHistory",
    "service": "serviceWiseReport",
  };

  final storage = const FlutterSecureStorage();
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
      context.read<ReportlistBloc>().add(
        FetchUserTypeEvent(token: token, companyCode: companyCode),
      );
    } else {
      debugPrint('Missing userId or companyCode in storage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Report',
                    style: TextStyle(
                      color: const Color(0xFF150A33),
                      fontSize: 16.sp,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 22.h),
              Expanded(
                child: BlocBuilder<ReportlistBloc, ReportlistState>(
                  builder: (context, state) {
                    if (state is ReportListLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state is ReportListError) {
                      return Center(child: Text('Failed to load data'));
                    }
                    if (state is UsertypeLoaded) {
                      final userType = state.userType;

                      final filteredMenu =
                          data.where((item) {
                            final type = item['type']!;
                            final permissionKey = reportPermissionMap[type];
                            if (permissionKey == null) return false;

                            return userType.hasPermission(permissionKey);
                          }).toList();

                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 12,
                          childAspectRatio: 168 / 130,
                        ),
                        itemCount: filteredMenu.length,
                        itemBuilder: (context, index) {
                          final item = filteredMenu[index];
                          return GestureDetector(
                            onTap: () {
                              switch (item['type']) {
                                case "order":
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => Adminreportdetail(),
                                    ),
                                  );
                                  break;
                                case "sales":
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => Adminsalesreport(),
                                    ),
                                  );
                                  break;
                                case "cash":
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => Admincashlegder(),
                                    ),
                                  );
                                  break;
                                case "expense":
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => Adminexpense(),
                                    ),
                                  );
                                  break;
                                case "transcation":
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => Admintransaction(),
                                    ),
                                  );
                                  break;
                                case "debtors":
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => Adminoutstanding(),
                                    ),
                                  );
                                  break;
                                case "employee":
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => Adminemployeereport(),
                                    ),
                                  );
                                  break;
                                case "driver":
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => Admindriverreport(),
                                    ),
                                  );
                                  break;
                                case "itemwise":
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => Adminitemwise(),
                                    ),
                                  );
                                  break;
                              }
                            },
                            child: Container(
                              // width: 148.w,
                              // height: 80.h,
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 59.w,
                                    height: 59.h,
                                    decoration: ShapeDecoration(
                                      color: const Color.fromARGB(
                                        255,
                                        241,
                                        221,
                                        249,
                                      ),
                                      shape: OvalBorder(),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        item['icon']!,
                                        width: 18.w,
                                        height: 18.h,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  Text(
                                    item['title']!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: const Color(0xFF150B3D),
                                      fontSize: 14,
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
