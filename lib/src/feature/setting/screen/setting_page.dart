import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/config/routes/routes.dart';
import 'package:hotle_attendnce_admin/src/feature/home/screen/home_menu.dart';
import 'package:hotle_attendnce_admin/src/feature/language/sreen/language.dart';
import 'package:hotle_attendnce_admin/src/feature/setting/screen/widget/setting_item.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/menu_item.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  double rowSpaceSize = 5;

  @override
  Widget build(BuildContext context) {
    final List<Map> homeMenu = [
      {
        "name": "Location",
        "iconColor": Colors.redAccent[200],
        "image": "assets/icon/maps-and-flags.png",
        "onPressed": () {
          Navigator.pushNamed(context, location);
        }
      },
      {
        "name": "Department",
        "iconColor": Colors.lightGreen,
        "image": "assets/icon/diagram.png",
        "onPressed": () {
          Navigator.pushNamed(context, department);
        }
      },
      {
        "name": "Position",
        "iconColor": Colors.orange,
        "image": "assets/icon/businesswoman.png",
        "onPressed": () {
          Navigator.pushNamed(context, position);
        }
      },
      {
        "name": "Timetable",
        "iconColor": Colors.lightBlue[300],
        "image": "assets/icon/timetable.png",
        "onPressed": () {
          Navigator.pushNamed(context, timetable);
        }
      },
      {
        "name": "Work day",
        "iconColor": Colors.green,
        "image": "assets/icon/calendar.png",
        "onPressed": () {
          Navigator.pushNamed(context, workDay);
        }
      },
      {
        "name": "Leave type",
        "iconColor": Colors.purple[300],
        "image": "assets/icon/calendar.png",
        "onPressed": () {
          Navigator.pushNamed(context, leavetype);
        }
      },
      {
        "name": "Holiday",
        "iconColor": Colors.lightBlue[300],
        "image": "assets/icon/calendar (1).png",
        "onPressed": () {
          Navigator.pushNamed(context, holiday);
        }
      },
      {
        "name": "Language",
        "iconColor": Colors.orange,
        "image": "assets/icon/language.png",
        "onPressed": () {
          languageModal(context);
        }
      },
      {
        "name": "Reset Password",
        "iconColor": Colors.lightGreen,
        "image": "assets/icon/change_password.png",
        "onPressed": () {
          Navigator.pushNamed(context, resetpassword);
        }
      },
    ];

    // BlocProvider.of<AccountBloc>(context).add(FetchAccountStarted());
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: standardAppBar(context, "Setting page"),
      body: ListView(
        clipBehavior: Clip.none,
        children: [
          OrientationBuilder(builder: (context, orie) {
            return Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.symmetric(horizontal: 10),
              // child: GridView.count(crossAxisCount: 2,children: [

              // ],),
              child: GridView.builder(
                padding: EdgeInsets.only(
                  top: 0,
                  left: 10,
                  right: 10,
                  bottom: 15,
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 4 / 2.5,
                    crossAxisCount: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? 2
                        : 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 15),
                itemBuilder: (_, index) =>
                    // menuItemTile(
                    //     alignment: Alignment.center,
                    //     iconBackgroundColor: Colors.green,
                    //     iconPath: homeMenu[index]["image"],
                    //     title: "Attendance",
                    //     // overidingColor: _isEnabled ? null : lockedColor,
                    //     onPressed: () {
                    //       // if (_isEnabled) {
                    //       //   Navigator.pushNamed(context, posAndSaleApp);
                    //       // }
                    //     }),
                    settingMenuTile(
                        iconColor: homeMenu[index]["iconColor"],
                        name: homeMenu[index]["name"],
                        image: homeMenu[index]["image"],
                        onPressed: homeMenu[index]["onPressed"]),
                itemCount: homeMenu.length,
              ),
            );
          }),
          SizedBox(
            height: 20,
          ),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     // Container(
          //     //   child: Text("Anakut Digital Solution"),
          //     // ),
          //     Container(
          //       child: Text("Version 1.0.1"),
          //     )
          //   ],
          // ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
