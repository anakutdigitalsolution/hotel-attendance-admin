import 'package:equatable/equatable.dart';

class NotificationState extends Equatable {
  const NotificationState();
  @override
  List<Object> get props => [];
}

class FetchingNotification extends NotificationState {}

class FetchedNotification extends NotificationState {}

class ErrorFetchingNotification extends NotificationState {
  final dynamic error;
  ErrorFetchingNotification({required this.error});
}
