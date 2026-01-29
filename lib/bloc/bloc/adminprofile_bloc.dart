import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:syswash/model/adminProfle.dart';
import 'package:syswash/repositories/sys_repository.dart';

part 'adminprofile_event.dart';
part 'adminprofile_state.dart';

class AdminprofileBloc extends Bloc<AdminprofileEvent, AdminprofileState> {
  SysRepository sysRepository = SysRepository();
  late AdminProfile adminProfile;
  AdminprofileBloc() : super(AdminprofileInitial()) {
    on<FetchAdminProfile>((event, emit) async {
      emit(AdminProfileLoading());
      try {
        adminProfile = await sysRepository.adminprofile(event.token, event.companyCode, event.userId);
        emit(AdminProfileLoaded(adminProfile: adminProfile));
      } catch (e) {
        emit(AdminProfileError());
      }
    });

    on<UpdateAdminProfileEvent>((event, emit) async {
      emit(AdminProfileLoading());
      try {
        final result = await sysRepository.admineditprofile(event.userID,event.token, event.companyCode,event.userName,event.email);
        emit(UpdateProfileLoaded());
      } catch (e) {
        emit(AdminProfileError());
      }
    });

    on<FetchAdminChangePassEvent>((event, emit) async {
      emit(AdminProfileLoading());
      try {
        final result = await sysRepository.adminchangepassword(event.token, event.companyCode,event.newConfPass,event.newPass,event.oldPass);
        emit(ChangePassLoaded(message: result));
      } catch (e) {
        emit(ChangePassError(message: e.toString()));
      }
    });
  }
}
