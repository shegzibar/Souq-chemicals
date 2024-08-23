import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:souq_chemicals/pages/home/navbar.dart';
import 'package:souq_chemicals/pages/models/colors.dart';
import 'package:souq_chemicals/services/database.dart';
import 'package:url_launcher/url_launcher.dart';

class transdetails extends StatefulWidget {
  String? sum;
  transdetails({required this.sum});

  @override
  State<transdetails> createState() => _transdetailsState();
}

class _transdetailsState extends State<transdetails> {
  final searchKey = TextEditingController();
  int? len;
  DatabaseService _db = DatabaseService();
  String? loc;

  final _formKey = GlobalKey<FormState>();
  int rand = Random().nextInt(1000000);
  final id = FirebaseAuth.instance.currentUser!.uid;
  appcolors col = appcolors();

  @override
  Widget build(BuildContext context) {
    String? Price = widget.sum!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الفاتورة',
          style: TextStyle(color: col.primarycolor, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: col.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: col.primarycolor,
          ),
        ),
      ),
      body: Container(
        color: col.white,
        child: Column(
          children: [
            Text(
              "رقم العمليه",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "$rand",
              style: TextStyle(fontSize: 30, color: col.primarycolor),
            ),
            SizedBox(
              height: 20,
            ),
            Flexible(
                child: StreamBuilder(
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
                              Image(
                                  width: 60,
                                  height: 60,
                                  image: AssetImage('assets/cart.png')),
                              Text(
                                'السله فارغه',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
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
                                    final DocumentSnapshot _ds =
                                        snapshot.data!.docs[index];
                                    loc = snapshot.data!.docs[index]['loc'];
                                    return Card(
                                        elevation: 2,
                                        child: ListTile(
                                          title: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  snapshot.data!
                                                          .docs[index]['price']
                                                          .toString() +
                                                      " SDG",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  '=',
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  "(" +
                                                      snapshot.data!.docs[index]
                                                          ['quantity'] +
                                                      ")",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  "x",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  snapshot.data!
                                                      .docs[index]['proname']
                                                      .toString(),
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ],
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
                    })),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '$Price',
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  "المجموع",
                  style: TextStyle(fontSize: 30, color: col.primarycolor),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '(Screenshot)',
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  'الرجاء تصوير الفاتورة',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              'ارسالها بالواتساب في الرقم 0121217384',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
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
                    String? username, phone;

                    showDialog(
                      context: context,
                      builder: (context) => SingleChildScrollView(
                        child: AlertDialog(
                          content: Column(
                            children: [
                              Text(
                                '$rand',
                                style: TextStyle(
                                    fontSize: 40, color: col.primarycolor),
                              ),
                              const SizedBox(height: 15),
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 20.0, horizontal: 20.0),
                                        hintText: 'اسم المستخدم ',
                                        hintStyle: TextStyle(
                                          fontFamily: 'jannah',
                                          fontSize: 17.4,
                                          letterSpacing: 1,
                                        ),
                                        labelStyle: TextStyle(
                                          fontSize: 23,
                                          color: Colors.black87,
                                        ),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        border: OutlineInputBorder(),
                                        filled: true,
                                      ),
                                      onChanged: (val) {
                                        username = val;
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "ارجوك ادخل اسمك";
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 20.0, horizontal: 20.0),
                                        hintText: 'رقم الهاتف',
                                        hintStyle: TextStyle(
                                          fontFamily: 'jannah',
                                          fontSize: 17.4,
                                          letterSpacing: 1,
                                        ),
                                        labelStyle: TextStyle(
                                          fontSize: 23,
                                          color: Colors.black87,
                                        ),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        border: OutlineInputBorder(),
                                        filled: true,
                                      ),
                                      onChanged: (val) {
                                        phone = val;
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "ارجوك ادخل رقم هاتفك";
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                width: 400,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: col.primarycolor,
                                  ),
                                  //-------Switch to Next Page 'Main'------
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _db.insertadmintransdata('$Price',
                                          username!, phone!, "$rand", loc!);
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: const Text('موافق',
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                            ],
                          ),
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
