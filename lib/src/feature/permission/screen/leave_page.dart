

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/feature/permission/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/loadin_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/utils/share/helper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
  @override
  void initState() {
    super.initState();

    leaveBloc.add(InitializeLeaveStarted());
  }

  @override
  Widget build(BuildContext context) {
    //  BlocProvider.of<WantedBloc>(context).add(FetchWantedStarted());

    return BlocConsumer(
        bloc: leaveBloc,
        builder: (context, state) {
          if (state is InitializingLeave) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ErrorFetchingLeave) {
            return Center(
              child: Text(state.error),
            );
          } else {
            if (leaveBloc.leavemodel.length == 0) {
              return Center(
                child: Text("No Data"),
              );
            }
            print("length ${leaveBloc.leavemodel.length}");

            return SmartRefresher(
              onRefresh: () {
                leaveBloc.add(RefreshLeaveStarted());
              },
              onLoading: () {
                leaveBloc.add(FetchLeaveStarted());
                _refreshController.loadComplete();
                // if (BlocProvider.of<LeaveBloc>(context).state
                //     is EndOfLeaveList) {
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
              child: ListView.builder(
                  itemCount: leaveBloc.leavemodel.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin:
                          EdgeInsets.only(bottom: 10.0, left: 8.0, right: 8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(6.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 3,
                            offset: Offset(0, 0), // changes position of shadow
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
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    "Date :",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Text(
                                  "${leaveBloc.leavemodel[index].date}",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
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
                                    "Employee name :",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Text(
                                  "${leaveBloc.leavemodel[index].employeeModel!.name}",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Text(
                                    "Reason :",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${leaveBloc.leavemodel[index].reason} ",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
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
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Text(
                                    "Duration :",
                                    style: TextStyle(color: Colors.black),
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
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Text(
                                    "From date :",
                                    style: TextStyle(color: Colors.black),
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
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Text(
                                    "Status :",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Text(
                                  "${leaveBloc.leavemodel[index].status}",
                                ),
                              ],
                            ),
                            leaveBloc.leavemodel[index].status == "pending"
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      CupertinoButton(
                                          padding: EdgeInsets.all(1.0),
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
                                                    builder: (con) =>
                                                        EditLeaveStatus(
                                                          leaveModel: leaveBloc
                                                                  .leavemodel[
                                                              index],
                                                        )));
                                          }),
                                      SizedBox(
                                        width: 5,
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
                                            print(
                                                "id ${leaveBloc.leavemodel[index].id}");
                                            leaveBloc.add(DeleteLeaveStarted(
                                                id: leaveBloc
                                                    .leavemodel[index].id));
                                          }),
                                    ],
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    );
                  }),
            );
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
}