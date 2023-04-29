import 'package:flutter/material.dart';

class WaterIntakePage extends StatefulWidget {
  @override
  _WaterIntakePageState createState() => _WaterIntakePageState();
}

class _WaterIntakePageState extends State<WaterIntakePage> {
  List<int> _waterIntakeRecords = [0, 0, 0, 0, 0, 0, 0];

  void _updateWaterIntakeRecord(int day, int amount) {
    setState(() {
      _waterIntakeRecords[day] = amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Water Intake'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Water Intake Records',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
          ),
          Table(
            columnWidths: {
              0: FlexColumnWidth(1.0),
              1: FlexColumnWidth(2.0),
            },
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Day',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Water Intake (ml)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              for (var i = 0; i < 7; i++)
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Day ${i + 1}',
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '${_waterIntakeRecords[i]}',
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
          SizedBox(height: 16.0),
          Text(
            'Record Water Intake',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i <= 2000; i += 250)
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      _updateWaterIntakeRecord(
                          DateTime.now().weekday - 1, i);
                    },
                    child: Text('$i ml'),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
