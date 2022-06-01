import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/feature/permission/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/loadin_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/utils/share/helper.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';

import 'edit_leave_status.dart';

LeaveBloc leaveBloc = LeaveBloc();

class LeavePage extends StatefulWidget {
  @override
  _LeavePageState createState() => _LeavePageState();
}

class _LeavePageState extends State<LeavePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context, "Leave Page"),
      body: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        child: WantedBody(),
      ),
      // floatingActionButton: Container(
      //   child: FloatingActionButton(
      //       backgroundColor: Colors.lightBlueAccent,
      //       child: Icon(Icons.add),
      //       elevation: 0,
      //       onPressed: () {
      //         Navigator.push(
      //             context, MaterialPageRoute(builder: (context) => AddLeave()));
      //       }),
      // ),
    );
  }
}

class WantedBody extends StatefulWidget {
  @override
  _WantedBodyState createState() => _WantedBodyState();
}

class _WantedBodyState extends State<WantedBody> {
  final RefreshController _refreshController = RefreshController();
  String mydateRage = "This week";
  @override
  void initState() {
    leaveBloc.add(InitializeLeaveStarted(dateRange: "This week"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  BlocProvider.of<WantedBloc>(context).add(FetchWantedStarted());

    return BlocConsumer(
        bloc: leaveBloc,
        builder: (context, state) {
          if (state is InitializingLeave) {
            return Center(
              // child: CircularProgressIndicator(),
              child: Lottie.asset('assets/animation/loader.json',
                  width: 200, height: 200),
            );
          } else if (state is ErrorFetchingLeave) {
            return Center(
              child: Text(state.error),
            );
          } else {
            return Column(
              children: [
                // user condition to avoid null and cause error while data is fetching
                leaveBloc.dateRange == null
                    ? Container()
                    : Container(
                        padding: EdgeInsets.only(left: 20),
                        alignment: Alignment.centerLeft,
                        child: DropdownButton<String>(
                          hint: leaveBloc.dateRange!.contains("to")
                              ? Text("${leaveBloc.dateRange!}")
                              : Text(
                                  // leaveBloc.dateRange!,
                                  // _reportBloc.dateRange!.contains("to")
                                  //     ? _reportBloc.dateRange!
                                  //     :W
                                  "${leaveBloc.dateRange!}",
                                  textScaleFactor: 1,
                                ),
                          items: [
                            'Today',
                            'This week',
                            'This month',
                            'This year',
                            "Custom"
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value == "Custom") {
                              showPickerDateRange(context);
                            } else {
                              setState(() {
                                mydateRage = value!;
                                print("myvalue $mydateRage");
                                print(mydateRage);
                              });
                              leaveBloc.add(
                                  InitializeLeaveStarted(dateRange: value));
                            }
                          },
                        ),
                      ),
                Container(
                  width: double.infinity,
                  height: 10,
                  color: Colors.transparent,
                ),
                leaveBloc.leavemodel.length == 0
                    ? Container(
                        child: Text("No data"),
                      )
                    : Expanded(
                        child: SmartRefresher(
                        onRefresh: () {
                          print("fetch dateRange");
                          print(mydateRage);
                          leaveBloc
                              .add(RefreshLeaveStarted(dateRange: mydateRage));
                        },
                        onLoading: () {
                          print("fetch dateRange");
                          print(mydateRage);
                          leaveBloc
                              .add(FetchLeaveStarted(dateRange: mydateRage));
                        },
                        enablePullDown: true,
                        enablePullUp: true,
                        controller: _refreshController,
                        child: SingleChildScrollView(
                          child: Column(
                            // addAutomaticKeepAlives: true,
                            children: [
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  // padding: EdgeIns
                                  cacheExtent: 1000,
                                  itemCount: leaveBloc.leavemodel.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(
                                          bottom: 10.0, left: 8.0, right: 8.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Colors.grey.withOpacity(0.2)),
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 0,
                                            blurRadius: 3,
                                            offset: Offset(0,
                                                0), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              // mainAxisAlignment:
                                              //     MainAxisAlignment.spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: Text(
                                                    "Date :",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  "${leaveBloc.leavemodel[index].date}",
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold),
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: Text(
                                                    "Employee name :",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  "${leaveBloc.leavemodel[index].employeeModel!.name}",
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8),
                                                  child: Text(
                                                    "Reason :",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "${leaveBloc.leavemodel[index].reason} ",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    // Text("- "),
                                                    // Text(
                                                    //   " ${BlocProvider.of<WantedBloc>(context).wantedList[index].maxPrice}",
                                                    //   style: TextStyle(
                                                    //       color: Colors.red,
                                                    //       fontWeight: FontWeight.bold),
                                                    // ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8),
                                                  child: Text(
                                                    "Duration :",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  "${leaveBloc.leavemodel[index].number}",
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8),
                                                  child: Text(
                                                    "From date :",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  "${leaveBloc.leavemodel[index].fromDate}",
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8),
                                                  child: Text(
                                                    "Status :",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Text(
                                                  "${leaveBloc.leavemodel[index].status}",
                                                ),
                                              ],
                                            ),
                                            leaveBloc.leavemodel[index]
                                                        .status ==
                                                    "pending"
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      CupertinoButton(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  1.0),
                                                          color: Colors.green,
                                                          child: Row(
                                                            children: [
                                                              Icon(Icons.edit),
                                                            ],
                                                          ),
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (con) =>
                                                                            EditLeaveStatus(
                                                                              leaveModel: leaveBloc.leavemodel[index],
                                                                            )));
                                                          }),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      CupertinoButton(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  1.0),
                                                          color: Colors.red,
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                  Icons.delete),
                                                            ],
                                                          ),
                                                          onPressed: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return AlertDialog(
                                                                    title: Text(
                                                                        'Alert'),
                                                                    content: Text(
                                                                        "Do want to delete this record?"),
                                                                    actions: <
                                                                        Widget>[
                                                                      FlatButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child: Text(
                                                                            'No',
                                                                            style:
                                                                                TextStyle(color: Colors.red)),
                                                                      ),
                                                                      FlatButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                          print(
                                                                              "id ${leaveBloc.leavemodel[index].id}");
                                                                          leaveBloc
                                                                              .add(DeleteLeaveStarted(id: leaveBloc.leavemodel[index].id));
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          'Yes',
                                                                          style:
                                                                              TextStyle(color: Colors.blue),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  );
                                                                });
                                                          }),
                                                    ],
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                      ),
                                    );
                                  })
                            ],
                          ),
                        ),
                      )),
              ],
            );
            // if (leaveBloc.leavemodel.length == 0) {
            //   return Center(
            //     child: Text("No Data"),
            //   );
            // }

          }
        },
        listener: (context, state) {
          if (state is ErrorFetchingLeave) {
            Helper.handleState(state: state, context: context);
          }
          if (state is FetchedLeave) {
            _refreshController.loadComplete();
            _refreshController.refreshCompleted();
          }
          if (state is EndOfLeaveList) {
            _refreshController.loadNoData();
          }
          if (state is AddingLeave) {
            EasyLoading.show(status: "loading....");
          } else if (state is ErrorAddingLeave) {
            Navigator.pop(context);
            errorSnackBar(text: state.error.toString(), context: context);
          } else if (state is AddedLeave) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess("Sucess");
          }
        });
  }

  showPickerDateRange(BuildContext context) {
    String? _startDate;
    String? _endDate;

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    Picker ps = Picker(
        confirmText: "Confirm",
        cancelText: "Cancel",
        hideHeader: true,
        adapter: DateTimePickerAdapter(
            type: PickerDateTimeType.kYMD, isNumberMonth: false),
        onConfirm: (Picker picker, List value) {
          _startDate = formatter
              .format((picker.adapter as DateTimePickerAdapter).value!);
        });

    Picker pe = Picker(
        hideHeader: true,
        adapter: DateTimePickerAdapter(type: PickerDateTimeType.kYMD),
        onConfirm: (Picker picker, List value) {
          _endDate = formatter
              .format((picker.adapter as DateTimePickerAdapter).value!);
        });

    List<Widget> actions = [
      TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(PickerLocalizations.of(context).cancelText!)),
      TextButton(
          onPressed: () {
            Navigator.pop(context);
            ps.onConfirm!(ps, ps.selecteds);
            pe.onConfirm!(pe, pe.selecteds);
            leaveBloc.add(
                InitializeLeaveStarted(dateRange: "$_startDate/$_endDate"));
          },
          child: Text(PickerLocalizations.of(context).confirmText!))
    ];

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Select Date"),
            actions: actions,
            content: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Start :"),
                  ps.makePicker(),
                  Text("End :"),
                  pe.makePicker()
                ],
              ),
            ),
          );
        });
  }
}
