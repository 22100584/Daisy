import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'add_smallInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daisy/config/info.dart';
import 'package:daisy/screens/update_smallInfo.dart';

String id = '';
String bigInfoid = '';

class optionalInfo2 extends StatefulWidget {
  const optionalInfo2({
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
  State<optionalInfo2> createState() => _optionalInfo2State();
}

class _optionalInfo2State extends State<optionalInfo2> {
  UpdateDeleteItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    bool _customTileExpanded = false;
    bigInfoid = widget.shareId;
    return Scaffold(
      backgroundColor: const Color(0xffEDF4F9),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: AppBar(
          backgroundColor: const Color(0xffD7E7EF),
          automaticallyImplyLeading: false,
          toolbarHeight: 80,
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios))
            ],
          ),
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
                if (widget.dateE.isNotEmpty)
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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "  ",
                      style: TextStyle(
                          fontFamily: 'seoul',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff131A1E)),
                    )),
              ],
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(children: [
            Column(
              children: [
                StreamBuilder(
                  stream: FirebaseProvider0.getAllInfos(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.active:
                        {
                          if (snapshot.data!.isEmpty) {
                            return const SizedBox(
                              height: 0,
                            );
                          }
                          return Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              initiallyExpanded: true,
                              iconColor: const Color(0xff1C1B1F),
                              title: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                    decoration: BoxDecoration(
                                        color: const Color(0xffFFE171),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        _CategoryIcon[0],
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          _Category[0],
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff1D192B)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              leading: Icon(
                                _customTileExpanded
                                    ? Icons.arrow_drop_down_circle
                                    : Icons.arrow_drop_down,
                              ),
                              controlAffinity: ListTileControlAffinity.leading,
                              onExpansionChanged: (bool expanded) {
                                setState(() => _customTileExpanded = expanded);
                              },
                              children: <Widget>[
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    int gestureColor = snapshot.data!
                                        .toList()[index]
                                        .user_ids!
                                        .length;
                                    Color selectColor = const Color(0xffFAFCFF);
                                    if (gestureColor == 1) {
                                      selectColor = const Color(0xffFAFCFF);
                                    } else if (gestureColor == 2) {
                                      selectColor = const Color(0xffFFF0C4);
                                    } else if (gestureColor == 3) {
                                      selectColor = const Color(0xffFFE171);
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 30,
                                          right: 16,
                                          bottom: 10,
                                          top: 10),
                                      child: Dismissible(
                                        key: ValueKey(
                                            snapshot.data!.toList()[index].id),
                                        background: Container(
                                          decoration: BoxDecoration(
                                              color: const Color(0xffBFF290),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Row(
                                              children: const [
                                                Icon(Icons.edit,
                                                    color: Colors.black),
                                                Text('  수정',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 19,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        secondaryBackground: Container(
                                          decoration: BoxDecoration(
                                              color: const Color(0xffFF897D),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: const [
                                                Icon(Icons.delete,
                                                    color: Colors.black),
                                                Text('  삭제',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 19,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        onDismissed: (direction) {
                                          setState(() {
                                            final docRef = FirebaseFirestore
                                                .instance
                                                .collection("smallInfo")
                                                .doc(id);
                                            docRef.delete().then(
                                                (doc) =>
                                                    print("Document deleted"),
                                                onError: (e) => print(
                                                    "Error updating document $e"));
                                          });
                                        },
                                        confirmDismiss: (direction) async {
                                          if (direction ==
                                              DismissDirection.endToStart) {
                                            return showDialog(
                                                context: context,
                                                builder: (ctx) => AlertDialog(
                                                      backgroundColor:
                                                          const Color(
                                                              0xffFAFCFF),
                                                      title: const Text(
                                                        "삭제하시겠습니까?",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'seoul_EB',
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff131A1E),
                                                        ),
                                                      ),
                                                      content: const Text(
                                                        "정말로 데이트를 삭제하시겠습니까?",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Color(
                                                                0xff737779)),
                                                      ),
                                                      actions: [
                                                        ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xffFFFBEE), // Background color
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(ctx)
                                                                  .pop(false);
                                                            },
                                                            child: const Text(
                                                              '취소',
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Color(
                                                                    0xff131A1E),
                                                              ),
                                                            )),
                                                        ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xffFFE171), // Background color
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(ctx)
                                                                  .pop(true);

                                                              id = snapshot
                                                                      .data!
                                                                      .toList()[
                                                                          index]
                                                                      .id ??
                                                                  '';
                                                              final docRef =
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          "smallInfo")
                                                                      .doc(id);
                                                              docRef.delete().then(
                                                                  (doc) => print(
                                                                      "Document deleted"),
                                                                  onError: (e) =>
                                                                      print(
                                                                          "Error updating document $e"));
                                                            },
                                                            child: const Text(
                                                              '확인',
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Color(
                                                                    0xff131A1E),
                                                              ),
                                                            )),
                                                      ],
                                                    ));
                                          } else if (direction ==
                                              DismissDirection.startToEnd) {
                                            return showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                backgroundColor:
                                                    const Color(0xffFAFCFF),
                                                title: const Text(
                                                  "수정하시겠습니까?",
                                                  style: TextStyle(
                                                    fontFamily: 'seoul_EB',
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff131A1E),
                                                  ),
                                                ),
                                                content: const Text(
                                                  "정말로 데이트를 수정하시겠습니까?",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xff737779)),
                                                ),
                                                actions: [
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            const Color(
                                                                0xffFFFBEE), // Background color
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(ctx)
                                                            .pop(false);
                                                      },
                                                      child: const Text(
                                                        '취소',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff131A1E),
                                                        ),
                                                      )),
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            const Color(
                                                                0xffFFE171), // Background color
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(ctx)
                                                            .pop(true);
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                          builder: (context) {
                                                            id = snapshot.data!
                                                                    .toList()[
                                                                        index]
                                                                    .id ??
                                                                '';
                                                            return UpdateSmallInfo(
                                                              shareId: widget
                                                                  .shareId,
                                                              smallId: id,
                                                            );
                                                          },
                                                        ));
                                                      },
                                                      child: const Text(
                                                        '확인',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff131A1E),
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            );
                                          }
                                        },
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (snapshot.data!
                                                  .toList()[index]
                                                  .user_ids!
                                                  .contains(
                                                      userProvider.userId)) {
                                                id = snapshot.data!
                                                        .toList()[index]
                                                        .id ??
                                                    '';
                                                final docRef = FirebaseFirestore
                                                    .instance
                                                    .collection("smallInfo")
                                                    .doc(id);
                                                docRef.update({
                                                  'user-ids':
                                                      FieldValue.arrayRemove(
                                                          [userProvider.userId])
                                                });
                                              } else {
                                                id = snapshot.data!
                                                        .toList()[index]
                                                        .id ??
                                                    '';
                                                final docRef = FirebaseFirestore
                                                    .instance
                                                    .collection("smallInfo")
                                                    .doc(id);
                                                docRef.update({
                                                  'user-ids':
                                                      FieldValue.arrayUnion(
                                                          [userProvider.userId])
                                                });
                                              }
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.7),
                                                    spreadRadius: 0,
                                                    blurRadius: 1.0,
                                                    offset: const Offset(0,
                                                        2), // changes position of shadow
                                                  ),
                                                ],
                                                color: selectColor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 0, 0, 15),
                                              child: SizedBox(
                                                width: 367,
                                                child: Column(
                                                  children: [
                                                    ListTile(
                                                        title: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  0, 20, 0, 0),
                                                          child: Text(
                                                            snapshot.data!
                                                                    .toList()[
                                                                        index]
                                                                    .smallname ??
                                                                "no name",
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'seoul_EB',
                                                                fontSize: 24,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Color(
                                                                    0xff353C49)),
                                                          ),
                                                        ),
                                                        subtitle: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Icon(
                                                                Icons.place),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          8.0),
                                                              child: Text(
                                                                snapshot.data!
                                                                        .toList()[
                                                                            index]
                                                                        .smallplace ??
                                                                    "no place",
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'seoul',
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Color(
                                                                        0xff353C49)),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        trailing: PopupMenuButton<
                                                                UpdateDeleteItem>(
                                                            initialValue:
                                                                selectedMenu,
                                                            onSelected:
                                                                (UpdateDeleteItem
                                                                    item) {
                                                              selectedMenu =
                                                                  item;
                                                              if (selectedMenu ==
                                                                  UpdateDeleteItem
                                                                      .update) {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                                    id = snapshot
                                                                            .data!
                                                                            .toList()[index]
                                                                            .id ??
                                                                        '';
                                                                    return UpdateSmallInfo(
                                                                      shareId:
                                                                          widget
                                                                              .shareId,
                                                                      smallId:
                                                                          id,
                                                                    );
                                                                  },
                                                                ));
                                                              }
                                                              if (selectedMenu ==
                                                                  UpdateDeleteItem
                                                                      .delete) {
                                                                final docRef = FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        "bigInfo")
                                                                    .doc(widget
                                                                        .shareId)
                                                                    .collection(
                                                                        'smallInfo')
                                                                    .doc(id);
                                                                docRef.delete().then(
                                                                    (doc) => print(
                                                                        "Document deleted"),
                                                                    onError: (e) =>
                                                                        print(
                                                                            "Error updating document $e"));
                                                              }
                                                            },
                                                            itemBuilder: ((context) =>
                                                                <
                                                                    PopupMenuEntry<
                                                                        UpdateDeleteItem>>[
                                                                  const PopupMenuItem<
                                                                      UpdateDeleteItem>(
                                                                    value: UpdateDeleteItem
                                                                        .update,
                                                                    child: Text(
                                                                        'Update'),
                                                                  ),
                                                                  const PopupMenuItem<
                                                                      UpdateDeleteItem>(
                                                                    value: UpdateDeleteItem
                                                                        .delete,
                                                                    child: Text(
                                                                        'Delete'),
                                                                  ),
                                                                ]))),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          8, 15, 0, 0),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 8.0),
                                                            child: Text(
                                                              snapshot.data!
                                                                      .toList()[
                                                                          index]
                                                                      .memo ??
                                                                  "no memo",
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'seoul',
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Color(
                                                                      0xff353C49)),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
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
                                ),
                              ],
                            ),
                          );
                        }
                      default:
                        return const CircularProgressIndicator();
                    }
                  },
                ),
                StreamBuilder(
                  stream: FirebaseProvider1.getAllInfos(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.active:
                        {
                          if (snapshot.data!.isEmpty) {
                            return const SizedBox(
                              height: 0,
                            );
                          }
                          return Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              initiallyExpanded: true,
                              iconColor: const Color(0xff1C1B1F),
                              title: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                    decoration: BoxDecoration(
                                        color: const Color(0xffFFE171),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        _CategoryIcon[1],
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          _Category[1],
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff1D192B)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              leading: Icon(
                                _customTileExpanded
                                    ? Icons.arrow_drop_down_circle
                                    : Icons.arrow_drop_down,
                              ),
                              controlAffinity: ListTileControlAffinity.leading,
                              onExpansionChanged: (bool expanded) {
                                setState(() => _customTileExpanded = expanded);
                              },
                              children: <Widget>[
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    int gestureColor = snapshot.data!
                                        .toList()[index]
                                        .user_ids!
                                        .length;
                                    Color selectColor = const Color(0xffFAFCFF);
                                    if (gestureColor == 1) {
                                      selectColor = const Color(0xffFAFCFF);
                                    } else if (gestureColor == 2) {
                                      selectColor = const Color(0xffFFF0C4);
                                    } else if (gestureColor == 3) {
                                      selectColor = const Color(0xffFFE171);
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 30,
                                          right: 16,
                                          bottom: 10,
                                          top: 10),
                                      child: Dismissible(
                                        key: ValueKey(
                                            snapshot.data!.toList()[index].id),
                                        background: Container(
                                          decoration: BoxDecoration(
                                              color: const Color(0xffBFF290),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Row(
                                              children: const [
                                                Icon(Icons.edit,
                                                    color: Colors.black),
                                                Text('  수정',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 19,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        secondaryBackground: Container(
                                          decoration: BoxDecoration(
                                              color: const Color(0xffFF897D),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: const [
                                                Icon(Icons.delete,
                                                    color: Colors.black),
                                                Text('  삭제',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 19,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        confirmDismiss: (direction) async {
                                          if (direction ==
                                              DismissDirection.endToStart) {
                                            return showDialog(
                                                context: context,
                                                builder: (ctx) => AlertDialog(
                                                      backgroundColor:
                                                          const Color(
                                                              0xffFAFCFF),
                                                      title: const Text(
                                                        "삭제하시겠습니까?",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'seoul_EB',
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff131A1E),
                                                        ),
                                                      ),
                                                      content: const Text(
                                                        "정말로 데이트를 삭제하시겠습니까?",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Color(
                                                                0xff737779)),
                                                      ),
                                                      actions: [
                                                        ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xffFFFBEE), // Background color
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(ctx)
                                                                  .pop(false);
                                                            },
                                                            child: const Text(
                                                              '취소',
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Color(
                                                                    0xff131A1E),
                                                              ),
                                                            )),
                                                        ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xffFFE171), // Background color
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(ctx)
                                                                  .pop(true);

                                                              id = snapshot
                                                                      .data!
                                                                      .toList()[
                                                                          index]
                                                                      .id ??
                                                                  '';
                                                              final docRef =
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          "smallInfo")
                                                                      .doc(id);
                                                              docRef.delete().then(
                                                                  (doc) => print(
                                                                      "Document deleted"),
                                                                  onError: (e) =>
                                                                      print(
                                                                          "Error updating document $e"));
                                                            },
                                                            child: const Text(
                                                              '확인',
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Color(
                                                                    0xff131A1E),
                                                              ),
                                                            )),
                                                      ],
                                                    ));
                                          } else if (direction ==
                                              DismissDirection.startToEnd) {
                                            return showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                backgroundColor:
                                                    const Color(0xffFAFCFF),
                                                title: const Text(
                                                  "수정하시겠습니까?",
                                                  style: TextStyle(
                                                    fontFamily: 'seoul_EB',
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff131A1E),
                                                  ),
                                                ),
                                                content: const Text(
                                                  "정말로 데이트를 수정하시겠습니까?",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xff737779)),
                                                ),
                                                actions: [
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            const Color(
                                                                0xffFFFBEE), // Background color
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(ctx)
                                                            .pop(false);
                                                      },
                                                      child: const Text(
                                                        '취소',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff131A1E),
                                                        ),
                                                      )),
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            const Color(
                                                                0xffFFE171), // Background color
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(ctx)
                                                            .pop(true);
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                          builder: (context) {
                                                            id = snapshot.data!
                                                                    .toList()[
                                                                        index]
                                                                    .id ??
                                                                '';
                                                            return UpdateSmallInfo(
                                                              shareId: widget
                                                                  .shareId,
                                                              smallId: id,
                                                            );
                                                          },
                                                        ));
                                                      },
                                                      child: const Text(
                                                        '확인',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff131A1E),
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            );
                                          }
                                        },
                                        onDismissed: (direction) {
                                          setState(() {
                                            final docRef = FirebaseFirestore
                                                .instance
                                                .collection("smallInfo")
                                                .doc(id);
                                            docRef.delete().then(
                                                (doc) =>
                                                    print("Document deleted"),
                                                onError: (e) => print(
                                                    "Error updating document $e"));
                                          });
                                        },
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (snapshot.data!
                                                  .toList()[index]
                                                  .user_ids!
                                                  .contains(
                                                      userProvider.userId)) {
                                                id = snapshot.data!
                                                        .toList()[index]
                                                        .id ??
                                                    '';
                                                final docRef = FirebaseFirestore
                                                    .instance
                                                    .collection("smallInfo")
                                                    .doc(id);
                                                docRef.update({
                                                  'user-ids':
                                                      FieldValue.arrayRemove(
                                                          [userProvider.userId])
                                                });
                                              } else {
                                                id = snapshot.data!
                                                        .toList()[index]
                                                        .id ??
                                                    '';
                                                final docRef = FirebaseFirestore
                                                    .instance
                                                    .collection("smallInfo")
                                                    .doc(id);
                                                docRef.update({
                                                  'user-ids':
                                                      FieldValue.arrayUnion(
                                                          [userProvider.userId])
                                                });
                                              }
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.7),
                                                    spreadRadius: 0,
                                                    blurRadius: 1.0,
                                                    offset: const Offset(0,
                                                        2), // changes position of shadow
                                                  ),
                                                ],
                                                color: selectColor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 0, 0, 15),
                                              child: SizedBox(
                                                width: 367,
                                                child: Column(
                                                  children: [
                                                    ListTile(
                                                        title: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  0, 20, 0, 0),
                                                          child: Text(
                                                            snapshot.data!
                                                                    .toList()[
                                                                        index]
                                                                    .smallname ??
                                                                "no name",
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'seoul_EB',
                                                                fontSize: 24,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Color(
                                                                    0xff353C49)),
                                                          ),
                                                        ),
                                                        subtitle: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Icon(
                                                                Icons.place),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          8.0),
                                                              child: Text(
                                                                snapshot.data!
                                                                        .toList()[
                                                                            index]
                                                                        .smallplace ??
                                                                    "no place",
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'seoul',
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Color(
                                                                        0xff353C49)),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        trailing: PopupMenuButton<
                                                                UpdateDeleteItem>(
                                                            initialValue:
                                                                selectedMenu,
                                                            onSelected:
                                                                (UpdateDeleteItem
                                                                    item) {
                                                              selectedMenu =
                                                                  item;
                                                              if (selectedMenu ==
                                                                  UpdateDeleteItem
                                                                      .update) {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                                    id = snapshot
                                                                            .data!
                                                                            .toList()[index]
                                                                            .id ??
                                                                        '';
                                                                    return UpdateSmallInfo(
                                                                      shareId:
                                                                          widget
                                                                              .shareId,
                                                                      smallId:
                                                                          id,
                                                                    );
                                                                  },
                                                                ));
                                                              }
                                                              if (selectedMenu ==
                                                                  UpdateDeleteItem
                                                                      .delete) {
                                                                final docRef = FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        "bigInfo")
                                                                    .doc(widget
                                                                        .shareId)
                                                                    .collection(
                                                                        'smallInfo')
                                                                    .doc(id);
                                                                docRef.delete().then(
                                                                    (doc) => print(
                                                                        "Document deleted"),
                                                                    onError: (e) =>
                                                                        print(
                                                                            "Error updating document $e"));
                                                              }
                                                            },
                                                            itemBuilder: ((context) =>
                                                                <
                                                                    PopupMenuEntry<
                                                                        UpdateDeleteItem>>[
                                                                  const PopupMenuItem<
                                                                      UpdateDeleteItem>(
                                                                    value: UpdateDeleteItem
                                                                        .update,
                                                                    child: Text(
                                                                        'Update'),
                                                                  ),
                                                                  const PopupMenuItem<
                                                                      UpdateDeleteItem>(
                                                                    value: UpdateDeleteItem
                                                                        .delete,
                                                                    child: Text(
                                                                        'Delete'),
                                                                  ),
                                                                ]))),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          8, 15, 0, 0),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 8.0),
                                                            child: Text(
                                                              snapshot.data!
                                                                      .toList()[
                                                                          index]
                                                                      .memo ??
                                                                  "no memo",
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'seoul',
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Color(
                                                                      0xff353C49)),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
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
                                ),
                              ],
                            ),
                          );
                        }
                      default:
                        return const CircularProgressIndicator();
                    }
                  },
                ),
                StreamBuilder(
                  stream: FirebaseProvider2.getAllInfos(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.active:
                        {
                          if (snapshot.data!.isEmpty) {
                            return const SizedBox(
                              height: 0,
                            );
                          }
                          return Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              initiallyExpanded: true,
                              iconColor: const Color(0xff1C1B1F),
                              title: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                    decoration: BoxDecoration(
                                        color: const Color(0xffFFE171),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        _CategoryIcon[2],
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          _Category[2],
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff1D192B)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              leading: Icon(
                                _customTileExpanded
                                    ? Icons.arrow_drop_down_circle
                                    : Icons.arrow_drop_down,
                              ),
                              controlAffinity: ListTileControlAffinity.leading,
                              onExpansionChanged: (bool expanded) {
                                setState(() => _customTileExpanded = expanded);
                              },
                              children: <Widget>[
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    int gestureColor = snapshot.data!
                                        .toList()[index]
                                        .user_ids!
                                        .length;
                                    Color selectColor = const Color(0xffFAFCFF);
                                    if (gestureColor == 1) {
                                      selectColor = const Color(0xffFAFCFF);
                                    } else if (gestureColor == 2) {
                                      selectColor = const Color(0xffFFF0C4);
                                    } else if (gestureColor == 3) {
                                      selectColor = const Color(0xffFFE171);
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 30,
                                          right: 16,
                                          bottom: 10,
                                          top: 10),
                                      child: Dismissible(
                                        key: ValueKey(
                                            snapshot.data!.toList()[index].id),
                                        background: Container(
                                          decoration: BoxDecoration(
                                              color: const Color(0xffBFF290),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Row(
                                              children: const [
                                                Icon(Icons.edit,
                                                    color: Colors.black),
                                                Text('  수정',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 19,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        secondaryBackground: Container(
                                          decoration: BoxDecoration(
                                              color: const Color(0xffFF897D),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: const [
                                                Icon(Icons.delete,
                                                    color: Colors.black),
                                                Text('  삭제',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 19,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        confirmDismiss: (direction) async {
                                          if (direction ==
                                              DismissDirection.endToStart) {
                                            return showDialog(
                                                context: context,
                                                builder: (ctx) => AlertDialog(
                                                      backgroundColor:
                                                          const Color(
                                                              0xffFAFCFF),
                                                      title: const Text(
                                                        "삭제하시겠습니까?",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'seoul_EB',
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff131A1E),
                                                        ),
                                                      ),
                                                      content: const Text(
                                                        "정말로 데이트를 삭제하시겠습니까?",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Color(
                                                                0xff737779)),
                                                      ),
                                                      actions: [
                                                        ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xffFFFBEE), // Background color
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(ctx)
                                                                  .pop(false);
                                                            },
                                                            child: const Text(
                                                              '취소',
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Color(
                                                                    0xff131A1E),
                                                              ),
                                                            )),
                                                        ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xffFFE171), // Background color
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(ctx)
                                                                  .pop(true);

                                                              id = snapshot
                                                                      .data!
                                                                      .toList()[
                                                                          index]
                                                                      .id ??
                                                                  '';
                                                              final docRef =
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          "smallInfo")
                                                                      .doc(id);
                                                              docRef.delete().then(
                                                                  (doc) => print(
                                                                      "Document deleted"),
                                                                  onError: (e) =>
                                                                      print(
                                                                          "Error updating document $e"));
                                                            },
                                                            child: const Text(
                                                              '확인',
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Color(
                                                                    0xff131A1E),
                                                              ),
                                                            )),
                                                      ],
                                                    ));
                                          } else if (direction ==
                                              DismissDirection.startToEnd) {
                                            return showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                backgroundColor:
                                                    const Color(0xffFAFCFF),
                                                title: const Text(
                                                  "수정하시겠습니까?",
                                                  style: TextStyle(
                                                    fontFamily: 'seoul_EB',
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff131A1E),
                                                  ),
                                                ),
                                                content: const Text(
                                                  "정말로 데이트를 수정하시겠습니까?",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xff737779)),
                                                ),
                                                actions: [
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            const Color(
                                                                0xffFFFBEE), // Background color
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(ctx)
                                                            .pop(false);
                                                      },
                                                      child: const Text(
                                                        '취소',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff131A1E),
                                                        ),
                                                      )),
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            const Color(
                                                                0xffFFE171), // Background color
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(ctx)
                                                            .pop(true);
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                          builder: (context) {
                                                            id = snapshot.data!
                                                                    .toList()[
                                                                        index]
                                                                    .id ??
                                                                '';
                                                            return UpdateSmallInfo(
                                                              shareId: widget
                                                                  .shareId,
                                                              smallId: id,
                                                            );
                                                          },
                                                        ));
                                                      },
                                                      child: const Text(
                                                        '확인',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff131A1E),
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            );
                                          }
                                        },
                                        onDismissed: (direction) {
                                          setState(() {
                                            final docRef = FirebaseFirestore
                                                .instance
                                                .collection("smallInfo")
                                                .doc(id);
                                            docRef.delete().then(
                                                (doc) =>
                                                    print("Document deleted"),
                                                onError: (e) => print(
                                                    "Error updating document $e"));
                                          });
                                        },
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (snapshot.data!
                                                  .toList()[index]
                                                  .user_ids!
                                                  .contains(
                                                      userProvider.userId)) {
                                                id = snapshot.data!
                                                        .toList()[index]
                                                        .id ??
                                                    '';
                                                final docRef = FirebaseFirestore
                                                    .instance
                                                    .collection("smallInfo")
                                                    .doc(id);
                                                docRef.update({
                                                  'user-ids':
                                                      FieldValue.arrayRemove(
                                                          [userProvider.userId])
                                                });
                                              } else {
                                                id = snapshot.data!
                                                        .toList()[index]
                                                        .id ??
                                                    '';
                                                final docRef = FirebaseFirestore
                                                    .instance
                                                    .collection("smallInfo")
                                                    .doc(id);
                                                docRef.update({
                                                  'user-ids':
                                                      FieldValue.arrayUnion(
                                                          [userProvider.userId])
                                                });
                                              }
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.7),
                                                    spreadRadius: 0,
                                                    blurRadius: 1.0,
                                                    offset: const Offset(0,
                                                        2), // changes position of shadow
                                                  ),
                                                ],
                                                color: selectColor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 0, 0, 15),
                                              child: SizedBox(
                                                width: 367,
                                                child: Column(
                                                  children: [
                                                    ListTile(
                                                        title: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  0, 20, 0, 0),
                                                          child: Text(
                                                            snapshot.data!
                                                                    .toList()[
                                                                        index]
                                                                    .smallname ??
                                                                "no name",
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'seoul_EB',
                                                                fontSize: 24,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Color(
                                                                    0xff353C49)),
                                                          ),
                                                        ),
                                                        subtitle: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Icon(
                                                                Icons.place),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          8.0),
                                                              child: Text(
                                                                snapshot.data!
                                                                        .toList()[
                                                                            index]
                                                                        .smallplace ??
                                                                    "no place",
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'seoul',
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Color(
                                                                        0xff353C49)),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        trailing: PopupMenuButton<
                                                                UpdateDeleteItem>(
                                                            initialValue:
                                                                selectedMenu,
                                                            onSelected:
                                                                (UpdateDeleteItem
                                                                    item) {
                                                              selectedMenu =
                                                                  item;
                                                              if (selectedMenu ==
                                                                  UpdateDeleteItem
                                                                      .update) {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                                    id = snapshot
                                                                            .data!
                                                                            .toList()[index]
                                                                            .id ??
                                                                        '';
                                                                    return UpdateSmallInfo(
                                                                      shareId:
                                                                          widget
                                                                              .shareId,
                                                                      smallId:
                                                                          id,
                                                                    );
                                                                  },
                                                                ));
                                                              }
                                                              if (selectedMenu ==
                                                                  UpdateDeleteItem
                                                                      .delete) {
                                                                final docRef = FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        "bigInfo")
                                                                    .doc(widget
                                                                        .shareId)
                                                                    .collection(
                                                                        'smallInfo')
                                                                    .doc(id);
                                                                docRef.delete().then(
                                                                    (doc) => print(
                                                                        "Document deleted"),
                                                                    onError: (e) =>
                                                                        print(
                                                                            "Error updating document $e"));
                                                              }
                                                            },
                                                            itemBuilder: ((context) =>
                                                                <
                                                                    PopupMenuEntry<
                                                                        UpdateDeleteItem>>[
                                                                  const PopupMenuItem<
                                                                      UpdateDeleteItem>(
                                                                    value: UpdateDeleteItem
                                                                        .update,
                                                                    child: Text(
                                                                        'Update'),
                                                                  ),
                                                                  const PopupMenuItem<
                                                                      UpdateDeleteItem>(
                                                                    value: UpdateDeleteItem
                                                                        .delete,
                                                                    child: Text(
                                                                        'Delete'),
                                                                  ),
                                                                ]))),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          8, 15, 0, 0),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 8.0),
                                                            child: Text(
                                                              snapshot.data!
                                                                      .toList()[
                                                                          index]
                                                                      .memo ??
                                                                  "no memo",
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'seoul',
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Color(
                                                                      0xff353C49)),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
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
                                ),
                              ],
                            ),
                          );
                        }
                      default:
                        return const CircularProgressIndicator();
                    }
                  },
                ),
                StreamBuilder(
                  stream: FirebaseProvider3.getAllInfos(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.active:
                        {
                          if (snapshot.data!.isEmpty) {
                            return const SizedBox(
                              height: 0,
                            );
                          }
                          return Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              initiallyExpanded: true,
                              iconColor: const Color(0xff1C1B1F),
                              title: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                    decoration: BoxDecoration(
                                        color: const Color(0xffFFE171),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        _CategoryIcon[3],
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          _Category[3],
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff1D192B)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              leading: Icon(
                                _customTileExpanded
                                    ? Icons.arrow_drop_down_circle
                                    : Icons.arrow_drop_down,
                              ),
                              controlAffinity: ListTileControlAffinity.leading,
                              onExpansionChanged: (bool expanded) {
                                setState(() => _customTileExpanded = expanded);
                              },
                              children: <Widget>[
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    int gestureColor = snapshot.data!
                                        .toList()[index]
                                        .user_ids!
                                        .length;
                                    Color selectColor = const Color(0xffFAFCFF);
                                    if (gestureColor == 1) {
                                      selectColor = const Color(0xffFAFCFF);
                                    } else if (gestureColor == 2) {
                                      selectColor = const Color(0xffFFF0C4);
                                    } else if (gestureColor == 3) {
                                      selectColor = const Color(0xffFFE171);
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 30,
                                          right: 16,
                                          bottom: 10,
                                          top: 10),
                                      child: Dismissible(
                                        key: ValueKey(
                                            snapshot.data!.toList()[index].id),
                                        background: Container(
                                          decoration: BoxDecoration(
                                              color: const Color(0xffBFF290),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Row(
                                              children: const [
                                                Icon(Icons.edit,
                                                    color: Colors.black),
                                                Text('  수정',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 19,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        secondaryBackground: Container(
                                          decoration: BoxDecoration(
                                              color: const Color(0xffFF897D),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: const [
                                                Icon(Icons.delete,
                                                    color: Colors.black),
                                                Text('  삭제',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 19,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        confirmDismiss: (direction) async {
                                          if (direction ==
                                              DismissDirection.endToStart) {
                                            return showDialog(
                                                context: context,
                                                builder: (ctx) => AlertDialog(
                                                      backgroundColor:
                                                          const Color(
                                                              0xffFAFCFF),
                                                      title: const Text(
                                                        "삭제하시겠습니까?",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'seoul_EB',
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff131A1E),
                                                        ),
                                                      ),
                                                      content: const Text(
                                                        "정말로 데이트를 삭제하시겠습니까?",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Color(
                                                                0xff737779)),
                                                      ),
                                                      actions: [
                                                        ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xffFFFBEE), // Background color
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(ctx)
                                                                  .pop(false);
                                                            },
                                                            child: const Text(
                                                              '취소',
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Color(
                                                                    0xff131A1E),
                                                              ),
                                                            )),
                                                        ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xffFFE171), // Background color
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(ctx)
                                                                  .pop(true);

                                                              id = snapshot
                                                                      .data!
                                                                      .toList()[
                                                                          index]
                                                                      .id ??
                                                                  '';
                                                              final docRef =
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          "smallInfo")
                                                                      .doc(id);
                                                              docRef.delete().then(
                                                                  (doc) => print(
                                                                      "Document deleted"),
                                                                  onError: (e) =>
                                                                      print(
                                                                          "Error updating document $e"));
                                                            },
                                                            child: const Text(
                                                              '확인',
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Color(
                                                                    0xff131A1E),
                                                              ),
                                                            )),
                                                      ],
                                                    ));
                                          } else if (direction ==
                                              DismissDirection.startToEnd) {
                                            return showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                backgroundColor:
                                                    const Color(0xffFAFCFF),
                                                title: const Text(
                                                  "수정하시겠습니까?",
                                                  style: TextStyle(
                                                    fontFamily: 'seoul_EB',
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff131A1E),
                                                  ),
                                                ),
                                                content: const Text(
                                                  "정말로 데이트를 수정하시겠습니까?",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xff737779)),
                                                ),
                                                actions: [
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            const Color(
                                                                0xffFFFBEE), // Background color
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(ctx)
                                                            .pop(false);
                                                      },
                                                      child: const Text(
                                                        '취소',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff131A1E),
                                                        ),
                                                      )),
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            const Color(
                                                                0xffFFE171), // Background color
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(ctx)
                                                            .pop(true);
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                          builder: (context) {
                                                            id = snapshot.data!
                                                                    .toList()[
                                                                        index]
                                                                    .id ??
                                                                '';
                                                            return UpdateSmallInfo(
                                                              shareId: widget
                                                                  .shareId,
                                                              smallId: id,
                                                            );
                                                          },
                                                        ));
                                                      },
                                                      child: const Text(
                                                        '확인',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff131A1E),
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            );
                                          }
                                        },
                                        onDismissed: (direction) {
                                          setState(() {
                                            final docRef = FirebaseFirestore
                                                .instance
                                                .collection("smallInfo")
                                                .doc(id);
                                            docRef.delete().then(
                                                (doc) =>
                                                    print("Document deleted"),
                                                onError: (e) => print(
                                                    "Error updating document $e"));
                                          });
                                        },
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (snapshot.data!
                                                  .toList()[index]
                                                  .user_ids!
                                                  .contains(
                                                      userProvider.userId)) {
                                                id = snapshot.data!
                                                        .toList()[index]
                                                        .id ??
                                                    '';
                                                final docRef = FirebaseFirestore
                                                    .instance
                                                    .collection("smallInfo")
                                                    .doc(id);
                                                docRef.update({
                                                  'user-ids':
                                                      FieldValue.arrayRemove(
                                                          [userProvider.userId])
                                                });
                                              } else {
                                                id = snapshot.data!
                                                        .toList()[index]
                                                        .id ??
                                                    '';
                                                final docRef = FirebaseFirestore
                                                    .instance
                                                    .collection("smallInfo")
                                                    .doc(id);
                                                docRef.update({
                                                  'user-ids':
                                                      FieldValue.arrayUnion(
                                                          [userProvider.userId])
                                                });
                                              }
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.7),
                                                    spreadRadius: 0,
                                                    blurRadius: 1.0,
                                                    offset: const Offset(0,
                                                        2), // changes position of shadow
                                                  ),
                                                ],
                                                color: selectColor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 0, 0, 15),
                                              child: SizedBox(
                                                width: 367,
                                                child: Column(
                                                  children: [
                                                    ListTile(
                                                        title: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  0, 20, 0, 0),
                                                          child: Text(
                                                            snapshot.data!
                                                                    .toList()[
                                                                        index]
                                                                    .smallname ??
                                                                "no name",
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'seoul_EB',
                                                                fontSize: 24,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Color(
                                                                    0xff353C49)),
                                                          ),
                                                        ),
                                                        subtitle: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Icon(
                                                                Icons.place),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          8.0),
                                                              child: Text(
                                                                snapshot.data!
                                                                        .toList()[
                                                                            index]
                                                                        .smallplace ??
                                                                    "no place",
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'seoul',
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Color(
                                                                        0xff353C49)),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        trailing: PopupMenuButton<
                                                                UpdateDeleteItem>(
                                                            initialValue:
                                                                selectedMenu,
                                                            onSelected:
                                                                (UpdateDeleteItem
                                                                    item) {
                                                              selectedMenu =
                                                                  item;
                                                              if (selectedMenu ==
                                                                  UpdateDeleteItem
                                                                      .update) {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                                    id = snapshot
                                                                            .data!
                                                                            .toList()[index]
                                                                            .id ??
                                                                        '';
                                                                    return UpdateSmallInfo(
                                                                      shareId:
                                                                          widget
                                                                              .shareId,
                                                                      smallId:
                                                                          id,
                                                                    );
                                                                  },
                                                                ));
                                                              }
                                                              if (selectedMenu ==
                                                                  UpdateDeleteItem
                                                                      .delete) {
                                                                final docRef = FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        "bigInfo")
                                                                    .doc(widget
                                                                        .shareId)
                                                                    .collection(
                                                                        'smallInfo')
                                                                    .doc(id);
                                                                docRef.delete().then(
                                                                    (doc) => print(
                                                                        "Document deleted"),
                                                                    onError: (e) =>
                                                                        print(
                                                                            "Error updating document $e"));
                                                              }
                                                            },
                                                            itemBuilder: ((context) =>
                                                                <
                                                                    PopupMenuEntry<
                                                                        UpdateDeleteItem>>[
                                                                  const PopupMenuItem<
                                                                      UpdateDeleteItem>(
                                                                    value: UpdateDeleteItem
                                                                        .update,
                                                                    child: Text(
                                                                        'Update'),
                                                                  ),
                                                                  const PopupMenuItem<
                                                                      UpdateDeleteItem>(
                                                                    value: UpdateDeleteItem
                                                                        .delete,
                                                                    child: Text(
                                                                        'Delete'),
                                                                  ),
                                                                ]))),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          8, 15, 0, 0),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 8.0),
                                                            child: Text(
                                                              snapshot.data!
                                                                      .toList()[
                                                                          index]
                                                                      .memo ??
                                                                  "no memo",
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'seoul',
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Color(
                                                                      0xff353C49)),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
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
                                ),
                              ],
                            ),
                          );
                        }
                      default:
                        return const CircularProgressIndicator();
                    }
                  },
                ),
                StreamBuilder(
                  stream: FirebaseProvider4.getAllInfos(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.active:
                        {
                          if (snapshot.data!.isEmpty) {
                            return const SizedBox(
                              height: 0,
                            );
                          }
                          return Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              initiallyExpanded: true,
                              iconColor: const Color(0xff1C1B1F),
                              title: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                    decoration: BoxDecoration(
                                        color: const Color(0xffFFE171),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        _CategoryIcon[4],
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          _Category[4],
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff1D192B)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              leading: Icon(
                                _customTileExpanded
                                    ? Icons.arrow_drop_down_circle
                                    : Icons.arrow_drop_down,
                              ),
                              controlAffinity: ListTileControlAffinity.leading,
                              onExpansionChanged: (bool expanded) {
                                setState(() => _customTileExpanded = expanded);
                              },
                              children: <Widget>[
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    int gestureColor = snapshot.data!
                                        .toList()[index]
                                        .user_ids!
                                        .length;
                                    Color selectColor = const Color(0xffFAFCFF);
                                    if (gestureColor == 1) {
                                      selectColor = const Color(0xffFAFCFF);
                                    } else if (gestureColor == 2) {
                                      selectColor = const Color(0xffFFF0C4);
                                    } else if (gestureColor == 3) {
                                      selectColor = const Color(0xffFFE171);
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 30,
                                          right: 16,
                                          bottom: 10,
                                          top: 10),
                                      child: Dismissible(
                                        key: ValueKey(
                                            snapshot.data!.toList()[index].id),
                                        background: Container(
                                          decoration: BoxDecoration(
                                              color: const Color(0xffBFF290),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Row(
                                              children: const [
                                                Icon(Icons.edit,
                                                    color: Colors.black),
                                                Text('  수정',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 19,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        secondaryBackground: Container(
                                          decoration: BoxDecoration(
                                              color: const Color(0xffFF897D),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: const [
                                                Icon(Icons.delete,
                                                    color: Colors.black),
                                                Text('  삭제',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 19,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        confirmDismiss: (direction) async {
                                          if (direction ==
                                              DismissDirection.endToStart) {
                                            return showDialog(
                                                context: context,
                                                builder: (ctx) => AlertDialog(
                                                      backgroundColor:
                                                          const Color(
                                                              0xffFAFCFF),
                                                      title: const Text(
                                                        "삭제하시겠습니까?",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'seoul_EB',
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff131A1E),
                                                        ),
                                                      ),
                                                      content: const Text(
                                                        "정말로 데이트를 삭제하시겠습니까?",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Color(
                                                                0xff737779)),
                                                      ),
                                                      actions: [
                                                        ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xffFFFBEE), // Background color
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(ctx)
                                                                  .pop(false);
                                                            },
                                                            child: const Text(
                                                              '취소',
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Color(
                                                                    0xff131A1E),
                                                              ),
                                                            )),
                                                        ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xffFFE171), // Background color
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(ctx)
                                                                  .pop(true);

                                                              id = snapshot
                                                                      .data!
                                                                      .toList()[
                                                                          index]
                                                                      .id ??
                                                                  '';
                                                              final docRef =
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          "smallInfo")
                                                                      .doc(id);
                                                              docRef.delete().then(
                                                                  (doc) => print(
                                                                      "Document deleted"),
                                                                  onError: (e) =>
                                                                      print(
                                                                          "Error updating document $e"));
                                                            },
                                                            child: const Text(
                                                              '확인',
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Color(
                                                                    0xff131A1E),
                                                              ),
                                                            )),
                                                      ],
                                                    ));
                                          } else if (direction ==
                                              DismissDirection.startToEnd) {
                                            return showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                backgroundColor:
                                                    const Color(0xffFAFCFF),
                                                title: const Text(
                                                  "수정하시겠습니까?",
                                                  style: TextStyle(
                                                    fontFamily: 'seoul_EB',
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff131A1E),
                                                  ),
                                                ),
                                                content: const Text(
                                                  "정말로 데이트를 수정하시겠습니까?",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xff737779)),
                                                ),
                                                actions: [
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            const Color(
                                                                0xffFFFBEE), // Background color
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(ctx)
                                                            .pop(false);
                                                      },
                                                      child: const Text(
                                                        '취소',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff131A1E),
                                                        ),
                                                      )),
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            const Color(
                                                                0xffFFE171), // Background color
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(ctx)
                                                            .pop(true);
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                          builder: (context) {
                                                            id = snapshot.data!
                                                                    .toList()[
                                                                        index]
                                                                    .id ??
                                                                '';
                                                            return UpdateSmallInfo(
                                                              shareId: widget
                                                                  .shareId,
                                                              smallId: id,
                                                            );
                                                          },
                                                        ));
                                                      },
                                                      child: const Text(
                                                        '확인',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff131A1E),
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            );
                                          }
                                        },
                                        onDismissed: (direction) {
                                          setState(() {
                                            final docRef = FirebaseFirestore
                                                .instance
                                                .collection("smallInfo")
                                                .doc(id);
                                            docRef.delete().then(
                                                (doc) =>
                                                    print("Document deleted"),
                                                onError: (e) => print(
                                                    "Error updating document $e"));
                                          });
                                        },
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (snapshot.data!
                                                  .toList()[index]
                                                  .user_ids!
                                                  .contains(
                                                      userProvider.userId)) {
                                                id = snapshot.data!
                                                        .toList()[index]
                                                        .id ??
                                                    '';
                                                final docRef = FirebaseFirestore
                                                    .instance
                                                    .collection("smallInfo")
                                                    .doc(id);
                                                docRef.update({
                                                  'user-ids':
                                                      FieldValue.arrayRemove(
                                                          [userProvider.userId])
                                                });
                                              } else {
                                                id = snapshot.data!
                                                        .toList()[index]
                                                        .id ??
                                                    '';
                                                final docRef = FirebaseFirestore
                                                    .instance
                                                    .collection("smallInfo")
                                                    .doc(id);
                                                docRef.update({
                                                  'user-ids':
                                                      FieldValue.arrayUnion(
                                                          [userProvider.userId])
                                                });
                                              }
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.7),
                                                    spreadRadius: 0,
                                                    blurRadius: 1.0,
                                                    offset: const Offset(0,
                                                        2), // changes position of shadow
                                                  ),
                                                ],
                                                color: selectColor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 0, 0, 15),
                                              child: SizedBox(
                                                width: 367,
                                                child: Column(
                                                  children: [
                                                    ListTile(
                                                        title: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  0, 20, 0, 0),
                                                          child: Text(
                                                            snapshot.data!
                                                                    .toList()[
                                                                        index]
                                                                    .smallname ??
                                                                "no name",
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'seoul_EB',
                                                                fontSize: 24,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Color(
                                                                    0xff353C49)),
                                                          ),
                                                        ),
                                                        subtitle: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Icon(
                                                                Icons.place),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          8.0),
                                                              child: Text(
                                                                snapshot.data!
                                                                        .toList()[
                                                                            index]
                                                                        .smallplace ??
                                                                    "no place",
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'seoul',
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Color(
                                                                        0xff353C49)),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        trailing: PopupMenuButton<
                                                                UpdateDeleteItem>(
                                                            initialValue:
                                                                selectedMenu,
                                                            onSelected:
                                                                (UpdateDeleteItem
                                                                    item) {
                                                              selectedMenu =
                                                                  item;
                                                              if (selectedMenu ==
                                                                  UpdateDeleteItem
                                                                      .update) {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                                    id = snapshot
                                                                            .data!
                                                                            .toList()[index]
                                                                            .id ??
                                                                        '';
                                                                    return UpdateSmallInfo(
                                                                      shareId:
                                                                          widget
                                                                              .shareId,
                                                                      smallId:
                                                                          id,
                                                                    );
                                                                  },
                                                                ));
                                                              }
                                                              if (selectedMenu ==
                                                                  UpdateDeleteItem
                                                                      .delete) {
                                                                final docRef = FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        "bigInfo")
                                                                    .doc(widget
                                                                        .shareId)
                                                                    .collection(
                                                                        'smallInfo')
                                                                    .doc(id);
                                                                docRef.delete().then(
                                                                    (doc) => print(
                                                                        "Document deleted"),
                                                                    onError: (e) =>
                                                                        print(
                                                                            "Error updating document $e"));
                                                              }
                                                            },
                                                            itemBuilder: ((context) =>
                                                                <
                                                                    PopupMenuEntry<
                                                                        UpdateDeleteItem>>[
                                                                  const PopupMenuItem<
                                                                      UpdateDeleteItem>(
                                                                    value: UpdateDeleteItem
                                                                        .update,
                                                                    child: Text(
                                                                        'Update'),
                                                                  ),
                                                                  const PopupMenuItem<
                                                                      UpdateDeleteItem>(
                                                                    value: UpdateDeleteItem
                                                                        .delete,
                                                                    child: Text(
                                                                        'Delete'),
                                                                  ),
                                                                ]))),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          8, 15, 0, 0),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 8.0),
                                                            child: Text(
                                                              snapshot.data!
                                                                      .toList()[
                                                                          index]
                                                                      .memo ??
                                                                  "no memo",
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'seoul',
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Color(
                                                                      0xff353C49)),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
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
                                ),
                              ],
                            ),
                          );
                        }
                      default:
                        return const CircularProgressIndicator();
                    }
                  },
                ),
                StreamBuilder(
                  stream: FirebaseProvider5.getAllInfos(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.active:
                        {
                          if (snapshot.data!.isEmpty) {
                            return const SizedBox(
                              height: 0,
                            );
                          }
                          return Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              initiallyExpanded: true,
                              iconColor: const Color(0xff1C1B1F),
                              title: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                    decoration: BoxDecoration(
                                        color: const Color(0xffFFE171),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        _CategoryIcon[5],
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          _Category[5],
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff1D192B)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              leading: Icon(
                                _customTileExpanded
                                    ? Icons.arrow_drop_down_circle
                                    : Icons.arrow_drop_down,
                              ),
                              controlAffinity: ListTileControlAffinity.leading,
                              onExpansionChanged: (bool expanded) {
                                setState(() => _customTileExpanded = expanded);
                              },
                              children: <Widget>[
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    int gestureColor = snapshot.data!
                                        .toList()[index]
                                        .user_ids!
                                        .length;
                                    Color selectColor = const Color(0xffFAFCFF);
                                    if (gestureColor == 1) {
                                      selectColor = const Color(0xffFAFCFF);
                                    } else if (gestureColor == 2) {
                                      selectColor = const Color(0xffFFF0C4);
                                    } else if (gestureColor == 3) {
                                      selectColor = const Color(0xffFFE171);
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 30,
                                          right: 16,
                                          bottom: 10,
                                          top: 10),
                                      child: Dismissible(
                                        key: ValueKey(
                                            snapshot.data!.toList()[index].id),
                                        background: Container(
                                          decoration: BoxDecoration(
                                              color: const Color(0xffBFF290),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Row(
                                              children: const [
                                                Icon(Icons.edit,
                                                    color: Colors.black),
                                                Text('  수정',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 19,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        secondaryBackground: Container(
                                          decoration: BoxDecoration(
                                              color: const Color(0xffFF897D),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: const [
                                                Icon(Icons.delete,
                                                    color: Colors.black),
                                                Text('  삭제',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 19,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        confirmDismiss: (direction) async {
                                          if (direction ==
                                              DismissDirection.endToStart) {
                                            return showDialog(
                                                context: context,
                                                builder: (ctx) => AlertDialog(
                                                      backgroundColor:
                                                          const Color(
                                                              0xffFAFCFF),
                                                      title: const Text(
                                                        "삭제하시겠습니까?",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'seoul_EB',
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff131A1E),
                                                        ),
                                                      ),
                                                      content: const Text(
                                                        "정말로 데이트를 삭제하시겠습니까?",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Color(
                                                                0xff737779)),
                                                      ),
                                                      actions: [
                                                        ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xffFFFBEE), // Background color
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(ctx)
                                                                  .pop(false);
                                                            },
                                                            child: const Text(
                                                              '취소',
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Color(
                                                                    0xff131A1E),
                                                              ),
                                                            )),
                                                        ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xffFFE171), // Background color
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(ctx)
                                                                  .pop(true);

                                                              id = snapshot
                                                                      .data!
                                                                      .toList()[
                                                                          index]
                                                                      .id ??
                                                                  '';
                                                              final docRef =
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          "smallInfo")
                                                                      .doc(id);
                                                              docRef.delete().then(
                                                                  (doc) => print(
                                                                      "Document deleted"),
                                                                  onError: (e) =>
                                                                      print(
                                                                          "Error updating document $e"));
                                                            },
                                                            child: const Text(
                                                              '확인',
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Color(
                                                                    0xff131A1E),
                                                              ),
                                                            )),
                                                      ],
                                                    ));
                                          } else if (direction ==
                                              DismissDirection.startToEnd) {
                                            return showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                backgroundColor:
                                                    const Color(0xffFAFCFF),
                                                title: const Text(
                                                  "수정하시겠습니까?",
                                                  style: TextStyle(
                                                    fontFamily: 'seoul_EB',
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff131A1E),
                                                  ),
                                                ),
                                                content: const Text(
                                                  "정말로 데이트를 수정하시겠습니까?",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xff737779)),
                                                ),
                                                actions: [
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            const Color(
                                                                0xffFFFBEE), // Background color
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(ctx)
                                                            .pop(false);
                                                      },
                                                      child: const Text(
                                                        '취소',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff131A1E),
                                                        ),
                                                      )),
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            const Color(
                                                                0xffFFE171), // Background color
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(ctx)
                                                            .pop(true);
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                          builder: (context) {
                                                            id = snapshot.data!
                                                                    .toList()[
                                                                        index]
                                                                    .id ??
                                                                '';
                                                            return UpdateSmallInfo(
                                                              shareId: widget
                                                                  .shareId,
                                                              smallId: id,
                                                            );
                                                          },
                                                        ));
                                                      },
                                                      child: const Text(
                                                        '확인',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff131A1E),
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            );
                                          }
                                        },
                                        onDismissed: (direction) {
                                          setState(() {
                                            final docRef = FirebaseFirestore
                                                .instance
                                                .collection("smallInfo")
                                                .doc(id);
                                            docRef.delete().then(
                                                (doc) =>
                                                    print("Document deleted"),
                                                onError: (e) => print(
                                                    "Error updating document $e"));
                                          });
                                        },
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (snapshot.data!
                                                  .toList()[index]
                                                  .user_ids!
                                                  .contains(
                                                      userProvider.userId)) {
                                                id = snapshot.data!
                                                        .toList()[index]
                                                        .id ??
                                                    '';
                                                final docRef = FirebaseFirestore
                                                    .instance
                                                    .collection("smallInfo")
                                                    .doc(id);
                                                docRef.update({
                                                  'user-ids':
                                                      FieldValue.arrayRemove(
                                                          [userProvider.userId])
                                                });
                                              } else {
                                                id = snapshot.data!
                                                        .toList()[index]
                                                        .id ??
                                                    '';
                                                final docRef = FirebaseFirestore
                                                    .instance
                                                    .collection("smallInfo")
                                                    .doc(id);
                                                docRef.update({
                                                  'user-ids':
                                                      FieldValue.arrayUnion(
                                                          [userProvider.userId])
                                                });
                                              }
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.7),
                                                    spreadRadius: 0,
                                                    blurRadius: 1.0,
                                                    offset: const Offset(0,
                                                        2), // changes position of shadow
                                                  ),
                                                ],
                                                color: selectColor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 0, 0, 15),
                                              child: SizedBox(
                                                width: 367,
                                                child: Column(
                                                  children: [
                                                    ListTile(
                                                        title: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  0, 20, 0, 0),
                                                          child: Text(
                                                            snapshot.data!
                                                                    .toList()[
                                                                        index]
                                                                    .smallname ??
                                                                "no name",
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'seoul_EB',
                                                                fontSize: 24,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Color(
                                                                    0xff353C49)),
                                                          ),
                                                        ),
                                                        subtitle: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Icon(
                                                                Icons.place),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          8.0),
                                                              child: Text(
                                                                snapshot.data!
                                                                        .toList()[
                                                                            index]
                                                                        .smallplace ??
                                                                    "no place",
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'seoul',
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Color(
                                                                        0xff353C49)),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        trailing: PopupMenuButton<
                                                                UpdateDeleteItem>(
                                                            initialValue:
                                                                selectedMenu,
                                                            onSelected:
                                                                (UpdateDeleteItem
                                                                    item) {
                                                              selectedMenu =
                                                                  item;
                                                              if (selectedMenu ==
                                                                  UpdateDeleteItem
                                                                      .update) {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                                    id = snapshot
                                                                            .data!
                                                                            .toList()[index]
                                                                            .id ??
                                                                        '';
                                                                    return UpdateSmallInfo(
                                                                      shareId:
                                                                          widget
                                                                              .shareId,
                                                                      smallId:
                                                                          id,
                                                                    );
                                                                  },
                                                                ));
                                                              }
                                                              if (selectedMenu ==
                                                                  UpdateDeleteItem
                                                                      .delete) {
                                                                final docRef = FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        "bigInfo")
                                                                    .doc(widget
                                                                        .shareId)
                                                                    .collection(
                                                                        'smallInfo')
                                                                    .doc(id);
                                                                docRef.delete().then(
                                                                    (doc) => print(
                                                                        "Document deleted"),
                                                                    onError: (e) =>
                                                                        print(
                                                                            "Error updating document $e"));
                                                              }
                                                            },
                                                            itemBuilder: ((context) =>
                                                                <
                                                                    PopupMenuEntry<
                                                                        UpdateDeleteItem>>[
                                                                  const PopupMenuItem<
                                                                      UpdateDeleteItem>(
                                                                    value: UpdateDeleteItem
                                                                        .update,
                                                                    child: Text(
                                                                        'Update'),
                                                                  ),
                                                                  const PopupMenuItem<
                                                                      UpdateDeleteItem>(
                                                                    value: UpdateDeleteItem
                                                                        .delete,
                                                                    child: Text(
                                                                        'Delete'),
                                                                  ),
                                                                ]))),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          8, 15, 0, 0),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 8.0),
                                                            child: Text(
                                                              snapshot.data!
                                                                      .toList()[
                                                                          index]
                                                                      .memo ??
                                                                  "no memo",
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'seoul',
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Color(
                                                                      0xff353C49)),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
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
                                ),
                              ],
                            ),
                          );
                        }
                      default:
                        return const CircularProgressIndicator();
                    }
                  },
                ),
                StreamBuilder(
                  stream: FirebaseProvider6.getAllInfos(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.active:
                        {
                          if (snapshot.data!.isEmpty) {
                            return const SizedBox(
                              height: 0,
                            );
                          }
                          return Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              initiallyExpanded: true,
                              iconColor: const Color(0xff1C1B1F),
                              title: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                    decoration: BoxDecoration(
                                        color: const Color(0xffFFE171),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        _CategoryIcon[6],
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          _Category[6],
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff1D192B)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              leading: Icon(
                                _customTileExpanded
                                    ? Icons.arrow_drop_down_circle
                                    : Icons.arrow_drop_down,
                              ),
                              controlAffinity: ListTileControlAffinity.leading,
                              onExpansionChanged: (bool expanded) {
                                setState(() => _customTileExpanded = expanded);
                              },
                              children: <Widget>[
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    int gestureColor = snapshot.data!
                                        .toList()[index]
                                        .user_ids!
                                        .length;
                                    Color selectColor = const Color(0xffFAFCFF);
                                    if (gestureColor == 1) {
                                      selectColor = const Color(0xffFAFCFF);
                                    } else if (gestureColor == 2) {
                                      selectColor = const Color(0xffFFF0C4);
                                    } else if (gestureColor == 3) {
                                      selectColor = const Color(0xffFFE171);
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 30,
                                          right: 16,
                                          bottom: 10,
                                          top: 10),
                                      child: Dismissible(
                                        key: ValueKey(
                                            snapshot.data!.toList()[index].id),
                                        background: Container(
                                          decoration: BoxDecoration(
                                              color: const Color(0xffBFF290),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Row(
                                              children: const [
                                                Icon(Icons.edit,
                                                    color: Colors.black),
                                                Text('  수정',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 19,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        secondaryBackground: Container(
                                          decoration: BoxDecoration(
                                              color: const Color(0xffFF897D),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: const [
                                                Icon(Icons.delete,
                                                    color: Colors.black),
                                                Text('  삭제',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 19,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        confirmDismiss: (direction) async {
                                          if (direction ==
                                              DismissDirection.endToStart) {
                                            return showDialog(
                                                context: context,
                                                builder: (ctx) => AlertDialog(
                                                      backgroundColor:
                                                          const Color(
                                                              0xffFAFCFF),
                                                      title: const Text(
                                                        "삭제하시겠습니까?",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'seoul_EB',
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff131A1E),
                                                        ),
                                                      ),
                                                      content: const Text(
                                                        "정말로 데이트를 삭제하시겠습니까?",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Color(
                                                                0xff737779)),
                                                      ),
                                                      actions: [
                                                        ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xffFFFBEE), // Background color
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(ctx)
                                                                  .pop(false);
                                                            },
                                                            child: const Text(
                                                              '취소',
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Color(
                                                                    0xff131A1E),
                                                              ),
                                                            )),
                                                        ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xffFFE171), // Background color
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(ctx)
                                                                  .pop(true);

                                                              id = snapshot
                                                                      .data!
                                                                      .toList()[
                                                                          index]
                                                                      .id ??
                                                                  '';
                                                              final docRef =
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          "smallInfo")
                                                                      .doc(id);
                                                              docRef.delete().then(
                                                                  (doc) => print(
                                                                      "Document deleted"),
                                                                  onError: (e) =>
                                                                      print(
                                                                          "Error updating document $e"));
                                                            },
                                                            child: const Text(
                                                              '확인',
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Color(
                                                                    0xff131A1E),
                                                              ),
                                                            )),
                                                      ],
                                                    ));
                                          } else if (direction ==
                                              DismissDirection.startToEnd) {
                                            return showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                backgroundColor:
                                                    const Color(0xffFAFCFF),
                                                title: const Text(
                                                  "수정하시겠습니까?",
                                                  style: TextStyle(
                                                    fontFamily: 'seoul_EB',
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff131A1E),
                                                  ),
                                                ),
                                                content: const Text(
                                                  "정말로 데이트를 수정하시겠습니까?",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xff737779)),
                                                ),
                                                actions: [
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            const Color(
                                                                0xffFFFBEE), // Background color
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(ctx)
                                                            .pop(false);
                                                      },
                                                      child: const Text(
                                                        '취소',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff131A1E),
                                                        ),
                                                      )),
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            const Color(
                                                                0xffFFE171), // Background color
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(ctx)
                                                            .pop(true);
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                          builder: (context) {
                                                            id = snapshot.data!
                                                                    .toList()[
                                                                        index]
                                                                    .id ??
                                                                '';
                                                            return UpdateSmallInfo(
                                                              shareId: widget
                                                                  .shareId,
                                                              smallId: id,
                                                            );
                                                          },
                                                        ));
                                                      },
                                                      child: const Text(
                                                        '확인',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff131A1E),
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            );
                                          }
                                        },
                                        onDismissed: (direction) {
                                          setState(() {
                                            final docRef = FirebaseFirestore
                                                .instance
                                                .collection("smallInfo")
                                                .doc(id);
                                            docRef.delete().then(
                                                (doc) =>
                                                    print("Document deleted"),
                                                onError: (e) => print(
                                                    "Error updating document $e"));
                                          });
                                        },
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (snapshot.data!
                                                  .toList()[index]
                                                  .user_ids!
                                                  .contains(
                                                      userProvider.userId)) {
                                                id = snapshot.data!
                                                        .toList()[index]
                                                        .id ??
                                                    '';
                                                final docRef = FirebaseFirestore
                                                    .instance
                                                    .collection("smallInfo")
                                                    .doc(id);
                                                docRef.update({
                                                  'user-ids':
                                                      FieldValue.arrayRemove(
                                                          [userProvider.userId])
                                                });
                                              } else {
                                                id = snapshot.data!
                                                        .toList()[index]
                                                        .id ??
                                                    '';
                                                final docRef = FirebaseFirestore
                                                    .instance
                                                    .collection("smallInfo")
                                                    .doc(id);
                                                docRef.update({
                                                  'user-ids':
                                                      FieldValue.arrayUnion(
                                                          [userProvider.userId])
                                                });
                                              }
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.7),
                                                    spreadRadius: 0,
                                                    blurRadius: 1.0,
                                                    offset: const Offset(0,
                                                        2), // changes position of shadow
                                                  ),
                                                ],
                                                color: selectColor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 0, 0, 15),
                                              child: SizedBox(
                                                width: 367,
                                                child: Column(
                                                  children: [
                                                    ListTile(
                                                        title: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  0, 20, 0, 0),
                                                          child: Text(
                                                            snapshot.data!
                                                                    .toList()[
                                                                        index]
                                                                    .smallname ??
                                                                "no name",
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'seoul_EB',
                                                                fontSize: 24,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Color(
                                                                    0xff353C49)),
                                                          ),
                                                        ),
                                                        subtitle: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Icon(
                                                                Icons.place),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          8.0),
                                                              child: Text(
                                                                snapshot.data!
                                                                        .toList()[
                                                                            index]
                                                                        .smallplace ??
                                                                    "no place",
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'seoul',
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Color(
                                                                        0xff353C49)),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        trailing: PopupMenuButton<
                                                                UpdateDeleteItem>(
                                                            initialValue:
                                                                selectedMenu,
                                                            onSelected:
                                                                (UpdateDeleteItem
                                                                    item) {
                                                              selectedMenu =
                                                                  item;
                                                              if (selectedMenu ==
                                                                  UpdateDeleteItem
                                                                      .update) {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                                    id = snapshot
                                                                            .data!
                                                                            .toList()[index]
                                                                            .id ??
                                                                        '';
                                                                    return UpdateSmallInfo(
                                                                      shareId:
                                                                          widget
                                                                              .shareId,
                                                                      smallId:
                                                                          id,
                                                                    );
                                                                  },
                                                                ));
                                                              }
                                                              if (selectedMenu ==
                                                                  UpdateDeleteItem
                                                                      .delete) {
                                                                final docRef = FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        "bigInfo")
                                                                    .doc(widget
                                                                        .shareId)
                                                                    .collection(
                                                                        'smallInfo')
                                                                    .doc(id);
                                                                docRef.delete().then(
                                                                    (doc) => print(
                                                                        "Document deleted"),
                                                                    onError: (e) =>
                                                                        print(
                                                                            "Error updating document $e"));
                                                              }
                                                            },
                                                            itemBuilder: ((context) =>
                                                                <
                                                                    PopupMenuEntry<
                                                                        UpdateDeleteItem>>[
                                                                  const PopupMenuItem<
                                                                      UpdateDeleteItem>(
                                                                    value: UpdateDeleteItem
                                                                        .update,
                                                                    child: Text(
                                                                        'Update'),
                                                                  ),
                                                                  const PopupMenuItem<
                                                                      UpdateDeleteItem>(
                                                                    value: UpdateDeleteItem
                                                                        .delete,
                                                                    child: Text(
                                                                        'Delete'),
                                                                  ),
                                                                ]))),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          8, 15, 0, 0),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 8.0),
                                                            child: Text(
                                                              snapshot.data!
                                                                      .toList()[
                                                                          index]
                                                                      .memo ??
                                                                  "no memo",
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'seoul',
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Color(
                                                                      0xff353C49)),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
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
                                ),
                              ],
                            ),
                          );
                        }
                      default:
                        return const CircularProgressIndicator();
                    }
                  },
                ),
              ],
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
        .where('bigInfoId', isEqualTo: bigInfoid)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((docSnap) => SmallInfo.fromFirebase(docSnap)));
  }
}

enum UpdateDeleteItem { update, delete }

class FirebaseProvider0 {
  static final smallInfoCollection =
      FirebaseFirestore.instance.collection('smallInfo');

  static Stream<Iterable<SmallInfo>> getAllInfos() {
    userProvider.userId = FirebaseAuth.instance.currentUser!.uid;
    print(bigInfoid);
    return smallInfoCollection
        .where('bigInfoId', isEqualTo: bigInfoid)
        .where('category', isEqualTo: _Category[0])
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((docSnap) => SmallInfo.fromFirebase(docSnap)));
  }
}

class FirebaseProvider1 {
  static final smallInfoCollection =
      FirebaseFirestore.instance.collection('smallInfo');

  static Stream<Iterable<SmallInfo>> getAllInfos() {
    userProvider.userId = FirebaseAuth.instance.currentUser!.uid;
    print(bigInfoid);
    return smallInfoCollection
        .where('bigInfoId', isEqualTo: bigInfoid)
        .where('category', isEqualTo: _Category[1])
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((docSnap) => SmallInfo.fromFirebase(docSnap)));
  }
}

class FirebaseProvider2 {
  static final smallInfoCollection =
      FirebaseFirestore.instance.collection('smallInfo');

  static Stream<Iterable<SmallInfo>> getAllInfos() {
    userProvider.userId = FirebaseAuth.instance.currentUser!.uid;
    print(bigInfoid);
    return smallInfoCollection
        .where('bigInfoId', isEqualTo: bigInfoid)
        .where('category', isEqualTo: _Category[2])
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((docSnap) => SmallInfo.fromFirebase(docSnap)));
  }
}

class FirebaseProvider3 {
  static final smallInfoCollection =
      FirebaseFirestore.instance.collection('smallInfo');

  static Stream<Iterable<SmallInfo>> getAllInfos() {
    userProvider.userId = FirebaseAuth.instance.currentUser!.uid;
    print(bigInfoid);
    return smallInfoCollection
        .where('bigInfoId', isEqualTo: bigInfoid)
        .where('category', isEqualTo: _Category[3])
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((docSnap) => SmallInfo.fromFirebase(docSnap)));
  }
}

class FirebaseProvider4 {
  static final smallInfoCollection =
      FirebaseFirestore.instance.collection('smallInfo');

  static Stream<Iterable<SmallInfo>> getAllInfos() {
    userProvider.userId = FirebaseAuth.instance.currentUser!.uid;
    print(bigInfoid);
    return smallInfoCollection
        .where('bigInfoId', isEqualTo: bigInfoid)
        .where('category', isEqualTo: _Category[4])
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((docSnap) => SmallInfo.fromFirebase(docSnap)));
  }
}

class FirebaseProvider5 {
  static final smallInfoCollection =
      FirebaseFirestore.instance.collection('smallInfo');

  static Stream<Iterable<SmallInfo>> getAllInfos() {
    userProvider.userId = FirebaseAuth.instance.currentUser!.uid;
    print(bigInfoid);
    return smallInfoCollection
        .where('bigInfoId', isEqualTo: bigInfoid)
        .where('category', isEqualTo: _Category[5])
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((docSnap) => SmallInfo.fromFirebase(docSnap)));
  }
}

class FirebaseProvider6 {
  static final smallInfoCollection =
      FirebaseFirestore.instance.collection('smallInfo');

  static Stream<Iterable<SmallInfo>> getAllInfos() {
    userProvider.userId = FirebaseAuth.instance.currentUser!.uid;
    print(bigInfoid);
    return smallInfoCollection
        .where('bigInfoId', isEqualTo: bigInfoid)
        .where('category', isEqualTo: _Category[6])
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((docSnap) => SmallInfo.fromFirebase(docSnap)));
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
    color: Color(0xff1C1B1F),
  ),
  const Icon(
    Icons.local_cafe_outlined,
    size: 15,
    color: Color(0xff1C1B1F),
  ),
  const Icon(
    Icons.sports_esports_outlined,
    size: 15,
    color: Color(0xff1C1B1F),
  ),
  const Icon(
    Icons.vrpano_outlined,
    size: 15,
    color: Color(0xff1C1B1F),
  ),
  const Icon(
    Icons.forest_outlined,
    size: 15,
    color: Color(0xff1C1B1F),
  ),
  const Icon(
    Icons.nature_people_outlined,
    size: 15,
    color: Color(0xff1C1B1F),
  ),
  const Icon(
    Icons.directions_walk_outlined,
    size: 15,
    color: Color(0xff1C1B1F),
  ),
];
