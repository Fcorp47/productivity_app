import 'package:flutter/material.dart';

class ImportantTask extends StatefulWidget {
  const ImportantTask({Key? key}) : super(key: key);

  @override
  State<ImportantTask> createState() => _ImportantTaskState();
}

class _ImportantTaskState extends State<ImportantTask> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Center(
       child: Text('IMPORTANT TASKS'),
     ),
   );
  }
}
