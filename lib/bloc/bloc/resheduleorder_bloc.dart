import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:syswash/repositories/sys_repository.dart';

part 'resheduleorder_event.dart';
part 'resheduleorder_state.dart';

class ResheduleorderBloc extends Bloc<ResheduleorderEvent, ResheduleorderState> {
  SysRepository sysRepository = SysRepository();
  ResheduleorderBloc() : super(ResheduleorderInitial()) {
    on<FetchResheduleOrderEvent>((event, emit) async {
      emit(ResheduleOrderLoading());
      try {
        final result = await sysRepository.pickupreshedule(event.id, event.token, event.companyCode);
        emit(ResheduleOrderLoaded(message: result));
      } catch (e) {
        emit(ResheduleOrderError());
      }
    });
    on<FetchResheduleOrderDeliveryEvent>((event, emit) async {
      emit(ResheduleOrderLoading());
      try {
        final result = await sysRepository.deliveryreshedule(event.id, event.token, event.companyCode);
        emit(ResheduleOrderDeliveryLoaded(message: result));
      } catch (e) {
        emit(ResheduleOrderError());
      }
    });
  }
}
