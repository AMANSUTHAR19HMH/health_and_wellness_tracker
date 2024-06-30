import 'package:flutter/material.dart';

import 'ActivityScreen.dart';
import 'DietScreen.dart';
import 'MoodScreen.dart';
import 'SleepScreen.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Health & Wellness Tracker')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ActivityScreen()),
                );
              },
              child: Text('Track Activity'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DietScreen()),
                );
              },
              child: Text('Track Diet'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SleepScreen()),
                );
              },
              child: Text('Track Sleep'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MoodScreen()),
                );
              },
              child: Text('Track Mood'),
            ),

          ],
        ),
      ),
    );
  }
}
