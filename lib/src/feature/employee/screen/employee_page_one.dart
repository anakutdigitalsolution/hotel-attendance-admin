import 'package:hotle_attendnce_admin/src/config/routes/routes.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/screen/add_employee.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/screen/edit_employee.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/screen/employee_detail_page.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/screen/widget/employee_tile.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/loadin_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({Key? key}) : super(key: key);

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: standardAppBar(context, "Employee Page"),
      body: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10), child: Body()),
      floatingActionButton: Container(
        child: FloatingActionButton(
            backgroundColor: Colors.lightBlueAccent,
            child: Icon(Icons.add),
            elevation: 0,
            onPressed: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => AddEmployee()));
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
  @override
  final RefreshController _refreshController = RefreshController();
  Widget build(BuildContext context) {
    BlocProvider.of<EmployeeBloc>(context).add(InitializeEmployeeStarted());

    return BlocBuilder<EmployeeBloc, EmployeeState>(
      builder: (context, state) {
        if (state is InitializingEmployee) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ErrorFetchingEmployee) {
          return Center(
            child: Text(state.error.toString()),
          );
        } else {
          if (BlocProvider.of<EmployeeBloc>(context).emploList.length == 0) {
            return Center(
              child: Text("No Data"),
            );
          }
          print(
              "length ${BlocProvider.of<EmployeeBloc>(context).emploList.length}");

          return BlocListener<EmployeeBloc, EmployeeState>(
            listener: (context, state) {
              if (state is FetchedEmployee) {
                _refreshController.loadComplete();
                _refreshController.refreshCompleted();
              }
              if (state is EndofEmployeeList) {
                _refreshController.loadNoData();
              }
              if (state is AddingEmployee) {
                loadingDialogs(context);
              } else if (state is ErorrAddingEmployee) {
                Navigator.pop(context);
                errorSnackBar(text: state.error.toString(), context: context);
              } else if (state is AddedEmployee) {
                // BlocProvider.of<LeaveBloc>(context).add(FetchLeaveStarted());
                // Navigator.pop(context);
                Navigator.pop(context);
              }
            },
            child: SmartRefresher(
              onRefresh: () {
                BlocProvider.of<EmployeeBloc>(context)
                    .add(RefreshEmployeeStarted());
              },
              onLoading: () {
                if (BlocProvider.of<EmployeeBloc>(context).state
                    is EndofEmployeeList) {
                } else {
                  // BlocProvider.of<ProductListingBloc>(context)
                  //     .add(FetchProductListStarted(arg: widget.category.id));
                }
                // BlocProvider.of<LeaveBloc>(context).add(FetchLeaveStarted());
              },
              enablePullDown: true,
              enablePullUp: true,
              cacheExtent: 1,
              controller: _refreshController,
              child: ListView.builder(
                  itemCount:
                      BlocProvider.of<EmployeeBloc>(context).emploList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(bottom: 10),
                      child: TextButton(
                          style: TextButton.styleFrom(
                            // backgroundColor: Colors.blue,
                            padding: EdgeInsets.all(20),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EmployeeDetailPage(
                                        employeeModel:
                                            BlocProvider.of<EmployeeBloc>(
                                                    context)
                                                .emploList[index])));
                          },
                          child: Row(
                            children: [
                              Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.grey[300]),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  )),
                              SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          BlocProvider.of<EmployeeBloc>(context)
                                              .emploList[index]
                                              .name,
                                          textAlign: TextAlign.right,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                        ),
                                        // AspectRatio(aspectRatio: 1)
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    BlocProvider.of<EmployeeBloc>(context)
                                                .emploList[index]
                                                .phone ==
                                            null
                                        ? Text("")
                                        : Text(
                                            BlocProvider.of<EmployeeBloc>(
                                                    context)
                                                .emploList[index]
                                                .phone!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                            textAlign: TextAlign.right,
                                          ),
                                    SizedBox(height: 10),

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
                                    //       ),
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
                                    print(
                                        "id ${BlocProvider.of<EmployeeBloc>(context).emploList[index].id}");
                                    BlocProvider.of<EmployeeBloc>(context).add(
                                        DeleteEmployeeStarted(
                                            id: BlocProvider.of<EmployeeBloc>(
                                                    context)
                                                .emploList[index]
                                                .id));
                                  }),
                            ],
                          )),
                    );
                    return customerTile(
                        employeeModel: BlocProvider.of<EmployeeBloc>(context)
                            .emploList[index]);
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
                                  "${BlocProvider.of<EmployeeBloc>(context).emploList[index].name}",
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
                                    "Gender :",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Text(
                                  "${BlocProvider.of<EmployeeBloc>(context).emploList[index].gender}",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                            // SizedBox(
                            //   height: 5.0,
                            // ),
                            // Row(
                            //   // mainAxisAlignment:
                            //   //     MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Padding(
                            //       padding: const EdgeInsets.only(right: 10),
                            //       child: Text(
                            //         "Time out :",
                            //         style: TextStyle(color: Colors.black),
                            //       ),
                            //     ),
                            //     Text(
                            //       "${BlocProvider.of<TimetableBloc>(context).timetableList[index].offDutyTime}",
                            //       style: TextStyle(
                            //           color: Colors.black,
                            //           ),
                            //     )
                            //   ],
                            // ),

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
                                          "id ${BlocProvider.of<EmployeeBloc>(context).emploList[index].id}");
                                      BlocProvider.of<EmployeeBloc>(context)
                                          .add(DeleteEmployeeStarted(
                                              id: BlocProvider.of<EmployeeBloc>(
                                                      context)
                                                  .emploList[index]
                                                  .id));
                                    }),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          );
        }
      },
    );
  }
}
