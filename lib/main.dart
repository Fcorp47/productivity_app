import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_todo_app/Login/login.dart';
import 'package:flutter_todo_app/Login/register.dart';
import 'package:flutter_todo_app/auth/main_page.dart';
import 'package:flutter_todo_app/screens/option_cards.dart';
import './screens/home.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo App',
      theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFFEFEFEF)),
      home:  MainPage(),
      initialRoute: '/',
      routes: {
        '/login': (context) => const Login(),
      },
    );
  }


      //just put the appbar method here to use it afterwards homiee
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,

      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(' '),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/images/login.jpg'),
          ),
        ),
      ]),
    );
  }
}

