import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:syswash/bloc/bloc/home_bloc.dart';
import 'package:syswash/helper/date_helper.dart';
import 'package:syswash/model/totalOrder.dart';
import 'package:syswash/screens/deliveryDetail.dart';
import 'package:syswash/screens/historyPickupDetail.dart';
import 'package:syswash/screens/historyViewDetails.dart';
import 'package:syswash/screens/pickupDetails.dart';

class Historydetail extends StatefulWidget {
  final String historyType; 
  const Historydetail({super.key,required this.historyType});

  @override
  State<Historydetail> createState() => _HistorydetailState();
}

class _HistorydetailState extends State<Historydetail> {
  TextEditingController searchData = TextEditingController();
  late TotalOrderModel totalOrderModel;
  String? userName;
  String? token;
  String? companyCode;
  String? userId;
  List<dynamic> filteredList = [];
  List<dynamic> fullList = [];
  Future<void> getUserData() async {
    const storage = FlutterSecureStorage();
    final name = await storage.read(key: 'user_name');
    final tokenAccess = await storage.read(key: 'access_Token');
    final companycode = await storage.read(key: 'company_Code');
    final userid = await storage.read(key: 'login_id');
    setState(() {
      userName = name;
      token = tokenAccess;
      companyCode = companycode;
      userId = userid;
    });
  }
  @override
  void initState() {
    super.initState();
    // Call it when screen loads
    getUserData();
    // Listen to search input changes
    searchData.addListener(() {
      _filterSearchResults(searchData.text);
    });
  }

  void _filterSearchResults(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredList = fullList;
      });
      return;
    }

    setState(() {
      filteredList =
          fullList.where((item) {
            final name = widget.historyType == 'pickup'
            ? (item['pickupCustomerName']?.toString().toLowerCase() ?? '')
            : (item['customerName']?.toString().toLowerCase() ?? '');
        
        final area = widget.historyType == 'pickup'
            ? (item['pickupCustomerArea']?.toString().toLowerCase() ?? '')
            : (item['customerAddress']?.toString().toLowerCase() ?? '');
        return name.contains(query.toLowerCase()) ||
            area.contains(query.toLowerCase());
          }).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              width: 400.w,
              height: 51.h,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: TextField(
                controller: searchData,
                decoration: InputDecoration(
                  // contentPadding: EdgeInsets.all(5),
                  border: InputBorder.none,
                  hintText: 'Search',

                  icon: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.h),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeBlocLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is HomeBlocError) {
                    return Center(
                      child: Text(
                        'Failed to load orders\n',
                        style: TextStyle(color: Colors.red, fontSize: 14.sp),
                      ),
                    );
                  }
                  if (state is HomeBlocLoaded) {
                    totalOrderModel = BlocProvider.of<HomeBloc>(
                                    context,
                                  ).totalOrderModel;
                    if (widget.historyType == 'pickup') {
                      fullList = totalOrderModel.pickup!.reversed.toList();
                    } else {
                      fullList = totalOrderModel.delivery!.reversed.toList();
                    }              
                    

                    // If filteredList is empty (first load or cleared search)
                    if (filteredList.isEmpty && searchData.text.isEmpty) {
                      filteredList = fullList;
                    }

                    if (filteredList.isEmpty) {
                      return const Center(child: Text('No results found.'));
                    }

                    return ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        String status;
                        var statusColor;
                        if (widget.historyType == 'pickup') {
                          status = filteredList[index]['pickupstatus'].toString();
                          if (status == 'Collected') {
                            statusColor = Color(0xFFF38305);
                          }
                          else {
                            statusColor = Colors.green;
                          }
                        }
                        else {
                          status = filteredList[index]['deliveryassgn'][0]['paymentstatus'].toString();
                          if (status == 'Unpaid') {
                            statusColor = Colors.red;
                          }
                          else if (status == 'Paid') {
                            statusColor = Colors.green;
                          }
                          else {
                            statusColor = Color(0xFFF38305);
                          }
                        }
                                          
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20,0,20,8),
                          child:  GestureDetector(
                            onTap: () {
                              if (widget.historyType == 'pickup') {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Historypickupdetail(customerId: filteredList[index]['pickupCustomerId'], pickupOrderId: filteredList[index]['pickupOrderId'] != null ? filteredList[index]['pickupOrderId'] : filteredList[index]['pickupassgn'][0]['pickuporderId'].toString() , pickupAssignId: filteredList[index]['pickupassgnId'], notes: filteredList[index]['notes'] ?? '', remarks: filteredList[index]['remarks'] ?? '', status: status, statusColor: statusColor)));
                              }
                              else {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Historyviewdetails(customerId: filteredList[index]['customerId'], deliveryOrderId: filteredList[index]['orderId'], deliveryAssgnId: filteredList[index]['deliveryassgn'][0]['deliveryassgnId'], notes: '', remarks: filteredList[index]['remarks'],status: status,statusColor : statusColor,)));
                              }
                              
                            },
                            child: Container(
                              width: 364.w,
                              height: 90.h,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.historyType == 'pickup'?filteredList[index]['pickupCustomerName']
                                          .toString():filteredList[index]['customerName']
                                          .toString(),
                                      style: TextStyle(
                                        color: const Color(0xFF150B3D),
                                        fontSize: 16.sp,
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      status,
                                      style: TextStyle(
                                        color: statusColor,
                                        fontSize: 14.sp,
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 3.h),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          size: 18.sp,
                                          color: Colors.grey,
                                        ),
                                        Text(
                                          widget.historyType == 'pickup'?filteredList[index]
                                              ['pickupCustomerArea']
                                              .toString():filteredList[index]['customerAddress']
                                          .toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 11.sp,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            height: 1.17,
                                            letterSpacing: 0.20,
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        Icon(
                                          Icons.access_time,
                                          size: 18.sp,
                                          color: Colors.grey,
                                        ),
                                        Text(
                                          widget.historyType == 'pickup'? '${formatDate(filteredList[index]['pickupDate'])} ''${filteredList[index]['pickuptime'] ?? ''}'
                                              : '${formatDate(filteredList[index]['deliveryDate'])} ${filteredList[index]['deliveryTime']}'
                                          .toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 11.sp,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                            height: 1.56,
                                            letterSpacing: 0.70,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
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
    );
  }
}