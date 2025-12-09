part of 'devicetoken_bloc.dart';

@immutable
sealed class DevicetokenEvent {}
class FetchDeviceTokenEvent extends DevicetokenEvent {
  final String userID;
  final String companyCode;
  final String token;
  final String devicetoken;
  FetchDeviceTokenEvent({
    required this.userID,
    required this.companyCode,
    required this.token,
    required this.devicetoken
    });
}