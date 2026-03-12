part of 'notificationlist_bloc.dart';

@immutable
sealed class NotificationlistState {}

final class NotificationlistInitial extends NotificationlistState {}
class NotificationlistLoading extends NotificationlistState {}
class NotificationlistLoaded extends NotificationlistState {
  final List<NotificationList> notificationList;
  NotificationlistLoaded({required this.notificationList});
}
class NotificationlistError extends NotificationlistState {}