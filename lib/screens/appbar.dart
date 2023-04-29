import 'package:flutter/material.dart';

AppBar myapp_bar(context){
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

