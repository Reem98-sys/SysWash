import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:syswash/repositories/sys_repository.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  SysRepository sysRepository = SysRepository();
  LogoutBloc() : super(LogoutInitial()) {
    on<FetchLogoutEvent>((event, emit) async {
      emit(LogoutBlocLoading());
      try {
        final message = await sysRepository.logout(event.id, event.companyCode, event.token);
        emit(LogoutBlocLoaded(message: message));
      } catch (e) {
        emit(LogoutBlocError());
      }
    });
    on<FetchAdminLogoutEvent>((event, emit) async {
      emit(LogoutBlocLoading());
      try {
        final message = await sysRepository.logoutadmin(event.id, event.companyCode, event.token);
        emit(LogoutBlocLoaded(message: message));
      } catch (e) {
        emit(LogoutBlocError());
      }
    });
  }
}
