import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/overtime/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/overtime/model/overtime_model.dart';
import 'package:hotle_attendnce_admin/src/feature/overtime/repository/overtime_repository.dart';
import 'package:hotle_attendnce_admin/src/utils/share/helper.dart';

class OvertimeBloc extends Bloc<OvertimeEvent, OvertimeState> {
  OvertimeBloc() : super(InitailizingOvertime());
  OvertimerRepository _overtimerRepository = OvertimerRepository();
  // for user
  List<OvertimeModel> overtimeList = [];
  // for chefif
  List<OvertimeModel> chieflList = [];

  int rowperpage = 12;
  String? dateRange;
  int page = 1;
  String? startDate;
  String? endDate;
  Helper helper = Helper();
  @override
  Stream<OvertimeState> mapEventToState(OvertimeEvent event) async* {
    if (event is InitailzeOvertimeStarted) {
      yield InitailizingOvertime();
      try {
        page = 1;
        overtimeList.clear();
        // like Today, this week , this month, this year
        dateRange = event.dateRange;
        setEndDateAndStartDate();
        print(startDate);
        print(endDate);

        // this function return start date and end date
        // Future.delayed(Duration(milliseconds: 200));
        List<OvertimeModel> leaveList = await _overtimerRepository.getOvertime(
            page: page,
            rowperpage: rowperpage,
            startDate: startDate!,
            endDate: endDate!);
        overtimeList.addAll(leaveList);
        print(leaveList.length);
        page++;
        print(page);
        print(leaveList.length);
        yield InitailizedOvertime();
      } catch (e) {
        yield ErrorFetchingOvertime(error: e.toString());
      }
    }
    // for role chief of department
    if (event is InitializeAllOvertimeStarted) {
      yield InitailizingOvertime();
      try {
        page = 1;
        chieflList.clear();
        // like Today, this week , this month, this year
        dateRange = event.dateRange;
        setEndDateAndStartDate();
        print(startDate);
        print(endDate);

        // this function return start date and end date
        // Future.delayed(Duration(milliseconds: 200));
        List<OvertimeModel> leaveList =
            await _overtimerRepository.getAllOvertime(
                page: page,
                rowperpage: rowperpage,
                startDate: startDate!,
                endDate: endDate!);
        chieflList.addAll(leaveList);
        print(leaveList.length);
        page++;
        print(page);
        print(leaveList.length);
        yield InitailizedOvertime();
      } catch (e) {
        yield ErrorFetchingOvertime(error: e.toString());
      }
    }
    if (event is FetchOvertimeStarted) {
      yield FetchingOvertime();

      try {
        print(overtimeList.length);
        dateRange = event.dateRange;
        setEndDateAndStartDate();
        print(startDate);
        print(endDate);

        // this function return start date and end date
        // Future.delayed(Duration(milliseconds: 200));
        List<OvertimeModel> leaveList = await _overtimerRepository.getOvertime(
            page: page,
            rowperpage: rowperpage,
            startDate: startDate!,
            endDate: endDate!);
        overtimeList.addAll(leaveList);
        print(leaveList.length);
        page++;
        print(page++);
        if (leaveList.length < rowperpage) {
          yield EndofOvertimeList();
        } else {
          print(leaveList.length);
          yield FetchedOvertime();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingOvertime(error: e.toString());
      }
    }
    if (event is FetchAllOvertimeStarted) {
      yield FetchingOvertime();

      try {
        print(chieflList.length);
        dateRange = event.dateRange;
        setEndDateAndStartDate();
        print(startDate);
        print(endDate);

        // this function return start date and end date
        // Future.delayed(Duration(milliseconds: 200));
        List<OvertimeModel> leaveList =
            await _overtimerRepository.getAllOvertime(
                page: page,
                rowperpage: rowperpage,
                startDate: startDate!,
                endDate: endDate!);
        chieflList.addAll(leaveList);
        print(leaveList.length);
        page++;
        print(page++);
        if (leaveList.length < rowperpage) {
          yield EndofOvertimeList();
        } else {
          print(leaveList.length);
          yield FetchedOvertime();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingOvertime(error: e.toString());
      }
    }
    if (event is RefreshOvertimeStarted) {
      yield FetchingOvertime();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        page = 1;
        overtimeList.clear();
        List<OvertimeModel> leaveList = await _overtimerRepository.getOvertime(
            page: page,
            rowperpage: rowperpage,
            startDate: startDate!,
            endDate: endDate!);

        overtimeList.addAll(leaveList);
        print(leaveList.length);
        page++;
        // page++;
        yield FetchedOvertime();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingOvertime(error: e.toString());
      }
    }
    if (event is RefreshAllOvertimeStarted) {
      yield FetchingOvertime();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        page = 1;
        chieflList.clear();
        List<OvertimeModel> leaveList =
            await _overtimerRepository.getAllOvertime(
                page: page,
                rowperpage: rowperpage,
                startDate: startDate!,
                endDate: endDate!);

        chieflList.addAll(leaveList);
        print(leaveList.length);
        page++;
        // page++;
        yield FetchedOvertime();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingOvertime(error: e.toString());
      }
    }
    // update status overtime accpet or not for user
    if (event is UpdateOvertimeStatusStarted) {
      yield AddingOvertime();
      try {
        await _overtimerRepository.editStatusOvertime(
            id: event.id, status: event.status, type: event.paytype);
        yield AddedOvertime();
        yield FetchingOvertime();
        overtimeList.clear();
        page = 1;
        // this week is default
        dateRange = "This week";
        setEndDateAndStartDate();
        List<OvertimeModel> leaveList = await _overtimerRepository.getOvertime(
            page: page,
            rowperpage: rowperpage,
            startDate: startDate!,
            endDate: endDate!);
        overtimeList.addAll(leaveList);
        print(leaveList.length);
        page++;
        yield FetchedOvertime();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingOvertime(error: e.toString());
      }
    }
    // add ,edit and delete overtime for cheif
    if (event is AddOvertimeStarted) {
      yield AddingOvertime();
      try {
        await _overtimerRepository.addOvertime(
            userId: event.userId,
            reason: event.reason,
            duration: event.duration,
            fromDate: event.fromDate,
            notes: event.notes,
            toDate: event.toDate);
        yield AddedOvertime();
        yield FetchingOvertime();
        chieflList.clear();
        page = 1;
        // this week is default
        dateRange = "This week";
        setEndDateAndStartDate();
        List<OvertimeModel> leaveList =
            await _overtimerRepository.getAllOvertime(
                page: page,
                rowperpage: rowperpage,
                startDate: startDate!,
                endDate: endDate!);
        chieflList.addAll(leaveList);
        print(leaveList.length);
        page++;
        yield FetchedOvertime();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingOvertime(error: e.toString());
      }
    }
    if (event is UpdateOvertimeStarted) {
      yield AddingOvertime();
      try {
        await _overtimerRepository.editOvertime(
            id: event.id,
            userId: event.userId,
            reason: event.reason,
            duration: event.duration,
            fromDate: event.fromDate,
            notes: event.notes,
            toDate: event.toDate);
        yield AddedOvertime();
        yield FetchingOvertime();
        chieflList.clear();
        page = 1;
        // this week is default
        dateRange = "This week";
        setEndDateAndStartDate();
        List<OvertimeModel> leaveList =
            await _overtimerRepository.getAllOvertime(
                page: page,
                rowperpage: rowperpage,
                startDate: startDate!,
                endDate: endDate!);
        chieflList.addAll(leaveList);
        print(leaveList.length);
        page++;
        yield FetchedOvertime();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingOvertime(error: e.toString());
      }
    }
    if (event is DeleteOvertimeStarted) {
      yield AddingOvertime();
      try {
        await _overtimerRepository.deleteOvertime(
          id: event.id,
        );
        yield AddedOvertime();
        yield FetchingOvertime();
        chieflList.clear();
        page = 1;
        // this week is default
        dateRange = "This week";
        setEndDateAndStartDate();
        List<OvertimeModel> leaveList =
            await _overtimerRepository.getAllOvertime(
                page: page,
                rowperpage: rowperpage,
                startDate: startDate!,
                endDate: endDate!);
        chieflList.addAll(leaveList);
        print(leaveList.length);
        page++;
        yield FetchedOvertime();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingOvertime(error: e.toString());
      }
    }
  }

  void setEndDateAndStartDate() {
    DateTime now = DateTime.now();
    if (dateRange == "Today") {
      dateRange = "Today";
      startDate =
          "${now.year}-${helper.intToStringWithPrefixZero(now.month)}-${helper.intToStringWithPrefixZero(now.day)}";
      endDate =
          "${now.year}-${helper.intToStringWithPrefixZero(now.month)}-${helper.intToStringWithPrefixZero(now.day)} 23:59:59";
    } else if (dateRange == "This week") {
      dateRange = "This week";
      DateTime startDateThisWeek = helper.findFirstDateOfTheWeek(now);
      DateTime endDateThisWeek = helper.findLastDateOfTheWeek(now);
      startDate =
          "${now.year}-${helper.intToStringWithPrefixZero(startDateThisWeek.month)}-${helper.intToStringWithPrefixZero(startDateThisWeek.day)}";
      if (helper.intToStringWithPrefixZero(startDateThisWeek.month) == "12" &&
          (helper.intToStringWithPrefixZero(endDateThisWeek.month) == "01")) {
        endDate =
            "${now.year + 1}-${helper.intToStringWithPrefixZero(endDateThisWeek.month)}-${helper.intToStringWithPrefixZero(endDateThisWeek.day)} 23:59:59";
      } else {
        endDate =
            "${now.year}-${helper.intToStringWithPrefixZero(endDateThisWeek.month)}-${helper.intToStringWithPrefixZero(endDateThisWeek.day)} 23:59:59";
      }
    } else if (dateRange == "This month") {
      dateRange = "This month";
      DateTime lastDateOfMonth = DateTime(now.year, now.month + 1, 0);
      startDate =
          "${now.year}-${helper.intToStringWithPrefixZero(now.month)}-01";
      endDate =
          "${now.year}-${helper.intToStringWithPrefixZero(now.month)}-${helper.intToStringWithPrefixZero(lastDateOfMonth.day)} 23:59:59";
    } else if (dateRange == "This year") {
      dateRange = "This year";
      DateTime lastDateOfYear = DateTime(now.year + 1, 1, 0);
      startDate = "${now.year}-01-01";
      endDate =
          "${now.year}-12-${helper.intToStringWithPrefixZero(lastDateOfYear.day)} 23:59:59";
    } else {
      startDate = dateRange!.split("/").first;
      endDate = dateRange!.split("/").last + " 23:59:59";
      dateRange = "$startDate to ${dateRange!.split("/").last}";
    }
  }
}
