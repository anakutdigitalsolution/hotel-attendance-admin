import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/feature/checkin/bloc/index.dart';
// import 'package:hotle_attendnce_admin/src/feature/employee/bloc/employee_event.dart';
// import 'package:hotle_attendnce_admin/src/feature/checkin/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/screen/employee_page.dart';
import 'package:intl/intl.dart';

class AttendanceTile extends StatefulWidget {
  final EmployeeModel employeeModel;

  const AttendanceTile({required this.employeeModel});

  @override
  State<AttendanceTile> createState() => _AttendanceTileState();
}

class _AttendanceTileState extends State<AttendanceTile> {
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
    return AspectRatio(
      aspectRatio: 4 / 4.5,
      child: Card(
        // color: Colors.greenAccent.withOpacity(0.5),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  // child: Image.asset(
                  //     "assets/icon/avartar.png"),
                  child: widget.employeeModel.img == null
                      ? Image.asset("assets/icon/avartar.png")
                      : CachedNetworkImage(
                          imageUrl:
                              "http://my-attendance-test-demo.herokuapp.com/${widget.employeeModel.img}",
                        ),
                ),
              ),

              // Container(
              //   padding: EdgeInsets.only(top: 5),
              //   child: Text("Admin Rock"),
              // ),
              Container(
                padding: EdgeInsets.only(top: 5, left: 10, right: 5),
                child: Center(
                  child: Text("${widget.employeeModel.name}"),
                ),
              ),
              widget.employeeModel.leaveStatus == "true"
                  ? Container(
                      child: ElevatedButton(
                          child: Text("Leave", style: TextStyle()),
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      side: BorderSide(color: Colors.red)))),
                          onPressed: () {}),
                    )
                  : widget.employeeModel.checkinStatus == "present"
                      ? Container(
                          child: ElevatedButton(
                              child: Text("Present", style: TextStyle()),
                              style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.lightBlue),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          side: BorderSide(
                                              color: Colors.lightBlue)))),
                              onPressed: () {}),
                        )
                      : widget.employeeModel.checkinStatus == "false"
                          ? Container(
                              child: ElevatedButton(
                                  child: Text("Checkin", style: TextStyle()),
                                  style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.green),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                              side: BorderSide(
                                                  color: Colors.green)))),
                                  onPressed: () {
                                    checkinTime = checkin!.substring(11, 19);
                                    print(checkinTime);
                                    BlocProvider.of<CheckInOutBloc>(context)
                                        .add(AddCheckinStarted(
                                            checkinTime: checkinTime!,
                                            employeeId:
                                                widget.employeeModel.id));
                                  }),
                            )
                          // : BlocProvider.of<CheckInOutBloc>(
                          //                 context)
                          //             .checkilist[index]
                          //             .status ==
                          //         "present"
                          //     ? Container(
                          //         child: Text(
                          //           "Present",
                          //           textScaleFactor: 1.3,
                          //           style: TextStyle(
                          //               color: Colors.green),
                          //         ),
                          //       )
                          // : BlocProvider.of<CheckInOutBloc>(
                          //                 context)
                          //             .checkilist[index]
                          //             .status ==
                          //         "leave"
                          //     ? Container(
                          //         child: ElevatedButton(
                          //             child: Text("Leave",
                          //                 style:
                          //                     TextStyle()),
                          //             style: ButtonStyle(
                          //                 foregroundColor:
                          //                     MaterialStateProperty.all<Color>(
                          //                         Colors
                          //                             .white),
                          //                 backgroundColor:
                          //                     MaterialStateProperty.all<Color>(Colors
                          //                         .red),
                          //                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                          //                     borderRadius:
                          //                         BorderRadius.circular(18),
                          //                     side: BorderSide(color: Colors.red)))),
                          //             onPressed: () => null),
                          //       )
                          : Container(
                              child: ElevatedButton(
                                  child: Text("Checkout", style: TextStyle()),
                                  style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.amberAccent[700]!),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                              side: BorderSide(
                                                  color: Colors.amberAccent[700]!)))),
                                  onPressed: () {
                                    checkinTime = checkin!.substring(11, 19);
                                    print(checkinTime);
                                    BlocProvider.of<CheckInOutBloc>(context)
                                        .add(AddCheckoutStarted(
                                            id: widget.employeeModel.checkinId!,
                                            checkoutTime: checkinTime!,
                                            employeeId:
                                                widget.employeeModel.id));
                                  }),
                            )
            ],
          ),
        ),
      ),
    );
    // return Container(
    //   child: Text(widget.employeeModel.name),
    // );
  }
}
