import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:syswash/repositories/sys_repository.dart';

part 'deliverystatus_event.dart';
part 'deliverystatus_state.dart';

class DeliverystatusBloc
    extends Bloc<DeliverystatusEvent, DeliverystatusState> {
  SysRepository sysRepository = SysRepository();
  DeliverystatusBloc() : super(DeliverystatusInitial()) {
    on<FetchDeliveryStatusEvent>((event, emit) async {
      
      emit(DeliveryLoading());
      try {
        final response = await sysRepository.deliverypaymentstatus(
          event.companyCode,
          event.token,
          event.deliveryassgnId,
          event.paymentMode,
          event.paymentstatus,
        );
        emit(DeliverySuccess());
      } catch (e,stackTrace) {
        emit(DeliveryError());
      }
    });
  }
}
