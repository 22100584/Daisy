import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daisy/config/info.dart';
import 'package:daisy/screens/get_partner_id_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:daisy/screens/login_page.dart';
import 'package:daisy/screens/home.dart';

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
                            return const LoginSignupScreen();
                          } else {
                            return const LoginSignupScreen();
                          }
                        default:
                          return const CircularProgressIndicator();
                      }
                    },
                  );
                }

                return const LoginSignupScreen();
              }),
        ));
  }
}
