import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:syswash/model/customerDetailsModel.dart';
import 'package:syswash/model/pickupOrderItemsModel.dart';
import 'package:syswash/model/settingsModel.dart';
import 'package:syswash/repositories/sys_repository.dart';

part 'pickupcustdetails_event.dart';
part 'pickupcustdetails_state.dart';

class PickupcustdetailsBloc
    extends Bloc<PickupcustdetailsEvent, PickupcustdetailsState> {
  SysRepository sysRepository = SysRepository();
  PickupcustdetailsBloc() : super(PickupcustdetailsInitial()) {
    on<FetchFullPickupDetailsEvent>((event, emit) async {
      emit(PickupCustDetailsLoading());
      try {
        final customer = await sysRepository.pickupcustomerdetails(
          event.customerId,
          event.token,
          event.companyCode,
        );
        final settings = await sysRepository.settingsData(event.companyCode, event.token);
        PickupOrderItemsModel? items;

        if (event.pickupOrderId != null &&
            event.pickupOrderId.toString().isNotEmpty &&
            event.pickupOrderId.toString().toLowerCase() != "null") {
          items = await sysRepository.pickuporderitem(
            event.pickupOrderId,
            event.token,
            event.companyCode,
          );
        } else {
          items =
              PickupOrderItemsModel.empty(); 
        }
        emit(
          PickupCustDetailsLoaded(
            customerDetailsModel: customer,
            pickupOrderItemsModel: items, settingsModel: settings,
          ),
        );
        
      } catch (e, stackTrace) {
        print("❌ Error in FetchFullPickupDetailsEvent: $e");
        print("📜 StackTrace: $stackTrace");
        emit(PickupCustDetailsError(message: e.toString()));
      }
    });

    on<FetchAddPickupOrderEvent>((event, emit) async {
      emit(PickupCustDetailsLoading());
      try {
        final response = await sysRepository.addpickuporder(
          event.pickupOrderId,
          event.token,
          event.companyCode,
          event.balance,
          event.clothData,
          event.customerDiscount,
          event.discount,
          event.lastModifiedTime,
          event.lastModifieddate,
          event.paidAmount,
          event.quantity,
          event.subTotal,
          event.totalAmount,
          event.userName,
          event.vatValue
        );
        if (response == 200) {
          emit(AddPickupOrderLoaded());
        } 
        // else {
        //   emit(PickupCustDetailsError(message: 'Failed to update order'));
        // }
      } catch (e) {
        emit(PickupCustDetailsError(message: e.toString()));
      }
    });

    on<FetchStatusPickupEvent>((event, emit) async {
      emit(PickupCustDetailsLoading());
      try {
        final response = await sysRepository.pickupstatus(
          event.pickupAssignId,
          event.token,
          event.companyCode,
          event.status
        );
        emit(StatusPickupLoaded());
      } catch (e) {
        emit(PickupCustDetailsError(message: e.toString()));
      }
    });

    on<FetchAddNewPickupEvent>((event, emit) async {
      emit(PickupCustDetailsLoading());
      try {
        final response = await sysRepository.addnewOrderItem(
          event.token,
          event.companyCode,
          event.pickupassgnId,
          event.pickupTime,
          event.quantity,
          event.subTotal,
          event.discount,
          event.totalAmount,
          event.paidAmount,
          event.balance,
          event.clothData,
          event.vatValue
        );
        emit(AddNewPickupOrderLoaded());
      } catch (e) {
        emit(PickupCustDetailsError(message: e.toString()));
      }
    });
  

  
  }
}
