
import 'package:abdelhomi/src/chat_ui/chat_page.dart';
import 'package:abdelhomi/src/ui/bottom_nav_bar/home_page.dart';
import 'package:abdelhomi/src/ui/bottom_nav_bar/news.dart';
import 'package:abdelhomi/src/ui/bottom_nav_bar/notification.dart';
import 'package:abdelhomi/src/ui/bottom_nav_bar/stats.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  int _index=0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _screen=
    [
    HomePage(),
      States(),
      News(),
      NotificationPage(),
      ChatPage()
    ];
    return Scaffold(
    bottomNavigationBar: BottomNavigationBar(
    currentIndex: _index,
    type: BottomNavigationBarType.fixed,
    items:
    [
    BottomNavigationBarItem(

    icon: Icon(Icons.home_filled,
    color:  _index==0?
    Colors.blue:Colors.grey,
    ),
    title: Text("Home",
    style: TextStyle(
    color:
    _index==0?
    Colors.blue:Colors.grey,
    fontWeight: FontWeight.normal
    ),
    )),
    BottomNavigationBarItem(
    icon: Icon(Icons.location_city,
    color:  _index==1?
    Colors.blue:Colors.grey,
    ),
    title: Text("Stats",
    style: TextStyle(
    color:
    _index==1?
    Colors.blue:Colors.grey,
    fontWeight: FontWeight.normal
    ),
    )),
    BottomNavigationBarItem(

    icon: Icon(Icons.chrome_reader_mode,
    color:  _index==2?
    Colors.blue:Colors.grey,
    ),
    title: Text("News",
    style: TextStyle(
    color:
    _index==2?
    Colors.blue:Colors.grey,
    fontWeight: FontWeight.normal
    ),
    )),
    BottomNavigationBarItem(
    icon: Icon(Icons.notifications,
    color:  _index==3?
    Colors.blue:Colors.grey,
    ),
    title: Text("Notification",
    style: TextStyle(
    color:
    _index==3?
    Colors.blue:Colors.grey,
    fontWeight:
    FontWeight.normal
    ),
    )),
      BottomNavigationBarItem(
    icon: Icon(Icons.person,
    color:  _index==3?
    Colors.blue:Colors.grey,
    ),
    title: Text("Profile",
    style: TextStyle(
    color:
    _index==3?
    Colors.blue:Colors.grey,
    fontWeight:
    FontWeight.normal
    ),
    )),

    ]
    ,
    onTap: (int index){
    setState(() {
    _index=index;
    });
    },
    ),
    body: _screen[_index],

    );
  }
}
