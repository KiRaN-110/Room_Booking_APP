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

class _BookingsState extends State<Bookings> {
  List<Map<dynamic, dynamic>> requestsList = [
  ]; // List to store the fetched requests data

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
          Map<dynamic, dynamic>? values = snapshot.value as Map<dynamic,
              dynamic>?;
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
                          final user_mail = FirebaseAuth.instance.currentUser!
                              .email;
                          if (email == encodeEmail(user_mail!)) {
                            if (value['Status'] == '1') {
                              Map<String, dynamic> requestData = {
                                'date': date,
                                'roomName': roomName,
                                'timeSlot': timeSlot,
                                'emailId' : email,
                                'status': 'Pending',
                              };
                              requestsList.add(requestData);
                            }
                            else if (value['Status'] == '0') {
                              Map<String, dynamic> requestData = {
                                'date': date,
                                'roomName': roomName,
                                'timeSlot': timeSlot,
                                'emailId' : email,
                                'status': 'Accepted',
                              };
                              requestsList.add(requestData);
                            }
                            else if (value['Status'] == '-1') {
                              Map<String, dynamic> requestData = {
                                'date': date,
                                'roomName': roomName,
                                'emailId' : email,
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
            return Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 20.0,
                ),
                title: Text(
                  requestsList[index]['date'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.0),
                    Text(
                      requestsList[index]['timeSlot'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      requestsList[index]['roomName'],
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[500],
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          requestsList[index]['status'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: requestsList[index]['status'] == 'Accepted'
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                        Visibility(
                          visible: requestsList[index]['status'] == 'Pending',
                          child: ElevatedButton(
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Cancel Request'),
                                    content: Text('Are you sure you want to cancel this request?'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Yes'),
                                        onPressed: () async {
                                          await requestsRef.child(requestsList[index]['date']).child(requestsList[index]['roomName']).child(requestsList[index]['timeSlot']).child(encodeEmail(FirebaseAuth.instance.currentUser!.email!)).remove();
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text('No'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },

                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }


}