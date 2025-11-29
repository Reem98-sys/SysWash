part of 'settings_bloc.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}
class SettingsBlocLoading extends SettingsState {}
class SettingsBlocLoaded extends SettingsState {
  final SettingsModel settingsModel;
   SettingsBlocLoaded({required this.settingsModel});
}
class SettingsBlocError extends SettingsState {}