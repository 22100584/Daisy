import 'package:daisy/config/info.dart';
import 'package:flutter/material.dart';
import 'package:daisy/config/palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:daisy/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'get_partner_id_page.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);

  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final _authentication = FirebaseAuth.instance;

  bool isSignupScreen = true;
  bool showSpinner = false;
  String userName = '';
  String userEmail = '';
  String userPassword = '';
  String partnerEmail = '';
  final _formKey = GlobalKey<FormState>();

  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Palette.backgroundColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 78,
              ),
              const Image(
                image: AssetImage('assets/daisy.png'),
                width: 124,
                height: 124,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 40,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                height: (isSignupScreen) ? 340 : 260,
                width: 320,
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = false;
                            });
                          },
                          child: Column(
                            children: [
                              const Text(
                                '로그인',
                                style: TextStyle(
                                    fontFamily: 'seoul_EB',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                              Opacity(
                                opacity: !isSignupScreen ? 1 : 0,
                                child: Container(
                                    margin: const EdgeInsets.only(top: 2),
                                    height: 4,
                                    width: 104,
                                    color: const Color(0xffFFD949)),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = true;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                '회원가입',
                                style: TextStyle(
                                    fontFamily: 'seoul_EB',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                              Opacity(
                                opacity: isSignupScreen ? 1 : 0,
                                child: Container(
                                    margin: const EdgeInsets.only(top: 2),
                                    height: 4,
                                    width: 104,
                                    color: const Color(0xffFFD949)),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    if (isSignupScreen)
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextFormField(
                                  key: const ValueKey(1),
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 3) {
                                      return '잘못 된 이메일입니다. 다시 시도해주세요';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    userName = value!;
                                  },
                                  onChanged: (value) {
                                    userName = value;
                                  },
                                  decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xffDFEBF3),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Palette.textColor1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Palette.textColor1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15.0),
                                        ),
                                      ),
                                      hintText: '이름',
                                      hintStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff737779)),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(20, 10, 10, 10)),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  key: const ValueKey(2),
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        !value.contains('@')) {
                                      return '잘못 된 이메일입니다. 다시 시도해주세요';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    userEmail = value!;
                                  },
                                  onChanged: (value) {
                                    userEmail = value;
                                  },
                                  decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xffDFEBF3),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Palette.textColor1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Palette.textColor1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15.0),
                                        ),
                                      ),
                                      hintText: '이메일',
                                      hintStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff737779)),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(20, 10, 10, 10)),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  obscureText: true,
                                  key: const ValueKey(3),
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 6) {
                                      return '최소 7자 이상 입력해주세요.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    userPassword = value!;
                                  },
                                  onChanged: (value) {
                                    userPassword = value;
                                  },
                                  decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xffDFEBF3),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Palette.textColor1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Palette.textColor1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15.0),
                                        ),
                                      ),
                                      hintText: '비밀번호',
                                      hintStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff737779)),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(20, 10, 10, 10)),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    if (!isSignupScreen)
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextFormField(
                                  key: const ValueKey(4),
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        !value.contains('@')) {
                                      return '잘못 된 이메일입니다. 다시 시도해주세요';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    userEmail = value!;
                                  },
                                  onChanged: (value) {
                                    userEmail = value;
                                  },
                                  decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xffDFEBF3),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Palette.textColor1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Palette.textColor1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15.0),
                                        ),
                                      ),
                                      hintText: '이메일',
                                      hintStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff737779)),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(20, 10, 10, 10)),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                TextFormField(
                                  obscureText: true,
                                  key: const ValueKey(5),
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 6) {
                                      return '최소 7자 이상 입력해주세요.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    userPassword = value!;
                                  },
                                  onChanged: (value) {
                                    userPassword = value;
                                  },
                                  decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xffDFEBF3),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Palette.textColor1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Palette.textColor1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15.0),
                                        ),
                                      ),
                                      hintText: '비밀번호',
                                      hintStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff737779)),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(20, 10, 10, 10)),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.all(15),
                height: 90,
                width: 340,
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    if (isSignupScreen) {
                      _tryValidation();

                      try {
                        final newUser = await _authentication
                            .createUserWithEmailAndPassword(
                          email: userEmail,
                          password: userPassword,
                        );
                        final user = FirebaseAuth.instance.currentUser!;
                        userProvider.userId = user.uid;

                        await FirebaseFirestore.instance
                            .collection('user')
                            .doc(user.uid)
                            .set({
                          'userName': userName,
                          'email': userEmail,
                          'user-id': user.uid,
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const DaisyPage())));
                      } catch (e) {
                        setState(() {
                          showSpinner = false;
                        });
                        print(e);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Please check your email and password'),
                            backgroundColor: Colors.blue,
                          ),
                        );
                      }
                    }
                    if (!isSignupScreen) {
                      _tryValidation();

                      try {
                        final newUser =
                            await _authentication.signInWithEmailAndPassword(
                          email: userEmail,
                          password: userPassword,
                        );
                      } catch (e) {
                        setState(() {
                          showSpinner = false;
                        });
                        print(e);
                      }
                    }
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffFFE171),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: isSignupScreen
                            ? const Text(
                                '회원가입',
                                style: TextStyle(
                                    fontFamily: 'seoul_EB',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              )
                            : const Text(
                                '로그인',
                                style: TextStyle(
                                    fontFamily: 'seoul_EB',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                      )),
                ),
              ),
              Column(
                children: [
                  if (!isSignupScreen)
                    const SizedBox(
                      height: 80,
                    ),
                  const Text(
                    "Date를 easy하게",
                    style: TextStyle(
                        fontFamily: 'seoul_CEB',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Palette.textColor2),
                  ),
                  const Text(
                    "데이지",
                    style: TextStyle(
                        fontFamily: 'seoul_CEB',
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                        color: Palette.textColor2),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
