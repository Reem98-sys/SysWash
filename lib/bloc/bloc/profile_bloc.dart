import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:syswash/model/profileModel.dart';
import 'package:syswash/repositories/sys_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  SysRepository sysRepository = SysRepository();
  ProfileBloc() : super(ProfileInitial()) {
    on<FetchProfileEvent>((event, emit) async {
      emit(ProfileBlocLoading());
      try {
        final profileData = await sysRepository.profileDetail(event.userId, event.companyCode, event.token);
        emit(ProfileBlocLoaded(profileModel: profileData));
      } catch (e) {
        emit(ProfileBlocError());
      }
    });
    on<UpdateProfileEvent>((event, emit) async {
      emit(ProfileBlocLoading());
      try {
        final updateprofile = await sysRepository.updateProfile(
          event.userID,
          event.companyCode,
          event.token,
          event.name,
          event.email,
          event.phone,
          event.password);
        emit(UpdateProfileLoaded());
      } catch (e) {
        emit(ProfileBlocError());
      }
    });
    on<UpdatePasswordEvent>((event, emit) async {
      emit(ProfileBlocLoading());
      try {
        final updatepassword = await sysRepository.updatepassword(
          event.userID,
          event.companyCode,
          event.token,
          event.currentpass,
          event.newPass,
          event.newconfpass);
        emit(UpdatePasswordLoaded());
      } catch (e) {
        emit(ProfileBlocError());
      }
    });
  }
}
