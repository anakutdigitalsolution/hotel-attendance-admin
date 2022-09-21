import 'package:equatable/equatable.dart';

abstract class RoleState extends Equatable {
  RoleState([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class FetchingRole extends RoleState {}

class FetchedRole extends RoleState {}

class ErrorFetchingRole extends RoleState {
  final dynamic error;
  ErrorFetchingRole({
    required this.error
  });
}
