part of 'qrputdata_bloc.dart';

@immutable
sealed class QrputdataEvent {}
class FetchQrputdataEvent extends QrputdataEvent {
  final String pickupOrderId;
  final String token;
  final String companyCode;
  final String deliveryCustomerArea;
  final String deliveryCustomerCode;
  final String deliveryCustomerId;
  final String deliveryCustomerName;
  final String deliveryCustomerPhno;
  final String deliveryDate;
  final String deliveryDriverid;
  final String deliveryDrivername;
  final String deliveryInvoiceNo;
  final String deliveryTime;
  final String orderReceiver;
  FetchQrputdataEvent({
    required this.pickupOrderId,
    required this.token,
    required this.companyCode,
    required this.deliveryCustomerArea,
    required this.deliveryCustomerCode,
    required this.deliveryCustomerId,
    required this.deliveryCustomerName,
    required this.deliveryCustomerPhno,
    required this.deliveryDate,
    required this.deliveryDriverid,
    required this.deliveryDrivername,
    required this.deliveryInvoiceNo,
    required this.deliveryTime,
    required this.orderReceiver});
}