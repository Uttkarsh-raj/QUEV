import 'package:flutter/material.dart';

class OnBoard0 extends StatefulWidget {
  const OnBoard0({Key? key}) : super(key: key);

  @override
  State<OnBoard0> createState() => _OnBoard0State();
}

class _OnBoard0State extends State<OnBoard0> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
                'WELCOME!!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32.0,
                  color: Colors.grey[100],
                ),
              ),
              const SizedBox(height: 40),
              Image.asset(
                'assets/images/on_00.png',
                height: 200.0,
                width: 260.0,
              ),
              const SizedBox(height: 40),
              Text(
                'Lets\'s get you Started !!',
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
    );
  }
}
