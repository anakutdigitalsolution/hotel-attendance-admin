import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/holiday/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/holiday/model/holiday_model.dart';
import 'package:hotle_attendnce_admin/src/feature/holiday/repository/holiday_repository.dart';

class HolidayBloc extends Bloc<HolidayEvent, HolidayState> {
  HolidayBloc() : super(FetchingHoliday());
  // List<HolidayModel> leaveList = [];
  HolidayRepository leaveRepository = HolidayRepository();
  List<HolidayModel> holidaylist = [];
  int rowperpage = 12;
  int page = 1;
  @override
  Stream<HolidayState> mapEventToState(HolidayEvent event) async* {
    if (event is FetchHolidayStarted) {
      yield FetchingHoliday();
      try {
        print(page);
        // holidaylist.clear();
        List<HolidayModel> _templist = await leaveRepository.getHoliday(
            page: page, rowperpage: rowperpage);
        holidaylist.addAll(_templist);
        // leavemodel.addAll(leaveList);
        print(holidaylist.length);
        page++;
        print("page $page");
        print(_templist.length);
        if (_templist.length < rowperpage) {
          yield EndOfHolidayList();
        } else {
          yield FetchedHoliday();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingHoliday(error: e.toString());
      }
    }
    if (event is InitializeHolidayStarted) {
      yield InitializingHoliday();
      try {
        // page = 1;
        // holidaylist.clear();
        List<HolidayModel> _templist = await leaveRepository.getHoliday(
            page: page, rowperpage: rowperpage);
        holidaylist.addAll(_templist);
        // leavemodel.addAll(leaveList);
        print(holidaylist.length);
        page++;
        print("page $page");
        print(holidaylist.length);
        yield InitializedHoliday();

        // if (holidaylist.length < rowperpage) {
        //   yield EndOfHolidayList();
        // } else {
        //   yield InitializedHoliday();
        // }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingHoliday(error: e.toString());
      }
    }
    if (event is RefreshHolidayStarted) {
      yield FetchingHoliday();
      try {
        page = 1;
        print(page);
        // if (holidaylist.length != 0) {
        //   holidaylist.clear();
        // }
        holidaylist.clear();
        List<HolidayModel> leaveList =
            await leaveRepository.getHoliday(page: 1, rowperpage: rowperpage);
        holidaylist.addAll(leaveList);
        print(leaveList.length);
        yield FetchedHoliday();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingHoliday(error: e.toString());
      }
    }
    if (event is AddHolidayStarted) {
      yield AddingHoliday();
      try {
        await leaveRepository.addHoliday(
            name: event.name,
            fromDate: event.fromDate,
            toDate: event.toDate,
            notes: event.note);
        yield AddedHoliday();
        yield FetchingHoliday();
        holidaylist.clear();
        holidaylist =
            await leaveRepository.getHoliday(page: 1, rowperpage: rowperpage);
        print(holidaylist.length);
        yield FetchedHoliday();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingHoliday(error: e.toString());
      }
    }
    if (event is UpdateHolidayStarted) {
      yield AddingHoliday();
      try {
        await leaveRepository.editHoliday(
            id: event.id,
            name: event.name,
            fromDate: event.fromDate,
            toDate: event.toDate,
            notes: event.note);
        yield AddedHoliday();
        yield FetchingHoliday();
        holidaylist.clear();
        holidaylist =
            await leaveRepository.getHoliday(page: 1, rowperpage: rowperpage);
        print(holidaylist.length);
        yield FetchedHoliday();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingHoliday(error: e.toString());
      }
    }
    if (event is DeleteHolidayStarted) {
      yield AddingHoliday();
      try {
        await leaveRepository.deleteHoliday(id: event.id);
        yield AddedHoliday();
        yield FetchingHoliday();
        holidaylist.clear();
        holidaylist =
            await leaveRepository.getHoliday(page: 1, rowperpage: rowperpage);
        print(holidaylist.length);
        yield FetchedHoliday();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingHoliday(error: e.toString());
      }
    }
  }
}
