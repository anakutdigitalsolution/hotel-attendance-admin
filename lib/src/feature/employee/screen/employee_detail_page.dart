import 'package:flutter/material.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/screen/widget/employee_item.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';

class EmployeeDetailPage extends StatefulWidget {
  final EmployeeModel employeeModel;
  const EmployeeDetailPage({required this.employeeModel});

  @override
  State<EmployeeDetailPage> createState() => _EmployeeDetailPageState();
}

class _EmployeeDetailPageState extends State<EmployeeDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context, "Employee Detail"),
      body: Stack(
        children: [
          Container(
            height: 70,
            width: double.infinity,
            color: Theme.of(context).primaryColor,
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // custom detail tile
                  menuItemTile(
                    onPressed: () {},
                    overidingWidget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Name : ",
                                style: Theme.of(context).textTheme.bodyText1),
                            Expanded(
                              child: Text(
                                widget.employeeModel.name,
                                textScaleFactor: 1.1,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text("Card Number : ",
                                style: Theme.of(context).textTheme.bodyText1),
                            widget.employeeModel.card == null
                                ? Text("")
                                : Expanded(
                                    child: Text(
                                      widget.employeeModel.card!,
                                      textScaleFactor: 1.1,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text("DOB : ",
                                style: Theme.of(context).textTheme.bodyText1),
                            widget.employeeModel.dob == null
                                ? Text("")
                                : Expanded(
                                    child: Text(
                                      widget.employeeModel.dob!,
                                      textScaleFactor: 1.1,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text("Nationality : ",
                                style: Theme.of(context).textTheme.bodyText1),
                            widget.employeeModel.nationalilty == null
                                ? Text("")
                                : Expanded(
                                    child: Text(
                                      widget.employeeModel.nationalilty!,
                                      textScaleFactor: 1.1,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                          ],
                        ),
                        SizedBox(height: 5),
                        // Row(
                        //   children: [
                        //     Text("Address : ",
                        //         style: Theme.of(context).textTheme.bodyText1),
                        //     widget.accountModel.address == null
                        //         ? Text("")
                        //         : Expanded(
                        //             child: Text(
                        //               widget.accountModel.address!,
                        //               textScaleFactor: 1.1,
                        //               style: TextStyle(
                        //                   color: Colors.black,
                        //                   fontWeight: FontWeight.bold),
                        //             ),
                        //           ),
                        //   ],
                        // ),
                        Row(
                          children: [
                            Text(
                              "Phone : ",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            widget.employeeModel.phone == null
                                ? Text("")
                                : Expanded(
                                    child: Text(
                                      widget.employeeModel.phone!,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                          ],
                        ),
                        SizedBox(height: 5),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email : ",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            widget.employeeModel.email == null
                                ? Text("")
                                : Expanded(
                                    child: Text(
                                      "${widget.employeeModel.email}",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                          ],
                        ),
                      ],
                    ),
                    iconBackgroundColor: Colors.white,
                    iconPath: '',
                    title: '',
                  ),
                  SizedBox(height: 10),
                  menuItemTile(
                    onPressed: () {},
                    overidingWidget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Text(
                                "Position : ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.orange[800]),
                              ),
                              Text(
                                widget
                                    .employeeModel.positionModel!.positionName,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.orange[800]),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Text(
                                "Department : ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(),
                              ),
                              Text(
                                widget.employeeModel.departmentModel!.name!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.purple),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Text("Office Tel : ",
                                style: Theme.of(context).textTheme.bodyText1),
                            widget.employeeModel.officeTel == null
                                ? Text("")
                                : Expanded(
                                    child: Text(
                                      widget.employeeModel.officeTel!,
                                      textScaleFactor: 1.1,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                          ],
                        ),

                        //  accountBloc.accountModel!.type =="2" ? :  Row(
                        //       children: [
                        //         Text(
                        //           "Timetable : ",
                        //           style: Theme.of(context).textTheme.bodyText1,
                        //         ),

                        //         widget.accountModel.timetableModel== null
                        //             ? Text("")
                        //             : Expanded(
                        //                 child: Text(
                        //                   widget.accountModel.phone!,
                        //                   style:
                        //                       Theme.of(context).textTheme.bodyText1,
                        //                 ),
                        //               ),
                        //       ],
                        //     ),
                        SizedBox(height: 5),
                        widget.employeeModel.email == null
                            ? Container()
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Email : ",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${widget.employeeModel.email}",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                    iconBackgroundColor: Colors.white,
                    iconPath: '',
                    title: '',
                  ),
                  SizedBox(height: 10),
                  // menuItemTile(
                  //   onPressed: () {},
                  //   overidingWidget: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text("Timetable"),
                  //       Container(
                  //         height: 50,
                  //         child: time(context,
                  //             time: widget.employeeModel.!),
                  //       ),
                  //       SizedBox(height: 5),
                  //     ],
                  //   ),
                  //   iconBackgroundColor: Colors.white,
                  //   iconPath: '',
                  //   title: '',
                  // ),
                  // SizedBox(height: 10),
                  // IntrinsicHeight(
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //           child: menuItemTile(
                  //               onPressed: () {
                  //                 Navigator.push(
                  //                     context,
                  //                     MaterialPageRoute(
                  //                         builder: (context) => EditProfile(
                  //                               accountModel:
                  //                                   accountBloc.accountModel!,
                  //                             )));
                  //               },
                  //               title: "Edit Profile",
                  //               iconPath: "assets/icon/edit.png",
                  //               iconBackgroundColor: Colors.orange)),
                  //       SizedBox(
                  //         width: 10,
                  //       ),

                  //     ],
                  //   ),
                  // ),

                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
