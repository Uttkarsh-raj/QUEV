import 'package:flutter/material.dart';

class OnBoard1 extends StatefulWidget {
  const OnBoard1({Key? key}) : super(key: key);

  @override
  State<OnBoard1> createState() => _OnBoard1State();
}

class _OnBoard1State extends State<OnBoard1> {
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
                const SizedBox(height: 120),
                Text(
                  'Locate',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0,
                    color: Colors.grey[100],
                  ),
                ),
                const SizedBox(height: 40),
                Image.asset(
                  'assets/images/On1.png',
                  height: 200.0,
                  width: 260.0,
                ),
                const SizedBox(height: 30),
                Text(
                  'All the charging stations \n around you!!',
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
