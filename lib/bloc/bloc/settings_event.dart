part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {}
class FetchSettingsEvent extends SettingsEvent {
  final String companyCode;
  final String token;
  FetchSettingsEvent({required this.companyCode,required this.token});
}