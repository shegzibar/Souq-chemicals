import 'dart:html';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:souq_chemicals/pages/home/navbar.dart';
import 'package:souq_chemicals/pages/home/transdetail.dart';
import 'package:souq_chemicals/pages/models/colors.dart';
import 'package:souq_chemicals/services/database.dart';

class cart extends StatefulWidget {
  const cart({super.key});

  @override
  State<cart> createState() => _cartState();
}

class _cartState extends State<cart> {
  appcolors col = appcolors();
  final searchKey = TextEditingController();
  DatabaseService _db = DatabaseService();
  CollectionReference _fb = FirebaseFirestore.instance.collection('Cart');
  CollectionReference _ud =
      FirebaseFirestore.instance.collection('Userdetails');
  int? len;
  int sum = 0;
  String? name;
  String? quantity;
  String? loc;
  String? proname;
  int rand = Random().nextInt(1000000);
  final _formKey = GlobalKey<FormState>();

  int? price;
  int? sumtotal;
  final id = FirebaseAuth.instance.currentUser!.uid;
  String? username;
  String? phone;
  final _auth = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: col.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: col.white,
        iconTheme: IconThemeData(color: col.primarycolor),
        title: Icon(Icons.shopping_cart),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: searchKey.text == null || searchKey.text == ''
              ? FirebaseFirestore.instance
                  .collection("Cart")
                  .where("id", isEqualTo: id)
                  .snapshots()
              : FirebaseFirestore.instance
                  .collection("Cart")
                  .where('searchIndex', arrayContains: searchKey.text)
                  .where("id", isEqualTo: id)
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
                  children: [
                    Image(image: AssetImage('assets/cart.png')),
                    Text(
                      'السله فارغه',
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
                    const SizedBox(
                      height: 20,
                    ),

                    // ignore: deprecated_member_use

                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          sum += int.parse(snapshot.data!.docs[index]['price']);
                          loc = snapshot.data!.docs[index]['loc'];
                          final DocumentSnapshot _ds =
                              snapshot.data!.docs[index];
                          return Card(
                              elevation: 2,
                              child: ListTile(
                                leading: Image(
                                  image: AssetImage('assets/download.jpeg'),
                                  height: 40,
                                  width: 40,
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot
                                                .data!.docs[index]['proname']
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            snapshot.data!.docs[index]['price']
                                                    .toString() +
                                                " SDG",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            snapshot
                                                .data!.docs[index]['quantity']
                                                .toString(),
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                snapshot
                                                    .data!.docs[index]['loc']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              Icon(
                                                Icons.location_pin,
                                                color: col.primarycolor,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                trailing: IconButton(
                                  onPressed: () async {
                                    await _fb.doc(_ds.id).delete();
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Color.fromARGB(255, 255, 90, 78),
                                  ),
                                ),
                              ));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: 11),
        child: SizedBox(
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('شراء',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 17,
                          color: Color.fromARGB(255, 255, 255, 255),
                        )),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: col.primarycolor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    elevation: 5,
                  ),
                  //-------Switch to Next Page 'Main'------
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => transdetails(
                          sum: sum.toString(),
                        ),
                      ),
                    );
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
