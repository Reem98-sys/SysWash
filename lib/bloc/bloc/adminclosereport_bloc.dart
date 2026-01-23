import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:syswash/model/closingReport.dart';
import 'package:syswash/repositories/sys_repository.dart';

part 'adminclosereport_event.dart';
part 'adminclosereport_state.dart';

class AdminclosereportBloc extends Bloc<AdminclosereportEvent, AdminclosereportState> {
  SysRepository sysRepository = SysRepository(); 
  late ClosingReport closingReport;
  AdminclosereportBloc() : super(AdminclosereportInitial()) {
    on<FetchClosingReportEvent>((event, emit) async {
      emit(AdminClosingReportLoading());
      try {
        closingReport = await sysRepository.adminclosingreport(event.token,event.companyCode,event.startDate,event.endDate);
        emit(AdminClosingReportLoaded(
          closingReport: closingReport
          ));
      } catch (e) {
        print(e);
        emit(AdminClosingReportError());
      }
    });
  }
}
