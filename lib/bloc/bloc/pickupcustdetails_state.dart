part of 'pickupcustdetails_bloc.dart';

@immutable
sealed class PickupcustdetailsState {}

final class PickupcustdetailsInitial extends PickupcustdetailsState {}
class PickupCustDetailsLoading extends PickupcustdetailsState {}
class PickupCustDetailsLoaded extends PickupcustdetailsState {
  final CustomerDetailsModel customerDetailsModel;
  final PickupOrderItemsModel pickupOrderItemsModel;
  final SettingsModel settingsModel;
  PickupCustDetailsLoaded({ required this.customerDetailsModel,required this.pickupOrderItemsModel, required this.settingsModel});
}
class PickupCustDetailsError extends PickupcustdetailsState {
  final String message;
  PickupCustDetailsError({required this.message});
}
class AddPickupOrderLoaded extends PickupcustdetailsState {}
class AddNewPickupOrderLoaded extends PickupcustdetailsState {}
class StatusPickupLoaded extends PickupcustdetailsState {}
class FetchVatValueEvent extends PickupcustdetailsEvent {
  final String token;
  final String companyCode;

  FetchVatValueEvent({required this.token, required this.companyCode});
}

