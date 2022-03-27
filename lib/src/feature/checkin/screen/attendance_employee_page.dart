import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/checkin/bloc/checkin_out_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/checkin/bloc/checkin_out_state.dart';
import 'package:hotle_attendnce_admin/src/feature/checkin/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/loadin_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class AttendanceEmployeePage extends StatefulWidget {
  const AttendanceEmployeePage({Key? key}) : super(key: key);

  @override
  State<AttendanceEmployeePage> createState() => _AttendanceEmployeePageState();
}

class _AttendanceEmployeePageState extends State<AttendanceEmployeePage> {
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
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: standardAppBar(context, "Employee Attendance"),
      body: Container(
        child:
            BlocBuilder<EmployeeBloc, EmployeeState>(builder: (context, state) {
          if (state is InitializingEmployee) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ErrorFetchingEmployee) {
            Navigator.pop(context);
            errorSnackBar(text: state.error.toString(), context: context);
          }
          if (state is InitializedEmployee) {}
          return BlocListener<EmployeeBloc, EmployeeState>(
            listener: (context, state) {
              if (state is FetchedEmployee) {}
            },
            child: BlocListener<CheckInOutBloc, CheckInOutState>(
              listener: (context, state) {
                if (state is AddingCheckin) {
                  loadingDialogs(context);
                }
                if (state is ErrorAddingCheckInOut) {
                  Navigator.pop(context);
                  errorSnackBar(text: state.error.toString(), context: context);
                }
                if (state is AddedCheckin) {
                  Navigator.pop(context);
                  BlocProvider.of<EmployeeBloc>(context)
                      .add(RefreshEmployeeStarted());
                  // Navigator.pop(context);
                }
              },
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        // height: MediaQuery.of(context).size.height,
                        child: GridView.builder(
                            itemCount: BlocProvider.of<EmployeeBloc>(context)
                                .emploList
                                .length,
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    childAspectRatio: 4 / 4.5,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10),
                            itemBuilder: (con, index) {
                              // return _buildContainer();
                              return InkWell(
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (con) => ListLiveByCate(
                                  //               categoryModel:
                                  //                   BlocProvider.of<CategoryBloc>(
                                  //                           context)
                                  //                       .category[index],
                                  //             )));
                                },
                                child: Card(
                                  // color: Colors.greenAccent.withOpacity(0.5),
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 80,
                                          height: 80,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.asset(
                                                "assets/icon/avartar.png"),
                                            // child: CachedNetworkImage(
                                            //   imageUrl:
                                            //       "${BlocProvider.of<EmployeeBloc>(context).category[index].image}",
                                            // ),
                                          ),
                                        ),

                                        // Container(
                                        //   padding: EdgeInsets.only(top: 5),
                                        //   child: Text("Admin Rock"),
                                        // ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 5, left: 10, right: 5),
                                          child: Center(
                                            child: Text(
                                                "${BlocProvider.of<EmployeeBloc>(context).emploList[index].name}"),
                                          ),
                                        ),
                                        BlocProvider.of<EmployeeBloc>(context)
                                                    .emploList[index]
                                                    .status ==
                                                "checked"
                                            ? Container(
                                                child: ElevatedButton(
                                                    child: Text("Checkout",
                                                        style: TextStyle()),
                                                    style: ButtonStyle(
                                                        foregroundColor:
                                                            MaterialStateProperty.all<Color>(
                                                                Colors.white),
                                                        backgroundColor: MaterialStateProperty.all<Color>(Colors
                                                            .amberAccent[700]!),
                                                        shape: MaterialStateProperty.all<
                                                                RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(18),
                                                                side: BorderSide(color: Colors.amberAccent[700]!)))),
                                                    onPressed: (){
                                                      checkinTime =
                                                                          checkin!.substring(
                                                                              11,
                                                                              19);
                                                                      print(
                                                                          checkinTime);
                                                                      // BlocProvider.of<CheckInOutBloc>(context).add(AddCheckoutStarted(
                                                                      //   id: ,
                                                                      //     checkoutTime:
                                                                      //         checkinTime!,
                                                                      //     employeeId: BlocProvider.of<EmployeeBloc>(context)
                                                                      //         .emploList[index]
                                                                      //         .id));
                                                    }),
                                              )
                                            : BlocProvider.of<EmployeeBloc>(
                                                            context)
                                                        .emploList[index]
                                                        .status ==
                                                    "leave"
                                                ? Container(
                                                    child: ElevatedButton(
                                                        child: Text("Leave",
                                                            style: TextStyle()),
                                                        style: ButtonStyle(
                                                            foregroundColor:
                                                                MaterialStateProperty.all<Color>(Colors
                                                                    .white),
                                                            backgroundColor:
                                                                MaterialStateProperty.all<Color>(Colors
                                                                    .red),
                                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(18),
                                                                    side: BorderSide(color: Colors.red)))),
                                                        onPressed: () => null),
                                                  )
                                                : BlocProvider.of<EmployeeBloc>(
                                                                context)
                                                            .emploList[index]
                                                            .status ==
                                                        "register"
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            child:
                                                                ElevatedButton(
                                                                    child: Text(
                                                                        "Checkin",
                                                                        style:
                                                                            TextStyle()),
                                                                    style: ButtonStyle(
                                                                        foregroundColor:
                                                                            MaterialStateProperty.all<Color>(Colors
                                                                                .white),
                                                                        backgroundColor:
                                                                            MaterialStateProperty.all<Color>(Colors
                                                                                .green),
                                                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(18),
                                                                            side: BorderSide(color: Colors.green)))),
                                                                    onPressed: () {
                                                                      checkinTime =
                                                                          checkin!.substring(
                                                                              11,
                                                                              19);
                                                                      print(
                                                                          checkinTime);
                                                                      BlocProvider.of<CheckInOutBloc>(context).add(AddCheckinStarted(
                                                                          checkinTime:
                                                                              checkinTime!,
                                                                          employeeId: BlocProvider.of<EmployeeBloc>(context)
                                                                              .emploList[index]
                                                                              .id));
                                                                    }),
                                                          ),
                                                          SizedBox(
                                                            width: 3,
                                                          ),
                                                          Container(
                                                            child:
                                                                ElevatedButton(
                                                                    child: Text(
                                                                      "Mark",
                                                                    ),
                                                                    style: ButtonStyle(
                                                                        foregroundColor:
                                                                            MaterialStateProperty.all<Color>(Colors
                                                                                .white),
                                                                        backgroundColor:
                                                                            MaterialStateProperty.all<Color>(Colors
                                                                                .lightBlue),
                                                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(18),
                                                                            side: BorderSide(color: Colors.lightBlue)))),
                                                                    onPressed: () {
                                                                      checkinTime =
                                                                          checkin!.substring(
                                                                              11,
                                                                              19);
                                                                      print(
                                                                          checkinTime);
                                                                      BlocProvider.of<CheckInOutBloc>(context).add(AddCheckinStarted(
                                                                          checkinTime:
                                                                              checkinTime!,
                                                                          employeeId: BlocProvider.of<EmployeeBloc>(context)
                                                                              .emploList[index]
                                                                              .id));
                                                                    }),
                                                          ),
                                                          // SizedBox(
                                                          //   width: 5,
                                                          // ),
                                                        ],
                                                      )
                                                    : Container(
                                                        child: ElevatedButton(
                                                            child: Text("Checkin",
                                                                style:
                                                                    TextStyle()),
                                                            style: ButtonStyle(
                                                                foregroundColor:
                                                                    MaterialStateProperty.all<Color>(Colors
                                                                        .white),
                                                                backgroundColor:
                                                                    MaterialStateProperty.all<Color>(Colors
                                                                        .green),
                                                                shape: MaterialStateProperty.all<
                                                                        RoundedRectangleBorder>(
                                                                    RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(18),
                                                                        side: BorderSide(color: Colors.green)))),
                                                            onPressed: () {
                                                              checkinTime =
                                                                  checkin!
                                                                      .substring(
                                                                          11,
                                                                          19);
                                                              print(
                                                                  checkinTime);
                                                              BlocProvider.of<
                                                                          CheckInOutBloc>(
                                                                      context)
                                                                  .add(AddCheckinStarted(
                                                                      checkinTime:
                                                                          checkinTime!,
                                                                      employeeId: BlocProvider.of<EmployeeBloc>(
                                                                              context)
                                                                          .emploList[
                                                                              index]
                                                                          .id));
                                                            }),
                                                      )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
