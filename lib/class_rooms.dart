import 'package:flutter/material.dart';

import 'home_page.dart';

class ClassroomPage extends StatefulWidget {
  final Classroom classroom;
  ClassroomPage({Key? key, required this.classroom}) : super(key: key);

  @override
  _ClassroomPageState createState() => _ClassroomPageState();
}

class _ClassroomPageState extends State<ClassroomPage> {
  String? _selectedDate;
  String? _selectedTimeSlot;

  final List<String> _dates = ['Monday', 'Tuesday', 'Wednesday','Thursday','Friday'];
  final List<String> _timeSlots = ['8AM - 9AM', '9AM - 10AM','10AM - 11AM','11AM - 12AM'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.classroom.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(widget.classroom.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(widget.classroom.description),
            SizedBox(height: 25),
            DropdownButton<String>(
              isExpanded: true,
              hint: Text('Select a date'),
              value: _selectedDate,
              onChanged: (newValue) {
                setState(() {
                  _selectedDate = newValue;
                });
              },
              items: _dates.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 25),
            DropdownButton<String>(
              isExpanded: true,
              hint: Text('Select a time slot'),
              value: _selectedTimeSlot,
              onChanged: (newValue) {
                setState(() {
                  _selectedTimeSlot = newValue;
                });
              },
              items: _timeSlots.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement check status functionality
              },
              child: Text('Check Status'),
            ),
          ],
        ),
      ),
    );
  }
}
