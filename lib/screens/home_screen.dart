import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quev/screens/profile_page.dart';
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
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                await FirebaseServices().signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Welcome()));
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                height: 100,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text('Sign Out', textAlign: TextAlign.center),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
                onTap: () async {
                  await FirebaseServices().signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  height: 100,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Text('Profil Page', textAlign: TextAlign.center),
                ))
          ],
        ),
      ),
    );
  }
}
