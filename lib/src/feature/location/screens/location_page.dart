import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/config/routes/routes.dart';
import 'package:hotle_attendnce_admin/src/feature/location/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/location/bloc/location_bloc.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

LocationBloc locationBloc = LocationBloc();

class LocationPage extends StatelessWidget {
  // const Location({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context, "Location QR"),
      body: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10), child: Body()),
      floatingActionButton: Container(
        child: FloatingActionButton(
            backgroundColor: Colors.blue,
            child: Icon(Icons.add),
            elevation: 0,
            onPressed: () {
              Navigator.pushNamed(context, addLocation);
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
  void initState() {
    super.initState();

    locationBloc.add(InitializeLocationStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: locationBloc,
        builder: (context, state) {
          if (state is InitializingLocation) {
            return Center(
              // child: CircularProgressIndicator(),
              child: Lottie.asset('assets/animation/loader.json',
                  width: 200, height: 200),
            );
          } else if (state is ErrorFetchingLocation) {
            return Center(
              child: Text(state.error.toString()),
            );
          } else {
            if (locationBloc.departmentList.length == 0) {
              return Center(
                child: Text("No Data"),
              );
            }
            print("length ${locationBloc.departmentList.length}");

            return SmartRefresher(
              onRefresh: () {
                locationBloc.add(RefreshLocationStarted());
              },
              onLoading: () {
                locationBloc.add(FetchLocationStarted());
                _refreshController.loadComplete();
              },
              enablePullDown: true,
              enablePullUp: true,
              cacheExtent: 1,
              controller: _refreshController,
              child: ListView.builder(
                  itemCount: locationBloc.departmentList.length,
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
                                  "${locationBloc.departmentList[index].name}",
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
                                    "Latitude :",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Text(
                                  "${locationBloc.departmentList[index].lat}",
                                  style: TextStyle(
                                    color: Colors.purple,
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
                                    "Longtitue:",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Text(
                                  "${locationBloc.departmentList[index].long}",
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
                                    "Notes :",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                locationBloc.departmentList[index].notes == null
                                    ? Text("")
                                    : Text(
                                        "${locationBloc.departmentList[index].notes}",
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
                                    color: Colors.blue,
                                    child: Row(
                                      children: [
                                        Icon(Icons.edit),
                                      ],
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(context, editLocation,
                                          arguments: locationBloc
                                              .departmentList[index]);
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
                                                    Navigator.pop(context);
                                                    print(
                                                        "id ${locationBloc.departmentList[index].id}");
                                                    locationBloc.add(
                                                        DeletLocationStarted(
                                                            id: locationBloc
                                                                .departmentList[
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
          if (state is FetchedLocation) {
            _refreshController.loadComplete();
            _refreshController.refreshCompleted();
          }
          if (state is EndOfLocationList) {
            _refreshController.loadNoData();
          }
          if (state is AddingLocation) {
            EasyLoading.show(status: "loading....");
          } else if (state is ErrorAddingLocation) {
            EasyLoading.dismiss();
            errorSnackBar(text: state.error.toString(), context: context);
          } else if (state is AddedLocation) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess("Sucess");
          }
        });
  }
}
