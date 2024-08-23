import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';


class userdb {
  final String uid;
  final CollectionReference procollection =
      FirebaseFirestore.instance.collection('Products');
  userdb({required this.uid});
  final CollectionReference attendcollection =
      FirebaseFirestore.instance.collection('Userdetails');

  final id = FirebaseAuth.instance.currentUser!.uid;
  Future updateuserdata(String? name, String? number) async {
     List<String> splitlist = name!.split(' ');
    List<String> indexList = [];
    for (int i = 0; i < splitlist.length; i++) {
      for (int j = 1; j < splitlist[i].length + 1; j++) {
        indexList.add(splitlist[i].substring(0, j).toLowerCase());
      }
    }
    return await attendcollection
        .doc()
        .set({'id': id, 'name': name, 'number': number , 'searchIndex': indexList});
  }

}
