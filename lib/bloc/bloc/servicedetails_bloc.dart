import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:syswash/model/serviceDetails.dart';
import 'package:syswash/repositories/sys_repository.dart';

part 'servicedetails_event.dart';
part 'servicedetails_state.dart';

class ServicedetailsBloc extends Bloc<ServicedetailsEvent, ServicedetailsState> {
  final SysRepository sysRepository = SysRepository();
  ServicedetailsBloc() : super(ServicedetailsInitial()) {
    on<FetchServiceDetailsEvent>((event, emit) async {
      emit(ServicedetailsLoading());
      try {
        final servicedetailsModel = await sysRepository.servicedetail(event.companyCode, event.token);
        emit(ServicedetailsLoaded(servicedetailModel: servicedetailsModel));
      } catch (e) {
        emit(ServicedetailsError(e.toString()));
      }
    });
  }
}
