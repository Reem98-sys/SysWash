import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:syswash/bloc/bloc/adminprofile_bloc.dart';

Future<bool?> adminshowEditPasswordDialog(BuildContext parentContext) async {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController reEnterPasswordController =
      TextEditingController();
  String? currentPassError;
  String? newPassError;
  String? rePassError;
  String? apiError;

  return showDialog<bool>(
    context: parentContext,
    barrierDismissible: false,
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, setState) {
          return BlocListener<AdminprofileBloc, AdminprofileState>(
            listener: (context, state) {
              if (state is ChangePassLoaded) {
                ScaffoldMessenger.of(parentContext).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.pop(dialogContext, true); // close with success
              }

              if (state is ChangePassError) {
                setState(() {
                  apiError = state.message;
                });
              }
            },
            child: Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 24,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Edit Password',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(dialogContext),
                            child: Icon(
                              Icons.cancel,
                              size: 28.sp,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Current Password
                      buildLabel('Current Password'),
                      SizedBox(height: 10.h),
                      buildTextField('', currentPasswordController,currentPassError,),
                      SizedBox(height: 12.h),

                      // New Password
                      buildLabel('New Password'),
                      SizedBox(height: 10.h),
                      buildTextField('', newPasswordController,newPassError,),
                      SizedBox(height: 12.h),

                      // Re-enter Password
                      buildLabel('Re-enter Password'),
                      SizedBox(height: 10.h),
                      buildTextField('', reEnterPasswordController,rePassError,),
                      SizedBox(height: 24.h),

                      if (apiError != null)
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: Text(
                            apiError!,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      // Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                currentPasswordController.clear();
                                newPasswordController.clear();
                                reEnterPasswordController.clear();
                                setState(() {
                                  currentPassError = null;
                                  newPassError = null;
                                  rePassError = null;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFED8CD),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'CLEAR',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                final current =
                                    currentPasswordController.text.trim();
                                final newPass =
                                    newPasswordController.text.trim();
                                final rePass =
                                    reEnterPasswordController.text.trim();

                                setState(() {
                                  currentPassError = current.isEmpty ? 'Enter current password' : null;
                                  newPassError = newPass.isEmpty ? 'Enter new password' : null;
                                  rePassError = rePass.isEmpty ? 'Re-enter password' : null;
                              
                                  if (newPass.isNotEmpty &&
                                      rePass.isNotEmpty &&
                                      newPass != rePass) {
                                    rePassError = 'Passwords do not match';
                                  }
                                });
                              
                                // Stop if any error exists
                                if (currentPassError != null ||
                                    newPassError != null ||
                                    rePassError != null) {
                                  return;
                                }

                                // Fetch stored credentials
                                const storage = FlutterSecureStorage();
                                final token = await storage.read(
                                  key: 'access_Token',
                                );
                                final companyCode = await storage.read(
                                  key: 'company_Code',
                                );
                                final userId = await storage.read(
                                  key: 'login_id',
                                );

                                if (userId == null ||
                                    companyCode == null ||
                                    token == null) {
                                  ScaffoldMessenger.of(
                                    parentContext,
                                  ).showSnackBar(
                                    const SnackBar(
                                      content: Text('Missing login details'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }

                                // 🔹 Call your Bloc to update password
                                parentContext.read<AdminprofileBloc>().add(
                                  FetchAdminChangePassEvent(
                                    token: token,
                                    companyCode: companyCode,
                                    newConfPass: rePass,
                                    newPass: newPass,
                                    oldPass: current,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF68188B),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'SAVE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
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
          );
        },
      );
    },
  );
}

Widget buildLabel(String label) {
  return Text(
    label,
    style: TextStyle(
      color: const Color(0xFF150B3D),
      fontSize: 12.sp,
      fontFamily: 'DM Sans',
      fontWeight: FontWeight.w700,
    ),
  );
}

Widget buildTextField(String hint, TextEditingController controller, String? errorText) {
  return Container(
    width: 348.w,
    // height: 65.h,
    padding: EdgeInsets.symmetric(horizontal: 16.w),
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
      controller: controller,
      // style: TextStyle(fontSize: 14.sp, height: 1.2),
      decoration: InputDecoration(
        hintText: hint,
        border: InputBorder.none,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 10.h),
        errorText: errorText, 
        errorStyle: TextStyle(
          fontSize: 10.sp,
          color: Colors.red,
        ),
      ),
    ),
  );
}
