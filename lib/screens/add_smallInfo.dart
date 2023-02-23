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

  int? _value = 1;
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
                  "새로운 데이트 일정",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff131A1E)),
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                print(bigInfoId);
                final docRef =
                    FirebaseFirestore.instance.collection("smallInfo").doc();
                SmallInfoProvider.bigInfoId = bigInfoId;
                await docRef.set({
                  registerTimeFieldName: FieldValue.serverTimestamp(),
                  idFieldName: docRef.id,
                  "smallname": SmallInfoProvider.smallname,
                  "smallplace": SmallInfoProvider.smallplace,
                  "memo": SmallInfoProvider.memo,
                  "bigInfoId": SmallInfoProvider.bigInfoId,
                  "category": SmallInfoProvider.category,
                  "user-ids": [''],
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
                SmallInfoProvider.bigInfoIdInFireStore =
                    snapshotData[bigInfoIdFieldName];
                SmallInfoProvider.categoryInFireStore =
                    snapshotData[categoryFieldName];

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
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 0, 28, 8),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: const Color(0xffFAFCFF),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            '카테고리',
                            style: TextStyle(
                                fontFamily: 'seoul_EB',
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Wrap(
                        spacing: 3.0,
                        children: List<Widget>.generate(
                          7,
                          (int index) {
                            return Padding(
                                padding: const EdgeInsets.all(4),
                                child: ChoiceChip(
                                  avatar: _CategoryIcon[index],
                                  selectedColor: const Color(0xffFFE171),
                                  backgroundColor:
                                      const Color(0xffFFE171).withOpacity(0.48),
                                  label: Opacity(
                                    opacity: (_value == index) ? 0.9 : 0.48,
                                    child: Text(
                                      _Category[index],
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff1D192B)),
                                    ),
                                  ),
                                  selected: _value == index,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      _value = selected ? index : null;
                                      SmallInfoProvider.category =
                                          selected ? _Category[index] : null;
                                    });
                                  },
                                ));
                          },
                        ).toList(),
                      ),
                    ],
                  ),
                ),
              ),

              //카테고리 설정
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 0, 28, 8),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: const Color(0xffFAFCFF),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            '메모',
                            style: TextStyle(
                                fontFamily: 'seoul_EB',
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
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
                            hintStyle: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                            hintText: 'Right here',
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
                    ],
                  ),
                ),
              ),
              //메모 작성
            ],
          ),
        ),
      ),
    );
  }
}

final List<String> _Category = [
  "식사",
  "디저트",
  "활동",
  "관람",
  "산책",
  "휴식",
  "이동",
];

final List<Icon> _CategoryIcon = [
  const Icon(
    Icons.restaurant_outlined,
    size: 15,
  ),
  const Icon(
    Icons.local_cafe_outlined,
    size: 15,
  ),
  const Icon(
    Icons.sports_esports_outlined,
    size: 15,
  ),
  const Icon(
    Icons.vrpano_outlined,
    size: 15,
  ),
  const Icon(
    Icons.forest_outlined,
    size: 15,
  ),
  const Icon(
    Icons.nature_people_outlined,
    size: 15,
  ),
  const Icon(
    Icons.directions_walk_outlined,
    size: 15,
  ),
];
