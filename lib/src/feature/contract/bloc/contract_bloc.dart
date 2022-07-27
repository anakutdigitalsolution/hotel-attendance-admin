import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/contract/bloc/contract_event.dart';
import 'package:hotle_attendnce_admin/src/feature/contract/bloc/contract_state.dart';
import 'package:hotle_attendnce_admin/src/feature/contract/model/contract_model.dart';
import 'package:hotle_attendnce_admin/src/feature/contract/repository/contract_repository.dart';

class ContractBloc extends Bloc<ContractEvent, ContractState> {
  ContractBloc() : super(InitailizingContract());
  ContractRepository _structuretypeRepository = ContractRepository();
  List<ContractModel> contract = [];
  int rowperpage = 12;
  int page = 1;
  @override
  Stream<ContractState> mapEventToState(ContractEvent event) async* {
    if (event is InitailizeContractStarted) {
      yield InitailizingContract();
      try {
        page = 1;
        contract.clear();
        List<ContractModel> _departmentList = await _structuretypeRepository
            .getContract(rowperpage: rowperpage, page: page);
        contract.addAll(_departmentList);
        page++;
        print(page);
        yield InitalizedContract();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingContract(error: e.toString());
      }
    }
    if (event is FetchContractSarted) {
      yield FetchingContract();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        List<ContractModel> _departmentList = await _structuretypeRepository
            .getContract(rowperpage: rowperpage, page: page);
        contract.addAll(_departmentList);
        page++;
        print(page);
        print(_departmentList.length);
        if (_departmentList.length < rowperpage) {
          yield EndofContractList();
        } else {
          yield FetchedContract();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingContract(error: e.toString());
      }
    }
    if (event is FetchAllContractStarted) {
      yield FetchingContract();
      try {
        contract.clear();
        // Future.delayed(Duration(milliseconds: 200));
        List<ContractModel> _departmentList =
            await _structuretypeRepository.getAllContract();
        contract.addAll(_departmentList);

        yield FetchedContract();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingContract(error: e.toString());
      }
    }
    if (event is AddContractStarted) {
      yield AddingContract();
      try {
        await _structuretypeRepository.addContract(
            userId: event.userId,
            contractId: event.contractId,
            startedDate: event.startedDate,
            endDate: event.endDate,
            workingSchedule: event.workingSchedule,
            status: event.status,
            refCode: event.refCode);
        yield AddedContract();
        yield FetchingContract();
        page = 1;
        contract.clear();
        // Future.delayed(Duration(milliseconds: 200));
        List<ContractModel> _departmentList =
            await _structuretypeRepository.getAllContract();
        contract.addAll(_departmentList);
        page++;
        print(page);
        yield FetchedContract();
      } catch (e) {
        yield ErrorAddingContract(error: e.toString());
      }
    }
    if (event is UpdateContractStarted) {
      yield AddingContract();
      try {
        await _structuretypeRepository.editContract(
            id: event.id,
            userId: event.userId,
            contractId: event.contractId,
            startedDate: event.startedDate,
            endDate: event.endDate,
            workingSchedule: event.workingSchedule,
            status: event.status,
            refCode: event.refCode);
        yield AddedContract();
        yield FetchingContract();
        page = 1;
        contract.clear();
        // Future.delayed(Duration(milliseconds: 200));
        List<ContractModel> _departmentList =
            await _structuretypeRepository.getAllContract();
        contract.addAll(_departmentList);
        page++;
        print(page);
        yield FetchedContract();
      } catch (e) {
        yield ErrorAddingContract(error: e.toString());
      }
    }
    if (event is DeleteContractStarted) {
      yield AddingContract();
      try {
        await _structuretypeRepository.deleteContract(
          id: event.id,
        );
        yield AddedContract();
        yield FetchingContract();
        page = 1;
        contract.clear();
        // Future.delayed(Duration(milliseconds: 200));
        List<ContractModel> _departmentList =
            await _structuretypeRepository.getAllContract();
        contract.addAll(_departmentList);
        page++;
        print(page);
        yield FetchedContract();
      } catch (e) {
        yield ErrorAddingContract(error: e.toString());
      }
    }
  }
}