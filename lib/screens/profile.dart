import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(Icons.arrow_back_sharp)),
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        ),
        body: Column(
          children: [
            SizedBox(height: 39.h,),
            Container(
          width: 106,
          height: 106,
          decoration: ShapeDecoration(
            image: DecorationImage(
              image: NetworkImage("https://placehold.co/106x106"),
              fit: BoxFit.cover,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        SizedBox(
          height: 19.h,
        ),
        Text(
          'Joanna Matthew',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          '+91 8800850641',
          style: TextStyle(
            color: const Color(0xFF6E6F79),
            fontSize: 16.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        Container(
                    width: 168.w,
                    height: 60.h,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFE2E5F4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                    child: Row(
                      children: [
                        
                        Text(
                  'Edit Profile',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                      ],
                    ),
                  ),
          ],
        ),
    );
  }
}