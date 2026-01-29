import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syswash/screens/adminHome.dart';
import 'package:syswash/screens/adminReport.dart';
import 'package:syswash/screens/adminprofile.dart';

class Bottomnavadmin extends StatefulWidget {
  final int currentIndex;
  const Bottomnavadmin({super.key, this.currentIndex = 0});

  @override
  State<Bottomnavadmin> createState() => _BottomnavadminState();
}

class _BottomnavadminState extends State<Bottomnavadmin> {
  late int _selectedScreen;

  final List<Widget> _screens = [
    const Adminhome(),
    const Adminreport(),
    const Adminprofile(),
  ];

  final List<Map<String, dynamic>> _items = [
    {'icon': 'assets/home.svg', 'label': 'Home'},
    {'icon': 'assets/history.svg', 'label': 'Report'},
    {'icon': 'assets/person.svg', 'label': 'Profile'},
  ];

  @override
  void initState() {
    super.initState();
    _selectedScreen = widget.currentIndex;
  } 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _screens[_selectedScreen]),
      bottomNavigationBar: SafeArea(
        child: ClipRRect(
          // borderRadius: BorderRadius.circular(16.r),
          child: Container(
            
            // width: 630.w,
            height: 76.h,
            clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
          color: const Color(0xFF68188B), // Purple background
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_items.length, (index) {
                final item = _items[index];
                final bool isSelected = index == _selectedScreen;
        
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedScreen = index);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: isSelected ? 8.h : 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                    child: Row(
                      children: [
                        
                        SvgPicture.asset(
                          item['icon'],
                          height: 20.h,
                          width: 20.w,
                          color: isSelected
                              ? const Color(0xFF68188B)
                              : Colors.white,
                        ),
                        if(isSelected) ...[
                          SizedBox(width: 6.w,),
                          Text(
                          item['label'],
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: const Color(0xFF68188B),
                              fontFamily: 'Poppins',
                            fontWeight:FontWeight.w500,
                          ),
                        ),]
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
      
    );
  }
}