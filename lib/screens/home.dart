import 'dart:developer';
import 'package:daisy/screens/login_page.dart';
import 'package:date_ranger/date_ranger.dart';
import 'package:intl/intl.dart';
import 'package:daisy/config/palette.dart';
import 'package:daisy/screens/add_bigInfo.dart';
import 'package:daisy/screens/get_partner_id_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'add_bigInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daisy/config/info.dart';
import 'package:daisy/screens/optionalInfo.dart';
import 'package:daisy/screens/update_bIgInfo.dart';

String shareId = '';

class Daisy extends StatelessWidget {
  const Daisy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const DaisyPage(),
      theme: ThemeData(
        fontFamily: 'seoul_B',
        primaryColor: Colors.black,
        useMaterial3: true,
      ),
    );
  }
}

class DaisyPage extends StatefulWidget {
  const DaisyPage({super.key});

  @override
  State<DaisyPage> createState() => _DaisyPageState();
}

class _DaisyPageState extends State<DaisyPage> {
  UpdateDeleteItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEDF4F9),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          foregroundColor: const Color(0xffEDF4F9),
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Image.asset(
                'assets/daeasyLogo.png',
                width: 25.03,
                height: 25.03,
              ),
              const SizedBox(
                width: 8,
              ),
              const Text(
                'Da-easy',
                style: TextStyle(
                    fontFamily: 'seoul_CEB',
                    fontSize: 26,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff5B6367)),
              )
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: const Text("sign out")),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const GetPartnerIdPage())));
                },
                child: const Text("Enroll Partner")),
          ],
          backgroundColor: const Color(0xffEDF4F9),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(children: [
            const Padding(
              padding: EdgeInsets.only(left: 18.0),
              child: Text(
                '데이트 목록',
                style: TextStyle(
                    fontFamily: 'seoul_EB',
                    fontSize: 24,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            StreamBuilder(
              stream: FirebaseProvider.getAllInfos(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    if (snapshot.data!.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 200.0),
                        child: Center(
                          child: Text(
                            " 새 데이트를\n추가해주세요.",
                            style: TextStyle(
                                fontSize: 28,
                                fontFamily: 'seoul_EB',
                                fontWeight: FontWeight.w400,
                                color: Color(0xff737779)),
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 16, bottom: 10, top: 10),
                          child: Dismissible(
                            key: ValueKey(snapshot.data!.toList()[index].id),
                            background: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xffBFF290),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  children: const [
                                    Icon(Icons.edit, color: Colors.black),
                                    Text('  수정',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 19,
                                            fontWeight: FontWeight.w400)),
                                  ],
                                ),
                              ),
                            ),
                            secondaryBackground: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xffFF897D),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Icon(Icons.delete, color: Colors.black),
                                    Text('  삭제',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 19,
                                            fontWeight: FontWeight.w400)),
                                  ],
                                ),
                              ),
                            ),
                            confirmDismiss: (direction) async {
                              if (direction == DismissDirection.endToStart) {
                                return showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                          title: const Text("Please Confirm!"),
                                          content: const Text(
                                              "Are you sure you want to delete?"),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(ctx).pop(false);
                                                },
                                                child: const Text('cancel')),
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(ctx).pop(true);
                                                  shareId = snapshot.data!
                                                          .toList()[index]
                                                          .id ??
                                                      '';

                                                  final docRef =
                                                      FirebaseFirestore.instance
                                                          .collection("bigInfo")
                                                          .doc(shareId);
                                                  docRef.delete().then(
                                                      (doc) => print(
                                                          "Document deleted"),
                                                      onError: (e) => print(
                                                          "Error updating document $e"));
                                                },
                                                child: const Text('Confirm')),
                                          ],
                                        ));
                              } else if (direction ==
                                  DismissDirection.startToEnd) {
                                return showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                          title: const Text("Please Confirm!"),
                                          content: const Text(
                                              "Are you sure you want to update?"),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(ctx).pop(false);
                                                },
                                                child: const Text('cancel')),
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(ctx).pop(true);
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                    builder: (context) {
                                                      shareId = snapshot.data!
                                                              .toList()[index]
                                                              .id ??
                                                          '';
                                                      return const updateInfo();
                                                    },
                                                  ));
                                                },
                                                child: const Text('Update')),
                                          ],
                                        ));
                              }
                            },
                            onDismissed: (direction) {
                              setState(() {
                                shareId =
                                    snapshot.data!.toList()[index].id ?? '';

                                final docRef = FirebaseFirestore.instance
                                    .collection("bigInfo")
                                    .doc(shareId);
                                docRef.delete().then(
                                    (doc) => print("Document deleted"),
                                    onError: (e) =>
                                        print("Error updating document $e"));
                              });
                            },
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        BigInfoProvider.bigname = snapshot.data!
                                                .toList()[index]
                                                .bigname ??
                                            "no name";
                                        BigInfoProvider.bigdateStart = snapshot
                                            .data!
                                            .toList()[index]
                                            .bigdateStart;
                                        BigInfoProvider.bigdateEnd = snapshot
                                            .data!
                                            .toList()[index]
                                            .bigdateEnd;
                                        BigInfoProvider.bigplace = snapshot
                                            .data!
                                            .toList()[index]
                                            .bigplace;
                                        BigInfoProvider.id =
                                            snapshot.data!.toList()[index].id;
                                        return optionalInfo1(
                                          name: BigInfoProvider.bigname ?? '',
                                          dateS: BigInfoProvider.bigdateStart ??
                                              "",
                                          dateE:
                                              BigInfoProvider.bigdateEnd ?? "",
                                          place: BigInfoProvider.bigplace ?? '',
                                          shareId: BigInfoProvider.id ?? '',
                                        );
                                      },
                                    ),
                                  );
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.7),
                                        spreadRadius: 0,
                                        blurRadius: 1.0,
                                        offset: const Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                    color: const Color(0xffFAFCFF),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 0, 15),
                                  child: SizedBox(
                                    width: 367,
                                    child: Column(
                                      children: [
                                        ListTile(
                                            title: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 20, 0, 0),
                                              child: Text(
                                                snapshot.data!
                                                        .toList()[index]
                                                        .bigname ??
                                                    "no name",
                                                style: const TextStyle(
                                                    fontFamily: 'seoul_EB',
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff353C49)),
                                              ),
                                            ),
                                            subtitle: Row(
                                              children: [
                                                Text(
                                                  snapshot.data!
                                                          .toList()[index]
                                                          .bigdateStart ??
                                                      "no date",
                                                  style: const TextStyle(
                                                      fontFamily: 'seoul',
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xff353C49)),
                                                ),
                                                if (!((snapshot.data!
                                                        .toList()[index]
                                                        .bigdateEnd) ==
                                                    null))
                                                  const Text(
                                                    " ~ ",
                                                    style: TextStyle(
                                                        fontFamily: 'seoul',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Color(0xff353C49)),
                                                  ),
                                                Text(
                                                  snapshot.data!
                                                          .toList()[index]
                                                          .bigdateEnd ??
                                                      "",
                                                  style: const TextStyle(
                                                      fontFamily: 'seoul',
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xff353C49)),
                                                ),
                                              ],
                                            ),
                                            trailing: PopupMenuButton<
                                                    UpdateDeleteItem>(
                                                initialValue: selectedMenu,
                                                onSelected:
                                                    (UpdateDeleteItem item) {
                                                  selectedMenu = item;
                                                  if (selectedMenu ==
                                                      UpdateDeleteItem.update) {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                      builder: (context) {
                                                        shareId = snapshot.data!
                                                                .toList()[index]
                                                                .id ??
                                                            '';
                                                        return const updateInfo();
                                                      },
                                                    ));
                                                  }
                                                  if (selectedMenu ==
                                                      UpdateDeleteItem.delete) {
                                                    shareId = snapshot.data!
                                                            .toList()[index]
                                                            .id ??
                                                        '';

                                                    final docRef =
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "bigInfo")
                                                            .doc(shareId);
                                                    docRef.delete().then(
                                                        (doc) => print(
                                                            "Document deleted"),
                                                        onError: (e) => print(
                                                            "Error updating document $e"));
                                                  }
                                                },
                                                itemBuilder: ((context) => <
                                                        PopupMenuEntry<
                                                            UpdateDeleteItem>>[
                                                      const PopupMenuItem<
                                                          UpdateDeleteItem>(
                                                        value: UpdateDeleteItem
                                                            .update,
                                                        child: Text('Update'),
                                                      ),
                                                      const PopupMenuItem<
                                                          UpdateDeleteItem>(
                                                        value: UpdateDeleteItem
                                                            .delete,
                                                        child: Text('Delete'),
                                                      ),
                                                    ]))),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 15, 0, 0),
                                          child: Row(
                                            children: [
                                              const Icon(Icons.place),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  snapshot.data!
                                                          .toList()[index]
                                                          .bigplace ??
                                                      "no place",
                                                  style: const TextStyle(
                                                      fontFamily: 'seoul',
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xff353C49)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  default:
                    return const CircularProgressIndicator();
                }
              },
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
        backgroundColor: const Color(0xffEDF4F9).withOpacity(0),
        elevation: 0,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddBigInfo()));
        },
        child: const Image(
          image: AssetImage('assets/FAB.png'),
        ),
      ),
    );
  }
}

class FirebaseProvider {
  static final myInfoCollection =
      FirebaseFirestore.instance.collection('bigInfo');

  static Stream<Iterable<BigInfo>> getAllInfos() {
    userProvider.userId = FirebaseAuth.instance.currentUser!.uid;

    return myInfoCollection
        .where('user-ids', arrayContains: userProvider.userId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((docSnap) => BigInfo.fromFirebase(docSnap)));
  }
}

enum UpdateDeleteItem { update, delete }

class updateInfo extends StatefulWidget {
  const updateInfo({super.key});

  @override
  State<updateInfo> createState() => updateInfoState();
}

class updateInfoState extends State<updateInfo> {
  @override
  Widget build(BuildContext context) {
    return TextFieldExample();
  }
}

class TextFieldExample extends StatefulWidget {
  const TextFieldExample({super.key});

  @override
  State<TextFieldExample> createState() => _TextFieldExampleState();
}

class _TextFieldExampleState extends State<TextFieldExample> {
  late final TextEditingController _nameTextEditingController;
  late final TextEditingController _placeTextEditingController;
  late final TextEditingController _dateStartTextEditingController;
  late final TextEditingController _dateEndTextEditingController;
  bool light = true;
  @override
  void initState() {
    super.initState();
    _nameTextEditingController = TextEditingController();
    _placeTextEditingController = TextEditingController();
    _dateStartTextEditingController = TextEditingController();
    _dateEndTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameTextEditingController.dispose();
    _placeTextEditingController.dispose();
    _dateStartTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffDFEBF3),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color(0xffDFEBF3),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DaisyPage()),
                );
              },
              child: const Text(
                '취소',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffDE3730)),
              ),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  "새로운 데이트",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff131A1E)),
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                final docRef = FirebaseFirestore.instance
                    .collection("bigInfo")
                    .doc(shareId);
                fetchAuthInfo();
                print(userProvider.partnerId);

                await docRef.set({
                  registerTimeFieldName: FieldValue.serverTimestamp(),
                  idFieldName: docRef.id,
                  "bigname": BigInfoProvider.bigname,
                  "bigdateStart": BigInfoProvider.bigdateStart,
                  "bigdateEnd": BigInfoProvider.bigdateEnd,
                  "bigplace": BigInfoProvider.bigplace,
                  "user-ids": [userProvider.userId, userProvider.partnerId],
                });
                final docSnapshot = await docRef.get();
                if (docSnapshot.data() == null) {
                  return;
                }
                final snapshotData = docSnapshot.data()!;

                BigInfoProvider.id = snapshotData[idFieldName];
                BigInfoProvider.bignameInFireStore =
                    snapshotData[bignameFieldName];
                BigInfoProvider.bigdateStartInFireStore =
                    snapshotData[bigdateStartFieldName];
                BigInfoProvider.bigdateEndInFireStore =
                    snapshotData[bigdateEndFieldName];
                BigInfoProvider.bigplaceInFireStore =
                    snapshotData[bigplaceFieldName];
                Navigator.pop(context);
              },
              child: const Text(
                '저장',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff131A1E)),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 20, 28, 8),
                child: TextField(
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffFAFCFF)),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffFAFCFF)),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      hintStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      hintText: '일정 제목',
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Color(0xffFAFCFF)),
                  controller: _nameTextEditingController,
                  onChanged: (value) {
                    setState(() {
                      BigInfoProvider.bigname = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 0, 28, 8),
                child: TextField(
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffFAFCFF)),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffFAFCFF)),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      hintStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      hintText: '장소',
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Color(0xffFAFCFF)),
                  controller: _placeTextEditingController,
                  onChanged: (value) {
                    setState(() {
                      BigInfoProvider.bigplace = value;
                    });
                  },
                ),
              ),
              const SameDate(),
            ],
          ),
        ),
      ),
    );
  }
}

class SameDatePicker extends StatefulWidget {
  @override
  State<SameDatePicker> createState() => _SameDatePickerState();
}

class _SameDatePickerState extends State<SameDatePicker> {
  var initialDate = DateTime.now();
  var initialDateRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: DateRanger(
        activeDateBottomSpace: 10,
        runSpacing: 13,
        itemHeight: 30,
        inRangeTextColor: const Color(0xff131A1E),
        outOfRangeTextColor: const Color(0xff131A1E),
        activeDateFontSize: 15,
        horizontalPadding: 5,
        activeItemBackground: const Color(0xffFFE171),
        rangeBackground: const Color(0xffFFF0C4),
        borderColors: const Color(0xffEAC400),
        backgroundColor: const Color(0xffEDF4F9),
        initialRange: initialDateRange,
        onRangeChanged: (range) {
          setState(() {
            initialDateRange = range;
            BigInfoProvider.bigdateStart =
                DateFormat.yMd().format(initialDateRange.start);
            BigInfoProvider.bigdateEnd =
                DateFormat.yMd().format(initialDateRange.end);
          });
        },
      ),
    );
  }
}

class SameDate extends StatelessWidget {
  const SameDate({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 380,
            height: 520,
            child: Card(
              elevation: 0,
              color: const Color(0xffFAFCFF),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(13, 15, 0, 0),
                      child: Text(
                        '날짜 선택',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff353C49)),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12),
                      child: SameDatePicker(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
