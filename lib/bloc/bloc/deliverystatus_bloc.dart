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
        final message = await sysRepository.deliverypaymentstatus(
          event.companyCode,
          event.token,
          event.deliveryassgnId,
          event.paymentMode,
          event.paymentstatus,
          event.remark
        );
        emit(DeliverySuccess(message: message));
      } catch (e) {
        emit(DeliveryError(message: e.toString().replaceFirst('Exception: ', '')));
      }
    });
  }
}
