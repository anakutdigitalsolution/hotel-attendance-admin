import 'package:hotle_attendnce_admin/src/feature/notification/screen/notification_page.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget {
  final String username;
  const MyAppBar({required this.username});

  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  bool isRead = false;
  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<AnnouncementBloc>(context)
    //     .add(SetReadingStatus(isRead: isRead));
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          // borderRadius: BorderRadius.only(
          //     bottomLeft: Radius.circular(20),
          //     bottomRight: Radius.circular(20))
        ),
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Welcome ${widget.username}",
                    textScaleFactor: 1.7,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                  // Image.asset('assets/icon/logo1.png')
                  ),
              Container(
                padding: EdgeInsets.only(right: 20),
                child: IconButton(
                  icon: Icon(
                    Icons.notifications_none_outlined,
                    color: Colors.white,
                    size: 38,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (con) => NotificationPage()));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
