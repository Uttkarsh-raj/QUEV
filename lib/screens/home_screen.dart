import 'package:flutter/material.dart';
import 'package:quev/screens/welcome.dart';

import 'google_signin.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QUEV'),
        backgroundColor: Colors.blue[900],
      ),
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                await FirebaseServices().signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Welcome()));
              },
              child: Container(
                  height: 150,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                  ),
                  child: const Text('Sign Out')),
            ),
          ],
        ),
      ),
    );
  }
}
