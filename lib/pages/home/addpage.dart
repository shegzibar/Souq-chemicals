import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:souq_chemicals/pages/home/addpro.dart';
import 'package:souq_chemicals/pages/home/loading.dart';
import 'package:souq_chemicals/pages/home/navbar.dart';
import 'package:souq_chemicals/pages/models/colors.dart';
import 'package:souq_chemicals/services/database.dart';

class addpropage extends StatefulWidget {
  String loc = '';
  String name = '';
  String username = '';
  String uid = '';
  String phone = '';

  addpropage(
      {required this.name,
      required this.uid,
      required this.loc,
      required this.username,
      required this.phone});

  @override
  State<addpropage> createState() => _addpropageState();
}

class _addpropageState extends State<addpropage> {
  appcolors col = appcolors();
  final searchKey = TextEditingController();

  final id = FirebaseAuth.instance.currentUser!.uid;

  int? len;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getToken();
    // saveToken(mtoken);
  }

  DatabaseService _db = DatabaseService();
  @override
  @override
  Widget build(BuildContext context) {
    Query<Map<String, dynamic>> _pb = FirebaseFirestore.instance
        .collection('Products')
        .where("id", isEqualTo: id);

    Query<Map<String, dynamic>> _ib = FirebaseFirestore.instance
        .collection('Items')
        .where("id", isEqualTo: id);
    Query<Map<String, dynamic>> _vb = FirebaseFirestore.instance
        .collection('Veiwpro')
        .where("id", isEqualTo: id);
    return Scaffold(
      backgroundColor: col.white,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              var snapshot = await _ib.get();
              for (var doc in snapshot.docs) {
                await doc.reference.delete();
              }
              var snapshots = await _pb.get();
              for (var doc in snapshots.docs) {
                await doc.reference.delete();
              }
              var snapshotss = await _vb.get();
              for (var doc in snapshotss.docs) {
                await doc.reference.delete();
              }

              Navigator.pop(context);
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
        title: Text(
          "اضف منتجاتك",
          textDirection: TextDirection.rtl,
          style: TextStyle(color: col.primarycolor),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const navbar(),
                ),
              );
            },
            icon: Icon(
              Icons.arrow_back,
              color: col.primarycolor,
            )),
        backgroundColor: col.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Items")
              .where("id", isEqualTo: id)
              .where("uid", isEqualTo: widget.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('error'),
              );
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            len = snapshot.data!.docs.length;
            if (len == 0) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/add_product.jpg'),
                      height: 100,
                      width: 100,
                    ),
                    Text(
                      'أضف اول منتج',
                      textDirection: TextDirection.rtl,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            }

            return Center(
              child: Container(
                color: col.white,
                child: Column(
                  children: [
                    // ignore: deprecated_member_use
                    SizedBox(
                      height: 40,
                    ),

                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot _ds =
                              snapshot.data!.docs[index];
                          return InkWell(
                            onTap: () {},
                            child: Card(
                                elevation: 2,
                                child: ListTile(
                                  leading: Image(
                                    image: AssetImage('assets/download.jpeg'),
                                    height: 40,
                                    width: 40,
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data!.docs[index]['name']
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          snapshot.data!.docs[index]['desc']
                                              .toString(),
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: Column(
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          await _db.deletepro(_ds.id);
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color:
                                              Color.fromARGB(255, 255, 90, 78),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [

      //       SizedBox(
      //         height: 80,
      //       ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 40,
          ),
          Padding(
            padding: EdgeInsets.only(left: 11),
            child: SizedBox(
              width: 170,
              height: 50,
              child: ElevatedButton(
                child: Row(
                  children: [
                    Icon(
                      Icons.post_add,
                      color: col.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('نشر المنتج',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 17,
                          color: col.white,
                        )),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  primary: col.yellow,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                ),
                //-------Switch to Next Page 'Main'------
                onPressed: () async {
                  _db.insertadmindata(widget.uid, widget.name, widget.loc,
                      widget.username, widget.phone);
                  // SendPushMessage(mtoken);
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 11),
            child: SizedBox(
              width: 170,
              height: 50,
              child: ElevatedButton(
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: col.white,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('اضافت منتج',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 17,
                          color: col.white,
                        )),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  primary: col.primarycolor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                ),
                //-------Switch to Next Page 'Main'------
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => addpro(
                        uid: widget.uid,
                        uname: widget.name,
                        username: widget.username,
                        phone: widget.phone,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  // String mtoken = '';
  // void requestuserpermission() async {
  //   FirebaseMessaging messaging = FirebaseMessaging.instance;
  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     sound: true,
  //   );
  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     print('User granted permission');
  //   } else if (settings.authorizationStatus ==
  //       AuthorizationStatus.provisional) {
  //     print('User granted provisional permission');
  //   } else {
  //     print("User declined or has not accepted permissoin");
  //   }
  // }

  // void getToken() async {
  //   await FirebaseMessaging.instance.getToken().then((token) {
  //     setState(() {
  //       mtoken = token!;
  //       print('My token is $mtoken');
  //     });
  //     saveToken(token!);
  //   });
  // }

  // void saveToken(String token) async {
  //   await FirebaseFirestore.instance
  //       .collection('Userdetails')
  //       .doc('PVH49ACdYNd3vcHA5cgxRik4uBp2')
  //       .set({'token': token});
  // }

  // void SendPushMessage(String token) async {
  //   try {
  //     await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
  //         headers: <String, String>{
  //           'Content-Type': 'application/json',
  //           'Autherization':
  //               'key=AAAAtGu-ihk:APA91bFk6sLZSV2OSLySeL9wUDLHgRvs6r9WKbUIJi0MT8SxnkZJjus3aJOsbDZbq4NxEXiwnaYm0M0ascxzZluQB2mvMqQldTRhAVfLa6x4gOvePKfp_IoQLlvjkxQZdrx5yq_40HdI',
  //         },
  //         body: jsonEncode(<String, dynamic>{
  //           'periority': 'high',
  //           'data': <String, dynamic>{
  //             'click_action': 'FLUTTER_NOTIFICATION_CLICK',
  //             'status': 'done',
  //             'body': 'تمت اضافت منتج جديد',
  //             'title': 'تمت اضافت منتج جديد',
  //           },
  //         }));
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
