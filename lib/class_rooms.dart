import 'package:flutter/material.dart';
import 'database.dart';
import 'home_page.dart';
import 'package:intl/intl.dart';

class ClassroomPage extends StatefulWidget {
  final Classroom classroom;
  const ClassroomPage({Key? key, required this.classroom}) : super(key: key);

  @override
  _ClassroomPageState createState() => _ClassroomPageState();
}

class _ClassroomPageState extends State<ClassroomPage> {
  DateTime? _selectedDate;
  String? _selectedTimeSlot;

  final List<String> _timeSlots = [    '8AM - 9AM',    '9AM - 10AM',    '10AM - 11AM',    '11AM - 12PM'  ];
  void _checkStatus() {
    if(_selectedDate == null && _selectedTimeSlot == null){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please select a date and a time slot.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }
    if (_selectedDate == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please select a date.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    if (_selectedTimeSlot == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please select a time slot.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    final day = DateFormat('EEEE').format(_selectedDate!);
    final roomName = widget.classroom.name;
    final timeSlot = _selectedTimeSlot!;
    weeklyScheduleRef.child(day).child(roomName).child(timeSlot).onValue.listen((event) {
        final status = event.snapshot.value;
        if (status == 0) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Status'),
                content: Text('Room is available'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Request'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Status'),
                content: Text('Room is not available'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.classroom.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                ),
                onPressed: () {
                  _selectDate(context);
                },
                child: Text(_selectedDate == null
                    ? 'Select a date'
                    : 'Selected date: ${DateFormat('dd/MM/yyyy').format(_selectedDate!)}'),
              ),
              SizedBox(height: 25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                ),
                onPressed: () {
                  _showTimeSlotPopup(context);
                },
                child: Text(_selectedTimeSlot == null ? 'Select a time slot' : 'Selected time slot: $_selectedTimeSlot'),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                ),
                onPressed: () {
                  _checkStatus();
                },
                child: Text('Check Status'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
  Future<void> _showTimeSlotPopup(BuildContext context) async {
    final selectedTimeSlot = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(16.0),
          title: Text('Select a Time Slot'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _timeSlots
                  .map((timeSlot) => RadioListTile<String>(
                title: Text(timeSlot),
                value: timeSlot,
                groupValue: _selectedTimeSlot,
                onChanged: (selected) {
                  Navigator.pop(context, selected);
                },
              ))
                  .toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('CANCEL'),
            ),
          ],
        );
      },
    );
    if (selectedTimeSlot != null) {
      setState(() {
        _selectedTimeSlot = selectedTimeSlot;
      });
    }
  }
}
