import 'package:daisy/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daisy/config/info.dart';
import 'package:date_ranger/date_ranger.dart';
import 'package:intl/intl.dart';

class AddBigInfo extends StatefulWidget {
  const AddBigInfo({super.key});

  @override
  State<AddBigInfo> createState() => AddBigInfoState();
}

class AddBigInfoState extends State<AddBigInfo> {
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
    _dateEndTextEditingController.dispose();
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
                final docRef =
                    FirebaseFirestore.instance.collection("bigInfo").doc();
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
