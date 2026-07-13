part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}
class FetchLoginEvent extends LoginEvent {
  final String email;
  final String password;
  final String companyCode;
  final bool force;
  FetchLoginEvent({required this.email, required this.password, required this.companyCode,required this.force});
}