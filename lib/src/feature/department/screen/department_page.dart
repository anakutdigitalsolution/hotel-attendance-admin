import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/config/routes/routes.dart';
import 'package:hotle_attendnce_admin/src/feature/department/bloc/index.dart';

import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/loadin_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'edit_department.dart';

DepartmentBlc departmentBlc = DepartmentBlc();
class DepartmentPage extends StatefulWidget {
  const DepartmentPage({ Key? key }) : super(key: key);

  @override
  State<DepartmentPage> createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<DepartmentPage> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: standardAppBar(context, "Department Page"),
      body: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10), child: DepartmentBody()),
      floatingActionButton: Container(
        child: FloatingActionButton(
            backgroundColor: Colors.lightBlueAccent,
            child: Icon(Icons.add),
            elevation: 0,
            onPressed: () {
              Navigator.pushNamed(context, addDepartment);
            }),
      ),
    );
  }
}

class DepartmentBody extends StatefulWidget {
  const DepartmentBody({ Key? key }) : super(key: key);

  @override
  State<DepartmentBody> createState() => _DepartmentBodyState();
}

class _DepartmentBodyState extends State<DepartmentBody> {
  @override
  Widget build(BuildContext context) {
    //  BlocProvider.of<WantedBloc>(context).add(FetchWantedStarted());
    departmentBlc.add(FetchDepartmentStarted());
    final RefreshController _refreshController = RefreshController();
    return BlocBuilder(
      bloc: departmentBlc,
      builder: (context, state) {
        if (state is FetchingDepartment) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ErrorFetchingDepartment) {
          return Center(
            child: Text(state.error.toString()),
          );
        } else {
          if (departmentBlc.departmentList.length == 0) {
            return Center(
              child: Text("No Data"),
            );
          }
          print(
              "length ${departmentBlc.departmentList.length}");

          return BlocListener(
            bloc: departmentBlc,
            listener: (context, state) {
              if (state is FetchedDepartment) {
                _refreshController.loadComplete();
                _refreshController.refreshCompleted();
              }
              if (state is EndOfDepartmentList) {
                _refreshController.loadNoData();
              }
              if (state is AddingDepartment) {
                EasyLoading.show(status: "loading....");
              } else if (state is ErrorAddingDepartment) {
                Navigator.pop(context);
                errorSnackBar(text: state.error.toString(), context: context);
              } else if (state is AddedDepartment) {
                EasyLoading.dismiss();
                EasyLoading.showSuccess("Sucess");
              }
            },
            child: SmartRefresher(
              onRefresh: () {
                departmentBlc.add(RefreshDepartmentStarted());
              },
              onLoading: () {
                 departmentBlc.add(FetchDepartmentStarted());
                  _refreshController.loadComplete();
                // if (departmentBlc.state
                //     is EndOfDepartmentList) {
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
                  itemCount:
                      departmentBlc.departmentList.length,
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
                                  "${departmentBlc.departmentList[index].name}",
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
                                                    builder: (con) => EditDepartment(
                                                          departmentModel: departmentBlc.departmentList[index],
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
                                                "id ${departmentBlc.departmentList[index].id}");
                                            departmentBlc
                                                .add(DeleteDepartmentStarted(
                                                    id:departmentBlc.departmentList[index]
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
