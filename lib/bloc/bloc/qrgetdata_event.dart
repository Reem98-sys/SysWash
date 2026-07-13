part of 'qrgetdata_bloc.dart';

@immutable
sealed class QrgetdataEvent {}
class FetchQrgetdataEvent extends QrgetdataEvent {
  final String pickupOrderId;
  final String token;
  final String companyCode;
  FetchQrgetdataEvent({required this.pickupOrderId,required this.token,required this.companyCode});
}