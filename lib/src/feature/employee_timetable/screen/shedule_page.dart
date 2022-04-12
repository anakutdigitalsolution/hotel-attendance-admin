import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/feature/employee_timetable/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/model/timetable_model.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/loadin_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'add_schedule.dart';

EmployeeTimetableBloc employeeTimetableBloc = EmployeeTimetableBloc();

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: standardAppBar(context, "Employee Schedule"),
      body: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10), child: Body()),
      floatingActionButton: Container(
        child: FloatingActionButton(
            backgroundColor: Colors.lightBlueAccent,
            child: Icon(Icons.add),
            elevation: 0,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddSchedule()));
            }),
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
  final RefreshController _refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    employeeTimetableBloc.add(FetchEmloyeeTimetableStarted());
    return BlocBuilder(
      bloc: employeeTimetableBloc,
      builder: (context, state) {
        if (state is FetchingEmployeeTimetable) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ErrorFetchingEmployeeTimetable) {
          return Center(
            child: Text(state.error.toString()),
          );
        } else {
          if (employeeTimetableBloc.timeList.length == 0) {
            return Center(
              child: Text("No Data"),
            );
          }
          print("length ${employeeTimetableBloc.timeList.length}");

          return BlocListener(
            bloc: employeeTimetableBloc,
            listener: (context, state) {
              if (state is FetchedEmployeeTimetable) {
                _refreshController.loadComplete();
                _refreshController.refreshCompleted();
              }
              if (state is EndofEmployeeTimetable) {
                _refreshController.loadNoData();
              }
              if (state is AddingEmployeeTimetable) {
                EasyLoading.show(status: "loading....");
              } else if (state is ErrorAddingEmployeeTimetable) {
                Navigator.pop(context);
                errorSnackBar(text: state.error.toString(), context: context);
              } else if (state is AddedEmployeeTimetable) {
                EasyLoading.dismiss();
                EasyLoading.showSuccess("Sucess");
              }
            },
            child: SmartRefresher(
              onRefresh: () {
                employeeTimetableBloc.add(RefreshEmployeeTimetableStarted());
              },
              onLoading: () {
                employeeTimetableBloc.add(FetchEmloyeeTimetableStarted());
                _refreshController.loadComplete();
                // if (BlocProvider.of<EmployeeBloc>(context).state
                //     is EndofEmployeeList) {
                // } else {
                // BlocProvider.of<ProductListingBloc>(context)
                //     .add(FetchProductListStarted(arg: widget.category.id));
                // }
                // BlocProvider.of<LeaveBloc>(context).add(FetchLeaveStarted());
              },
              enablePullDown: true,
              enablePullUp: true,
              cacheExtent: 1,
              controller: _refreshController,
              child: ListView.builder(
                  itemCount: employeeTimetableBloc
                      .timeList
                      .length,
                  itemBuilder: (context, index) {
                    return employeeTimetableBloc
                                .timeList[index]
                                .timetableList!
                                .length ==
                            0
                        ? Container()
                        : Container(
                            color: Colors.white,
                            margin: EdgeInsets.only(bottom: 10),
                            child: TextButton(
                                style: TextButton.styleFrom(
                                  // backgroundColor: Colors.blue,
                                  padding: EdgeInsets.all(20),
                                ),
                                onPressed: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => EmployeeDetailPage(
                                  //             employeeModel:
                                  //                 BlocProvider.of<EmployeeBloc>(
                                  //                         context)
                                  //                     .emploList[index])));
                                },
                                child: Row(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: Colors.grey[300]),
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                        )),
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                employeeTimetableBloc
                                                    .timeList[index]
                                                    .employeeModel
                                                    .name,
                                                textAlign: TextAlign.right,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1,
                                              ),
                                              // AspectRatio(aspectRatio: 1)
                                            ],
                                          ),
                                          _buildTimetable(employeeTimetableBloc
                                              .timeList[index]
                                              .timetableList!)

                                          // BlocProvider.of<EmployeeTimetableBloc>(
                                          //                 context)
                                          //             .timeList[index]
                                          //             .employeeModel
                                          //             .phone ==
                                          //         null
                                          //     ? Text("")
                                          //     : Text(
                                          //         BlocProvider.of<
                                          //                     EmployeeTimetableBloc>(
                                          //                 context)
                                          //             .timeList[index]
                                          //             .employeeModel
                                          //             .phone!,
                                          //         style: Theme.of(context)
                                          //             .textTheme
                                          //             .subtitle2,
                                          //         textAlign: TextAlign.right,
                                          //       ),
                                          // SizedBox(height: 10),

                                          // Text(
                                          //         ": ${customer.balance}",
                                          //         style: Theme.of(context)
                                          //             .textTheme
                                          //             .subtitle2!
                                          //             .copyWith(color: Colors.orange[700]),
                                          //         textAlign: TextAlign.right,
                                          //       ),
                                          // customer.point == null ||
                                          //         customer.point == "null" ||
                                          //         (customer.point == "0")
                                          //     ? Center()
                                          //     : Container(
                                          //         margin: EdgeInsets.only(top: 10),
                                          //         child: Text(
                                          //           "${AppLocalizations.of(context)!.translate("point")!} : ${customer.point}",
                                          //           style: Theme.of(context)
                                          //               .textTheme
                                          //               .subtitle2!
                                          //               .copyWith(color: Colors.purple[700]),
                                          //           textAlign: TextAlign.right,
                                          //         ),
                                        ],
                                      ),
                                    ),
                                    CupertinoButton(
                                        padding: EdgeInsets.all(1.0),
                                        color: Colors.green,
                                        child: Row(
                                          children: [
                                            Icon(Icons.edit),
                                          ],
                                        ),
                                        onPressed: () {
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (con) => EditEmployee(
                                          //               employeeModel: BlocProvider
                                          //                       .of<EmployeeBloc>(
                                          //                           context)
                                          //                   .emploList[index],
                                          //             )));
                                        }),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    CupertinoButton(
                                        padding: EdgeInsets.all(1.0),
                                        color: Colors.red,
                                        child: Row(
                                          children: [
                                            Icon(Icons.delete),
                                          ],
                                        ),
                                        onPressed: () {
                                          // print(
                                          //     "id ${BlocProvider.of<EmployeeBloc>(context).emploList[index].id}");
                                          // BlocProvider.of<EmployeeBloc>(context).add(
                                          //     DeleteEmployeeStarted(
                                          //         id: BlocProvider.of<EmployeeBloc>(
                                          //                 context)
                                          //             .emploList[index]
                                          //             .id));
                                        }),
                                  ],
                                )),
                          );
                  }),
            ),
          );
        }
      },
    );
  }

  _buildTimetable(List<TimetableModel> time) {
    return Container(
      height: 50,
      child: ListView.builder(
          itemCount: time.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Row(
                  // mainAxisAlignment:
                  //     MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        "Time in :",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Text(
                      "${time[index].onDutyTtime}",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  // mainAxisAlignment:
                  //     MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        "Time out :",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Text(
                      "${time[index].offDutyTime}",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
              ],
            );
          }),
    );
  }
}
