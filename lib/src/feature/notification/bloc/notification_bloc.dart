import 'dart:developer';

import 'package:hotle_attendnce_admin/src/feature/notification/model/notification_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/notification/repository/notification_repository.dart';

import 'index.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(FetchingNotification());
  List<NotificationModel> notificationModel = [];
  NotificationRepository _notificationRepository = NotificationRepository();
   int rowperpage = 12;
  int page = 1;
  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is FetchNotificationStarted) {
      yield FetchingNotification();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        List<NotificationModel> _temList = await _notificationRepository.getNotification(rowPerpage: rowperpage, page: page);
        print(notificationModel.length);
        notificationModel.addAll(_temList);
        page++;
        print(page);
        print(_temList.length);
        if (_temList.length < rowperpage) {
          yield EndOfNotificationList();
        } else {
          yield FetchedNotification();
        }
        
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingNotification(error: e.toString());
      }
    }
    if(event is InitializeNotificationStarted){
      yield FetchingNotification();
      try {
        page =1;
        notificationModel= await _notificationRepository.getNotification(rowPerpage: rowperpage, page: page);
        page ++;
         print(page);
        print(notificationModel.length);
        if (notificationModel.length < rowperpage) {
          yield EndOfNotificationList();
        } else {
          yield InitializedNotification();
        }

      } catch (e) {
        log(e.toString());
        yield ErrorFetchingNotification(error: e.toString());
      }
    }
    if(event is AddNotificationStarted){
      yield AddingNotification();
      try {
        await _notificationRepository.addNotification(title: event.title, des: event.des);
        yield AddedNotification();
        yield FetchingNotification();
          notificationModel.clear();
          notificationModel= await _notificationRepository.getNotification(rowPerpage: rowperpage, page: 1);
        yield FetchingNotification();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingNotification(error: e.toString());
      }
    }
    if(event is UpdateNotificationStarted){
       yield AddingNotification();
      try {
        await _notificationRepository.editNotification(id: event.id,title: event.title, des: event.des);
        yield AddedNotification();
        yield FetchingNotification();
          notificationModel.clear();
          notificationModel= await _notificationRepository.getNotification(rowPerpage: rowperpage, page: 1);
        yield FetchingNotification();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingNotification(error: e.toString());
      }
    }
    if(event is DeleteNotificationStarted){
      yield AddingNotification();
      try {
        await _notificationRepository.deleteNotification(id: event.id);
        yield AddedNotification();
        yield FetchingNotification();
          notificationModel.clear();
          notificationModel= await _notificationRepository.getNotification(rowPerpage: rowperpage, page: 1);
        yield FetchingNotification();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingNotification(error: e.toString());
      }
    }
  }
}
