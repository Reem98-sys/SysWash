part of 'pickuplist_bloc.dart';

@immutable
sealed class PickuplistState {}

final class PickuplistInitial extends PickuplistState {}
class PickUpBlocLoading extends PickuplistState {}
class PickUpBlocLoaded extends PickuplistState {
  final PickUpListResponse? pickUpListModel;
  final DeliveryListResponse? deliveryListModel;
  PickUpBlocLoaded({required this.pickUpListModel, required this.deliveryListModel});
}
class PickUpBlocError extends PickuplistState {
  final String message; 
  PickUpBlocError(this.message);
}