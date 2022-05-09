import 'package:flutter_easyloading/flutter_easyloading.dart';
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
import 'package:hotle_attendnce_admin/src/utils/share/helper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
 EmployeeBloc employeeBloc = EmployeeBloc();
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
              Navigator.pushNamed(context, addEmployee);
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
    employeeBloc.add(InitializeEmployeeStarted());
  }

  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: employeeBloc,
      listener: (context, state) {
        if (state is ErrorFetchingEmployee) {
          Helper.handleState(state: state, context: context);
        }
        if (state is FetchedEmployee) {
          _refreshController.loadComplete();
          _refreshController.refreshCompleted();
        }
        if (state is EndofEmployeeList) {
          _refreshController.loadNoData();
        }
        if (state is AddingEmployee) {
          EasyLoading.show(status: "loading....");
        } else if (state is ErorrAddingEmployee) {
          EasyLoading.dismiss();
          EasyLoading.showError(state.error.toString());
          // errorSnackBar(text: state.error.toString(), context: context);
        } else if (state is AddedEmployee) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess("Sucess");
        }
      },
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
          if (employeeBloc.emploList.length == 0) {
            return Center(
              child: Text("No Data"),
            );
          }
          return SmartRefresher(
            onRefresh: () {
              employeeBloc.add(RefreshEmployeeStarted());
            },
            onLoading: () {
              if (employeeBloc.state is EndofEmployeeList) {
                _refreshController.loadNoData();
              } else {
                employeeBloc.add(FetchEmloyeeStarted());
              }

              // _refreshController.loadComplete();
              // if (BlocProvider.of<EmployeeBloc>(context).state
              //     is EndofEmployeeList) {
              // } else {
              //  BlocProvider.of<EmployeeBloc>(context)
              //     .add(FetchEmloyeeStarted());
              // }
              // BlocProvider.of<LeaveBloc>(context).add(FetchLeaveStarted());
            },
            enablePullDown: true,
            enablePullUp: true,
            cacheExtent: 1,
            controller: _refreshController,
            child: ListView.builder(
                itemCount: employeeBloc.emploList.length,
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
                                          employeeBloc.emploList[index])));
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
                                        employeeBloc.emploList[index].name,
                                        textAlign: TextAlign.right,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      // AspectRatio(aspectRatio: 1)
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  employeeBloc.emploList[index].phone == null
                                      ? Text("")
                                      : Text(
                                          employeeBloc.emploList[index].phone!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2,
                                          textAlign: TextAlign.right,
                                        ),
                                  SizedBox(height: 10),
                                  employeeBloc.emploList[index].address == null
                                      ? Text("")
                                      : Text(
                                          employeeBloc
                                              .emploList[index].address!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2,
                                          textAlign: TextAlign.right,
                                        ),

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
                                  //               employeeModel: employeeBloc
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
                                      "id ${employeeBloc.emploList[index].id}");
                                  employeeBloc.add(DeleteEmployeeStarted(
                                      id: employeeBloc.emploList[index].id));
                                }),
                          ],
                        )),
                  );
                }),
          );
        }
      },
    );
  }
}
