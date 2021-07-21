import 'package:abdelhomi/src/service/user_service.dart';
import 'package:abdelhomi/src/ui/bottom_nav_bar/home.dart';
import 'package:abdelhomi/src/ui/bottom_nav_bar/home_page.dart';
import 'package:abdelhomi/src/ui/start_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';
class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    final userService=Provider.of<UserService>(context);
    print(userService.isLoggedIn);
    return SplashScreen(
        seconds: 4,
        navigateAfterSeconds:userService.isLoggedIn?Login():  StartPage(),
        title: new Text('Welcome In SplashScreen'),
        image: new Image.network('https://image.shutterstock.com/image-illustration/emergency-icon-website-button-on-260nw-528980086.jpg'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        loaderColor: Colors.red
    );
  }
}
