part of 'logout_bloc.dart';

@immutable
sealed class LogoutEvent {}
class FetchLogoutEvent extends LogoutEvent {
  final String id;
  final String companyCode;
  final String token;
  FetchLogoutEvent({required this.id,required this.companyCode,required this.token});
}
class FetchAdminLogoutEvent extends LogoutEvent {
  final String id;
  final String companyCode;
  final String token;
  FetchAdminLogoutEvent({required this.id,required this.companyCode,required this.token});
}