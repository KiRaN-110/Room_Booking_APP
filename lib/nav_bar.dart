import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'bookings.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser!;
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.displayName!),
            accountEmail: Text(user.email!),
            currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.network(user.photoURL ?? 'https://www.example.com/default-image.jpg'),
                )
            ),
          ),
          ListTile(
            leading: Icon(Icons.event_note),
            title: Text('Bookings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Bookings()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app_rounded),
            title: Text('Log Out'),
            onTap: () {
              AuthService().signOut();
            },
          ),
        ],
      ),
    );
  }
}
