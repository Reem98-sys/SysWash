part of 'uploadpickup_bloc.dart';

@immutable
sealed class UploadpickupEvent {}
class FetchUploadPickupEvent extends UploadpickupEvent {
  final String companyCode;
  final String token;
  final String notes;
  final String pickupCustomerArea;
  final String pickupCustomerCode;
  final String pickupCustomerId;
  final String pickupCustomerName;
  final String pickupCustomerPhno;
  final String pickupDate;
  final String pickupDriverid;
  final String pickupDrivername;
  final String remarks;
  FetchUploadPickupEvent({
    required this.companyCode,
    required this.notes,
    required this.pickupCustomerArea,
    required this.pickupCustomerCode,
    required this.pickupCustomerId,
    required this.pickupCustomerName,
    required this.pickupCustomerPhno,
    required this.pickupDate,
    required this.pickupDriverid,
    required this.pickupDrivername,
    required this.remarks,
    required this.token});
}