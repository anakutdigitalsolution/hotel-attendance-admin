import 'dart:io';

import 'package:equatable/equatable.dart';

class EmployeeEvent extends Equatable {
  EmployeeEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class FetchEmloyeeStarted extends EmployeeEvent {}

class InitializeEmployeeStarted extends EmployeeEvent {}

class RefreshEmployeeStarted extends EmployeeEvent {}

class FetchAllEmployeeStarted extends EmployeeEvent {}

class AddEmployeeStarted extends EmployeeEvent {
  final String name;
  final String gender;
  final String dob;
  final String email;
  final String officeTel;
  final File? img;
  final String username;

  final String password;
  final String positionId;
  final String departmentId;
  final String storeId;
  final String phoneNumber;
  final String address;
  AddEmployeeStarted(
      {required this.name,
      required this.gender,
      required this.dob,
      required this.email,
      required this.officeTel,
      required this.username,
      required this.img,
      required this.password,
      required this.positionId,
      required this.departmentId,
      required this.storeId,
      required this.phoneNumber,
      required this.address});
}

class UpdateEmployeeStarted extends EmployeeEvent {
  final String id;
  final String name;
  final String gender;
  final String dob;
  final String email;
  final String officeTel;
  final File? img;
  final String positionId;
  final String departmentId;
  final String storeId;
  final String phoneNumber;
  final String address;
  final String imgUrl;
  UpdateEmployeeStarted(
      {required this.id,
      required this.name,
      required this.gender,
      required this.dob,
      required this.email,
      required this.officeTel,
      required this.img,
      required this.imgUrl,
      required this.phoneNumber,
      required this.positionId,
      required this.departmentId,
      required this.storeId,
      required this.address});
}

class DeleteEmployeeStarted extends EmployeeEvent {
  final String id;

  // final String date;
  DeleteEmployeeStarted({
    required this.id,
  });
}
