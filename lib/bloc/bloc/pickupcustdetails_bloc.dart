import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:syswash/model/customerDetailsModel.dart';
import 'package:syswash/model/pickupOrderItemsModel.dart';
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
              PickupOrderItemsModel.empty(); // this line errors if not defined
        }

        emit(
          PickupCustDetailsLoaded(
            customerDetailsModel: customer,
            pickupOrderItemsModel: items,
          ),
        );
        print('SSSSSSSSSSSSSSSSSSSSSS');
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
        );
        emit(AddPickupOrderLoaded());
      } catch (e) {
        emit(PickupCustDetailsError(message: e.toString()));
      }
    });
  }
}
