part of 'pickuplist_bloc.dart';

@immutable
sealed class PickuplistEvent {}
class FetchPickUpEvent extends PickuplistEvent {
  final String userId;
  final String companyCode;
  final String token;
  FetchPickUpEvent({required this.userId,required this.companyCode,required this.token});
}
class FetchDeliveryEvent extends PickuplistEvent {
  final String userId;
  final String companyCode;
  final String token;
  FetchDeliveryEvent({
    required this.userId,
    required this.companyCode,
    required this.token,
  });
}
class FetchAllOrdersEvent extends PickuplistEvent {
  final String userId;
  final String companyCode;
  final String token;
  FetchAllOrdersEvent({
    required this.userId,
    required this.companyCode,
    required this.token,
  });
}