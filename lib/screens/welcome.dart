import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quev/login_controller.dart';
import 'package:quev/screens/google_signin.dart';
import 'package:quev/screens/home_screen.dart';
import 'package:quev/screens/profile_page.dart';
import '../google_maps/main.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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

                const SizedBox(height: 22),

                //Sign In Button
                GestureDetector(
                  // onTap: (() async {
                  //   await FirebaseServices().signInWIthGoogle();
                  //   Navigator.push(context,
                  //       MaterialPageRoute(builder: (context) => HomePage()));
                  // }),
                  onTap: () async {
                    await GoogleSignIn().signIn();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const MyApp()));
                    // if (controller.googleAccount.value != null) {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => const ProfilePage()));
                    // } else {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => const Welcome()));
                    // }
                  },
                  child: Container(
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
