import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';

import 'package:syswash/bloc/bloc/home_bloc.dart';
import 'package:syswash/bloc/bloc/pickuplist_bloc.dart';
import 'package:syswash/helper/date_helper.dart';
import 'package:syswash/model/deliveryListModel.dart';
import 'package:syswash/model/pickupListModel.dart';
import 'package:syswash/model/totalOrder.dart';
import 'package:syswash/screens/bottomnav.dart';
import 'package:syswash/screens/pickup.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedFilter = 'All';

  late TotalOrderModel totalOrderModel;
  final storage = const FlutterSecureStorage();
  String? username;
  @override
  void initState() {
    super.initState();
    _loadUserAndFetchData(); // run async function
  }

  Future<void> _loadUserAndFetchData() async {
    final userId = await storage.read(key: 'login_id');
    final companyCode = await storage.read(key: 'company_Code');
    final token = await storage.read(key: 'access_Token');
    final storedUsername = await storage.read(key: 'user_name');
    if (mounted) {
      setState(() {
        username = storedUsername ?? 'User';
      });
    }
    print('userId : ${userId}');
    print('companyCode : ${companyCode}');
    print('token : ${token}');
    if (userId != null && companyCode != null && token != null) {
      context.read<HomeBloc>().add(
        FetchHomeEvent(userId: userId, companyCode: companyCode, token: token),
      );
      context.read<PickuplistBloc>().add(
        FetchAllOrdersEvent(
          userId: userId,
          companyCode: companyCode,
          token: token,
        ),
      );
    } else {
      debugPrint('Missing userId or companyCode in storage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Hello, $username',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
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

      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // a Header Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                      items: [
                        Image.asset('assets/sys.png'),
                        Image.asset('assets/sys.png'),
                        Image.asset('assets/sys.png'),
                      ],
                      options: CarouselOptions(
                        height: 180.h,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 1,
                      ),
                    ),

                    SizedBox(height: 22.h),

                    //  Order Summary Row
                    Row(
                      children: [
                        BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            if (state is HomeBlocLoading) {
                              return Container(
                                width: 167.w,
                                height: 114.h,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF68188B),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            }
                            if (state is HomeBlocError) {
                              return Container(
                                width: 167.w,
                                height: 114.h,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF68188B),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                  child: Text(
                                    '--',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            }
                            if (state is HomeBlocLoaded) {
                              totalOrderModel =
                                  BlocProvider.of<HomeBloc>(
                                    context,
                                  ).totalOrderModel;
                              return Container(
                                width: 167.w,
                                height: 114.h,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF68188B),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      (totalOrderModel.delivery!.length +
                                              totalOrderModel.pickup!.length)
                                          .toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 26.sp,
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      'Completed Order',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.9),
                                        fontSize: 14.sp,
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Container(
                                width: 167.w,
                                height: 114.h,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF68188B),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                  child: Text(
                                    '--',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),

                        SizedBox(width: 35.w),
                        Column(
                          children: [
                            GestureDetector(
                              onTap:
                                  () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              const Bottomnav(currentIndex: 1),
                                    ),
                                  ),
                              child: _orderButton(
                                'PICKUP ORDER',
                                const Color(0xFF5F02E7),
                              ),
                            ),
                            SizedBox(height: 14.h),
                            GestureDetector(
                              onTap: () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              const Bottomnav(currentIndex: 2),
                                    ),
                                  ),
                              child: _orderButton(
                                'DELIVERY ORDER',
                                const Color(0xFFF38305),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 25.h),

                    //  Latest Orders Header + Filter Chips
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Latest Orders',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          children:
                              ['All', 'Pickup', 'Delivery'].map((filter) {
                                bool isSelected = selectedFilter == filter;
                                return Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: ChoiceChip(
                                    label: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.w,
                                      ),
                                      child: Text(
                                        filter,
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color:
                                              isSelected
                                                  ? Colors.white
                                                  : Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    selected: isSelected,
                                    selectedColor: const Color(0xFF5D5FEF),
                                    backgroundColor: const Color(0xFFECECEC),
                                    showCheckmark: false,
                                    visualDensity: const VisualDensity(
                                      horizontal: -4,
                                      vertical: -4,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      side: BorderSide.none,
                                    ),
                                    onSelected: (_) {
                                      setState(() => selectedFilter = filter);
                                    },
                                  ),
                                );
                              }).toList(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 30),
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
                      final pickupOrdersList =
                          state.pickUpListModel?.data ?? [];
                      // Filter orders whose pickupstatus is NOT "Received"
                      final pickupOrders =
                          pickupOrdersList
                              .where(
                                (order) =>
                                    order.pickupstatus
                                        ?.toString()
                                        .toLowerCase() !=
                                    'received',
                              )
                              .toList();
                      final deliveryOrdersList = 
                                state.deliveryListModel?.data ?? [];  
                      final deliveryOrders =
                                deliveryOrdersList.where((order) =>
                                order.status?.toString().toLowerCase() !=
                                "delivered").toList();
                      final allOrders = [...pickupOrders, ...deliveryOrders];

                      final filteredOrders =
                          selectedFilter == 'All'
                              ? allOrders
                              : selectedFilter == 'Pickup'
                              ? pickupOrders
                              : deliveryOrders;

                      if (filteredOrders.isEmpty) {
                        return Center(
                          child: Text('No $selectedFilter orders found.'),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredOrders.length,
                        itemBuilder: (context, index) {
                          final order = filteredOrders[index];
                          final isPickup = order is PickUpListModel;

                          final name =
                              isPickup
                                  ? order.pickupCustomerName
                                  : (order as DeliveryListModel)
                                      .deliveryCustomerName;
                          final location =
                              isPickup
                                  ? order.pickupCustomerArea
                                  : (order as DeliveryListModel)
                                      .deliveryCustomerArea;
                          final rawDate =
                              isPickup
                                  ? order.pickupDate
                                  : (order as DeliveryListModel).deliveryDate;

                          final date = formatOrderDate(rawDate);

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Material(
                              color: const Color(0xFFF8F8F8),
                              borderRadius: BorderRadius.circular(8.r),
                              child: Container(
                                height: 60.h,
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 38.w,
                                      height: 38.h,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF5D5FEF),
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          isPickup
                                              ? 'assets/pickUp.svg'
                                              : 'assets/delivery.svg',
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 5.0,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              name ?? 'No Name',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17.sp,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                            Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    isPickup
                                                        ? const Color(
                                                          0xFFF38305,
                                                        )
                                                        : const Color(
                                                          0xFF27AE60,
                                                        ),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 8.w,
                                                vertical: 2.h,
                                              ),
                                              child: Text(
                                                isPickup
                                                    ? 'Pickup'
                                                    : 'Delivery',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10.sp,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                        right: 8,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            location ?? 'Unknown',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(height: 4.h),
                                          Text(
                                            date,
                                            style: TextStyle(
                                              color: const Color(0xFFFF0000),
                                              fontSize: 12.sp,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //  Small reusable button widget
  Widget _orderButton(String text, Color color) {
    return Container(
      width: 173.w,
      height: 49.h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          SizedBox(width: 15.w),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.all(5.0),
            child: Icon(Icons.arrow_forward_rounded, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
