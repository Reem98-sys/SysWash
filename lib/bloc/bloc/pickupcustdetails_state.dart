part of 'pickupcustdetails_bloc.dart';

@immutable
sealed class PickupcustdetailsState {}

final class PickupcustdetailsInitial extends PickupcustdetailsState {}
class PickupCustDetailsLoading extends PickupcustdetailsState {}
class PickupCustDetailsLoaded extends PickupcustdetailsState {
  final CustomerDetailsModel customerDetailsModel;
  final PickupOrderItemsModel pickupOrderItemsModel;
  PickupCustDetailsLoaded({ required this.customerDetailsModel,required this.pickupOrderItemsModel});
}
class PickupCustDetailsError extends PickupcustdetailsState {
  final String message;
  PickupCustDetailsError({required this.message});
}
class AddPickupOrderLoaded extends PickupcustdetailsState {}
