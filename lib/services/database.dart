import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  //collection reference
  final CollectionReference procollection =
      FirebaseFirestore.instance.collection('Products');
  final CollectionReference veiwprocollection =
      FirebaseFirestore.instance.collection('Veiwpro');
  final CollectionReference itemcollection =
      FirebaseFirestore.instance.collection('Items');
  final CollectionReference cartcollection =
      FirebaseFirestore.instance.collection('Cart');
  final CollectionReference admincollection =
      FirebaseFirestore.instance.collection('Adminpro');
  final CollectionReference admintrans =
      FirebaseFirestore.instance.collection('trans');

  final id = FirebaseAuth.instance.currentUser!.uid;
// all the products in the program
  Future insertuserdata(String uid, String name, String loc, String username,
      String phone) async {
    List<String> splitlist = name.split(' ');
    List<String> indexList = [];
    for (int i = 0; i < splitlist.length; i++) {
      for (int j = 1; j < splitlist[i].length + 1; j++) {
        indexList.add(splitlist[i].substring(0, j).toLowerCase());
      }
    }
    return await procollection.doc().set({
      'uid': uid,
      'id': id,
      'username': username,
      'phone': phone,
      'name': name,
      'loc': loc,
      'searchIndex': indexList
    });
  }

// products in the admin section
  Future insertadmindata(String uid, String name, String loc, String username,
      String phone) async {
    List<String> splitlist = name.split(' ');
    List<String> indexList = [];
    for (int i = 0; i < splitlist.length; i++) {
      for (int j = 1; j < splitlist[i].length + 1; j++) {
        indexList.add(splitlist[i].substring(0, j).toLowerCase());
      }
    }
    return await admincollection.doc().set({
      'uid': uid,
      'id': id,
      'name': name,
      'username': username,
      'phone': phone,
      'loc': loc,
      'searchIndex': indexList
    });
  }

// names of the products category
  Future insertveiwprodata(String uid, String _id, String name, String username,
      String phone, String loc) async {
    List<String> splitlist = name.split(' ');
    List<String> indexList = [];
    for (int i = 0; i < splitlist.length; i++) {
      for (int j = 1; j < splitlist[i].length + 1; j++) {
        indexList.add(splitlist[i].substring(0, j).toLowerCase());
      }
    }
    return await veiwprocollection.doc().set({
      'uid': uid,
      'id': _id,
      'username': username,
      'phone': phone,
      'name': name,
      'loc': loc,
      'searchIndex': indexList
    });
  }

// products data
  Future insertprodata(
    String name,
    String uid,
    String Price,
    String scale,
    String quantity,
    String desc,
    String uname,
    String username,
    String phone,
  ) async {
    return await itemcollection.doc().set({
      "id": id,
      "uid": uid,
      "uname": uname,
      'scale': scale,
      "name": name,
      "username": username,
      "phone": phone,
      'price': Price,
      'quantity': quantity,
      'desc': desc,
    });
  }

// cart data
  Future insertCartdata(
      String name,
      String proname,
      String username,
      String phone,
      String price,
      String qauntity,
      String desc,
      String loc) async {
    List<String> splitlist = name.split(' ');
    List<String> indexList = [];
    for (int i = 0; i < splitlist.length; i++) {
      for (int j = 1; j < splitlist[i].length + 1; j++) {
        indexList.add(splitlist[i].substring(0, j).toLowerCase());
      }
    }
    return await cartcollection.doc().set({
      'id': id,
      'name': name,
      'username': username,
      'phone': phone,
      'proname': proname,
      'loc': loc,
      'price': price,
      'quantity': qauntity,
      'desc': desc,
      'searchIndex': indexList
    });
  }

  // program transaction data
  Future insertadmintransdata(String price, String username, String phone,
      String rand, String loc) async {
    List<String> splitlist = rand.split(' ');
    List<String> indexList = [];
    for (int i = 0; i < splitlist.length; i++) {
      for (int j = 1; j < splitlist[i].length + 1; j++) {
        indexList.add(splitlist[i].substring(0, j).toLowerCase());
      }
    }
    return await admintrans.doc().set({
      'id': id,
      'loc': loc,
      "username": username,
      "phone": phone,
      'price': price,
      'rand': rand,
      'searchIndex': indexList,
    });
  }

  deletedata() {
    cartcollection.doc().delete();
  }

  deletepro(String id) {
    itemcollection.doc(id).delete();
  }

  // Future updateuserdata(String name, String price, String id, String image,
  //     String description) async {
  //   return await procollection.doc(uid).update({
  //     'name': name,
  //     'price': price,
  //     'id': id,
  //     'image': image,
  //     'description': description
  //   });
  // }
}
