import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syswash/bloc/bloc/adminhome_bloc.dart';
import 'package:syswash/bloc/bloc/pickuplist_bloc.dart';
import 'package:syswash/helper/date_helper.dart';
import 'package:syswash/screens/bottomnav.dart';
import 'package:syswash/screens/deliveryDetail.dart';

class Delivery extends StatefulWidget {
  const Delivery({super.key});

  @override
  State<Delivery> createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
  TextEditingController searchData = TextEditingController();
  String? userName;
  String? token;
  String? companyCode;
  String? userId;
  final storage = FlutterSecureStorage();
  List<dynamic> filteredList = [];
  List<dynamic> fullList = [];
  Future<void> getUserData() async {
    
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
    if (token != null && userId != null && companyCode != null) {
      context.read<PickuplistBloc>().add(
            FetchDeliveryEvent(
              token: token!,
              companyCode: companyCode!,
              userId: userId!,
            ),
          );
          context.read<AdminhomeBloc>().add(
        FetchcompanyEvent(token: token!, companyCode: companyCode!)
      );
    }
  }

  Future<void> _onRefresh() async {
  final userId = await storage.read(key: 'login_id');
  final companyCode = await storage.read(key: 'company_Code');
  final token = await storage.read(key: 'access_Token');

  if (userId != null && companyCode != null && token != null) {
    context.read<PickuplistBloc>().add(
            FetchDeliveryEvent(
              token: token!,
              companyCode: companyCode!,
              userId: userId!,
            ),
          );
          context.read<AdminhomeBloc>().add(
        FetchcompanyEvent(token: token, companyCode: companyCode)
      );
  }
}

  @override
  void initState() {
    super.initState();
    // Call it when screen loads
    getUserData();
    // Delay adding listener until after widget builds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchData.addListener(() => _filterSearchResults(searchData.text));
    });
  }

  // ------------------- Search Filter -------------------
  void _filterSearchResults(String query) {
    if (fullList.isEmpty) {
      return;
    }
    if (query.isEmpty) {
      setState(() {
        filteredList = List.from(fullList);
      });
      return;
    }

    setState(() {
      filteredList =
          fullList.where((item) {
            final name = item.deliveryCustomerName?.toLowerCase() ?? '';
            final phone = item.deliveryCustomerPhno?.toString() ?? '';
            final area = item.deliveryCustomerArea?.toLowerCase() ?? '';
            return name.contains(query.toLowerCase()) ||
                phone.contains(query) ||
                area.contains(query.toLowerCase());
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<AdminhomeBloc, AdminhomeState>(
        builder: (context, state) {
          if (state is AdmincompanyLoaded &&
              state.companyDetails.imageLightMode != null &&
              state.companyDetails.imageLightMode!.isNotEmpty) {
            return Image.network(
              state.companyDetails.imageLightMode!,
              width: 150.w,
              height: 42.h,
              fit: BoxFit.contain,
            );
          }
          return SizedBox();
        },
                  ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E5F4),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.notifications_none_rounded),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Delivery Customers',
                    style: TextStyle(
                      color: const Color(0xFF63629C),
                      fontSize: 16.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              const Bottomnav(currentIndex: 1),
                                    ),
                                  );
                    },
                    child: SvgPicture.asset('assets/Back.svg'),
                  ),
                ],
              ),
              SizedBox(height: 18.h),
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
                    hintText: fullList.isEmpty ? '' : 'Search',
        
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Expanded(
                child: BlocBuilder<PickuplistBloc, PickuplistState>(
                  builder: (context, state) {
                    if (state is PickUpBlocLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is PickUpBlocError) {
                      return Center(
                        child: Text(
                          'Failed to load orders',
                          style: TextStyle(color: Colors.red, fontSize: 14.sp),
                        ),
                      );
                    }
                    if (state is PickUpBlocLoaded) {
                      fullList =
                          (state.deliveryListModel?.data ?? [])
                              .where(
                                (order) =>
                                    order.status?.toString().toLowerCase() !=
                                    "delivered",
                              )
                              .toList().reversed.toList();
        
                      // If filteredList is empty (first load or cleared search)
                      if (searchData.text.isEmpty) {
                        filteredList = List.from(fullList);
                      } else {
                        // Run filtering after build completes (no setState error)
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _filterSearchResults(searchData.text);
                        });
                      }
        
                      if (filteredList.isEmpty) {
                        return const Center(child: Text('No results found.'));
                      }
        
                      return ListView.builder(
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: GestureDetector(
                              onTap: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => Deliverydetail(
                                          customerId:
                                              filteredList[index]
                                                  .deliveryCustomerId,
                                          deliveryOrderId:
                                              filteredList[index]
                                                  .deliveryInvoiceNo
                                                  .toString(),
                                          deliveryAssgnId: filteredList[index].deliveryassgnId,
                                          notes:
                                              // filteredList[index].notes ??
                                              '',
                                          remarks:
                                              // filteredList[index].remarks ??
                                              '',
                                        ),
                                  ),
                                );
                                //  If the result is true, reload data
                                if (result == true) {
                                  // clear old cached lists first
                                  setState(() {
                                    fullList.clear();
                                    filteredList.clear();
                                  });
                                  await Future.delayed(const Duration(seconds: 1), () {
                                    context.read<PickuplistBloc>().add(
                                      FetchDeliveryEvent(
                                        userId: userId ?? '',
                                        companyCode: companyCode ?? '',
                                        token: token ?? '',
                                      ),
                                    );
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Updated Successfully'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                }
                              },
                              child: Container(
                                width: 364.w,
                                // height: 105.h,
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
                                        filteredList[index].deliveryCustomerName
                                            .toString(),
                                        style: TextStyle(
                                          color: const Color(0xFF150B3D),
                                          fontSize: 16.sp,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        filteredList[index].deliveryCustomerPhno
                                            .toString(),
                                        style: TextStyle(
                                          color: const Color(0xFF514A6B),
                                          fontSize: 14.sp,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        'Pending',
                                        style: TextStyle(
                                          color: const Color(0xFFF38305),
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
                                            filteredList[index]
                                                .deliveryCustomerArea
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
                                            '${formatDate(filteredList[index].deliveryDate.toString())} ${filteredList[index].deliveryTime}',
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
        ),
      ),
    );
  }
}
