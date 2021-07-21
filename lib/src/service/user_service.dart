import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UserService with ChangeNotifier{
  final userName =TextEditingController();
  final email =TextEditingController();
  final dob =TextEditingController();
  final contactNumber =TextEditingController();
  final password =TextEditingController();
  bool _isLoading=false;
  bool _isLoginPage=true;
  bool _isLoggedIn=false;
final auth=FirebaseAuth.instance;
final formKey=GlobalKey<FormState>();
  SharedPreferences preferences;
  set isLoginPage(v){
    _isLoginPage=v;
    notifyListeners();
  }
  bool get isLoginPage=>_isLoginPage;
  set isLoading(v){
    _isLoading=v;
    notifyListeners();
  }
  bool get isLoading=>_isLoading;
  set isLoggedIn(v){
    _isLoggedIn=v;
    notifyListeners();
  }
  bool get isLoggedIn=>_isLoggedIn;

  UserService(){
    checkUser();
  }
  Future<bool> checkUser()async{
     preferences=await SharedPreferences.getInstance();
    _isLoggedIn= preferences.getBool("isLoggedIn");
    print(isLoggedIn);
    if(isLoggedIn==null){
      _isLoggedIn=false;
      notifyListeners();
      return _isLoggedIn;
    }
    else{
      _isLoggedIn=true;
      notifyListeners();
      return _isLoggedIn;

    }
  }
Future<bool> loginUser()async{
preferences=await SharedPreferences.getInstance();
 try{
  var user= await auth.signInWithEmailAndPassword(email: email.text, password: password.text);
  savePreferencesValue(user);
   return true;
 }


 catch(signUpError) {
print("ssssss");
     print(signUpError.message);
     print(signUpError.code);
     if(signUpError.code == 'user-not-found') {
       /// `foo@bar.com` has alread been registered.
       return false;
     }

   return false;
 }
}

  Future<bool> createUser()async{
  print(userName.text);
  print(password.text);
  print(email.text);
  try{

   await auth.createUserWithEmailAndPassword(email: email.text, password: password.text).then((value) {
      FirebaseFirestore.instance.collection("users").add({
        "userName":"${userName.text}",
        "email":"${email.text}",
        "dob":"${dob.text}",
        "contact":"${contactNumber.text}",
        "password":"${password.text}"
      });

    });
   return true;
  }
    catch(signUpError) {

      print('dddddddddd');
      print(signUpError.message);
      print(signUpError.code);
    if(signUpError.message == 'The email address is already in use by another account') {

    }

    return false;
    }

  }
  savePreferencesValue(UserCredential user){
    preferences.setBool("isLoggedIn", true);
    preferences.setString("userId", user.user.uid);
    preferences.setString("userEmail", user.user.email);
  }
}