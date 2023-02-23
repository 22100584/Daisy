import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class userProvider {
  static String? userId;
  static String? partnerId;

  static String? userName;
  static String? userNameInFireStore;
  static String? userEmail;
  static String? userEmailInFireStore;
  static String? userPassword;
  static String? userPasswordInFireStore;
  static String? partnerEmail;
  static String? partnerEmailInFireStore;
}

class daisyuser {
  final String? userName;
  final String? userEmail;
  final String? userPassword;
  final String? partnerEmail;

  daisyuser(
      {required this.userName,
      required this.userEmail,
      required this.userPassword,
      required this.partnerEmail});

  factory daisyuser.fromFirebase(
      QueryDocumentSnapshot<Map<String, dynamic>> docSnap) {
    final snapshotData = docSnap.data();
    return daisyuser(
        userName: snapshotData[userNameFieldName],
        userEmail: snapshotData[userEmailFieldName],
        userPassword: snapshotData[userPasswordFieldName],
        partnerEmail: snapshotData[partnerEmailFieldName]);
  }
}

const String userNameFieldName = "userName";
const String userEmailFieldName = "userEamil";
const String userPasswordFieldName = "userPassword";
const String partnerEmailFieldName = "partnerEmail";

class BigInfoProvider {
  static String? id;
  static String? idInFireStore;
  static String? bigname;
  static String? bignameInFireStore;
  static String? bigdateStart;
  static String? bigdateStartInFireStore;
  static String? bigdateEnd;
  static String? bigdateEndInFireStore;

  static String? bigplace;
  static String? bigplaceInFireStore;
  static String? smallkey;
  static String? smallkeyInFireStore;
  static String? registerTime;
  static String? registerTimeInFireStore;
}

class SmallInfoProvider {
  static String? id;
  static String? idInFireStore;
  static String? smallname;
  static String? smallnameInFireStore;
  static String? smallplace;
  static String? smallplaceInFireStore;
  static String? category;
  static String? categoryInFireStore;
  static String? memo;
  static String? memoInFireStore;
  static String? bigInfoId;
  static String? bigInfoIdInFireStore;
  static List? user_ids;
  static List? user_idsInFireStore;
  static String? registerTime;
  static String? registerTimeInFireStore;
}

Future<void> fetchAuthInfo() async {
  Map data = {};
  userProvider.userId = FirebaseAuth.instance.currentUser!.uid;
  var docref = FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  docref.get().then((doc) => {
        (DocumentSnapshot doc) {
          data = doc.data() as Map<String, dynamic>;
          print(data);
        },
      });

  userProvider.partnerId = (await FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get())['partner-user-id'];
}

class SmallInfo {
  final String? id;
  final String? smallname;
  final String? smallplace;
  final String? category;
  final String? memo;
  final Timestamp? registerTime;
  final String? bigInfoId;
  final List? user_ids;

  SmallInfo(
      {required this.id,
      required this.smallname,
      required this.smallplace,
      required this.category,
      required this.memo,
      required this.registerTime,
      required this.bigInfoId,
      required this.user_ids});

  factory SmallInfo.fromFirebase(
      QueryDocumentSnapshot<Map<String, dynamic>> docSnap) {
    final snapshotData = docSnap.data();
    return SmallInfo(
      id: snapshotData[idFieldName],
      registerTime: snapshotData[registerTimeFieldName],
      smallname: snapshotData[smallnameFieldName],
      smallplace: snapshotData[smallplaceFieldName],
      category: snapshotData[categoryFieldName],
      memo: snapshotData[memoFieldName],
      bigInfoId: snapshotData[bigInfoIdFieldName],
      user_ids: snapshotData[user_idsFieldName],
    );
  }
}

const String user_idsFieldName = "user-ids";
const String idFieldName = 'id';
const String registerTimeFieldName = "register-time";
const String smallnameFieldName = "smallname";
const String smallplaceFieldName = "smallplace";
const String categoryFieldName = 'category';
const String memoFieldName = "memo";
const String bigInfoIdFieldName = 'bigInfoId';

class BigInfo {
  final String? id;
  final String? bigname;
  final String? bigdateStart;
  final String? bigdateEnd;

  final String? bigplace;
  final String? smallkey;
  final Timestamp? registerTime;

  BigInfo(
      {required this.id,
      required this.bigname,
      required this.bigdateStart,
      required this.bigdateEnd,
      required this.bigplace,
      required this.smallkey,
      required this.registerTime});

  factory BigInfo.fromFirebase(
      QueryDocumentSnapshot<Map<String, dynamic>> docSnap) {
    final snapshotData = docSnap.data();
    return BigInfo(
      id: snapshotData[idFieldName],
      registerTime: snapshotData[registerTimeFieldName],
      bigname: snapshotData[bignameFieldName],
      bigdateStart: snapshotData[bigdateStartFieldName],
      bigdateEnd: snapshotData[bigdateEndFieldName],
      bigplace: snapshotData[bigplaceFieldName],
      smallkey: snapshotData[smallkeyFieldName],
    );
  }
}

const String bignameFieldName = "bigname";
const String bigdateStartFieldName = "bigdateStart";
const String bigdateEndFieldName = "bigdateEnd";
const String bigplaceFieldName = "bigplace";
const String smallkeyFieldName = "smallkey";
