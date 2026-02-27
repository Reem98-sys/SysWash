import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:syswash/bloc/bloc/customerlist_bloc.dart';
import 'package:syswash/bloc/bloc/uploadpickup_bloc.dart';

Future<bool?> showAddCustomerDialog(
  BuildContext context,
  String companyCode,
  String token,
  String username,
  String userId,
) {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();
  final TextEditingController dateController = TextEditingController(
    text: DateFormat('dd-MM-yyyy').format(DateTime.now()),
  );

  String? pickupCustomerCode;
  String? pickupCustomerId;
  String? pickupDriverid = userId;
  String? pickupDrivername = username;

  final dropDownKey = GlobalKey<DropdownSearchState>();

  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Align(
            alignment: Alignment.center,
            child: Material(
              child: Container(
                width: 402.w,
              
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: SingleChildScrollView(
                        keyboardDismissBehavior:
            ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.fromLTRB(
    16.w,
    16.h,
    16.w,
    16.h + MediaQuery.of(context).viewInsets.bottom, 
  ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// HEADER
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Select Customer',
                                  style: TextStyle(
                                    color: const Color(0xFF150B3D),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Icon(Icons.cancel, size: 30.sp),
                                ),
                              ],
                            ),
                          
                            SizedBox(height: 31.h),
                          
                            /// CUSTOMER
                            Text(
                              'Customer',
                              style: TextStyle(
                                color: const Color(0xFF150B3D),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 10.h),
                          
                            BlocBuilder<CustomerlistBloc, CustomerlistState>(
                              builder: (context, state) {
                                if (state is CustomerListBlocLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                          
                                if (state is CustomerListBlocError) {
                                  return Center(
                                    child: Text(
                                      'Failed to load Customer',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  );
                                }
                          
                                if (state is CustomerListBlocLoaded) {
                                  final customerList =
                                      state.customerListModel?.data ?? [];
                          
                                  return Container(
                                    width: 348.w,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.06),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: DropdownSearch<String>(
                                      key: dropDownKey,
                                      items: (filter, infiniteScrollProps) {
                                        return customerList
                                            .where(
                                              (c) =>
                                                  c.name
                                                      ?.toLowerCase()
                                                      .contains(
                                                        filter?.toLowerCase() ?? '',
                                                      ) ??
                                                  false,
                                            )
                                            .map((c) => c.name ?? '')
                                            .toList();
                                      },
                                      decoratorProps: DropDownDecoratorProps(
                                        decoration: InputDecoration(
                                          hintText: 'Search',
                                          
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 10,
                                          ),
                                        ),
                                      ),
                                      popupProps: PopupProps.menu(
                                        showSearchBox: true,
                                        constraints:
                                            const BoxConstraints(maxHeight: 420),
                                        menuProps: const MenuProps(
                                          backgroundColor: Colors.white,
                                        ),
                                        searchFieldProps: TextFieldProps(
                                          decoration: InputDecoration(
                                            hintText: 'Search...',
                                            prefixIcon: Icon(Icons.search),
                                            border: OutlineInputBorder(),
                                            fillColor: Colors.white,
                                            filled: true,
                                          ),
                                        ),
                                      ),
                                      onChanged: (selectedName) {
                                        final selectedCustomer =
                                            customerList.firstWhere(
                                          (c) => c.name == selectedName,
                                        );
                          
                                        phoneController.text =
                                            selectedCustomer.mobile?.toString() ?? '';
                                        areaController.text =
                                            selectedCustomer.area?.toString() ?? '';
                                        pickupCustomerId =
                                            selectedCustomer.customerId?.toString();
                                        pickupCustomerCode =
                                            selectedCustomer.cusCode?.toString();
                                      },
                                    ),
                                  );
                                }
                          
                                return const SizedBox();
                              },
                            ),
                          
                            SizedBox(height: 20.h),
                          
                            /// PHONE
                            Text(
                              'Phone Number',
                              style: TextStyle(
                                color: const Color(0xFF150B3D),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Container(
                              width: 348.w,
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.06),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: phoneController,
                                decoration: InputDecoration(
                                  hintText: 'Phone number',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(fontSize: 16.sp),
                                ),
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ),
                          
                            SizedBox(height: 20.h),
                            Row(
                              children: [
                                SizedBox(
                                  width: 140.w,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Area',
                                        style: TextStyle(
                                          color: const Color(0xFF150B3D),
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(8.r),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.06),
                                              blurRadius: 10,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: TextFormField(
                                          controller: areaController,
                                          decoration: InputDecoration(
                                            hintText: 'Place',
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(fontSize: 16.sp),
                                          ),
                                          style: TextStyle(fontSize: 16.sp),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                SizedBox(
                                  width: 140.w,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Date',
                                        style: TextStyle(
                                          color: const Color(0xFF150B3D),
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(8.r),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.06),
                                              blurRadius: 10,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: TextFormField(
                                          controller: dateController,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            hintText: 'Date',
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(fontSize: 16.sp),
                                          ),
                                          style: TextStyle(fontSize: 16.sp),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          
                            SizedBox(height: 20.h),
                          
                            /// NOTES
                            Text(
                              'Notes',
                              style: TextStyle(
                                color: const Color(0xFF150B3D),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Container(
                              width: 348.w,
                              height: 100.h,
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.06),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: noteController,
                                minLines: 4,
                                maxLines: 6,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  hintText: 'Write Notes here',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(fontSize: 16.sp),
                                ),
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ),
                          
                            SizedBox(height: 20.h),
                          
                            /// REMARK
                            Text(
                              'Remark',
                              style: TextStyle(
                                color: const Color(0xFF150B3D),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Container(
                              width: 348.w,
                              height: 100.h,
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.06),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: remarkController,
                                minLines: 4,
                                maxLines: 6,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  hintText: 'Write Remark here',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(fontSize: 16.sp),
                                ),
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ),
                          
                            SizedBox(height: 24.h),
                          
                            /// ACTIONS
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    width: 130.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFED8CD),
                                      borderRadius: BorderRadius.circular(6.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'CLEAR',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    context.read<UploadpickupBloc>().add(
                                          FetchUploadPickupEvent(
                                            companyCode: companyCode,
                                            token: token,
                                            notes: noteController.text.trim(),
                                            pickupCustomerArea:
                                                areaController.text.trim(),
                                            pickupCustomerCode:
                                                pickupCustomerCode ?? '',
                                            pickupCustomerId:
                                                pickupCustomerId ?? '',
                                            pickupCustomerName:
                                                dropDownKey.currentState
                                                        ?.getSelectedItem ??
                                                    '',
                                            pickupCustomerPhno:
                                                phoneController.text.trim(),
                                            pickupDate: DateTime.now()
                                                .toIso8601String()
                                                .split('T')[0],
                                            pickuptime:
                                                DateFormat('HH:mm')
                                                    .format(DateTime.now()),
                                            pickupDriverid: pickupDriverid,
                                            pickupDrivername: pickupDrivername,
                                            remarks: remarkController.text.trim(),
                                          ),
                                        );
                                    Navigator.pop(context, true);
                                  },
                                  child: Container(
                                    width: 130.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF68188B),
                                      borderRadius: BorderRadius.circular(6.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'SAVE',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
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
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}