import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class AppBarWidget extends StatelessWidget {
final String title;
final String iconData;
final IconData menuData;
final bool isProfile;
AppBarWidget({this.title,this.iconData,this.menuData,this.isProfile});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      leading: isProfile?Container(
        margin: EdgeInsets.all(6),
        child: CircleAvatar(
            radius: 12,
            child: Icon(Icons.person)),):Container(),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right:8.0),
          child: Icon(menuData),
        ),
      ],
    );
  }
}
