import 'package:flutter/material.dart';
import 'package:flutter_todo_app/Login/register.dart';
import 'package:flutter_todo_app/Testing/Test1.dart';
import 'package:flutter_todo_app/screens/home.dart';
import 'package:flutter_todo_app/screens/imptask.dart';
import 'package:flutter_todo_app/screens/option_cards.dart';
import 'package:flutter_todo_app/screens/waterintake.dart';
import 'package:firebase_auth/firebase_auth.dart';

Widget my_drawer(BuildContext context)
{
  return Drawer(
    child: Container(
      color: Colors.white,
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Image.asset('assets/images/logo.jpg'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Colors.black, size: 35,),
            title: Text(
              'Home',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WaterIntakePage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.task_alt_sharp, color: Colors.green, size: 35,),
            title: Text('Tasks', style: TextStyle(fontSize: 20),),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Home() ));
            },
          ),
          ListTile(
            leading: Icon(Icons.star, color: Colors.yellow, size: 35,),
            title: Text(
              'Important Task',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ImportantTask()));
            },
          ),
          ListTile(
            leading: Icon(Icons.water_drop_rounded, color: Colors.blue, size: 35,),
            title: Text(
              'Water Intake',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => WaterReminderApp()));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.blue, size: 35,),
            title: Text(
              'Logout',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              FirebaseAuth.instance.signOut();
              /* Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => WaterIntake()));*/
            },
          ),
        ],
      ),
    ),
  );

}
