// import 'package:e_learning/src/shared/bloc/invoking/invoking_bloc.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


// // IndexingBloc? bottomNavigationIndexBloc;

// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);
//   @override
//   HomeState createState() => HomeState();
// }

// class HomeState extends State<Home> {
//   static List<InvokingBloc> bottomNavigationPagesInvokingBloc = [
//     InvokingBloc(),
//     InvokingBloc(),
//     // InvokingBloc(),
//     // InvokingBloc(),
//     // InvokingBloc(),
//   ];
//   final List<Widget> bottomNavigationPages = [
//     HomePage(),
//     // MyPropertyPage(),
//     // BlogPage(),
//     // CompanyPage(),
//     AccountPage()
//   ];
//   @override
//   void initState() {
//     bottomNavigationIndexBloc = IndexingBloc();
//     [
//       1,
//       2,
//     ].forEach((element) {
//       bottomNavigationPagesInvokingBloc.add(InvokingBloc());
//     });
//     super.initState();
//   }
//   // PageController _pageController = PageController();

//   // HomePage _homeScreenPage = HomePage();
//   // MyPropertyPage _homeProperty = MyPropertyPage();
//   // BlogPage _homeChat = BlogPage();
//   // AccountPage _homeProfile = AccountPage();
//   // CompanyPage _homeCompany = CompanyPage();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder(
//         bloc: bottomNavigationIndexBloc,
//         builder: (BuildContext context, int state) {
//           return IndexedStack(
//             index: state,
//             children: this.bottomNavigationPages,
//           );
//         },
//       ),
//       bottomNavigationBar: AppBottomNavigationBar(),
//     );
//   }

//   // Widget get _buildBody {
//   //   return PageView(
//   //     controller: _pageController,
//   //     children: [
//   //       _homeScreenPage,
//   //       _homeProperty,
//   //       _homeCompany,
//   //       _homeChat,
//   //       _homeProfile,
//   //     ],
//   //   );
//   // }

//   int _currentIndex = 0;
//   Widget get _buildBottom {
//     return BottomNavigationBar(
//         selectedItemColor: Colors.amberAccent[700],
//         unselectedItemColor: Colors.black,
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//             // _pageController.jumpToPage(index);
//           });
//         },
//         items: [
//           BottomNavigationBarItem(
//               icon: Icon(CupertinoIcons.home), label: "Home"),
//           // BottomNavigationBarItem(
//           //     icon: Icon(MdiIcons.homeCity), label: "My properties"),
//           // BottomNavigationBarItem(
//           //     icon: Icon(CupertinoIcons.person_3), label: "Company"),
//           // BottomNavigationBarItem(
//           //     icon: Icon(CupertinoIcons.book), label: "News"),
//           BottomNavigationBarItem(
//               icon: Icon(CupertinoIcons.profile_circled), label: "Profile"),
//         ]);
//   }
// }
