import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:syswash/model/notificationlist.dart';
import 'package:syswash/repositories/sys_repository.dart';

part 'notificationlist_event.dart';
part 'notificationlist_state.dart';

class NotificationlistBloc extends Bloc<NotificationlistEvent, NotificationlistState> {
  late List<NotificationList> notificationList;
  SysRepository sysRepository = SysRepository();
  NotificationlistBloc() : super(NotificationlistInitial()) {
    on<FetchNotificationEvent>((event, emit) async {
      emit(NotificationlistLoading());
      try {
        notificationList = await sysRepository.notificationlist(event.userId, event.token, event.companyCode);
        emit(NotificationlistLoaded(notificationList: notificationList));
      } catch (e) {
        print(e);
        emit(NotificationlistError());
      }
    });
  }
}
