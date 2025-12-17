part of 'forgotpass_bloc.dart';

@immutable
sealed class ForgotpassEvent {}
class FetchForgotEvent extends ForgotpassEvent {
  final String companyCode;
  final String email;
  FetchForgotEvent({required this.companyCode,required this.email});
}
class FetchResetEvent extends ForgotpassEvent {
  final String companyCode;
  final String email;
  final String newpass;
  final int otp;
  FetchResetEvent({required this.companyCode,required this.email,required this.newpass,required this.otp});
}