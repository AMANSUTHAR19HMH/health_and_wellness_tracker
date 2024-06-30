import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DietScreen extends StatefulWidget {
  @override
  _DietScreenState createState() => _DietScreenState();
}

class _DietScreenState extends State<DietScreen> {
  final TextEditingController _foodController = TextEditingController();
  List<String> _meals = [];

  @override
  void initState() {
    super.initState();
    _loadMeals();
  }

  Future<void> _loadMeals() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _meals = prefs.getStringList('meals') ?? [];
    });
  }

  Future<void> _addMeal() async {
    if (_foodController.text.isNotEmpty) {
      setState(() {
        _meals.add(_foodController.text);
        _foodController.clear();
      });
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('meals', _meals);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Track Diet')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _foodController,
              decoration: InputDecoration(labelText: 'Food Item'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addMeal,
              child: Text('Add Meal'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _meals.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(_meals[index]));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
