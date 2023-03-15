import 'package:flutter/material.dart';
import 'package:untitled/nav_bar_admin.dart';

class HomePage_Admin extends StatefulWidget {
  @override
  _HomePage_AdminState createState() => _HomePage_AdminState();
}

class _HomePage_AdminState extends State<HomePage_Admin>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar_Admin(),
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Container(

      ),
    );
  }

}