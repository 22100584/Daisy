import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daisy/config/info.dart';

String bigInfoId = '';

class AddSmallInfo extends StatefulWidget {
  const AddSmallInfo({Key? key, required this.shareId}) : super(key: key);
  final String shareId;
  @override
  State<AddSmallInfo> createState() => AddSmallInfoState();
}

class AddSmallInfoState extends State<AddSmallInfo> {
  @override
  Widget build(BuildContext context) {
    bigInfoId = widget.shareId;
    return const TextFieldExample();
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
  late final TextEditingController _memoTextEditingController;
  bool light = true;
  @override
  void initState() {
    super.initState();
    _nameTextEditingController = TextEditingController();
    _placeTextEditingController = TextEditingController();
    _memoTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameTextEditingController.dispose();
    _placeTextEditingController.dispose();
    _memoTextEditingController.dispose();
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
                Navigator.pop(context);
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
                    .doc(bigInfoId)
                    .collection("smallInfo")
                    .doc();
                SmallInfoProvider.bigInfoId = bigInfoId;
                await docRef.set({
                  registerTimeFieldName: FieldValue.serverTimestamp(),
                  idFieldName: docRef.id,
                  "smallname": SmallInfoProvider.smallname,
                  "smallplace": SmallInfoProvider.smallplace,
                  "memo": SmallInfoProvider.memo,
                  "bigInfoId": SmallInfoProvider.bigInfoId,
                });
                final docSnapshot = await docRef.get();
                if (docSnapshot.data() == null) {
                  return;
                }
                final snapshotData = docSnapshot.data()!;

                SmallInfoProvider.id = snapshotData[idFieldName];
                SmallInfoProvider.smallnameInFireStore =
                    snapshotData[smallnameFieldName];
                SmallInfoProvider.smallplaceInFireStore =
                    snapshotData[smallplaceFieldName];
                SmallInfoProvider.memoInFireStore = snapshotData[memoFieldName];
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
                      SmallInfoProvider.smallname = value;
                    });
                  },
                ),
              ),
              //데이트이름
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
                      SmallInfoProvider.smallplace = value;
                    });
                  },
                ),
              ),
              //장소 이름
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
                      hintText: '메모',
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Color(0xffFAFCFF)),
                  controller: _memoTextEditingController,
                  onChanged: (value) {
                    setState(() {
                      SmallInfoProvider.memo = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
