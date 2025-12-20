import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:syswash/bloc/bloc/pickupcustdetails_bloc.dart';
import 'package:syswash/bloc/bloc/settings_bloc.dart';
import 'package:syswash/screens/delivery_dialog.dart';
import 'package:syswash/screens/mapping.dart';

class Deliverydetail extends StatefulWidget {
  final String customerId;
  final dynamic deliveryOrderId;
  final String notes;
  final String remarks;
  const Deliverydetail({
    super.key,
    required this.customerId,
    required this.deliveryOrderId,
    required this.notes,
    required this.remarks,
  });

  @override
  State<Deliverydetail> createState() => _DeliverydetailState();
}

class _DeliverydetailState extends State<Deliverydetail> {
  bool showDetails = false;
  String? companyCode;
  String? token;
  int? totalItem = 0;
  int? totalquantity = 0;

  final storage = const FlutterSecureStorage();

  String buildFullAddress({
    String? area,
    String? hotel,
    String? street,
    String? houseNumber,
  }) {
    // Collect only non-empty values
    final parts = [
      if (houseNumber != null && houseNumber.trim().isNotEmpty) houseNumber,
      if (street != null && street.trim().isNotEmpty) street,
      if (hotel != null && hotel.trim().isNotEmpty) hotel,
      if (area != null && area.trim().isNotEmpty) area,
    ];

    // Join with comma
    return parts.join(', ');
  }

  @override
  void initState() {
    super.initState();
    _loadUserAndFetchData(); // run async function
  }

  Future<void> _loadUserAndFetchData() async {
    final companyCode = await storage.read(key: 'company_Code');
    final token = await storage.read(key: 'access_Token');
    if (companyCode != null && token != null) {
      context.read<PickupcustdetailsBloc>().add(
        FetchFullPickupDetailsEvent(
          customerId: widget.customerId,
          pickupOrderId: widget.deliveryOrderId,
          token: token,
          companyCode: companyCode,
        ),
      );
    } else {
      debugPrint('Missing token or companyCode in storage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_rounded),
        ),
        title: Text(
          'Delivery Order',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22.sp,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: BlocConsumer<PickupcustdetailsBloc, PickupcustdetailsState>(
            listener: (context, state) async {
              if (state is PickupCustDetailsError) {
                Navigator.pop(context);
                print('❌ Bloc Error: ${state.message}');
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Failed to load data')));
              }
            },
            builder: (context, state) {
              if (state is PickupCustDetailsLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is PickupCustDetailsLoaded) {
                final customerDetailsModel = state.customerDetailsModel;
                final deliveryItems = state.pickupOrderItemsModel;
                final settingsData = state.settingsModel;
                return Column(
                  children: [
                    Container(
                      width: 384.w,

                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${customerDetailsModel.name} [${customerDetailsModel.cusCode}]',
                                  style: TextStyle(
                                    color: const Color(0xFF0A0A0A),
                                    fontSize: 16.sp,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Discount: ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.sp,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        height: 1.17,
                                        letterSpacing: 0.20,
                                      ),
                                    ),
                                    Text(
                                      customerDetailsModel.discount.toString(),
                                      style: TextStyle(
                                        color: const Color(0xFF68188B),
                                        fontSize: 12.sp,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        height: 1.17,
                                        letterSpacing: 0.20,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h),
                                Row(
                                  children: [
                                    Icon(Icons.phone_in_talk, size: 18.sp),
                                    Text(
                                      customerDetailsModel.mobile.toString(),
                                      style: TextStyle(
                                        color: const Color(0xFF0A0A0A),
                                        fontSize: 14.sp,
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Icon(Icons.location_on_sharp, size: 18.sp),
                                    Text(
                                      customerDetailsModel.area.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.sp,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        height: 1.17,
                                        letterSpacing: 0.20,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    final fullAddress = buildFullAddress(
                                      area:
                                          customerDetailsModel.area ??
                                          customerDetailsModel.area,
                                      hotel:
                                          customerDetailsModel.hotel ??
                                          customerDetailsModel.hotel,
                                      street:
                                          customerDetailsModel.streetNo ??
                                          customerDetailsModel.streetNo,
                                      houseNumber:
                                          customerDetailsModel.roomNo ??
                                          customerDetailsModel.roomNo,
                                    );
                                    if (fullAddress.isNotEmpty) {
                                      openRoute(fullAddress);
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Address not available',
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    width: 100.w,
                                    height: 30.h,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFF68188B),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      shadows: [
                                        BoxShadow(
                                          color: Color(0x3F000000),
                                          blurRadius: 4,
                                          offset: Offset(0, 4),
                                          spreadRadius: 0,
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Route',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showDetails = !showDetails;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        showDetails
                                            ? 'Close Details'
                                            : 'View Details',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: const Color(0xFF68188B),
                                          fontSize: 12.sp,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          height: 1.17,
                                          letterSpacing: 0.20,
                                        ),
                                      ),
                                      Icon(
                                        showDetails
                                            ? Icons.keyboard_arrow_up_sharp
                                            : Icons.keyboard_arrow_down_sharp,
                                        color: const Color(0xFF68188B),
                                        size: 22.sp,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    // Expandable details container
                    AnimatedCrossFade(
                      firstChild: const SizedBox.shrink(),
                      secondChild: Container(
                        width: 384.w,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Area',
                                    style: TextStyle(
                                      color: const Color(0xFFA9A5B8),
                                      fontSize: 14.sp,
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w500,
                                      height: 1.17,
                                    ),
                                  ),
                                  Text(
                                    customerDetailsModel.area.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w500,
                                      height: 1.17,
                                    ),
                                  ),
                                  SizedBox(height: 17.h),
                                  Text(
                                    'Villa No',
                                    style: TextStyle(
                                      color: const Color(0xFFA9A5B8),
                                      fontSize: 14.sp,
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w500,
                                      height: 1.17,
                                    ),
                                  ),
                                  Text(
                                    customerDetailsModel.villaNumber.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w500,
                                      height: 1.17,
                                    ),
                                  ),
                                  SizedBox(height: 17.h),
                                  Text(
                                    'Fragrance',
                                    style: TextStyle(
                                      color: const Color(0xFFA9A5B8),
                                      fontSize: 14.sp,
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w500,
                                      height: 1.17,
                                    ),
                                  ),
                                  Text(
                                    customerDetailsModel.fragrance.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w500,
                                      height: 1.17,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Zone',
                                    style: TextStyle(
                                      color: const Color(0xFFA9A5B8),
                                      fontSize: 14.sp,
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w500,
                                      height: 1.17,
                                    ),
                                  ),
                                  Text(
                                    customerDetailsModel.zone.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w500,
                                      height: 1.17,
                                    ),
                                  ),
                                  SizedBox(height: 17.h),
                                  Text(
                                    'Hotel',
                                    style: TextStyle(
                                      color: const Color(0xFFA9A5B8),
                                      fontSize: 14.sp,
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w500,
                                      height: 1.17,
                                    ),
                                  ),
                                  Text(
                                    customerDetailsModel.hotel.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w500,
                                      height: 1.17,
                                    ),
                                  ),
                                  SizedBox(height: 17.h),
                                  Text(
                                    'Remark',
                                    style: TextStyle(
                                      color: const Color(0xFFA9A5B8),
                                      fontSize: 14.sp,
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w500,
                                      height: 1.17,
                                    ),
                                  ),
                                  Text(
                                    widget.remarks,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w500,
                                      height: 1.17,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Street No',
                                    style: TextStyle(
                                      color: const Color(0xFFA9A5B8),
                                      fontSize: 14.sp,
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w500,
                                      height: 1.17,
                                    ),
                                  ),
                                  Text(
                                    customerDetailsModel.streetNo.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w500,
                                      height: 1.17,
                                    ),
                                  ),
                                  SizedBox(height: 17.h),
                                  Text(
                                    'Reference No',
                                    style: TextStyle(
                                      color: const Color(0xFFA9A5B8),
                                      fontSize: 14.sp,
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w500,
                                      height: 1.17,
                                    ),
                                  ),
                                  Text(
                                    customerDetailsModel.refNo.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w500,
                                      height: 1.17,
                                    ),
                                  ),
                                  SizedBox(height: 17.h),
                                  Text(
                                    'Note',
                                    style: TextStyle(
                                      color: const Color(0xFFA9A5B8),
                                      fontSize: 14.sp,
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w500,
                                      height: 1.17,
                                    ),
                                  ),
                                  Text(
                                    widget.notes,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w500,
                                      height: 1.17,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      crossFadeState:
                          showDetails
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 300),
                    ),

                    SizedBox(height: 21.h),
                    Row(
                      children: [
                        Text(
                          'Delivery Items',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w700,
                            height: 0.87,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 17.h),
                    if (deliveryItems.clothData!.isNotEmpty)
                      Expanded(
                        child: ListView.builder(
                          itemCount: deliveryItems.clothData!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Container(
                                width: 364.w,
                                height: 64.h,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    // borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    children: [
                                      Image.network(
                                        deliveryItems.clothData![index].clothImg
                                            .toString(),
                                        width: 46.w,
                                        height: 44.h,
                                      ),
                                      SizedBox(width: 10.w),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 2.h),
                                          Text(
                                            deliveryItems
                                                .clothData![index]
                                                .clothName
                                                .toString(),
                                            style: TextStyle(
                                              color: const Color(0xFF150B3D),
                                              fontSize: 16.sp,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            '${deliveryItems.clothData![index].qnty} QTY',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.sp,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(height: 2.h),
                                          Text(
                                            deliveryItems
                                                .clothData![index]
                                                .service
                                                .toString(),
                                            style: TextStyle(
                                              color: const Color(0xFF150B3D),
                                              fontSize: 16.sp,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            deliveryItems
                                                .clothData![index]
                                                .billing
                                                .toString(),
                                            style: TextStyle(
                                              color: const Color(0xFF68188B),
                                              fontSize: 14.sp,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    Container(
                      width: 380.w,
                      height: 72.h,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          // borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Total Quantity :',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17.sp,
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w700,
                                        height: 1,
                                      ),
                                    ),
                                    Text(
                                      deliveryItems.quantity.toString(),
                                      style: TextStyle(
                                        color: const Color(0xFF68188B),
                                        fontSize: 15.sp,
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w700,
                                        height: 1,
                                        letterSpacing: 1.20,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                Row(
                                  children: [
                                    Text(
                                      'Total Amount : ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17.sp,
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w700,
                                        height: 1,
                                      ),
                                    ),
                                    Text(
                                      deliveryItems.totalAmount.toString(),
                                      style: TextStyle(
                                        color: const Color(0xFF68188B),
                                        fontSize: 15.sp,
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w700,
                                        height: 1,
                                        letterSpacing: 1.20,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () async {
                                final payModes = {
                                  "PaymodeCash": settingsData.paymodeCash,
                                  "PaymodeBank": settingsData.paymodeBank,
                                  "PaymodeCard": settingsData.paymodeCard,
                                  "PaymodeWallet": settingsData.paymodeWallet
                                };
                                final result = await DeliveryDialog.show(
                                  context,
                                  payModes: payModes,
                                  deliveryassgnId:
                                      deliveryItems
                                          .deliveryassgn![0]
                                          .deliveryassgnId,
                                );

                                //  If dialog returns success, pop back to list and trigger reload
                                if (result == true) {
                                  Navigator.pop(context, true);
                                }
                              },
                              child: Container(
                                width: 125.w,
                                height: 40.h,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFF68188B),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Delivery now',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.sp,
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
