import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syswash/bloc/bloc/pickupcustdetails_bloc.dart';
import 'package:syswash/model/pickupCustomerDetailsModel.dart';
import 'package:syswash/screens/bottomnav.dart';

class Pickupdetails extends StatefulWidget {
  final String pickUpId;
  const Pickupdetails({super.key, required this.pickUpId});

  @override
  State<Pickupdetails> createState() => _PickupdetailsState();
}

class _PickupdetailsState extends State<Pickupdetails> {
  bool showDetails = false;
  late PickUpCustomerDetailsModel pickUpCustomerDetailsModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_rounded),
        ),
        title: Text(
          'Pickup Order',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22.sp,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      // bottomNavigationBar: Bottomnav(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              BlocBuilder<PickupcustdetailsBloc,PickupcustdetailsState>(
                builder:(context, state) {
                  if (state is PickupCustDetailsLoading) {
                    showDialog(
                      context: context, 
                      builder: (BuildContext context) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },);
                  }
                  if (state is PickupCustDetailsError) {
                    Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to load data'),
                        backgroundColor: Colors.red,)
                    );
                  }
                  if (state is PickupCustDetailsLoaded) {
                    pickUpCustomerDetailsModel = BlocProvider.of<PickupcustdetailsBloc>(context).pickUpCustomerDetailsModel;
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nishitha Sherin  [JL0019]',
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
                            '0.5 %',
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
                            '46456455',
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
                            'Wakra Meshaf',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 1.17,
                              letterSpacing: 0.20,
                            ),
                          ),
                          Spacer(),
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
                                      ? 'View Details'
                                      : 'Close Details',
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
                                      ? Icons.keyboard_arrow_down_sharp
                                      : Icons.keyboard_arrow_up_sharp,
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
                              'WAKRA',
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
                              'House no',
                              style: TextStyle(
                                color: const Color(0xFFA9A5B8),
                                fontSize: 14.sp,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w500,
                                height: 1.17,
                              ),
                            ),
                            Text(
                              'V 44',
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
                              '--',
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
                              '--',
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
                              'Reference no',
                              style: TextStyle(
                                color: const Color(0xFFA9A5B8),
                                fontSize: 14.sp,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w500,
                                height: 1.17,
                              ),
                            ),
                            Text(
                              '6786543456',
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
                              '--',
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
                              'Street Name',
                              style: TextStyle(
                                color: const Color(0xFFA9A5B8),
                                fontSize: 14.sp,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w500,
                                height: 1.17,
                              ),
                            ),
                            Text(
                              'WAKRA',
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
                              '--',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.sp,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w500,
                                height: 1.17,
                              ),
                            ),
                            SizedBox(
                              height: 50.h,
                            )
                            
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
                      ],
                    );
                  }
                  else {
                    return SizedBox();
                  }
                }, ),
              
              SizedBox(height: 21.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
          'Order Items',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w700,
            height: 0.87,
          ),
        ),
                  Container(
          width: 99.w,
          height: 30.h,
          decoration: ShapeDecoration(
            color: const Color(0xFF68188B),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
            shadows: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, 4),
                spreadRadius: 0,
              )
            ],
          ),
          child: Center(
            child: Text(
            'ADD ITEMS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w700,
            ),
                    ),
          ),
        ),

                ],
              ),
              SizedBox(height: 17.h,),
Expanded(
  child: ListView.builder(
    itemCount: 5,
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
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          Image.asset('assets/shirt.png',
                          width: 41.w,
                          height: 44.h,),
                          SizedBox(width: 10.w,),
                          Column(
                            children: [
                              SizedBox(height: 2.h,),
                              Text(
                                        'T-Shirt',
                                        style: TextStyle(
                                          color: const Color(0xFF150B3D),
                                          fontSize: 16.sp,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                  '2 QTY',
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
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(height: 2.h,),
                              Text(
                                'D C',
                                style: TextStyle(
                                  color: const Color(0xFF150B3D),
                                  fontSize: 16.sp,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                  'Express',
                                  style: TextStyle(
                                    color: const Color(0xFF68188B),
                                    fontSize: 14.sp,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                            ],
                          )
                        ],
                      ),
                    ),
        ),
      );
    },)),
    Container(
          width: 364.w,
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
                                      'Total Items :',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 17.sp,
                                                      fontFamily: 'DM Sans',
                                                      fontWeight: FontWeight.w700,
                                                      height: 1,
                                                    ),
                                    ),
                                    Text(
                                      ' 5',
                style: TextStyle(
                  color: const Color(0xFF68188B),
                  fontSize: 15.sp,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w700,
                  height: 1,
                  letterSpacing: 1.20,
                ),
                                    )
                                
                                  ],
                                ),
                                SizedBox(height: 10.h,),
                                Row(
                                  children: [
                                    Text(
                                      'Total QTY : ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w700,
                  height: 1,
                ),
                                    ),
                                    Text(
                                      ' 11',
                style: TextStyle(
                  color: const Color(0xFF68188B),
                  fontSize: 15.sp,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w700,
                  height: 1,
                  letterSpacing: 1.20,
                ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Spacer(),
                            Container(
          width: 99.w,
          height: 28.h,
          decoration: ShapeDecoration(
            color: const Color(0xFF68188B),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          ),
          child: Center(
            child: Text(
            'Collect now',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w700,
            ),
                    ),
          ),
      
        ),
                          ],
                        ),

                      ),
        ),
            ],
          ),
        ),
      ),
      // bottomSheet: Padding(
      //   padding: const EdgeInsets.all(15.0),
      //   child: 
      // ),
    );
  }
}
