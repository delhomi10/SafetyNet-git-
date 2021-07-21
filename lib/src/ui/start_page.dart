import 'package:abdelhomi/src/service/user_service.dart';
import 'package:abdelhomi/src/ui/bottom_nav_bar/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    final userService=Provider.of<UserService>(context);
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        width: size.width,
        decoration: BoxDecoration(
            color: Colors.grey,
            image: DecorationImage(
              image: AssetImage("lib/assets/a.jpg",),
              fit: BoxFit.cover
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )
        ),
        height: size.height,
        child: SingleChildScrollView(
          child: Form(
            key: userService.formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: size.height*0.1,),
                  Stack(alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius:
                        userService.isLoginPage?60:
                        45.0,
                        backgroundImage:
                        NetworkImage("https://image.shutterstock.com/image-illustration/emergency-icon-website-button-on-260nw-528980086.jpg"),
                        backgroundColor: Colors.grey[300],
                      ),
                      Positioned(
                        right: 0,bottom: 0,
                        child: CircleAvatar(
                            radius: 15,
                            child: Icon(Icons.photo_camera,size: 16,)),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height*0.05,),

                  SizedBox(height: size.height*0.05,),

                  userService.isLoginPage?Container():
                  TextFormField(controller: userService.userName,
                    validator: (v){
                      if(v.length==0){
                        return "required";
                      }
                      return null;
                    },
                    style: TextStyle(
                        color: Colors.white
                    ),
                    decoration: InputDecoration(


                        labelText: 'Name',
                        hintText: "john smith",
                        hintStyle: TextStyle(
                            color: Colors.white
                        ),
                        labelStyle: TextStyle(
                            color: Colors.white
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors. white, width: 2.0),
                          borderRadius: BorderRadius. circular(25.0),
                        ),
                        focusedBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors. white, width: 2.0),
                          borderRadius: BorderRadius. circular(25.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 14,horizontal: 20)
                    ),
                  ),
                  userService.isLoginPage?Container(): SizedBox(height: size.height*0.02,),

                  TextFormField(
                    style: TextStyle(
                        color: Colors.white
                    ),
                    validator: (v){
                      if(v.length==0){
                        return "required";
                      }
                      return null;
                    },
                    controller: userService.email,
                    decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: "john@email.com",
                        hintStyle: TextStyle(
                            color: Colors.white
                        ),
                        labelStyle: TextStyle(
                            color: Colors.white
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors. white, width: 2.0),
                          borderRadius: BorderRadius. circular(25.0),
                        ),
                        focusedBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors. white, width: 2.0),
                          borderRadius: BorderRadius. circular(25.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 14,horizontal: 10)
                    ),
                  ),         userService.isLoginPage?Container():   SizedBox(height: size.height*0.02,),

                  userService.isLoginPage?Container(): TextFormField(

                    style: TextStyle(
                        color: Colors.white
                    ),
                    controller: userService.dob,
                    validator: (v){
                      if(v.length==0){
                        return "required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Date of Birth',
                        hintText: "01/12/2000",
                        hintStyle: TextStyle(
                            color: Colors.white
                        ),
                        labelStyle: TextStyle(
                            color: Colors.white
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors. white, width: 2.0),
                          borderRadius: BorderRadius. circular(25.0),
                        ),
                        focusedBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors. white, width: 2.0),
                          borderRadius: BorderRadius. circular(25.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 14,horizontal: 10)
                    ),
                  ),
                  SizedBox(height: size.height*0.02,),

                  userService.isLoginPage?Container(): TextFormField(
                    style: TextStyle(
                        color: Colors.white
                    ),
                    validator: (v){
                      if(v.length==0){
                        return "required";
                      }
                      return null;
                    },
                    controller: userService.contactNumber,
                    decoration: InputDecoration(
                        labelText: 'Emergency Contact',
                        fillColor: Colors.white,
                        hintText: "+123554466778",
                        hintStyle: TextStyle(
                            color: Colors.white
                        ),
                        labelStyle: TextStyle(
                            color: Colors.white
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors. white, width: 2.0),
                          borderRadius: BorderRadius. circular(25.0),
                        ),
                        focusedBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors. white, width: 2.0),
                          borderRadius: BorderRadius. circular(25.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 14,horizontal: 10)
                    ),
                  ),
                  userService.isLoginPage?Container(): SizedBox(height: size.height*0.02,),
                  TextFormField(
                    style: TextStyle(
                        color: Colors.white
                    ),
                    validator: (v){
                      if(v.length==0){
                        return "required";
                      }
                      return null;
                    },
                    controller: userService.password,
                    decoration: InputDecoration(
                        labelText: 'password',
                        hintText: "abc123",
                        hintStyle: TextStyle(
                            color: Colors.white
                        ),
                        labelStyle: TextStyle(
                            color: Colors.white
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors. white, width: 2.0),
                          borderRadius: BorderRadius. circular(25.0),
                        ),
                        focusedBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors. white, width: 2.0),
                          borderRadius: BorderRadius. circular(25.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        isDense: true,

                        contentPadding: EdgeInsets.symmetric(vertical: 14,horizontal: 10)
                    ),
                    obscureText: true,
                  ),
                  // Spacer(),
                  SizedBox(height: size.height*0.05,),

                  GestureDetector(
                    onTap: userService.isLoginPage?(){
                      if(userService.formKey.currentState.validate()){
                        userService.isLoading=true;

                        userService.loginUser().then((value){
                          if(value==true){
                            userService.isLoading=false;
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                          }
                          else{
                            userService.isLoading=false;
                            _scaffoldKey.currentState.
                            showSnackBar(SnackBar(content: Text("user not found")));

                          }
                        });
                      }
                      else{
                        // ignore: deprecated_member_use
                        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("form not validate")));

                      }
                    }: (){
                      if(userService.formKey.currentState.validate()){
                        userService.isLoading=true;

                        userService.createUser().then((value) {
                          if(value==true){
                            userService.isLoading=false;

                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                          }
                          else{
                            userService.isLoading=false;
                            _scaffoldKey.currentState.showSnackBar(SnackBar
                              (content: Text("Email Already Exist")));

                          }
                        });
                      }
                      else{
                        // ignore: deprecated_member_use
                        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("form not validate")));
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blue,

                        borderRadius: BorderRadius.circular(25),
                      ),
                      width: size.width*0.5,
                      height: 40,
                      child:userService.isLoginPage?userService.isLoading?Center(child: Container(
                          width: 20,height: 20,
                          child: CircularProgressIndicator(color: Colors.white,)),):Text("Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),):userService.isLoading?Center(child: Container(
                          width: 20,height: 20,
                          child: CircularProgressIndicator(color: Colors.white,)),): Text("Create Account",
                        style: TextStyle(
                          color: Colors.white,
                            fontWeight: FontWeight.bold

                        ),),),
                  ),
                  MaterialButton(onPressed:userService.isLoginPage?(){
                    userService.isLoginPage=!userService.isLoginPage;
                  }: (){
                    userService.isLoginPage=!userService.isLoginPage;

                  },
                    shape: StadiumBorder(),

                    minWidth: size.width*0.5,
                    height: 40,
                    // color: Colors.blue,
                    child:userService.isLoginPage? Text("Create Account!",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ):Text("Already have Account!",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),),
                  SizedBox(height: size.height*0.01,),

                ],
              ),
            ),
          ),
        ),

      ),
    );
  }
}
