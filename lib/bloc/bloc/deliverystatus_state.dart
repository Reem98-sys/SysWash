part of 'deliverystatus_bloc.dart';

@immutable
sealed class DeliverystatusState {}

final class DeliverystatusInitial extends DeliverystatusState {}

class DeliveryLoading extends DeliverystatusState {}

class DeliverySuccess extends DeliverystatusState {
  final String message;
  DeliverySuccess({required this.message});
}

class DeliveryError extends DeliverystatusState {
  final String message;
  DeliveryError({required this.message});
}
