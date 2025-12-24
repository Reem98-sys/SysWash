import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syswash/bloc/bloc/customerlist_bloc.dart';
import 'package:syswash/bloc/bloc/pickuplist_bloc.dart';
import 'package:syswash/bloc/bloc/uploadpickup_bloc.dart';
import 'package:syswash/screens/add_customer_dialog.dart';
import 'package:syswash/screens/bottomnav.dart';
import 'package:syswash/screens/pickupDetails.dart';

class Pickup extends StatefulWidget {
  const Pickup({super.key});

  @override
  State<Pickup> createState() => _PickupState();
}

class _PickupState extends State<Pickup> {
  final TextEditingController searchData = TextEditingController();

  String? userName;
  String? token;
  String? companyCode;
  String? userId;

  List<dynamic> filteredList = [];
  List<dynamic> fullList = [];

  // ------------------- Fetch User Data & Pickup List -------------------
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

    if (userId != null && companyCode != null && token != null) {
      context.read<PickuplistBloc>().add(
        FetchPickUpEvent(
          token: token ?? '',
          companyCode: companyCode ?? '',
          userId: userId ?? '',
        ),
      );
    }
  }

  // ------------------- Search Filter -------------------
  void _filterSearchResults(String query) {
    if (fullList.isEmpty) {
      return;
    }

    // Prevent search before data is ready
    if (query.isEmpty) {
      setState(() => filteredList = List.from(fullList));
      return;
    }

    setState(() {
      filteredList =
          fullList.where((item) {
            final name = item.pickupCustomerName?.toLowerCase() ?? '';
            final phone = item.pickupCustomerPhno?.toString() ?? '';
            final area = item.pickupCustomerArea?.toLowerCase() ?? '';
            return name.contains(query.toLowerCase()) ||
                phone.contains(query) ||
                area.contains(query.toLowerCase());
          }).toList();
    });
  }

  // ------------------- Open Add Customer Dialog -------------------
  Future<void> _openAddCustomerDialog(BuildContext context) async {
    final result = await showAddCustomerDialog(
      context,
      companyCode ?? '',
      token ?? '',
      userName ?? '',
      userId ?? '',
    );

    // if (result == true) {
    //   // Show success snackbar first
    //   final snackBar = SnackBar(
    //     content: const Text('Customer added successfully!'),
    //     backgroundColor: Colors.green,
    //     duration: const Duration(seconds: 2),
    //   );

    //   // Wait until snackbar is done showing
    //   await ScaffoldMessenger.of(context).showSnackBar(snackBar).closed;

    // // Then refresh the pickup list
    // context.read<PickuplistBloc>().add(
    //       FetchPickUpEvent(
    //         token: token ?? '',
    //         companyCode: companyCode ?? '',
    //         userId: userId ?? '',
    //       ),
    //     );
    // }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    // Delay adding listener until after widget builds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchData.addListener(() => _filterSearchResults(searchData.text));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            userName ?? '',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
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

      // ------------------- Body -------------------
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pickup Customers',
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
                                            const Bottomnav(currentIndex: 0),
                                  ),
                                );
                  },
                  child: SvgPicture.asset('assets/Back.svg'),
                ),
              ],
            ),
            SizedBox(height: 18.h),

            // ------------------- Search Box -------------------
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
                  border: InputBorder.none,
                  hintText: fullList.isEmpty ? '' : 'Search',
                  icon: const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.h),

            // ------------------- Pickup List -------------------
            Expanded(
              child: BlocBuilder<PickuplistBloc, PickuplistState>(
                builder: (context, state) {
                  if (state is PickUpBlocLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is PickUpBlocError) {
                    return Center(
                      child: Text(
                        'Failed to load orders\n${state.message}',
                        style: TextStyle(color: Colors.red, fontSize: 14.sp),
                      ),
                    );
                  }

                  if (state is PickUpBlocLoaded) {
                    fullList =
                        (state.pickUpListModel?.data ?? [])
                            .where(
                              (order) =>
                                  order.pickupstatus?.toLowerCase() !=
                                  'received',
                            )
                            .toList();

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
                        final order = filteredList[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: GestureDetector(
                            onTap: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => Pickupdetails(
                                        customerId:
                                            order.pickupCustomerId.toString(),
                                        pickupOrderId:
                                            order.pickupOrderId.toString(),
                                        pickupAssignId:
                                            order.pickupassgnId ?? 0,
                                        notes: order.notes ?? '',
                                        remarks: order.remarks ?? '',
                                      ),
                                ),
                              );
                              if (result == true) {
                                context.read<PickuplistBloc>().add(
                                  FetchPickUpEvent(
                                    token: token ?? '',
                                    companyCode: companyCode ?? '',
                                    userId: userId ?? '',
                                  ),
                                );
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
                                      order.pickupCustomerName.toString(),
                                      style: TextStyle(
                                        color: const Color(0xFF150B3D),
                                        fontSize: 16.sp,
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      order.pickupCustomerPhno.toString(),
                                      style: TextStyle(
                                        color: const Color(0xFF514A6B),
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
                                          order.pickupCustomerArea ?? '',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 11.sp,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        Icon(
                                          Icons.access_time,
                                          size: 18.sp,
                                          color: Colors.grey,
                                        ),
                                        Text(
                                          order.pickupDate.toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 11.sp,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
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
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),

      // ------------------- Floating Action Button -------------------
      floatingActionButton: BlocListener<UploadpickupBloc, UploadpickupState>(
        listener: (context, state) async {
          if (state is UploadpickupLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Uploading pickup...")),
            );
          } else if (state is UploadpickupLoaded) {
            final snackBar = SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 3),
            );

            await ScaffoldMessenger.of(context).showSnackBar(snackBar).closed;

            // Reload data after upload success
            context.read<PickuplistBloc>().add(
              FetchPickUpEvent(
                token: token ?? '',
                companyCode: companyCode ?? '',
                userId: userId ?? '',
              ),
            );
          } else if (state is UploadpickupError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: FloatingActionButton(
          backgroundColor: const Color(0xFF68188B),
          onPressed: () {
            context.read<CustomerlistBloc>().add(
              FetchCustomerListEvent(
                token: token ?? '',
                companyCode: companyCode ?? '',
              ),
            );
            _openAddCustomerDialog(context);
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
