import 'package:flutter/material.dart';
import 'package:ioteggincubatorapp/pages/about.dart';
import 'package:ioteggincubatorapp/pages/dashboard.dart';
import 'package:ioteggincubatorapp/pages/humgraph.dart';
import 'package:ioteggincubatorapp/pages/tempgraph.dart';
import 'package:getflutter/getflutter.dart';

final drawer = Drawer(child: drawerItems);
final drawerHeader = UserAccountsDrawerHeader(
  accountName: Text('Admin'),
  accountEmail: Text('larteyjoshua@gmail.com'),
  currentAccountPicture: GFAvatar(
    // You can't use Image.asset for backgroundImage
    // because it requires an ImageProvider not Image widget
    backgroundImage: AssetImage(
      'assets/images/joshua.jpg',
    ),
    shape: GFAvatarShape.standard,
  ),
);

final drawerItems = Builder(builder: (context) {
  return ListView(
    children: <Widget>[
      drawerHeader,
      ListTile(
        title: Text('Dashboard'),
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DashBoard()),
          );
        },
      ),
//      ListTile(
//        title: Text('Pump Control'),
//        onTap: () {
//          Navigator.pushReplacement(
//            context,
//            MaterialPageRoute(builder: (context) => PumpControl()),
//          );
//        },
//      ),
      ListTile(
        title: Text('Temperature Graph'),
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => TempGraph()),
          );
        },
      ),
      ListTile(
        title: Text('Humidity Graph'),
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HumGraph()),
          );
        },
      ),
      ListTile(
        title: Text('About'),
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => About()),
          );
        },
      )
    ],
  );
});
