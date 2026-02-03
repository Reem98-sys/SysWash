import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:syswash/model/userType.dart';
import 'package:syswash/repositories/sys_repository.dart';

part 'reportlist_event.dart';
part 'reportlist_state.dart';

class ReportlistBloc extends Bloc<ReportlistEvent, ReportlistState> {
  SysRepository sysRepository = SysRepository();
  late UserType userType;
  ReportlistBloc() : super(ReportlistInitial()) {
    on<FetchUserTypeEvent>((event, emit) async {
      emit(ReportListLoading());
      try {
        userType = await sysRepository.adminusertype(event.token, event.companyCode);
        emit(UsertypeLoaded(userType: userType));
      } catch (e) {
        print(e);
        emit(ReportListError());
      }
    });
  }
}
