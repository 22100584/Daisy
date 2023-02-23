import 'package:daisy/screens/home.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:daisy/config/font.dart';

class CoupleGardenPage extends StatelessWidget {
  const CoupleGardenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffDDF0FF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffDDF0FF),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Image.asset(
                    'assets/RealLogo.png',
                    width: 100,
                    height: 100,
                  ),
                  Image.asset(
                    'assets/Da-easy.png',
                    width: 154,
                    height: 84,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(15, 40, 7, 10),
                    child: Builder(builder: (context) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EmptyPage()));
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: Stack(children: [
                                  Image.asset('assets/invite.png'),
                                  Positioned(
                                    bottom: 22,
                                    right: 102,
                                    child: Container(
                                      width: 101,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffFFE171),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              Future.delayed(
                                                  Duration(seconds: 3), (() {
                                                Navigator.pop(context);
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Dialog(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          SlideNextTuto()));
                                                        },
                                                        child: Image.asset(
                                                            'assets/accepted.png'),
                                                      ),
                                                    );
                                                  },
                                                );
                                              }));
                                              return Dialog(
                                                child: Stack(children: [
                                                  Image.asset(
                                                      'assets/waiting.png'),
                                                  Positioned(
                                                    bottom: 22,
                                                    right: 102,
                                                    child: Container(
                                                      width: 101,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                          color: const Color(
                                                              0xffFFE171),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                      child: TextButton(
                                                        onPressed: () {
                                                          // 여기에 다시 또 dialog 만들어야 됨
                                                        },
                                                        child: const Text(
                                                          '복사',
                                                          style: body1_2,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 20,
                                                    right: 82,
                                                    child: Image.asset(
                                                        'assets/moveLogo.gif'),
                                                    width: 130,
                                                    height: 126,
                                                  )
                                                ]),
                                              );
                                            },
                                          );

                                          // start a timer to close the dialog after 2000 milliseconds
                                        },
                                        child: const Text(
                                          '복사',
                                          style: body1_2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                              );
                            },
                          );
                        },
                        child: Card(
                            color: const Color.fromARGB(255, 255, 233, 167),
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                              alignment: Alignment.bottomLeft,
                              width: 156,
                              height: 200,
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: ListTile(
                                      title: Text(
                                        '커플 가든\n생성',
                                        textAlign: TextAlign.left,
                                        style: Title2,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 32, 7, 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Image.asset(
                                          'assets/RealLogo.png',
                                          width: 70,
                                          height: 70,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                      );
                    })),
                Padding(
                    padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: Stack(children: [
                                Image.asset(
                                  'assets/default.png',
                                ),
                                Positioned(
                                  bottom: 22,
                                  right: 102,
                                  child: Container(
                                    width: 101,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffFFE171),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                              child: Stack(children: [
                                                Image.asset(
                                                  'assets/error.png',
                                                ),
                                                Positioned(
                                                  bottom: 22,
                                                  right: 102,
                                                  child: Container(
                                                    width: 101,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xffFFE171),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    child: TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return Dialog(
                                                              child: Stack(
                                                                  children: [
                                                                    Image.asset(
                                                                      'assets/ErrorMessage.png',
                                                                    ),
                                                                    Positioned(
                                                                      bottom:
                                                                          22,
                                                                      right:
                                                                          102,
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            101,
                                                                        height:
                                                                            40,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                const Color(0xffFFE171),
                                                                            borderRadius: BorderRadius.circular(15)),
                                                                        child:
                                                                            TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                            showDialog(
                                                                              context: context,
                                                                              builder: (BuildContext context) {
                                                                                return Dialog(
                                                                                  child: Stack(children: [
                                                                                    Image.asset(
                                                                                      /////283283283
                                                                                      'assets/solve.png',
                                                                                    ),
                                                                                    Positioned(
                                                                                      bottom: 22,
                                                                                      right: 102,
                                                                                      child: Container(
                                                                                        width: 101,
                                                                                        height: 40,
                                                                                        decoration: BoxDecoration(color: const Color(0xffFFE171), borderRadius: BorderRadius.circular(15)),
                                                                                        child: TextButton(
                                                                                          onPressed: () {
                                                                                            Navigator.pop(context);
                                                                                            showDialog(
                                                                                              context: context,
                                                                                              builder: (BuildContext context) {
                                                                                                return Dialog(
                                                                                                  child: Stack(children: [
                                                                                                    Image.asset(
                                                                                                      /////283283283
                                                                                                      'assets/final.png',
                                                                                                    ),
                                                                                                    Positioned(
                                                                                                      bottom: 21,
                                                                                                      right: 32,
                                                                                                      child: Container(
                                                                                                        width: 100,
                                                                                                        height: 40,
                                                                                                        decoration: BoxDecoration(color: const Color(0xffFFE171), borderRadius: BorderRadius.circular(15)),
                                                                                                        child: TextButton(
                                                                                                          onPressed: () {
                                                                                                            Navigator.push(
                                                                                                              context,
                                                                                                              MaterialPageRoute(builder: (context) => const SlideNextTuto()),
                                                                                                            );
                                                                                                            /////////
                                                                                                            ////////
                                                                                                            /////////
                                                                                                            ////////
                                                                                                            /////////
                                                                                                          },
                                                                                                          child: const Text(
                                                                                                            '확인',
                                                                                                            style: body1_2,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ]),
                                                                                                );
                                                                                              },
                                                                                            );
                                                                                          },
                                                                                          child: const Text(
                                                                                            '확인',
                                                                                            style: body1_2,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ]),
                                                                                );
                                                                              },
                                                                            );
                                                                          },
                                                                          child:
                                                                              const Text(
                                                                            '확인',
                                                                            style:
                                                                                body1_2,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ]),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: const Text(
                                                        '확인',
                                                        style: body1_2,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                            );
                                          },
                                        );
                                      },
                                      child: const Text(
                                        '확인',
                                        style: body1_2,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            );
                          },
                        );
                      },
                      child: Card(
                          color: const Color.fromARGB(255, 255, 254, 253),
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Container(
                            alignment: Alignment.bottomLeft,
                            width: 156,
                            height: 200,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Image.asset(
                                        'assets/doubleLogo.png',
                                        width: 90,
                                        height: 90,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 32, 10, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: const [
                                      Text(
                                        '커플 가든\n입장',
                                        textAlign: TextAlign.right,
                                        style: Title2,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 180),
              child: Column(
                children: const [
                  Text(
                    'Date를 Easy하게',
                    style: SplashFont2,
                  ),
                  Text(
                    '데이지',
                    style: SplashFont,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GotoGarden extends StatelessWidget {
  const GotoGarden({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CoupleGardenPage()),
        );
      },
      child: const Text('Couple Garden 임시버튼'),
    );
  }
}

class EmptyPage extends StatefulWidget {
  const EmptyPage({super.key});

  @override
  State<EmptyPage> createState() => _EmptyPageState();
}

class _EmptyPageState extends State<EmptyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEDF4F9),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65.83),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Image.asset(
                'assets/TopLogo.png',
                width: 130,
                height: 30,
              ),
            ],
          ),
          backgroundColor: const Color(0xffEDF4F9),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
        child: Center(
          child: ListView(
            children: const [
              Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 12),
                child: Text(
                  '데이트 목록',
                  style: Title3,
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 223),
                child: Text(
                  '새 데이트를\n추가해 주세요.',
                  textAlign: TextAlign.center,
                  style: Title1_G,
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: const Color(0xffEDF4F9).withOpacity(0),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DaisyPage()),
            );
          },
          child: const Image(
            image: AssetImage('assets/FAB.png'),
          ),
        ),
      ),
    );
  }
}

class SlideNextTuto extends StatefulWidget {
  const SlideNextTuto({super.key});
  @override
  State<SlideNextTuto> createState() => _SlideNextTutoState();
}

class _SlideNextTutoState extends State<SlideNextTuto> {
  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        Tutorial1(),
        Tutorial2(),
        Tutorial3(),
        Tutorial4(),
      ],
    );
  }
}

class Tutorial1 extends StatelessWidget {
  Tutorial1() : super(key: UniqueKey());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset('assets/tutorial1.png'),
    );
  }
}

class Tutorial2 extends StatelessWidget {
  Tutorial2() : super(key: UniqueKey());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset('assets/tutorial2.png'),
    );
  }
}

class Tutorial3 extends StatelessWidget {
  Tutorial3() : super(key: UniqueKey());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Image.asset('assets/tutorial3.png'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Tutorial4()),
          );
        },
      ),
    );
  }
}

class Tutorial4 extends StatelessWidget {
  Tutorial4() : super(key: UniqueKey());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/tutorial4.png'),
          Positioned(
            top: 42,
            right: 13,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DaisyPage()),
                );
              },
              child: const Text(
                '확인',
                style: Title4,
              ),
            ),
          )
        ],
      ),
    );
  }
}

// 19 Extra Bold
const TextStyle Title4 = TextStyle(
  fontSize: 19,
  fontFamily: 'Seoul_EB',
  fontWeight: FontWeight.w800,
  color: Color(0xffFAFCFF),
);
