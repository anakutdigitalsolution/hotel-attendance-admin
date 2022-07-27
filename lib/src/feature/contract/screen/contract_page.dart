// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:hotle_attendnce_admin/src/feature/contract/bloc/index.dart';
// import 'package:hotle_attendnce_admin/src/feature/department/bloc/index.dart';
// import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
// import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
// import 'package:lottie/lottie.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

// import '../../../appLocalizations.dart';

// ContractBloc contractBloc = ContractBloc();

// class Contractpage extends StatelessWidget {
//   const Contractpage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.withOpacity(0.2),
//       appBar: standardAppBar(
//           context, "${AppLocalizations.of(context)!.translate("structure")!}"),
//       body: Container(
//           margin: EdgeInsets.only(top: 10, bottom: 10), child: Body()),
//       floatingActionButton: Container(
//         child: FloatingActionButton(
//             backgroundColor: Colors.blue,
//             child: Icon(Icons.add),
//             elevation: 0,
//             onPressed: () {
//               // Navigator.pushNamed(context, addStructuretype);
//             }),
//       ),
//     );
//   }
// }

// class Body extends StatefulWidget {
//   const Body({Key? key}) : super(key: key);

//   @override
//   State<Body> createState() => _BodyState();
// }

// class _BodyState extends State<Body> {
//   final RefreshController _refreshController = RefreshController();
//   @override
//   void initState() {
//     super.initState();

//     contractBloc.add(InitailizeContractStarted());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer(
//       bloc: contractBloc,
//       listener: (context, state) {
//         if (state is FetchedContract) {
//           _refreshController.loadComplete();
//           _refreshController.refreshCompleted();
//         }
//         if (state is EndofContractList) {
//           _refreshController.loadNoData();
//         }
//         if (state is AddingContract) {
//           EasyLoading.show(status: "loading....");
//         } else if (state is ErrorAddingContract) {
//           EasyLoading.dismiss();
//           errorSnackBar(text: state.error.toString(), context: context);
//         } else if (state is AddedContract) {
//           EasyLoading.dismiss();
//           EasyLoading.showSuccess("Sucess");
//         }
//       },
//       builder: (context, state) {
//         if (state is InitailizingContract) {
//           return Center(

//             child: Lottie.asset('assets/animation/loader.json',
//                 width: 200, height: 200),
//           );
//         } else if (state is ErrorFetchingDepartment) {
//           return Center(
//             child: Text(state.error.toString()),
//           );
//         } else {
//           if (contractBloc.contract.length == 0) {
//             return Center(
//               child: Text("No Data"),
//             );
//           }
//           print("length ${contractBloc.contract.length}");

//           return SmartRefresher(
//             onRefresh: () {
//               contractBloc.add(InitailizeContractStarted());
//             },
//             onLoading: () {
//               contractBloc.add(FetchContractSarted());
//               _refreshController.loadComplete();
//             },
//             enablePullDown: true,
//             enablePullUp: true,
//             cacheExtent: 1,
//             controller: _refreshController,
//             child: ListView.builder(
//                 itemCount: contractBloc.contract.length,
//                 itemBuilder: (context, index) {
//                   return Container(
//                     margin: EdgeInsets.only(
//                       bottom: 10.0,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       // boxShadow: [
//                       //   BoxShadow(
//                       //     color: Colors.grey.withOpacity(0.5),
//                       //     spreadRadius: 0,
//                       //     blurRadius: 3,
//                       //     offset: Offset(0, 0), // changes position of shadow
//                       //   ),
//                       // ],
//                     ),
//                     child: Container(
//                       padding: EdgeInsets.all(8.0),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Row(
//                             // mainAxisAlignment:
//                             //     MainAxisAlignment.spaceBetween,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(right: 10),
//                                 child: Text(
//                                   "${AppLocalizations.of(context)!.translate("name")!} :",
//                                   style: TextStyle(color: Colors.black),
//                                 ),
//                               ),
//                               Text(
//                                 "${contractBloc.contract[index].r}",
//                                 style: TextStyle(
//                                   color: Colors.green,
//                                 ),
//                               )
//                             ],
//                           ),
//                           Row(
//                             // mainAxisAlignment:
//                             //     MainAxisAlignment.spaceBetween,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(right: 10),
//                                 child: Text(
//                                   "${AppLocalizations.of(context)!.translate("manager")!} :",
//                                   style: TextStyle(color: Colors.black),
//                                 ),
//                               ),
//                               departmentBlc.departmentList[index].managerName ==
//                                       null
//                                   ? Text("")
//                                   : Text(
//                                       "${departmentBlc.departmentList[index].managerName}",
//                                       style: TextStyle(
//                                         color: Colors.blue,
//                                       ),
//                                     )
//                             ],
//                           ),
//                           Row(
//                             // mainAxisAlignment:
//                             //     MainAxisAlignment.spaceBetween,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(right: 10),
//                                 child: Text(
//                                   "${AppLocalizations.of(context)!.translate("workday")!} :",
//                                   style: TextStyle(color: Colors.black),
//                                 ),
//                               ),
//                               departmentBlc.departmentList[index]
//                                           .workingDayModel ==
//                                       null
//                                   ? Text("")
//                                   : Text(
//                                       "${departmentBlc.departmentList[index].workingDayModel!.name}",
//                                       style: TextStyle(
//                                         color: Colors.green,
//                                       ),
//                                     )
//                             ],
//                           ),
//                           Row(
//                             // mainAxisAlignment:
//                             //     MainAxisAlignment.spaceBetween,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(right: 10),
//                                 child: Text(
//                                   "${AppLocalizations.of(context)!.translate("location")!} :",
//                                   style: TextStyle(color: Colors.black),
//                                 ),
//                               ),
//                               Text(
//                                 "${departmentBlc.departmentList[index].locationModel!.name}",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                 ),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               CupertinoButton(
//                                   padding: EdgeInsets.all(1.0),
//                                   color: Colors.blue,
//                                   child: Row(
//                                     children: [
//                                       Icon(Icons.edit),
//                                     ],
//                                   ),
//                                   onPressed: () {
//                                     Navigator.pushNamed(context, editDepartment,
//                                         arguments: departmentBlc
//                                             .departmentList[index]);
//                                   }),
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               CupertinoButton(
//                                   padding: EdgeInsets.all(1.0),
//                                   color: Colors.red,
//                                   child: Row(
//                                     children: [
//                                       Icon(Icons.delete),
//                                     ],
//                                   ),
//                                   onPressed: () {
//                                     deleteDialog(
//                                         context: context,
//                                         onPress: () {
//                                           Navigator.pop(context);
//                                           print(
//                                               "id ${departmentBlc.departmentList[index].id}");
//                                           departmentBlc.add(
//                                               DeleteDepartmentStarted(
//                                                   id: departmentBlc
//                                                       .departmentList[index]
//                                                       .id));
//                                         });
//                                   }),
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   );
//                 }),
//           );
//         }
//       },
//     );
//   }
// }
