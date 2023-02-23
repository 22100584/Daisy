import 'dart:ffi';
import 'package:daisy/screens/tutorial.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daisy/config/info.dart';
import 'package:daisy/screens/get_partner_id_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:daisy/screens/login_page.dart';
import 'package:daisy/screens/home.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Daisy',
        theme: ThemeData(
          fontFamily: 'seoul',
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  fetchAuthInfo();
                  return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    future: FirebaseFirestore.instance
                        .collection('user')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .get(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.done:
                          if (snapshot.hasData) {
                            if (snapshot.data!
                                .data()
                                .toString()
                                .contains('partner-user-id')) {
                              return const DaisyPage();
                            }
                            return DaisyPage();
                          } else {
                            return const LoginSignupScreen();
                          }
                        default:
                          return const CircularProgressIndicator();
                      }
                    },
                  );
                }

                return const Splash();
              }),
        ));
  }
}

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
          child: Image.asset(
            'assets/Splashmove.gif',
            fit: BoxFit.fill,
          )),
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
        child: Container(
            constraints: BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/onboarding1.png'),
                fit: BoxFit.cover,
              ),
            )),
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
        child: Container(
            constraints: BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/onboarding2.png'),
                fit: BoxFit.cover,
              ),
            )),
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
        child: Container(
            constraints: BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/onboarding3.png'),
                fit: BoxFit.cover,
              ),
            )),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginSignupScreen()),
          );
        },
      ),
    );
  }
}
