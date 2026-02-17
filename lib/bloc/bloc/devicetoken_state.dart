part of 'devicetoken_bloc.dart';

@immutable
sealed class DevicetokenState {}

final class DevicetokenInitial extends DevicetokenState {}
class DeviceTokenLoading extends DevicetokenState {}
class DeviceTokenLoaded extends DevicetokenState {
  final String message;
  DeviceTokenLoaded({required this.message});
}
class AdminDeviceTokenLoaded extends DevicetokenState {
  final String message;
  AdminDeviceTokenLoaded({required this.message});
}
class DeviceTokenError extends DevicetokenState {
  final String message;
  DeviceTokenError({required this.message});
}