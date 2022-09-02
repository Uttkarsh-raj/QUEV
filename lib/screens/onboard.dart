import 'package:flutter/material.dart'
    show
        Alignment,
        AssetImage,
        BoxDecoration,
        BoxFit,
        BuildContext,
        Center,
        Color,
        Container,
        Curves,
        DecorationImage,
        EdgeInsets,
        GestureDetector,
        Key,
        MainAxisAlignment,
        MaterialPageRoute,
        MediaQuery,
        Navigator,
        PageController,
        PageView,
        Row,
        Scaffold,
        Stack,
        State,
        StatefulWidget,
        Text,
        TextStyle,
        Widget;
import 'package:quev/screens/onboarding_1.dart';
import 'package:quev/screens/onboarding_2.dart';
import 'package:quev/screens/welcome.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'onboarding_0.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  //controller to keep track of the page we are in
  PageController _controller = PageController();

  //if at last page
  bool onLastPage = false;

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
        child: Stack(
          //PAGE VIEW
          children: [
            PageView(
              onPageChanged: (index) {
                setState(() {
                  onLastPage = (index == 2);
                });
              },
              controller: _controller,
              children: const [
                OnBoard0(),
                OnBoard1(),
                OnBoard2(),
              ],
            ),

            //DOT INDICATOR
            Container(
              alignment: const Alignment(0.0, 0.55),
              child: SmoothPageIndicator(controller: _controller, count: 3),
            ), //controller is the count of the page we are att and count is the maximum number of pages

            //Navigate
            Center(
              child: Container(
                padding: const EdgeInsets.only(bottom: 50),
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _controller.jumpToPage(2);
                      },
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 240, 240, 240),
                        ),
                      ),
                    ),

                    //NEXT

                    onLastPage
                        ? GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const Welcome();
                              }));
                            },
                            child: const Text(
                              'Done',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 240, 240, 240),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              _controller.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn);
                            },
                            child: const Text(
                              'Next',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 240, 240, 240),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
