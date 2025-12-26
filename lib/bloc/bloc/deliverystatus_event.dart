part of 'deliverystatus_bloc.dart';

@immutable
sealed class DeliverystatusEvent {}

class FetchDeliveryStatusEvent extends DeliverystatusEvent {
  final String companyCode;
  final String token;
  final int deliveryassgnId;
  final String? paymentMode;
  final String? paymentstatus;
  final String? remark;
  FetchDeliveryStatusEvent({
    required this.companyCode,
    required this.token,
    required this.deliveryassgnId,
     this.paymentMode,
     this.paymentstatus,
     this.remark
  });
}
