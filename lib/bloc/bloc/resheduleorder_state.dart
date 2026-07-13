part of 'resheduleorder_bloc.dart';

@immutable
sealed class ResheduleorderState {}

final class ResheduleorderInitial extends ResheduleorderState {}
class ResheduleOrderLoading extends ResheduleorderState {}
class ResheduleOrderLoaded extends ResheduleorderState {
  final String message;
  ResheduleOrderLoaded({required this.message});
}
class ResheduleOrderDeliveryLoaded extends ResheduleorderState {
  final String message;
  ResheduleOrderDeliveryLoaded({required this.message});
}
class ResheduleOrderError extends ResheduleorderState {}