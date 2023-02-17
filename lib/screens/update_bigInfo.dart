import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daisy/config/info.dart';

class UpdateBigInfo extends StatefulWidget {
  const UpdateBigInfo({super.key});

  @override
  State<UpdateBigInfo> createState() => UpdateBigInfoState();
}

class UpdateBigInfoState extends State<UpdateBigInfo> {
  @override
  Widget build(BuildContext context) {
    return const TextFieldExample();
  }
}

class TextFieldExample extends StatefulWidget {
  const TextFieldExample({super.key});

  @override
  State<TextFieldExample> createState() => _TextFieldExampleState();
}

class _TextFieldExampleState extends State<TextFieldExample> {
  late final TextEditingController _UdnameTextEditingController;
  late final TextEditingController _UdplaceTextEditingController;
  late final TextEditingController _UddateStartTextEditingController;
  late final TextEditingController _UddateEndTextEditingController;
  bool light = true;
  @override
  void initState() {
    super.initState();
    _UdnameTextEditingController = TextEditingController();
    _UdplaceTextEditingController = TextEditingController();
    _UddateStartTextEditingController = TextEditingController();
    _UddateEndTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _UdnameTextEditingController.dispose();
    _UdplaceTextEditingController.dispose();
    _UddateStartTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          color: Colors.white),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('도망가'),
          actions: [
            TextButton(
                onPressed: () async {
                  final docRef =
                      FirebaseFirestore.instance.collection("bigInfo").doc();

                  await docRef.update({
                    registerTimeFieldName: FieldValue.serverTimestamp(),
                    "bigname": BigInfoProvider.bigname,
                    "bigdateStart": BigInfoProvider.bigdateStart,
                    "bigdateEnd": BigInfoProvider.bigdateEnd,
                    "bigplace": BigInfoProvider.bigplace,
                  });
                  final docSnapshot = await docRef.get();
                  if (docSnapshot.data() == null) {
                    return;
                  }
                  final snapshotData = docSnapshot.data()!;

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
                child: const Text('저장'))
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '데이트 제목',
                  ),
                  controller: _UdnameTextEditingController,
                  onChanged: (value) {
                    setState(() {
                      BigInfoProvider.bigname = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '데이트 장소',
                  ),
                  controller: _UdplaceTextEditingController,
                  onChanged: (value) {
                    setState(() {
                      BigInfoProvider.bigplace = value;
                    });
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(child: Text('당일치기')),
                  Switch(
                      // This bool value toggles the switch.
                      value: light,
                      activeColor: Colors.red,
                      onChanged: (bool value) {
                        // This is called when the user toggles the switch.
                        setState(() {
                          light = value;
                        });
                      }),
                ],
              ),
              if (light)
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '시작',
                        ),
                        controller: _UddateStartTextEditingController,
                        onChanged: (value) {
                          setState(() {
                            BigInfoProvider.bigdateStart = value;
                            BigInfoProvider.bigdateEnd = null;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              if (!light)
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '시작',
                        ),
                        controller: _UddateStartTextEditingController,
                        onChanged: (value) {
                          setState(() {
                            BigInfoProvider.bigdateStart = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '끝',
                        ),
                        controller: _UddateEndTextEditingController,
                        onChanged: (value) {
                          setState(() {
                            BigInfoProvider.bigdateEnd = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
