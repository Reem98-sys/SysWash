import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<Map<String, String>?> showAddCustomerDialog(BuildContext context) {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final dropDownKey = GlobalKey<DropdownSearchState>();
  return showDialog<Map<String, String>?>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              width: 402.w,
              height: 630.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select Customer',
                        style: TextStyle(
                          color: const Color(0xFF150B3D),
                          fontSize: 16.sp,
                          fontFamily: 'DM Sans',
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
                  Text(
                    'Customer',
                    style: TextStyle(
                      color: const Color(0xFF150B3D),
                      fontSize: 12.sp,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    width: 348.w,
                    height: 50.h,
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
                      
                      items:
                          (filter, infiniteScrollProps) => [
                            "Arun",
                            "Arjun",
                            "James",
                            "Jane",
                            "Diya",
                            "John",
                            "Jack",
                            "Ariyan",
                          ],
                      decoratorProps: DropDownDecoratorProps(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 16, top: 12),
                        ),
                      ),
                      
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                        constraints: BoxConstraints(maxHeight: 420),

                        menuProps: MenuProps(
                          backgroundColor: Colors.white,
                          margin : EdgeInsets.zero,
                          
                        ),
                        searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                            hintText: "Search...",
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                   Text(
            'Phone Number',
            style: TextStyle(
              color: const Color(0xFF150B3D),
              fontSize: 12.sp,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10.h),
Container(
                    width: 348.w,
                    height: 50.h,
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
                    decoration: const InputDecoration(
                      hintText: 'Phone number',
                      border: InputBorder.none
                    ),
                    ),),
                  
                   
                  
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Container(
          width: 140.w,
          height: 66.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
            'Area',
            style: TextStyle(
              color: const Color(0xFF150B3D),
              fontSize: 12.sp,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10.h,),
          Container(
                    width: 140.w,
                    height: 40.h,
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
                    decoration: const InputDecoration(
                      hintText: 'Place',
                      border: InputBorder.none
                    ),
                    ),),
            ],
          ),),
          SizedBox(width: 10.w,),
          Container(
          width: 140.w,
          height: 66.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
            'Date',
            style: TextStyle(
              color: const Color(0xFF150B3D),
              fontSize: 12.sp,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10.h,),
          Container(
                    width: 140.w,
                    height: 40.h,
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
                    decoration: const InputDecoration(
                      hintText: 'Date',
                      border: InputBorder.none
                    ),
                    ),),
            ],
          ),),
                    ],
                  ),
                   SizedBox(height: 20.h),
                   Text(
            'Notes',
            style: TextStyle(
              color: const Color(0xFF150B3D),
              fontSize: 12.sp,
              fontFamily: 'DM Sans',
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
                      
                    controller: phoneController,
                    
                    
                    decoration: const InputDecoration(
                      hintText: 'Write Notes here',
                      border: InputBorder.none,
                      
                    ),
                    minLines: 4,
    maxLines: 6,
    keyboardType: TextInputType.multiline,
                    ),),
                   SizedBox(height: 20.h),
                   Text(
            'Remark',
            style: TextStyle(
              color: const Color(0xFF150B3D),
              fontSize: 12.sp,
              fontFamily: 'DM Sans',
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
                      
                    controller: phoneController,
                    
                    
                    decoration: const InputDecoration(
                      hintText: 'Write Remark here',
                      border: InputBorder.none,
                      
                    ),
                    minLines: 4,
    maxLines: 6,
    keyboardType: TextInputType.multiline,
                    ),),
                ],
              ),
            ),
          ),
        ),
        actions: [
          
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                        width: 140.w,
                        height: 50.h,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFED8CD),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
                        ),
                        child: Center(
                          child: Text(
                          'CLEAR',
                          style: TextStyle(
                            color: Colors.black.withValues(alpha: 0.54),
                            fontSize: 14.sp,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.84,
                          ),
                                              ),
                        ),
                      ),
              ),
                    SizedBox(width: 12.w,),
                    Container(
                  width: 140.w,
                  height: 50.h,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF68188B),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    shadows: [
                      BoxShadow(
                        color: Color(0x2D99AAC5),
                        blurRadius: 62,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Center(
                    child: Text(
                    'SAVE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.84,
                    ),
                                    ),
                  ),
                ),
            ],
          ),
                
        ],
      );
    },
  );
}
