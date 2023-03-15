import 'package:flutter/material.dart';

class Bookings extends StatefulWidget {
  const Bookings({Key? key}) : super(key: key);

  @override
  _BookingsState createState() => _BookingsState();
}

class _BookingsState extends State<Bookings>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Bookings"),
        backgroundColor: Colors.blue,
      ),
      body: Container(


      )
    );
  }

}
