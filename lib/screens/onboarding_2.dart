import 'package:flutter/material.dart';

class OnBoard2 extends StatefulWidget {
  const OnBoard2({Key? key}) : super(key: key);

  @override
  State<OnBoard2> createState() => _OnBoard1State();
}

class _OnBoard1State extends State<OnBoard2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AspectRatio(
        aspectRatio: MediaQuery.of(context).size.aspectRatio,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 100),
                Text(
                  'Know About',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0,
                    color: Colors.grey[100],
                  ),
                ),
                const SizedBox(height: 40),
                Image.asset(
                  'assets/images/BG2.png',
                  height: 200.0,
                  width: 260.0,
                ),
                const SizedBox(height: 30),
                Text(
                  'Know more about the',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    wordSpacing: 3,
                    color: Colors.grey[200],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Electric Vehicles !!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    wordSpacing: 3,
                    color: Colors.grey[200],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
