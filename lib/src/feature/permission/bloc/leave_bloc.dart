import 'dart:developer';

import 'package:hotle_attendnce_admin/src/feature/levetype/model/leave_type_model.dart';
import 'package:hotle_attendnce_admin/src/feature/permission/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/permission/model/leave_model.dart';

import 'package:hotle_attendnce_admin/src/feature/permission/repository/leave_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  LeaveBloc() : super(InitializingLeave());
  List<LeaveTypeModel> leaveList = [];
  LeaveRepository leaveRepository = LeaveRepository();
  List<LeaveModel> leavemodel = [];
  int rowperpage = 12;
  int page = 1;
  @override
  Stream<LeaveState> mapEventToState(LeaveEvent event) async* {
    if (event is InitializeLeaveStarted) {
      yield InitializingLeave();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        List<LeaveModel> leaveList =
            await leaveRepository.getleave(page: page, rowperpage: rowperpage);
        leavemodel.addAll(leaveList);
        print(leaveList.length);
        page++;
        print(page);
        yield InitializedLeave();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingLeave(error: e.toString());
      }
    }
    if (event is FetchLeaveStarted) {
      yield FetchingLeave();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        // page = 1;
        List<LeaveModel> leaveList =
            await leaveRepository.getleave(page: page, rowperpage: rowperpage);
        leavemodel.addAll(leaveList);
        print(leaveList.length);
        page++;
        print(page);
        print(leaveList.length);
        if (leaveList.length < rowperpage) {
          yield EndOfLeaveList();
        } else {
          yield FetchedLeave();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingLeave(error: e.toString());
      }
    }
    if (event is RefreshLeaveStarted) {
      yield FetchingLeave();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        page = 1;
        if (leavemodel.length != 0) {
          leavemodel.clear();
        }
        List<LeaveModel> leaveList =
            await leaveRepository.getleave(page: page, rowperpage: rowperpage);
        leavemodel.addAll(leaveList);
        print(leaveList.length);
        // page++;
        yield FetchedLeave();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingLeave(error: e.toString());
      }
    }
    if (event is AddLeaveStarted) {
      yield AddingLeave();
      try {
        await leaveRepository.addleave(
            employeeId: event.employeeId,
            leavetypeId: event.leaveTypeId,
            reason: event.reason,
            number: event.number,
            fromDate: event.fromDate,
            // date: event.date,
            toDate: event.toDate);
        yield AddedLeave();
        yield FetchingLeave();
        print(leavemodel.length);
        leavemodel.clear();
        leavemodel =
            await leaveRepository.getleave(page: 1, rowperpage: rowperpage);
        print(leavemodel.length);
        yield FetchedLeave();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingLeave(error: e.toString());
      }
    }
    if (event is UpdateLeaveStarted) {
      yield AddingLeave();
      try {
        await leaveRepository.editleave(
            id: event.id,
            employeeId: event.employeeId,
            leavetypeId: event.leaveTypeId,
            reason: event.reason,
            number: event.number,
            fromDate: event.fromDate,
            // date: event.date,
            toDate: event.toDate);
        yield AddedLeave();
        yield FetchingLeave();
        print(leavemodel.length);
        leavemodel.clear();
        leavemodel =
            await leaveRepository.getleave(page: 1, rowperpage: rowperpage);
        print(leavemodel.length);
        yield FetchedLeave();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingLeave(error: e.toString());
      }
    }
    if (event is UpdateLeaveStatusStarted) {
      yield AddingLeave();
      try {
        await leaveRepository.editleaveStatus(
            id: event.id, status: event.status);
        yield AddedLeave();
        yield FetchingLeave();
        print(leavemodel.length);
        leavemodel.clear();
        leavemodel =
            await leaveRepository.getleave(page: 1, rowperpage: rowperpage);
        print(leavemodel.length);
        yield FetchedLeave();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingLeave(error: e.toString());
      }
    }
    if (event is DeleteLeaveStarted) {
      yield AddingLeave();
      try {
        await leaveRepository.deleteleave(
          id: event.id,
          // employeeId: event.employeeId,
        );
        yield AddedLeave();
        yield FetchingLeave();
        print(leavemodel.length);
        leavemodel =
            await leaveRepository.getleave(page: 1, rowperpage: rowperpage);
        print(leavemodel.length);
        yield FetchedLeave();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingLeave(error: e.toString());
      }
    }
  }
}
