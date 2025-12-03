part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}
class ProfileBlocLoading extends ProfileState {}
class ProfileBlocLoaded extends ProfileState {
  final ProfileModel profileModel;
  ProfileBlocLoaded({required this.profileModel});
}
class ProfileBlocError extends ProfileState {}