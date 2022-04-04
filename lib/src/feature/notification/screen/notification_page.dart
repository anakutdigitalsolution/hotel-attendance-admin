import 'package:hotle_attendnce_admin/src/feature/notification/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/notification/model/notification_model.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NotificationBloc>(context).add(FetchNotificationStarted());
    return Scaffold(
      appBar: standardAppBar(context, "Notification"),
      floatingActionButton: Container(
        child: FloatingActionButton(
            backgroundColor: Colors.lightBlueAccent,
            child: Icon(Icons.add),
            elevation: 0,
            onPressed: () {
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => AddDepartment()));
            }),
      ),
      body: Container(
        child: BlocBuilder<NotificationBloc, NotificationState>(
            bloc: BlocProvider.of<NotificationBloc>(context),
            builder: (context, state) {
              if (state is FetchedNotification) {
                if (BlocProvider.of<NotificationBloc>(context)
                        .notificationModel
                        .length ==
                    0) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("No notification",
                          style: TextStyle(color: Colors.grey[400]))
                    ],
                  ));
                }
                return Container(
                  child: ListView.builder(
                      itemCount: BlocProvider.of<NotificationBloc>(context)
                          .notificationModel
                          .length,
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
                                    offset: Offset(
                                        0, 0), // changes position of shadow
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
                                              BlocProvider.of<NotificationBloc>(
                                                      context)
                                                  .notificationModel[index]
                                                  .title,
                                          style: TextStyle(
                                              color: Colors.orange[900]),
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
              if (state is ErrorFetchingNotification) {
                return Center(
                    child: Container(child: Text(state.error.toString())));
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
