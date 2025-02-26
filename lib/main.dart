 
import 'package:bakery_app/admin_view/admin_home.dart';
import 'package:bakery_app/controller/login_controller.dart';
import 'package:bakery_app/controller/registartion_controller.dart';
import 'package:bakery_app/firebase_options.dart';
import 'package:bakery_app/view/bottom_nav_bar.dart';
import 'package:bakery_app/view/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
runApp(MultiProvider(
  
  providers: [
    ChangeNotifierProvider(create:(context) => RegistrationController(),),
    ChangeNotifierProvider(create: (context) => LoginScreenController(),),
  ],
  child: MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        home:StreamBuilder(stream:FirebaseAuth.instance.authStateChanges() , builder: (context, snapshot) {
          if(snapshot.hasData){
              if (snapshot.data!.email == "admin@gmail.com"){
               return AdminHome();
              } else {
                return BottomNavScreen();
              }
           
          }else{
            return LoginScreen();
          }
        },) ,
      ),
    );
  }
}