part of 'pickupcustdetails_bloc.dart';

@immutable
sealed class PickupcustdetailsEvent {}

class FetchPickipCustDetailsEvent extends PickupcustdetailsEvent {
  final String customerId;
  final String companyCode;
  final String token;
  FetchPickipCustDetailsEvent({
    required this.customerId,
    required this.companyCode,
    required this.token,
  });
}

class FetchPickupOrderItemsEvent extends PickupcustdetailsEvent {
  final String pickupOrderId;
  final String token;
  final String companyCode;
  FetchPickupOrderItemsEvent({
    required this.pickupOrderId,
    required this.token,
    required this.companyCode,
  });
}

class FetchFullPickupDetailsEvent extends PickupcustdetailsEvent {
  final String customerId;
  final String pickupOrderId;
  final String token;
  final String companyCode;

  FetchFullPickupDetailsEvent({
    required this.customerId,
    required this.pickupOrderId,
    required this.token,
    required this.companyCode,
  });
}

class FetchAddPickupOrderEvent extends PickupcustdetailsEvent {
  final String pickupOrderId;
  final String token;
  final String companyCode;
  final String balance;
  final String clothData;
  final String arabicName;
  final String billing;
  final String clothImg;
  final String clothName;
  final String clothPrice;
  final String priceId;
  final String qnty;
  final String service;
  final String unit;
  final String customerDiscount;
  final String discount;
  final String lastModifiedTime;
  final String lastModifieddate;
  final String paidAmount;
  final String quantity;
  final String subTotal;
  final String totalAmount;
  final String userName;
  FetchAddPickupOrderEvent({
    required this.pickupOrderId,
    required this.token,
    required this.companyCode,
    required this.balance,
    required this.clothData,
    required this.arabicName,
    required this.billing,
    required this.clothImg,
    required this.clothName,
    required this.clothPrice,
    required this.priceId,
    required this.qnty,
    required this.service,
    required this.unit,
    required this.customerDiscount,
    required this.discount,
    required this.lastModifiedTime,
    required this.lastModifieddate,
    required this.paidAmount,
    required this.quantity,
    required this.subTotal,
    required this.totalAmount,
    required this.userName,
  });
}
