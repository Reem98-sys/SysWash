import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:syswash/repositories/sys_repository.dart';

part 'qrputdata_event.dart';
part 'qrputdata_state.dart';

class QrputdataBloc extends Bloc<QrputdataEvent, QrputdataState> {
  SysRepository sysRepository = SysRepository();
  QrputdataBloc() : super(QrputdataInitial()) {
    on<FetchQrputdataEvent>((event, emit) async {
      emit(QrputdataBlocLoading());
      try {
        final resultDelivery = await sysRepository.qrdelivery(
          event.companyCode,
          event.token,
          event.deliveryCustomerArea,
          event.deliveryCustomerCode,
          event.deliveryCustomerId,
          event.deliveryCustomerName,
          event.deliveryCustomerPhno,
          event.deliveryDate,
          event.deliveryDriverid,
          event.deliveryDrivername,
          event.deliveryInvoiceNo,
          event.deliveryTime,);
        final resultOrder = await sysRepository.qrorder(event.companyCode,event.token,event.deliveryDriverid,event.deliveryDrivername,event.orderReceiver,event.pickupOrderId);
        var message = 'Confirmed Successfully';
        

        emit(QrputdataBlocLoaded(message: message));
        
      } catch (e) {
        print(e);
        emit(QrputdataBlocError());
      }
    });
  }
}
