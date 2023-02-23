import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp() : super(key: UniqueKey());
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Splash(),
    );
  }
}

//////////////////////////////////////////////////////////
class Splash extends StatefulWidget {
  const Splash({super.key});
  @override
  State<Splash> createState() => SplashState();
}

class SplashState extends State<Splash> {
  //이게 맞아
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(milliseconds: 2050),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Onboarding1() // OnBoardingPage(),
              ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0A0028),
      body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset('assets/Splashmove.gif')),
    );
  }
}

//////////////////////////////////////////////////////////
class Onboarding1 extends StatelessWidget {
  Onboarding1() : super(key: UniqueKey());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Image.asset('assets/onboarding1.png'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Onboarding2()),
          );
        },
      ),
    );
  }
}

class Onboarding2 extends StatelessWidget {
  Onboarding2() : super(key: UniqueKey());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Image.asset('assets/onboarding2.png'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Onboarding3()),
          );
        },
      ),
    );
  }
}

class Onboarding3 extends StatelessWidget {
  Onboarding3() : super(key: UniqueKey());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Image.asset('assets/onboarding3.png'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Splash()),
          );
        },
      ),
    );
  }
}
