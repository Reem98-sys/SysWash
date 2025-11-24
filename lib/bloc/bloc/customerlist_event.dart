part of 'customerlist_bloc.dart';

@immutable
sealed class CustomerlistEvent {}
class FetchCustomerListEvent extends CustomerlistEvent {
  final String token;
  FetchCustomerListEvent({required this.token});
}