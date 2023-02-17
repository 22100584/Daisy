import 'package:daisy/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'small_bigInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daisy/config/info.dart';

String id = '';
String bigInfoid = '';

class optionalInfo1 extends StatefulWidget {
  const optionalInfo1({
    Key? key,
    required this.name,
    required this.dateS,
    required this.dateE,
    required this.place,
    required this.shareId,
  }) : super(key: key);

  final String name;
  final String dateS;
  final String dateE;
  final String place;
  final String shareId;
  @override
  State<optionalInfo1> createState() => _optionalInfo1State();
}

class _optionalInfo1State extends State<optionalInfo1> {
  UpdateDeleteItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    bigInfoid = widget.shareId;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.name,
                style: const TextStyle(
                    fontFamily: 'seoul_EB',
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff353C49)),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.dateS,
                style: const TextStyle(
                    fontFamily: 'seoul',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff353C49)),
              ),
              if (!((widget.dateE) == null))
                const Text(
                  " ~ ",
                  style: TextStyle(
                      fontFamily: 'seoul',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff353C49)),
                ),
              Text(
                widget.dateE,
                style: const TextStyle(
                    fontFamily: 'seoul',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff353C49)),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.place),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  widget.place,
                  style: const TextStyle(
                      fontFamily: 'seoul',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff353C49)),
                ),
              ),
            ],
          ),
        ]),
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text(
                "선택",
                style: TextStyle(
                    fontFamily: 'seoul',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff131A1E)),
              )),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(children: [
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
                            " 새 일정을\n추가해주세요.",
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

                                                  id = snapshot.data!
                                                          .toList()[index]
                                                          .id ??
                                                      '';
                                                  final docRef =
                                                      FirebaseFirestore
                                                          .instance
                                                          .collection("bigInfo")
                                                          .doc(widget.shareId)
                                                          .collection(
                                                              'smallInfo')
                                                          .doc(id);
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
                                                      id = snapshot.data!
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
                                final docRef = FirebaseFirestore.instance
                                    .collection("bigInfo")
                                    .doc(widget.shareId);
                                docRef.delete().then(
                                    (doc) => print("Document deleted"),
                                    onError: (e) =>
                                        print("Error updating document $e"));
                              });
                            },
                            child: GestureDetector(
                              onTap: () {
                                setState(() {});
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
                                                        .smallname ??
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
                                                const Icon(Icons.place),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                    snapshot.data!
                                                            .toList()[index]
                                                            .smallplace ??
                                                        "no place",
                                                    style: const TextStyle(
                                                        fontFamily: 'seoul',
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Color(0xff353C49)),
                                                  ),
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
                                                        id = snapshot.data!
                                                                .toList()[index]
                                                                .id ??
                                                            '';
                                                        return const updateInfo();
                                                      },
                                                    ));
                                                  }
                                                  if (selectedMenu ==
                                                      UpdateDeleteItem.delete) {
                                                    final docRef =
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "bigInfo")
                                                            .doc(widget.shareId)
                                                            .collection(
                                                                'smallInfo')
                                                            .doc(id);
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
                                                          .memo ??
                                                      "no memo",
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddSmallInfo(shareId: widget.shareId)));
        },
        child: const Image(
          image: AssetImage('assets/FAB.png'),
        ),
      ),
    );
  }
}

class FirebaseProvider {
  static final smallInfoCollection =
      FirebaseFirestore.instance.collection('smallInfo');

  static Stream<Iterable<SmallInfo>> getAllInfos() {
    userProvider.userId = FirebaseAuth.instance.currentUser!.uid;
    print(bigInfoid);
    return smallInfoCollection
        // .where('bigInfoId', isEqualTo: shareId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((docSnap) => SmallInfo.fromFirebase(docSnap)));
  }
}

enum UpdateDeleteItem { update, delete }
