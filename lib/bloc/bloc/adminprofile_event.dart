part of 'adminprofile_bloc.dart';

@immutable
sealed class AdminprofileEvent {}
class FetchAdminProfile extends AdminprofileEvent {
  final String token;
  final String companyCode;
  final String userId;
  FetchAdminProfile({required this.token,required this.companyCode,required this.userId});
}
class UpdateAdminProfileEvent extends AdminprofileEvent {
  final String userID;
  final String token;
  final String companyCode;
  final String userName;
  final String email;
  UpdateAdminProfileEvent({
    required this.userID,
    required this.token,
    required this.companyCode,
    required this.userName,
    required this.email
  });
}

class FetchAdminChangePassEvent extends AdminprofileEvent {
  final String token;
  final String companyCode;
  final String newConfPass;
  final String newPass;
  final String oldPass;
  FetchAdminChangePassEvent({
    required this.token,
    required this.companyCode,
    required this.newConfPass,
    required this.newPass,
    required this.oldPass,
  });
}