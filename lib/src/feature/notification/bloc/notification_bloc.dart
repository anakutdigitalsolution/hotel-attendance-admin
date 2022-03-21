import 'dart:developer';

import 'package:hotle_attendnce_admin/src/feature/notification/model/notification_model.dart';
import 'package:hotle_attendnce_admin/src/feature/notification/res/notification_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'index.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(FetchingNotification());
  List<NotificationModel> notificationModel = [];
  NotificationRepository notificationRepository = NotificationRepository();
  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is FetchNotificationStarted) {
      yield FetchingNotification();
      try {
        Future.delayed(Duration(milliseconds: 200));
        notificationModel = await notificationRepository.getNotification();
        print(notificationModel.length);
        yield FetchedNotification();
      } catch (e) {
        print(e.toString());
        yield ErrorFetchingNotification(error: e.toString());
      }
    }
  }
}
