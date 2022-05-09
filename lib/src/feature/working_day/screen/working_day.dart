import 'package:flutter/material.dart';
import 'package:hotle_attendnce_admin/src/feature/home/screen/home_menu.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';

class WorkingDay extends StatelessWidget {
  const WorkingDay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map> homeMenu = [
      {
        "name": "Department",
        "iconColor": Colors.green,
        "image": "assets/icon/clock.png",
        "onPressed": () {
          // Navigator.pushNamed(context, attendance);
        }
      },
      {
        "name": "Public",
        "iconColor": Colors.orange,
        "image": "assets/icon/man.png",
        "onPressed": () {
          // Navigator.pushNamed(context, employee);
        }
      },
      {
        "name": "Employee",
        "iconColor": Colors.orange,
        "image": "assets/icon/man.png",
        "onPressed": () {
          // Navigator.pushNamed(context, schedule);
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
      appBar: standardAppBar(context, "Working Day"),
      // body: Container(
      //   margin: EdgeInsets.only(top: 10),
      //             padding: EdgeInsets.symmetric(horizontal: 10),
      //   child: GridView.builder(
      //               padding: EdgeInsets.only(
      //                   top: 0, right: 15, bottom: 15, left: 15),
      //               shrinkWrap: true,
      //               physics: NeverScrollableScrollPhysics(),
      //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //                   childAspectRatio: 4 / 3,
      //                   crossAxisCount: MediaQuery.of(context).orientation ==
      //                           Orientation.portrait
      //                       ? 2
      //                       : 3,
      //                   crossAxisSpacing: 15,
      //                   mainAxisSpacing: 15),
      //               itemBuilder: (_, index) => homeMenuTile(
      //                   iconColor: homeMenu[index]["iconColor"],
      //                   name: homeMenu[index]["name"],
      //                   image: homeMenu[index]["image"],
      //                   onPressed: homeMenu[index]["onPressed"]),
      //               itemCount: homeMenu.length,
      //             ),
      // ),
    );
  }
}
