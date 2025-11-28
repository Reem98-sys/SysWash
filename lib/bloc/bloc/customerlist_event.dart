part of 'customerlist_bloc.dart';

@immutable
sealed class CustomerlistEvent {}
class FetchCustomerListEvent extends CustomerlistEvent {
  final String token;
  final String companyCode;
  FetchCustomerListEvent({required this.token,required this.companyCode});
}