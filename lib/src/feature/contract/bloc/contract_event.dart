import 'package:equatable/equatable.dart';

class ContractEvent extends Equatable {
  ContractEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class InitailizeContractStarted extends ContractEvent {}

class FetchContractSarted extends ContractEvent {}

class FetchAllContractStarted extends ContractEvent {}

class AddContractStarted extends ContractEvent {
  final String userId;
  final String contractId;
  final String startedDate;
  final String endDate;
  final String workingSchedule;
  final String status;
  final String refCode;
  AddContractStarted(
      {required this.userId,
      required this.contractId,
      required this.startedDate,
      required this.endDate,
      required this.workingSchedule,
      required this.status,
      required this.refCode});
}

class UpdateContractStarted extends ContractEvent {
  final String id;
  final String userId;
  final String contractId;
  final String startedDate;
  final String endDate;
  final String workingSchedule;
  final String status;
  final String refCode;
  UpdateContractStarted(
      {required this.id,
      required this.userId,
      required this.contractId,
      required this.startedDate,
      required this.endDate,
      required this.workingSchedule,
      required this.status,
      required this.refCode});
}

class DeleteContractStarted extends ContractEvent {
  final String id;
  DeleteContractStarted({
    required this.id,
  });
}