import 'package:hotle_attendnce_admin/src/feature/position/bloc/index.dart';

import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/loadin_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'add_position.dart';
import 'edit_position.dart';

class PositionPage extends StatefulWidget {
  const PositionPage({Key? key}) : super(key: key);

  @override
  State<PositionPage> createState() => _PositionPageState();
}

class _PositionPageState extends State<PositionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context, "Position Page"),
      body: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10), child: PositionBody()),
      floatingActionButton: Container(
        child: FloatingActionButton(
            backgroundColor: Colors.lightBlueAccent,
            child: Icon(Icons.add),
            elevation: 0,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddPosition()));
            }),
      ),
    );
  }
}

class PositionBody extends StatefulWidget {
  const PositionBody({Key? key}) : super(key: key);

  @override
  State<PositionBody> createState() => _PositionBodyState();
}

class _PositionBodyState extends State<PositionBody> {
  @override
  Widget build(BuildContext context) {
    //  BlocProvider.of<WantedBloc>(context).add(FetchWantedStarted());
    BlocProvider.of<PositionBlc>(context).add(InitializePositionStarted());
    final RefreshController _refreshController = RefreshController();
    return BlocBuilder<PositionBlc, PositionState>(
      builder: (context, state) {
        if (state is InitializingPosition) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ErrorFetchingPosition) {
          return Center(
            child: Text(state.error.toString()),
          );
        } else {
          if (BlocProvider.of<PositionBlc>(context).positionList.length == 0) {
            return Center(
              child: Text("No Data"),
            );
          }
          print(
              "length ${BlocProvider.of<PositionBlc>(context).positionList.length}");

          return BlocListener<PositionBlc, PositionState>(
            listener: (context, state) {
              if (state is FetchedPosition) {
                _refreshController.loadComplete();
                _refreshController.refreshCompleted();
              }
              if (state is EndOfPositionList) {
                _refreshController.loadNoData();
              }
              if (state is AddingPosition) {
                loadingDialogs(context);
              } else if (state is ErrorAddingPosition) {
                Navigator.pop(context);
                errorSnackBar(text: state.error.toString(), context: context);
              } else if (state is AddedPosition) {
                // BlocProvider.of<LeaveBloc>(context).add(FetchLeaveStarted());
                Navigator.pop(context);
              }
            },
            child: SmartRefresher(
              onRefresh: () {
                BlocProvider.of<PositionBlc>(context)
                    .add(RefreshPositionStarted());
              },
              onLoading: () {
                if (BlocProvider.of<PositionBlc>(context).state
                    is EndOfPositionList) {
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
                      BlocProvider.of<PositionBlc>(context).positionList.length,
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
                                  "${BlocProvider.of<PositionBlc>(context).positionList[index].positionName}",
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
                                              builder: (con) => EditPosition(
                                                    positionModel: BlocProvider
                                                            .of<PositionBlc>(
                                                                context)
                                                        .positionList[index],
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
                                          "id ${BlocProvider.of<PositionBlc>(context).positionList[index].id}");
                                      BlocProvider.of<PositionBlc>(context).add(
                                          DeletePositionStarted(
                                              id: BlocProvider.of<PositionBlc>(
                                                      context)
                                                  .positionList[index]
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
