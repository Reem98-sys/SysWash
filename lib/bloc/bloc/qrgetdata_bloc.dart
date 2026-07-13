import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:syswash/model/customerDetailsModel.dart';
import 'package:syswash/model/pickupOrderItemsModel.dart';
// Import your customer profile/details model here:
// import 'package:syswash/model/customerDetailsModel.dart'; 
import 'package:syswash/repositories/sys_repository.dart';

part 'qrgetdata_event.dart';
part 'qrgetdata_state.dart';

class QrgetdataBloc extends Bloc<QrgetdataEvent, QrgetdataState> {
  late PickupOrderItemsModel pickupOrderItemsModel;
  CustomerDetailsModel? customerDetailsData; // Use your specific Customer model type if you have one
  
  SysRepository sysRepository = SysRepository();

  QrgetdataBloc() : super(QrgetdataInitial()) {
    on<FetchQrgetdataEvent>((event, emit) async {
      emit(QrgetdataBlocLoading());
      try {
        // 1. Fetch primary order data
        pickupOrderItemsModel = await sysRepository.pickuporderitem(
          event.pickupOrderId,
          event.token,
          event.companyCode,
        );
        
        // 2. Extract customerId from the fetched model
        final customerId = pickupOrderItemsModel.customerId;

        // 3. Fetch the secondary customer profile data if customerId exists
        if (customerId != null && customerId.isNotEmpty) {
          // Replace 'fetchCustomerDetails' with your exact repository method name
          customerDetailsData = await sysRepository.pickupcustomerdetails(
            customerId, 
            event.token, 
            event.companyCode,
          );
        }

        // 4. Emit both datasets together to the UI
        emit(QrgetdataBlocLoaded(
          pickupOrderItemsModel: pickupOrderItemsModel,
          customerDetailsModel: customerDetailsData, // Pass to state
        ));
        
      } catch (e) {
        emit(QrgetdataBlocError());
      }
    });
  }
}