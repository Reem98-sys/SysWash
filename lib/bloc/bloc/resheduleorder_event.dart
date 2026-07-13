part of 'resheduleorder_bloc.dart';

@immutable
sealed class ResheduleorderEvent {}
class FetchResheduleOrderEvent extends ResheduleorderEvent {
  final String id;
  final String token;
  final String companyCode;
  FetchResheduleOrderEvent({required this.id,required this.token,required this.companyCode});
}
class FetchResheduleOrderDeliveryEvent extends ResheduleorderEvent {
  final String id;
  final String token;
  final String companyCode;
  FetchResheduleOrderDeliveryEvent({required this.id,required this.token,required this.companyCode});
}