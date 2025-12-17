import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:syswash/repositories/sys_repository.dart';

part 'forgotpass_event.dart';
part 'forgotpass_state.dart';

class ForgotpassBloc extends Bloc<ForgotpassEvent, ForgotpassState> {
  SysRepository sysRepository = SysRepository();
  ForgotpassBloc() : super(ForgotpassInitial()) {
    on<FetchForgotEvent>((event, emit) async {
      emit(ForgotpassLoading());
      try {
        final result = await sysRepository.forgotpass(event.companyCode, event.email);
        emit(ForgotpassLoaded(result));
      } catch (e) {
        emit(ForgotpassError(e.toString()));
      }
    });
    on<FetchResetEvent>((event, emit) async {
      emit(ForgotpassLoading());
      try {
        final result = await sysRepository.resetpass(event.companyCode, event.email, event.newpass, event.otp);
        emit(ResetpassLoaded(result));
      } catch (e) {
        emit(ForgotpassError(e.toString()));
      }
    });
  }
}
