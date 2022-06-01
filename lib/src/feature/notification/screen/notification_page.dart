import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/config/routes/routes.dart';
import 'package:hotle_attendnce_admin/src/feature/notification/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/notification/model/notification_model.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

NotificationBloc notificationBloc = NotificationBloc();

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context, "Notification"),
      floatingActionButton: Container(
        child: FloatingActionButton(
            backgroundColor: Colors.lightBlueAccent,
            child: Icon(Icons.add),
            elevation: 0,
            onPressed: () {
              Navigator.pushNamed(context, addNotification);
            }),
      ),
      body: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10), child: Body()),
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
    notificationBloc.add(InitializeNotificationStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: notificationBloc,
        builder: (context, state) {
          if (state is FetchingNotification) {
            return Center(
              // child: CircularProgressIndicator(),
              child: Lottie.asset('assets/animation/loader.json',
                  width: 200, height: 200),
            );
          }
          if (state is ErrorFetchingNotification) {
            return Center(
                child: Container(child: Text(state.error.toString())));
          } else {
            if (notificationBloc.notificationModel.length == 0) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("No notification",
                      style: TextStyle(color: Colors.grey[400]))
                ],
              ));
            }
            return SmartRefresher(
              onRefresh: () {
                notificationBloc.add(RefreshNotificationStarted());
              },
              onLoading: () {
                if (notificationBloc.state is EndOfNotificationList) {
                  _refreshController.loadNoData();
                } else {
                  notificationBloc.add(FetchNotificationStarted());
                }
              },
              enablePullDown: true,
              enablePullUp: true,
              cacheExtent: 1,
              controller: _refreshController,
              child: ListView.builder(
                  itemCount: notificationBloc.notificationModel.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (con)=>));
                      },
                      child: Card(
                        child: Container(
                          // margin: EdgeInsets.only(bottom: 8, left: 8, right: 8),
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset:
                                    Offset(0, 0), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.date_range,
                                      size: 18.0,
                                      color: Colors.orange[900],
                                    ),
                                    Text(
                                      " " + '02/28/2022',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: [
                                    // Icon(
                                    //   Icons.date_range,
                                    //   size: 18.0,
                                    //   color: Colors.orange[900],
                                    // ),
                                    Text(
                                      " " +
                                          notificationBloc
                                              .notificationModel[index].title,
                                      style:
                                          TextStyle(color: Colors.orange[900]),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            );
          }
        },
        listener: (context, state) {
          if (state is FetchedNotification) {
            _refreshController.loadComplete();
            _refreshController.refreshCompleted();
          }
          if (state is EndOfNotificationList) {
            _refreshController.loadNoData();
          }
          if (state is AddingNotification) {
            EasyLoading.show(status: 'loading...');
          }
          if (state is ErrorAddingNotification) {
            EasyLoading.dismiss();
            EasyLoading.showError(state.error.toString());
          }
          if (state is AddedNotification) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess('Success');
          }
        });
  }
}
