import 'package:hotle_attendnce_admin/src/config/routes/routes.dart';
import 'package:hotle_attendnce_admin/src/feature/account/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/auth/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/home/screen/menu.dart';
import 'package:hotle_attendnce_admin/src/feature/home/screen/widget/home_item.dart';
import 'package:hotle_attendnce_admin/src/feature/notification/screen/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/setting/screen/operation_page.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:location/location.dart';

import 'home_menu.dart';
import 'my_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Future<Position?> getGeoLocationPosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the
  //     // App to enable the location services.
  //     await Geolocator.openLocationSettings();
  //     return Future.error('Location services are disabled.');
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }

  //   // When we reach here, permissions are granted and we can
  //   // continue accessing the position of the device.
  //   return await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  // }

  // LocationData _currentPosition;
  // currentLocation(double lat) async {
  //   position = await getGeoLocationPosition();
  //   return lat = position!.latitude;
  // }

  // Position? position;
  // LocationData? _currentPosition;
  // Location location = new Location();
  // @override
  // void initState() {
  //   fetchLocation();
  //   super.initState();
  // }

  // fetchLocation() async {
  //   bool _serviceEnabled;
  //   PermissionStatus _permissionGranted;

  //   _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await location.requestService();
  //     if (!_serviceEnabled) {
  //       return;
  //     }
  //   }

  //   _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }

  //   _currentPosition = await location.getLocation();
  //   print("location $_currentPosition");
  //   location.onLocationChanged.listen((LocationData currentLocation) {
  //     setState(() {
  //       _currentPosition = currentLocation;
  //       print("listen $_currentPosition");
  //       // getAddress(_currentPosition.latitude, _currentPosition.longitude)
  //       //     .then((value) {
  //       //   setState(() {
  //       //     _address = "${value.first.addressLine}";
  //       //   });
  //       // });
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final List<Map> homeMenu = [
      {
        "name": "Attendance",
        "iconColor": Colors.blue,
        "image": "assets/blackIcon/checking-attendance.png",
        "onPressed": () {
          Navigator.pushNamed(context, attendance);
        }
      },
      {
        "name": "Employee",
        "iconColor": Colors.blue,
        "image": "assets/blackIcon/group.png",
        "onPressed": () {
          Navigator.pushNamed(context, employee);
        }
      },
      {
        "name": "Schedule",
        "iconColor": Colors.blue,
        "image": "assets/blackIcon/clock1.png",
        "onPressed": () {
          Navigator.pushNamed(context, schedules);
        }
      },
      {
        "name": "Permission",
        "iconColor": Colors.blue,
        "image": "assets/blackIcon/file.png",
        "onPressed": () {
          Navigator.pushNamed(context, leave);
        }
      },

      {
        "name": "Overtime",
        "iconColor": Colors.blue,
        "image": "assets/blackIcon/overtime.png",
        "onPressed": () {
          Navigator.pushNamed(context, leave);
        }
      },
      {
        "name": "Payslip",
        "iconColor": Colors.blue,
        "image": "assets/blackIcon/money.png",
        "onPressed": () {
          Navigator.pushNamed(context, report);
        }
      },
      {
        "name": "Report",
        "iconColor": Colors.blue,
        "image": "assets/blackIcon/analytics.png",
        "onPressed": () {
          Navigator.pushNamed(context, report);
        }
      },
      {
        "name": "Configuration",
        "iconColor": Colors.blue,
        "image": "assets/icon/setting.png",
        "onPressed": () {
          // Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingPage()));
          Navigator.pushNamed(context, operation);
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

    // BlocProvider.of<AccountBloc>(context).add(FetchAccountStarted());
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 100),
          child: MyAppBar(
            username:
                "${BlocProvider.of<AuthenticationBloc>(context).state.user!.name}",
          )),
      body: ListView(
        clipBehavior: Clip.none,
        children: [
          Stack(
            children: [
              Container(
                height:
                    15 + ((MediaQuery.of(context).size.width / 2) - (45)) / 2.3,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      bottom: new Radius.elliptical(
                          MediaQuery.of(context).size.width, 60.0)),
                  color: Theme.of(context).primaryColor,
                ),
              ),
              OrientationBuilder(builder: (context, orie) {
                return Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  // child: GridView.count(crossAxisCount: 2,children: [

                  // ],),
                  child: GridView.builder(
                    padding: EdgeInsets.only(
                        top: 0, right: 15, bottom: 15, left: 15),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 4 / 2.5,
                        crossAxisCount: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? 2
                            : 3,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15),
                    itemBuilder: (_, index) => homeItem(
                        iconColor: homeMenu[index]["iconColor"],
                        name: homeMenu[index]["name"],
                        image: homeMenu[index]["image"],
                        onPressed: homeMenu[index]["onPressed"]),
                    // itemBuilder: (_, index) => homeMenuTile(
                    //     iconColor: homeMenu[index]["iconColor"],
                    //     name: homeMenu[index]["name"],
                    //     image: homeMenu[index]["image"],
                    //     onPressed: homeMenu[index]["onPressed"]),
                    itemCount: homeMenu.length,
                  ),
                );
              })
            ],
          ),
        ],
      ),
    );
  }
}
