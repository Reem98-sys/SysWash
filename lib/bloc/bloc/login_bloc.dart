import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:syswash/model/loginModel.dart';
import 'package:syswash/repositories/sys_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late LoginModel loginModel;
  SysRepository sysRepository = SysRepository();
  LoginBloc() : super(LoginInitial()) {
    on<FetchLoginEvent>((event, emit) async {
      emit(LoginBlocLoading());
      try {
        loginModel = await sysRepository.loginIn(event.email, event.password, event.companyCode);
        emit(LoginBlocLoaded());
      } catch (e) {
        emit(LoginBlocError('Invalid username or password'));
      }
    });
  }
}
