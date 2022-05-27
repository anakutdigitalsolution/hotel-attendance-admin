import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/config/routes/routes.dart';
import 'package:hotle_attendnce_admin/src/feature/holiday/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/holiday/screen/edit_holiday.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

HolidayBloc holidayBloc = HolidayBloc();

class HolidayPage extends StatelessWidget {
  const HolidayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context, "Holiday page"),
      body: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        child: Body(),
      ),
      floatingActionButton: Container(
        child: FloatingActionButton(
            backgroundColor: Colors.lightBlueAccent,
            child: Icon(Icons.add),
            elevation: 0,
            onPressed: () {
              Navigator.pushNamed(context, addHoliday);
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
  void initState() {
    super.initState();
    holidayBloc.holidaylist.clear();
    holidayBloc.page = 1;
    holidayBloc.add(InitializeHolidayStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: holidayBloc,
      listener: (context, state) {
        if (state is FetchedHoliday) {
          _refreshController.loadComplete();
          _refreshController.refreshCompleted();
        }
        if (state is EndOfHolidayList) {
          print("nodata");
          _refreshController.loadNoData();
        }
        if (state is AddingHoliday) {
          EasyLoading.show(status: "loading....");
        }
        if (state is ErrorAddingHoliday) {
          EasyLoading.dismiss();
          errorSnackBar(text: state.error.toString(), context: context);
        }
        if (state is AddedHoliday) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess("Sucess");
        }
      },
      builder: (context, state) {
        if (state is InitializingHoliday) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ErrorFetchingHoliday) {
          return Center(
            child: Text(state.error.toString()),
          );
        } else {
          if (holidayBloc.holidaylist.length == 0) {
            return Center(
              child: Text("No data"),
            );
          }
          return SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            cacheExtent: 1,
            controller: _refreshController,
            onRefresh: () {
              holidayBloc.add(RefreshHolidayStarted());
            },
            onLoading: () {
              if (holidayBloc.state is EndOfHolidayList) {
                _refreshController.loadNoData();
                print("no data");
              } else {
                holidayBloc.add(FetchHolidayStarted());
              }

              // _refreshController.loadComplete();
              // _refreshController.loadNoData();
            },
            child: ListView.builder(
                itemCount: holidayBloc.holidaylist.length,
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
                                "${holidayBloc.holidaylist[index].name}",
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
                                  "Notes :",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${holidayBloc.holidaylist[index].notes} ",
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
                                "${holidayBloc.holidaylist[index].fromDate}",
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
                                "${holidayBloc.holidaylist[index].status}",
                              ),
                            ],
                          ),
                          holidayBloc.holidaylist[index].status == "pending"
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
                                                  builder: (con) => EditHoliday(
                                                      holidayModel: holidayBloc
                                                              .holidaylist[
                                                          index])));
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
                                                              color:
                                                                  Colors.red)),
                                                    ),
                                                    FlatButton(
                                                      onPressed: () {
                                                        showDialog(
                                                            context: context,
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
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.red)),
                                                                  ),
                                                   
                                                                    FlatButton(
                                                                    onPressed:
                                                                        () {
                                                                      showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (BuildContext context) {
                                                                            return AlertDialog(
                                                                              title: Text('Alert'),
                                                                              content: Text("Do want to delete this record?"),
                                                                              actions: <Widget>[
                                                                                FlatButton(
                                                                                  onPressed: () {
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child: Text('No', style: TextStyle(color: Colors.red)),
                                                                                ),
                                                                                FlatButton(
                                                                                  onPressed: () {
                                                                                    print("id ${holidayBloc.holidaylist[index].id}");
                                                                                    holidayBloc.add(DeleteHolidayStarted(id: holidayBloc.holidaylist[index].id));
                                                                                  },
                                                                                  child: Text(
                                                                                    'Yes',
                                                                                    style: TextStyle(color: Colors.blue),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            );
                                                                          });
                                                                    },
                                                                    child: Text(
                                                                      'Yes',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.blue),
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
                                                            });
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
                              : Container(),
                        ],
                      ),
                    ),
                  );
                }),
          );
        }
      },
    );
  }
}
