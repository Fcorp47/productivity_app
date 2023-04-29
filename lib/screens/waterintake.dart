import 'package:flutter/material.dart';
import 'package:flutter_todo_app/screens/mydrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
class WaterReminderApp extends StatefulWidget {
  const WaterReminderApp({Key? key}) : super(key: key);

  @override
  _WaterReminderAppState createState() => _WaterReminderAppState();
}

class _WaterReminderAppState extends State<WaterReminderApp> {
  int _waterIntake = 0;

  void _incrementWaterIntake() {
    setState(() {
      _waterIntake += 200;
    });
  }
  final user = FirebaseAuth.instance.currentUser;
  AppBar myappbar() {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('${user!.email}', style: TextStyle(fontSize: 10)),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: GestureDetector(
              child: Image.asset('assets/images/login.jpg'),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: my_drawer(context),
        appBar: myappbar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Your Water Intake:',
                style: TextStyle(fontSize: 24.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                '$_waterIntake ml',
                style: TextStyle(fontSize: 40.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(

               child: IconButton(onPressed: (){_incrementWaterIntake();}, icon: Icon(Icons.local_drink, size: 50,)),

              ),



            ],
          ),
        ),
    );
  }
}
