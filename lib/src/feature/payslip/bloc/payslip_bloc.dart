import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/payslip/bloc/payslip_event.dart';
import 'package:hotle_attendnce_admin/src/feature/payslip/bloc/payslip_state.dart';
import 'package:hotle_attendnce_admin/src/feature/payslip/model/payslip_model.dart';
import 'package:hotle_attendnce_admin/src/feature/payslip/repository/payslip_repository.dart';

class PayslipBloc extends Bloc<PayslipEvent, PayslipState> {
  PayslipBloc() : super(InitailizingPayslip());
  PayslipRepository _payslipRepository = PayslipRepository();
  List<PayslipModel> payslip = [];
  int rowperpage = 12;
  int page = 1;
  @override
  Stream<PayslipState> mapEventToState(PayslipEvent event) async* {
    if (event is InitailizePayslipStarted) {
      yield InitailizingPayslip();
      try {
        page = 1;
        payslip.clear();
        List<PayslipModel> _departmentList = await _payslipRepository
            .getPayslip(rowperpage: rowperpage, page: page);
        payslip.addAll(_departmentList);
        page++;
        print(page);
        yield InitailizedPayslip();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingPayslip(error: e.toString());
      }
    }
    if (event is RefreshPayslipStarted) {
      yield FetchingPayslip();
      try {
        page = 1;
        payslip.clear();
        List<PayslipModel> _departmentList = await _payslipRepository
            .getPayslip(rowperpage: rowperpage, page: page);
        payslip.addAll(_departmentList);
        page++;
        print(page);
        yield FetchedPayslip();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingPayslip(error: e.toString());
      }
    }
    if (event is FetchPayslipStarted) {
      yield FetchingPayslip();
      try {
        List<PayslipModel> _departmentList = await _payslipRepository
            .getPayslip(rowperpage: rowperpage, page: page);
        payslip.addAll(_departmentList);
        page++;
        print(page);
        if (_departmentList.length < rowperpage) {
          yield EndofPayslip();
        } else {
          yield FetchedPayslip();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingPayslip(error: e.toString());
      }
    }
    if (event is AddPayslipStarted) {
      yield AddingPayslip();
      try {
        await _payslipRepository.addPayslip(
            userId: event.userId,
            contractId: event.contractId,
            fromDate: event.fromDate,
            toDate: event.toDate,
            allowance: event.allowance,
            bonus: event.bonus,
            senioritySalary: event.senioritySalary,
            advanceMoney: event.advanceMoney,
            currey: event.currey,
            exChangeRate: event.exChangeRate,
            deduction: event.deduction);
        yield AddedPayslip();
        yield FetchingPayslip();
        payslip.clear();
        page = 1;
        List<PayslipModel> _departmentList = await _payslipRepository
            .getPayslip(rowperpage: rowperpage, page: page);
        payslip.addAll(_departmentList);
        page++;
        yield FetchedPayslip();
      } catch (e) {
        yield AddedPayslip();
      }
    }
    if (event is UpdatePayslipStarted) {
      yield AddingPayslip();
      try {
        await _payslipRepository.editPayslip(
            id: event.id,
            userId: event.userId,
            contractId: event.contractId,
            fromDate: event.fromDate,
            toDate: event.toDate,
            allowance: event.allowance,
            bonus: event.bonus,
            senioritySalary: event.senioritySalary,
            advanceMoney: event.advanceMoney,
            currey: event.currey,
            exChangeRate: event.exChangeRate,
            deduction: event.deduction);
        yield AddedPayslip();
        yield FetchingPayslip();
        payslip.clear();
        page = 1;
        List<PayslipModel> _departmentList = await _payslipRepository
            .getPayslip(rowperpage: rowperpage, page: page);
        payslip.addAll(_departmentList);
        page++;
        yield FetchedPayslip();
      } catch (e) {
        yield AddedPayslip();
      }
    }
    if (event is DeletePayslipStarted) {
      yield AddingPayslip();
      try {
        await _payslipRepository.deletePayslip(
          id: event.id,
        );
        yield AddedPayslip();
        yield FetchingPayslip();
        payslip.clear();
        page = 1;
        List<PayslipModel> _departmentList = await _payslipRepository
            .getPayslip(rowperpage: rowperpage, page: page);
        payslip.addAll(_departmentList);
        page++;
        yield FetchedPayslip();
      } catch (e) {
        yield AddedPayslip();
      }
    }
  }
}
