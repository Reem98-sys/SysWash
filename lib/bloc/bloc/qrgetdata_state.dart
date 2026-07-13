part of 'qrgetdata_bloc.dart';

@immutable
sealed class QrgetdataState {}

final class QrgetdataInitial extends QrgetdataState {}
class QrgetdataBlocLoading extends QrgetdataState {}
class QrgetdataBlocLoaded extends QrgetdataState {
  final PickupOrderItemsModel pickupOrderItemsModel;
  final CustomerDetailsModel? customerDetailsModel;
  QrgetdataBlocLoaded({required this.pickupOrderItemsModel, this.customerDetailsModel});
}
class QrgetdataBlocError extends QrgetdataState {}