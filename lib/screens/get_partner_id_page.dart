import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daisy/config/info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class GetPartnerIdPage extends StatefulWidget {
  const GetPartnerIdPage({super.key});

  @override
  State<GetPartnerIdPage> createState() => _GetPartnerIdPageState();
}

class _GetPartnerIdPageState extends State<GetPartnerIdPage> {
  late final TextEditingController textEditingController;
  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("enter your partner email here"),
            TextField(
              controller: textEditingController,
            ),
            OutlinedButton(
              onPressed: () async {
                final partnerEmail = textEditingController.text;
                if (partnerEmail.isEmpty) return;

                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: ((context) => const AlertDialog()),
                );

                final userInfo = FirebaseFirestore.instance
                    .collection('user')
                    .where('email', isEqualTo: partnerEmail)
                    .snapshots();
                final isEmpty = await userInfo.isEmpty;
                if (isEmpty) return;
                final partnerUserId =
                    (await userInfo.first).docs.first.data()['user-id'];
                log(partnerUserId);

                userProvider.partnerId = partnerUserId;
                await FirebaseFirestore.instance
                    .collection('user')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .update({'partner-user-id': partnerUserId});
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => DaisyPage()),
                    ),
                    (route) => false);
              },
              child: const Text("enter"),
            ),
            Text("my user id: ${FirebaseAuth.instance.currentUser!.uid}"),
          ],
        ),
      ),
    );
  }
}
