import 'package:equatable/equatable.dart';

abstract class RoleEvent extends Equatable {
  RoleEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class FetchRoleStarted extends RoleEvent {}
