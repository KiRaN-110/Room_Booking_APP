import 'package:flutter/material.dart';
import 'database.dart';

class Requests extends StatefulWidget {
  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Requests"),
          backgroundColor: Colors.redAccent,
        ),
        body: Container(
        )
    );
  }
}
