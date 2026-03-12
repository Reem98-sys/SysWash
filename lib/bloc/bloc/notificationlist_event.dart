part of 'notificationlist_bloc.dart';

@immutable
sealed class NotificationlistEvent {}
class FetchNotificationEvent extends NotificationlistEvent {
  final String userId;
  final String token;
  final String companyCode;
  FetchNotificationEvent({required this.userId,required this.token,required this.companyCode});
}