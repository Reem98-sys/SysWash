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
  final List<Map<String,dynamic>> clothData;
  final int customerDiscount;
  final int discount;
  final String lastModifiedTime;
  final String lastModifieddate;
  final int paidAmount;
  final int quantity;
  final String subTotal;
  final String totalAmount;
  final String userName;
  final double vatValue;
  FetchAddPickupOrderEvent({
    required this.pickupOrderId,
    required this.token,
    required this.companyCode,
    required this.balance,
    required this.clothData,
    required this.customerDiscount,
    required this.discount,
    required this.lastModifiedTime,
    required this.lastModifieddate,
    required this.paidAmount,
    required this.quantity,
    required this.subTotal,
    required this.totalAmount,
    required this.userName,
    required this.vatValue
  });
}

class FetchStatusPickupEvent extends PickupcustdetailsEvent {
  final int pickupAssignId;
  final String token;
  final String companyCode;
  final String status;
  FetchStatusPickupEvent({
    required this.pickupAssignId,
    required this.token,
    required this.companyCode,
    required this.status
  });
}

class FetchAddNewPickupEvent extends PickupcustdetailsEvent {
  final String token;
  final String companyCode;
  final String pickupassgnId;
  final String pickupTime;
  final int quantity;
  final double subTotal;
  final double discount;
  final double totalAmount;
  final double paidAmount;
  final double balance;
  final List<Map<String,dynamic>> clothData;
  final double vatValue;
  FetchAddNewPickupEvent({
    required this.token,
    required this.companyCode,
    required this.pickupassgnId,
    required this.pickupTime,
    required this.quantity,
    required this.subTotal,
    required this.discount,
    required this.totalAmount,
    required this.paidAmount,
    required this.balance,
    required this.clothData,
    required this.vatValue
  });
}

class FetchSettingsLoaded extends PickupcustdetailsState {
  final String companyCode;
  final String token;
  FetchSettingsLoaded({required this.companyCode,required this.token});
}