import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/config/routes/routes.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/bloc/timetable_bloc.dart';

import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'edit_timetable.dart';

TimetableBloc timetableBloc = TimetableBloc();

class TimetablePage extends StatefulWidget {
  const TimetablePage({Key? key}) : super(key: key);

  @override
  State<TimetablePage> createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context, "Timetable Page"),
      body: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          child: DepartmentBody()),
      floatingActionButton: Container(
        child: FloatingActionButton(
            backgroundColor: Colors.lightBlueAccent,
            child: Icon(Icons.add),
            elevation: 0,
            onPressed: () {
              Navigator.pushNamed(context, addTimetable);
            }),
      ),
    );
  }
}

class DepartmentBody extends StatefulWidget {
  const DepartmentBody({Key? key}) : super(key: key);

  @override
  State<DepartmentBody> createState() => _DepartmentBodyState();
}

class _DepartmentBodyState extends State<DepartmentBody> {
  final RefreshController _refreshController = RefreshController();
  void initState() {
    super.initState();

    timetableBloc.add(InitializeTimetableStarted());
  }

  @override
  Widget build(BuildContext context) {
    //  BlocProvider.of<WantedBloc>(context).add(FetchWantedStarted());

    return BlocConsumer(
        bloc: timetableBloc,
        builder: (context, state) {
          if (state is InitializingTimetable) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ErrorFetchingTimetable) {
            return Center(
              child: Text(state.error.toString()),
            );
          } else {
            if (timetableBloc.timetableList.length == 0) {
              return Center(
                child: Text("No Data"),
              );
            }
            print("length ${timetableBloc.timetableList.length}");

            return SmartRefresher(
              onRefresh: () {
                timetableBloc.add(RefreshTimetableStarted());
              },
              onLoading: () {
                timetableBloc.add(FetchTimetableStarted());
                _refreshController.loadComplete();
              },
              enablePullDown: true,
              enablePullUp: true,
              cacheExtent: 1,
              controller: _refreshController,
              child: ListView.builder(
                  itemCount: timetableBloc.timetableList.length,
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
                                    "Name :",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Text(
                                  "${timetableBloc.timetableList[index].timetableName}",
                                  style: TextStyle(
                                    color: Colors.green,
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
                                    "Time in :",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Text(
                                  "${timetableBloc.timetableList[index].onDutyTtime}",
                                  style: TextStyle(
                                    color: Colors.lightBlue,
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
                                  "${timetableBloc.timetableList[index].offDutyTime}",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                            Row(
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
                                              builder: (con) => EditTimetable(
                                                    timetableModel:
                                                        timetableBloc
                                                                .timetableList[
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
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Alert'),
                                              content: Text(
                                                  "Do want to delete this record?"),
                                              actions: <Widget>[
                                                FlatButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('No',
                                                      style: TextStyle(
                                                          color: Colors.red)),
                                                ),
                                                FlatButton(
                                                  onPressed: () {
                                                    print(
                                                        "id ${timetableBloc.timetableList[index].id}");
                                                    timetableBloc.add(
                                                        DeleteTimetableStarted(
                                                            id: timetableBloc
                                                                .timetableList[
                                                                    index]
                                                                .id));
                                                  },
                                                  child: Text(
                                                    'Yes',
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  ),
                                                ),
                                              ],
                                            );
                                          });
                                    }),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            );
          }
        },
        listener: (context, state) {
          if (state is FetchedTimetable) {
            _refreshController.loadComplete();
            _refreshController.refreshCompleted();
          }
          if (state is EndOfTimetableList) {
            _refreshController.loadNoData();
          }
          if (state is AddingTimetable) {
            EasyLoading.show(status: "loading....");
          } else if (state is ErrorAddingTimetable) {
            EasyLoading.dismiss();
            errorSnackBar(text: state.error.toString(), context: context);
          } else if (state is AddedTimetable) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess("Sucess");
          }
        });
  }
}
