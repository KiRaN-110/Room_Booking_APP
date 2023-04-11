import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'database.dart';
import 'auth_service.dart';
import 'class_rooms.dart';
import 'home_page.dart';

class Bookings extends StatefulWidget {
  const Bookings({Key? key}) : super(key: key);

  @override
  _BookingsState createState() => _BookingsState();
}

class _BookingsState extends State<Bookings>{
  List<Map<dynamic, dynamic>> requestsList = []; // List to store the fetched requests data

  @override
  void initState() {
    super.initState();
    fetchRequestsData(); // Fetch requests data when the widget is initialized
  }

  void fetchRequestsData() {
    // Fetch requests data from Firebase database using the requestsRef from database.dart
    requestsRef.onValue.listen((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      // print("Fetched data from Firebase: ${snapshot.value}");
      // Once the data is fetched, update the requestsList and trigger a rebuild
      setState(() {
        requestsList = [];
        if (snapshot.value != null) {
          // Convert the fetched data into a list of maps and store it in requestsList
          Map<dynamic, dynamic>? values = snapshot.value as Map<dynamic, dynamic>?;
          // print("The map values generated are : ${values}");
          if (values != null) {
            values.forEach((date, dateData) {
              // Iterate through the date data
              if (dateData is Map<dynamic, dynamic>) {
                dateData.forEach((roomName, roomData) {
                  // Iterate through the room data
                  if (roomData is Map<dynamic, dynamic>) {
                    roomData.forEach((timeSlot, emailId) {
                      // Iterate through the email ids
                      if (emailId is Map<dynamic, dynamic>) {
                        emailId.forEach((email, value) {
                          final user_mail = FirebaseAuth.instance.currentUser!.email;
                          if (email == encodeEmail( user_mail!)) {
                            if (value == '1') {
                              Map<String, dynamic> requestData = {
                                'date': date,
                                'roomName': roomName,
                                'timeSlot': timeSlot,
                                'status': 'Pending',
                              };
                              requestsList.add(requestData);
                            }
                            else if (value == '0') {
                              Map<String, dynamic> requestData = {
                                'date': date,
                                'roomName': roomName,
                                'timeSlot': timeSlot,
                                'status': 'Accepted',
                              };
                              requestsList.add(requestData);
                            }
                            else if (value == '-1') {
                              Map<String, dynamic> requestData = {
                                'date': date,
                                'roomName': roomName,
                                'timeSlot': timeSlot,
                                'status': 'Rejected',
                              };
                              requestsList.add(requestData);
                            }
                          }
                        });
                      }
                    });
                  }
                });
              }
            });
          }
          // print("requestsList after fetch: $requestsList");
        }
      });
    });
  }





  @override
  Widget build(BuildContext context) {
    // Check if requestsList is empty
    // print('requestsList is empty: ${requestsList.isEmpty}');

    return Scaffold(
      appBar: AppBar(
        title: Text("Requests"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: requestsList.length,
          itemBuilder: (context, index) {
            // Create a widget for each request item in the requestsList
            return ListTile(
              title: Text(requestsList[index]['date']),
              subtitle: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(requestsList[index]['timeSlot']),
                        Text(requestsList[index]['roomName']),
                      ],
                    ),
                  ),
                  Text(requestsList[index]['status']),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

}
