import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SleepScreen extends StatefulWidget {
  @override
  _SleepScreenState createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {
  final TextEditingController _sleepController = TextEditingController();
  List<String> _sleepLogs = [];

  @override
  void initState() {
    super.initState();
    _loadSleepLogs();
  }

  Future<void> _loadSleepLogs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _sleepLogs = prefs.getStringList('sleepLogs') ?? [];
    });
  }

  Future<void> _addSleep() async {
    if (_sleepController.text.isNotEmpty) {
      setState(() {
        _sleepLogs.add('${_sleepController.text} hours');
        _sleepController.clear();
      });
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('sleepLogs', _sleepLogs);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Track Sleep')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _sleepController,
              decoration: InputDecoration(labelText: 'Hours of Sleep'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addSleep,
              child: Text('Add Sleep Log'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _sleepLogs.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(_sleepLogs[index]));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
