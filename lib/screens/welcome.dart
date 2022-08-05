import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),

              //Image
              Image.asset(
                'assets/images/party.png',
                width: 325,
                height: 325,
              ),
              const SizedBox(height: 15),

              //WELCOME
              const Text(
                'Welcome to QUEV',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 232, 231, 231),
                  fontSize: 28,
                ),
              ),

              const SizedBox(height: 5),

              //Small Text
              const Text(
                'We are happy to have you \n here.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 169, 169, 169),
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 49),

              //QUEV
              Opacity(
                opacity: 0.175,
                child: Image.asset(
                  'assets/images/QUEV.png',
                  height: 75,
                  width: 400,
                ),
              ),

              const SizedBox(height: 41),

              //Sign In Button
              Container(
                height: 60,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Center(
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
