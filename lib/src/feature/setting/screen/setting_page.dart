import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/config/routes/routes.dart';
import 'package:hotle_attendnce_admin/src/feature/auth/bloc/index.dart';

import 'package:hotle_attendnce_admin/src/feature/setting/screen/setting_tile.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final List<Map> homeMenu = [
      {
        "name": "Attendance",
        "iconColor": Colors.green,
        "image": "assets/icon/clock.png",
        "onPressed": () {
          Navigator.pushNamed(context, attendance);
        }
      },
      {
        "name": "Employee",
        "iconColor": Colors.orange,
        "image": "assets/icon/man.png",
        "onPressed": () {
          Navigator.pushNamed(context, account);
        }
      },
      {
        "name": "Schedule",
        "iconColor": Colors.orange,
        "image": "assets/icon/attendance.png",
        "onPressed": () {
          Navigator.pushNamed(context, account);
        }
      },
      {
        "name": "Travel/Leave",
        "iconColor": Colors.orange,
        "image": "assets/icon/man.png",
        "onPressed": () {
          Navigator.pushNamed(context, account);
        }
      },
      {
        "name": "Report",
        "iconColor": Colors.green,
        "image": "assets/icon/report.png",
        "onPressed": () {
          Navigator.pushNamed(context, attendance);
        }
      },
      {
        "name": "Setting",
        "iconColor": Colors.green,
        "image": "assets/icon/settings.png",
        "onPressed": () {
          Navigator.pushNamed(context, attendance);
        }
      },
      // {
      //   "name": "Account",
      //   "iconColor": Colors.orange,
      //   "image": "assets/icon/man.png",
      //   "onPressed": () {
      //     Navigator.pushNamed(context, account);
      //   }
      // },
    ];
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            "Setting",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            settingitem(
                name: "Department",
                icon: Icons.people,
                onPressed: () {
                  Navigator.pushNamed(context, department);
                }),
            SizedBox(
              height: 10,
            ),
            settingitem(name: "Position", icon: Icons.people, onPressed: () {}),
            SizedBox(
              height: 10,
            ),
            settingitem(
                name: "Timetable", icon: Icons.people, onPressed: () {}),
            SizedBox(
              height: 10,
            ),
            settingitem(
                name: "Notification", icon: Icons.people, onPressed: () {}),
            SizedBox(
              height: 10,
            ),
            settingitem(name: "Language", icon: Icons.people, onPressed: () {}),
            SizedBox(
              height: 10,
            ),
            settingitem(
                name: "Logout",
                icon: Icons.exit_to_app_outlined,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Alert'),
                          content: Text("Are you want to leave?"),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('NO'),
                            ),
                            FlatButton(
                              onPressed: () {
                                BlocProvider.of<AuthenticationBloc>(context)
                                    .add(LogoutPressed());
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Text('Yes'),
                            ),
                          ],
                        );
                      });
                })

            // GridView.builder(
            //   padding: EdgeInsets.only(top: 0, right: 15, bottom: 15, left: 15),
            //   shrinkWrap: true,
            //   physics: NeverScrollableScrollPhysics(),
            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //       childAspectRatio: 4 / 3,
            //       crossAxisCount:
            //           MediaQuery.of(context).orientation == Orientation.portrait
            //               ? 2
            //               : 3,
            //       crossAxisSpacing: 15,
            //       mainAxisSpacing: 15),
            //   itemBuilder: (_, index) => homeMenuTile(
            //       iconColor: homeMenu[index]["iconColor"],
            //       name: homeMenu[index]["name"],
            //       image: homeMenu[index]["image"],
            //       onPressed: homeMenu[index]["onPressed"]),
            //   itemCount: homeMenu.length,
            // )
          ],
        ));
  }
}
