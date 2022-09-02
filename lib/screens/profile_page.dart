import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quev/login_controller.dart';
import 'package:quev/screens/welcome.dart';

import 'google_signin.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<ProfilePage> {
  late User _user;
  bool _isSigningOut = false;

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const Welcome(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    late var url = controller.googleAccount.value?.photoUrl;
    print(url);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(9),
        decoration: const BoxDecoration(
          // color: Colors.blueGrey[900],
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 25),

              //BACK BUTTON

              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Icon(
                      Icons.arrow_back,
                      color: Color.fromARGB(255, 234, 232, 232),
                      size: 25,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              //CIRCULAR PROFILE PHOTO

              CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 202, 203, 203),
                radius: 85,
                child: CircleAvatar(
                  //backgroundImage: AssetImage('assets/images/soloLeveling.jpg'),
                  // backgroundImage: NetworkImage(
                  //     'https://avatars.githubusercontent.com/u/85030597?v=4'),
                  backgroundImage: Image.network(controller
                              .googleAccount.value?.photoUrl ??
                          'https://avatars.githubusercontent.com/u/85030597?v=4')
                      .image,
                  radius: 80,
                ),
              ),

              const SizedBox(height: 30),

              // FIELDS

              // @ Name:
              Container(
                height: 70,
                width: 310,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(255, 62, 80, 88),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Name',
                      style: TextStyle(
                        color: Color.fromARGB(255, 211, 210, 210),
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      //'Display Name',
                      controller.googleAccount.value?.displayName ?? '',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 247, 246, 246),
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // @ email:

              Container(
                height: 70,
                width: 310,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(255, 62, 80, 88),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'e-mail',
                      style: TextStyle(
                        color: Color.fromARGB(255, 211, 210, 210),
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      //'demo@gmail.com',
                      controller.googleAccount.value?.email ?? '',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 247, 246, 246),
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 150),

              // @ SignOut

              GestureDetector(
                onTap: () async {
                  await FirebaseServices().signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Welcome()));
                },
                child: Container(
                    height: 70,
                    width: 310,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromARGB(255, 116, 129, 134),
                    ),
                    child: const Center(
                      child: Text(
                        'SignOut',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 231, 230, 230)),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
