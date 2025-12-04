import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syswash/bloc/bloc/profile_bloc.dart';

void showEditPasswordDialog(BuildContext context, String currentPassword) {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController reEnterPasswordController =
      TextEditingController();

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext dialogContext) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
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
                buildTextField('', currentPasswordController),
                SizedBox(height: 12.h),

                // New Password
                buildLabel('New Password'),
                SizedBox(height: 10.h),
                buildTextField('', newPasswordController),
                SizedBox(height: 12.h),

                // Re-enter Password
                buildLabel('Re-enter Password'),
                SizedBox(height: 10.h),
                buildTextField('', reEnterPasswordController),
                SizedBox(height: 24.h),

                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          currentPasswordController.clear();
                          newPasswordController.clear();
                          reEnterPasswordController.clear();
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
                          final current = currentPasswordController.text.trim();
                          final newPass = newPasswordController.text.trim();
                          final rePass = reEnterPasswordController.text.trim();

                          if (newPass.isEmpty ||
                              rePass.isEmpty ||
                              current.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please fill all fields'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          if (currentPassword != current) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Current password is not correct',
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          if (newPass != rePass) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('New passwords do not match'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          // Fetch stored credentials
                          const storage = FlutterSecureStorage();
                          final token = await storage.read(key: 'access_Token');
                          final companyCode = await storage.read(
                            key: 'company_Code',
                          );
                          final userId = await storage.read(key: 'login_id');

                          if (userId == null ||
                              companyCode == null ||
                              token == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Missing login details'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          // 🔹 Call your Bloc to update password
                          context.read<ProfileBloc>().add(
                            UpdatePasswordEvent(
                              userID: userId,
                              companyCode: companyCode,
                              token: token,
                              currentpass: current,
                              newPass: newPass,
                              newconfpass: rePass,
                            ),
                          );

                          

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Password updated successfully!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          // Navigator.pop(dialogContext);
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

Widget buildTextField(String hint, TextEditingController controller) {
  return Container(
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
      controller: controller,
      decoration: InputDecoration(hintText: hint, border: InputBorder.none),
    ),
  );
}
