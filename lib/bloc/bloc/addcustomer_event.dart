part of 'addcustomer_bloc.dart';

@immutable
sealed class AddcustomerEvent {}
class FetchAddcustomerEvent extends AddcustomerEvent {
  final String token;
  final String username;
  final String companyCode;
  final Map<String, dynamic> customerData;
  FetchAddcustomerEvent({required this.token, required this.username, required this.companyCode, required this.customerData});
}