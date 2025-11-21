import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:syswash/model/deliveryListModel.dart';
import 'package:syswash/model/delivery_list_response.dart';
import 'package:syswash/model/pickupListModel.dart';
import 'package:syswash/model/pickup_list_response.dart';
import 'package:syswash/repositories/sys_repository.dart';

part 'pickuplist_event.dart';
part 'pickuplist_state.dart';

class PickuplistBloc extends Bloc<PickuplistEvent, PickuplistState> {
  final SysRepository sysRepository = SysRepository();

  PickuplistBloc() : super(PickuplistInitial()) {
    // Fetch pickup orders
    on<FetchPickUpEvent>((event, emit) async {
      emit(PickUpBlocLoading());
      try {
        final pickUpListModel = await sysRepository.pickUpList(
          event.userId, event.companyCode, event.token);
        emit(PickUpBlocLoaded(pickUpListModel: pickUpListModel, deliveryListModel: null));
      } catch (e) {
        emit(PickUpBlocError(e.toString()));
      }
    });

    // Fetch delivery orders
    on<FetchDeliveryEvent>((event, emit) async {
      emit(PickUpBlocLoading());
      try {
        final deliveryListModel = await sysRepository.deliveryList(
          event.userId, event.companyCode, event.token);
        emit(PickUpBlocLoaded(deliveryListModel: deliveryListModel, pickUpListModel: null));
      } catch (e) {
        emit(PickUpBlocError(e.toString()));
      }
    });

    // Fetch both pickup + delivery together
    on<FetchAllOrdersEvent>((event, emit) async {
      emit(PickUpBlocLoading());
      try {
        final pickupResponse = await sysRepository.pickUpList(
          event.userId, event.companyCode, event.token);
        final deliveryResponse = await sysRepository.deliveryList(
          event.userId, event.companyCode, event.token);
        emit(PickUpBlocLoaded(
          pickUpListModel: pickupResponse,
          deliveryListModel: deliveryResponse,
        ));
      } catch (e) {
        emit(PickUpBlocError(e.toString()));
      }
    });
  }
}
