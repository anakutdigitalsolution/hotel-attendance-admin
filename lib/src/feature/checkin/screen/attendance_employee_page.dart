import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hotle_attendnce_admin/src/feature/checkin/bloc/checkin_out_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/checkin/bloc/checkin_out_state.dart';
import 'package:hotle_attendnce_admin/src/feature/checkin/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/checkin/screen/widget/attendance_tile.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/loadin_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// EmployeeBloc employeeBloc = EmployeeBloc();

class AttendanceEmployeePage extends StatelessWidget {
  const AttendanceEmployeePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: standardAppBar(context, "Employee Attendance"),
      body: Container(
        child: Body(),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  DateTime? date;
  DateTime dateNow = DateTime.now();
  String? checkin;
  String? data;
  String? checkinTime;
  @override
  void initState() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MM/dd/yyyy kk:mm:ss').format(now);
    // String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);
    checkin = formattedDate.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<EmployeeBloc>(context).add(InitializeEmployeeStarted());
    final RefreshController _refreshController = RefreshController();
    return BlocBuilder<EmployeeBloc, EmployeeState>(builder: (context, state) {
      if (state is FetchingEmployee) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is ErrorFetchingEmployee) {
        return Center(
          child: Text(state.error.toString()),
        );
      }

      return BlocListener<CheckInOutBloc, CheckInOutState>(
        listener: (context, state) {
          // if (state is FetchedEmployee) {}
        },
        child: BlocListener<CheckInOutBloc, CheckInOutState>(
          listener: (context, state) {
            if (state is AddingCheckin) {
              EasyLoading.show(status: "loading....");
            }
            if (state is ErrorAddingCheckInOut) {
              EasyLoading.dismiss();
              EasyLoading.showToast(state.error.toString());
            }
            if (state is AddedCheckin) {
              EasyLoading.dismiss();
              EasyLoading.showSuccess("Sucess");
              BlocProvider.of<EmployeeBloc>(context)
                  .add(RefreshEmployeeStarted());
            }
          },
          child: SmartRefresher(
            onRefresh: () {
              // BlocProvider.of<TimetableBloc>(context).add(RefreshTimetableStarted());
            },
            onLoading: () {
              // if (BlocProvider.of<TimetableBloc>(context).state
              //     is EndOfTimetableList) {
              // } else {
              //   // BlocProvider.of<ProductListingBloc>(context)
              //   //     .add(FetchProductListStarted(arg: widget.category.id));
              // }
              // BlocProvider.of<LeaveBloc>(context).add(FetchLeaveStarted());
            },
            enablePullDown: true,
            enablePullUp: true,
            cacheExtent: 1,
            controller: _refreshController,
            child: SingleChildScrollView(
              child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: StaggeredGrid.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: [
                      ...BlocProvider.of<EmployeeBloc>(context)
                          .emploList
                          .map((e) => AttendanceTile(
                                employeeModel: e,
                              ))
                    ],
                  )),
            ),
          ),
        ),
      );
    });
  }
}
