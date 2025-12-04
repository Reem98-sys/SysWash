part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}
class FetchProfileEvent extends ProfileEvent {
  final String userId;
  final String companyCode;
  final String token;
  FetchProfileEvent({required this.userId,required this.companyCode,required this.token});
}
class UpdateProfileEvent extends ProfileEvent {
  final String userID;
  final String companyCode;
  final String token;
  final String name;
  final String email;
  final String phone;
  final String password;
  UpdateProfileEvent({
    required this.userID,
    required this.companyCode, 
    required this.token,
    required this.name,
    required this.email,
    required this.phone,
    required this.password
  });
}
class UpdatePasswordEvent extends ProfileEvent {
  final String userID;
  final String companyCode;
  final String token;
  final String currentpass;
  final String newPass;
  final String newconfpass;
  UpdatePasswordEvent({
    required this.userID,
    required this.companyCode, 
    required this.token,
    required this.currentpass,
    required this.newPass,
    required this.newconfpass,
  });
}