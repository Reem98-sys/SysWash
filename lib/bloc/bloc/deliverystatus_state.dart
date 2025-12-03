part of 'deliverystatus_bloc.dart';

@immutable
sealed class DeliverystatusState {}

final class DeliverystatusInitial extends DeliverystatusState {}

class DeliveryLoading extends DeliverystatusState {}

class DeliverySuccess extends DeliverystatusState {}

class DeliveryError extends DeliverystatusState {}
