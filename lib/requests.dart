import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'database.dart';
import 'class_rooms.dart';
import 'home_page.dart';

class Requests extends StatefulWidget {
  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
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
                          if (value == '1') {
                            Map<String, dynamic> requestData = {
                              'date': date,
                              'roomName': roomName,
                              'timeSlot': timeSlot,
                              'emailId': email,
                            };
                            requestsList.add(requestData);
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
        backgroundColor: Colors.redAccent,
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
                  Text(requestsList[index]['emailId']),
                ],
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Request Details'),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Date: ${requestsList[index]['date']}'),
                          Text('Room Name: ${requestsList[index]['roomName']}'),
                          Text('Time Slot: ${requestsList[index]['timeSlot']}'),
                          Text('Email ID: ${requestsList[index]['emailId']}'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          child: Text('Accept'),
                          onPressed: () async {
                            // Handle Accept button click
                            // print('Accepted request with id: ${requestsList[index]['id']}');
                            var emailRef = database.child('/Requests').child(requestsList[index]['date']).child(requestsList[index]['roomName']).child(requestsList[index]['timeSlot']);
                            emailRef.onValue.listen((DatabaseEvent event) {
                              DataSnapshot snapshot = event.snapshot;
                              setState(() {
                                if (snapshot.value != null) {
                                  Map<dynamic, dynamic>? emailList = snapshot.value as Map<dynamic, dynamic>?;
                                  // print("The waiting emails are ${emailList}");
                                  if (emailList != null) {
                                    emailList.forEach((wait_email, value) async {
                                      if (wait_email != requestsList[index]['emailId']) {
                                        await emailRef.child(wait_email).set("-1");
                                      }
                                    });
                                  }
                                }
                              });
                            });
                            await bookingsRef.child(requestsList[index]['date']).child(requestsList[index]['roomName']).child(requestsList[index]['timeSlot']).set(1);
                            await requestsRef.child(requestsList[index]['date']).child(requestsList[index]['roomName']).child(requestsList[index]['timeSlot']).child(encodeEmail(requestsList[index]['emailId'])).set('0');
                            Navigator.of(context).pop(); // Close the dialog
                            // Add your logic for accepting the request here
                          },
                        ),
                        TextButton(
                          child: Text('Reject'),
                          onPressed: () async {
                            // Handle Reject button click
                            await requestsRef.child(requestsList[index]['date']).child(requestsList[index]['roomName']).child(requestsList[index]['timeSlot']).child(encodeEmail(requestsList[index]['emailId'])).set('-1');
                            // print('Rejected request with id: ${requestsList[index]['id']}');
                            Navigator.of(context).pop(); // Close the dialog
                            // Add your logic for rejecting the request here
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
