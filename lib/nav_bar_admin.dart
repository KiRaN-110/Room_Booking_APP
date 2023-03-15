import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/requests.dart';
import 'auth_service.dart';

class NavBar_Admin extends StatelessWidget {
  const NavBar_Admin({Key? key}) : super(key: key);

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
            decoration: BoxDecoration(
              color: Colors.redAccent,
            ),

          ),
          ListTile(
            leading: Icon(Icons.chat_bubble),
            title: Text('Booking and Cancellation Requests'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Requests()),
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
