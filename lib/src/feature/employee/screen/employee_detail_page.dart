// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotle_attendnce_admin/src/feature/checkin/bloc/index.dart';
// import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';
// import 'package:hotle_attendnce_admin/src/feature/employee/screen/widget/employee_detail_tile.dart';
// import 'package:hotle_attendnce_admin/src/feature/permission/screen/leave_page.dart';
// import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
// import 'package:hotle_attendnce_admin/src/shared/widget/loadin_dialog.dart';
// import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
// import 'package:intl/intl.dart';

// class EmployeeDetailPage extends StatefulWidget {
//   final EmployeeModel employeeModel;
//   const EmployeeDetailPage({required this.employeeModel});

//   @override
//   State<EmployeeDetailPage> createState() => _EmployeeDetailPageState();
// }

// class _EmployeeDetailPageState extends State<EmployeeDetailPage> {
//   DateTime? date;
//   DateTime dateNow = DateTime.now();
//   String? checkin;
//   String? data;
//   String? checkinTime;
//   @override
//   void initState() {
//     DateTime now = DateTime.now();
//     String formattedDate = DateFormat('MM/dd/yyyy kk:mm:ss').format(now);
//     // String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);
//     checkin = formattedDate.toString();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: standardAppBar(context, "Employee Detail"),
//       body: BlocListener<CheckInOutBloc, CheckInOutState>(
//         listener: (context, state) {
//           if (state is AddingCheckin) {
//             loadingDialogs(context);
//           }
//           if (state is ErrorAddingCheckInOut) {
//             Navigator.pop(context);
//             errorSnackBar(text: state.error.toString(), context: context);
//           }
//           if (state is AddedCheckin) {
//             Navigator.pop(context);
//           }
//         },
//         child: Stack(
//           children: [
//             Container(
//               height: 70,
//               width: double.infinity,
//               color: Theme.of(context).primaryColor,
//             ),
//             SingleChildScrollView(
//               child: Container(
//                 margin: EdgeInsets.symmetric(horizontal: 20),
//                 // color: Colors.grey.withOpacity(0.2),
//                 child: Column(
//                   children: [
//                     EmployeeDetailTile(employeeModel: widget.employeeModel),
//                     widget.employeeModel.leaveStatus == "true"
//                         ? Container()
//                         : widget.employeeModel.checkinStatus == "false"
//                             ? _actionButton(
//                                 context: context,
//                                 color: Colors.green,
//                                 title: "Checkin",
//                                 onPressed: () {
//                                   checkinTime = checkin!.substring(11, 19);
//                                   print(checkinTime);
//                                   BlocProvider.of<CheckInOutBloc>(context).add(
//                                       AddCheckinStarted(
//                                           checkinTime: checkinTime!,
//                                           employeeId: widget.employeeModel.id));
//                                 })
//                             : _actionButton(
//                                 context: context,
//                                 color: Colors.lightBlue,
//                                 title: "Checkout",
//                                 onPressed: () {
//                                   checkinTime = checkin!.substring(11, 19);
//                                   print(checkinTime);
//                                   // BlocProvider.of<CheckInOutBloc>(context).add(
//                                   //     AddCheckoutStarted(checkoutTime: checkinTime!, id: id, employeeId: widget.employeeModel.id));
//                                 }),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     widget.employeeModel.leaveStatus == "false"
//                         ? Container()
//                         : widget.employeeModel.checkinStatus == "true"
//                             ? Container()
//                             : _actionButton(
//                                 context: context,
//                                 color: Colors.red,
//                                 title: "Leave",
//                                 onPressed: () {
//                                   // Navigator.push(
//                                   //     context,
//                                   //     MaterialPageRoute(
//                                   //         builder: (context) => LeavePage()));
//                                 }),

//                     //
//                     widget.employeeModel.checkinStatus == "false"
//                         ? _actionButton(
//                             context: context,
//                             color: Colors.white,
//                             title: "Mark Absent",
//                             onPressed: () {})
//                         : Container(),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     // widget.employeeModel.leaveStatus == "true"
//                     //     ? Container()
//                     //     : _actionButton(
//                     //         context: context,
//                     //         color: Colors.amberAccent[700]!,
//                     //         title: "Leave",
//                     //         onPressed: () {
//                     //           Navigator.push(
//                     //               context,
//                     //               MaterialPageRoute(
//                     //                   builder: (context) => LeavePage()));
//                     //         })
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   _actionButton(
//       {required BuildContext context,
//       required String title,
//       required Color color,
//       required Function? onPressed}) {
//     return Container(
//       height: 50,
//       width: MediaQuery.of(context).size.width,
//       child: FlatButton(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//             // side: BorderSide(color: Colors.red)
//           ),
//           color: color,
//           padding: EdgeInsets.symmetric(vertical: 10),
//           onPressed: onPressed as void Function()?,
//           child: Text(title,
//               textScaleFactor: 1.2, style: TextStyle(color: Colors.white))),
//     );
//   }
// }
