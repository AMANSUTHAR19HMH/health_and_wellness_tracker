import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final TextEditingController _activityController = TextEditingController();
  List<String> _activities = [];

  @override
  void initState() {
    super.initState();
    _loadActivities();
  }

  Future<void> _loadActivities() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _activities = prefs.getStringList('activities') ?? [];
    });
  }

  Future<void> _addActivity() async {
    if (_activityController.text.isNotEmpty) {
      setState(() {
        _activities.add(_activityController.text);
        _activityController.clear();
      });
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('activities', _activities);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Track Activity')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _activityController,
              decoration: InputDecoration(labelText: 'Activity'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addActivity,
              child: Text('Add Activity'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _activities.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(_activities[index]));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
