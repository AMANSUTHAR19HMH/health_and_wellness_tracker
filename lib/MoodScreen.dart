import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoodScreen extends StatefulWidget {
  @override
  _MoodScreenState createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  final TextEditingController _moodController = TextEditingController();
  List<String> _moods = [];

  @override
  void initState() {
    super.initState();
    _loadMoods();
  }

  Future<void> _loadMoods() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _moods = prefs.getStringList('moods') ?? [];
    });
  }

  Future<void> _addMood() async {
    if (_moodController.text.isNotEmpty) {
      setState(() {
        _moods.add(_moodController.text);
        _moodController.clear();
      });
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('moods', _moods);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Track Mood')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _moodController,
              decoration: InputDecoration(labelText: 'Mood'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addMood,
              child: Text('Add Mood'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _moods.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(_moods[index]));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
