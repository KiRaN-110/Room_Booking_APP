import 'package:firebase_database/firebase_database.dart';

final database = FirebaseDatabase.instance.ref();
final bookingsRef = database.child('/Bookings');
final requestsRef = database.child('/Requests');
final weeklyScheduleRef = database.child('/Weekly Schedule');
final bookingsRef = database.child('/Bookings');
final requestsRef = database.child('/Requests');
final weeklySchedule = {
  'Monday': {
    'LHB 110': {
      '8AM - 9AM': 0,
      '9AM - 10AM': 0,
      '10AM - 11AM': 0,
      '11AM - 12PM': 0,
      // add more time slots as needed
    },
    'LHB 308': {
      '8AM - 9AM': 0,
      '9AM - 10AM': 0,
      '10AM - 11AM': 0,
      '11AM - 12PM': 0,
      // add more time slots as needed
    },
    // add more rooms as needed
  },
  'Tuesday': {
    'LHB 110': {
      '8AM - 9AM': 0,
      '9AM - 10AM': 0,
      '10AM - 11AM': 0,
      '11AM - 12PM': 0,
      // add more time slots as needed
    },
    'LHB 308': {
      '8AM - 9AM': 0,
      '9AM - 10AM': 0,
      '10AM - 11AM': 0,
      '11AM - 12PM': 0,
      // add more time slots as needed
    },
  },
  'Wednesday': {
    'LHB 110': {
      '8AM - 9AM': 0,
      '9AM - 10AM': 0,
      '10AM - 11AM': 0,
      '11AM - 12PM': 0,
      // add more time slots as needed
    },
    'LHB 308': {
      '8AM - 9AM': 0,
      '9AM - 10AM': 0,
      '10AM - 11AM': 0,
      '11AM - 12PM': 0,
      // add more time slots as needed
    },
  },
  'Thursday': {
    'LHB 110': {
      '8AM - 9AM': 0,
      '9AM - 10AM': 0,
      '10AM - 11AM': 0,
      '11AM - 12PM': 0,
      // add more time slots as needed
    },
    'LHB 308': {
      '8AM - 9AM': 0,
      '9AM - 10AM': 0,
      '10AM - 11AM': 0,
      '11AM - 12PM': 0,
      // add more time slots as needed
    },
  },
  'Friday': {
    'LHB 110': {
      '8AM - 9AM': 0,
      '9AM - 10AM': 0,
      '10AM - 11AM': 0,
      '11AM - 12PM': 0,
      // add more time slots as needed
    },
    'LHB 308': {
      '8AM - 9AM': 0,
      '9AM - 10AM': 0,
      '10AM - 11AM': 0,
      '11AM - 12PM': 0,
      // add more time slots as needed
    },
  },
  // add more days as needed
};