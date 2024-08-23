import 'dart:html';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:souq_chemicals/pages/home/addpage.dart';
import 'package:souq_chemicals/pages/home/addpro.dart';
import 'package:souq_chemicals/pages/home/editpro.dart';
import 'package:souq_chemicals/pages/home/updatepro.dart';
import 'package:souq_chemicals/pages/home/veiwpro.dart';
import 'package:souq_chemicals/pages/models/colors.dart';
import 'package:souq_chemicals/services/database.dart';

class myitems extends StatefulWidget {
  const myitems({super.key});

  @override
  State<myitems> createState() => _myitemsState();
}

class _myitemsState extends State<myitems> {
  appcolors col = appcolors();
  final _formKey = GlobalKey<FormState>();
  int? len;
  String? name;
  String? loc;
  String? username;
  String? phone;
  String? Name;
  String number = '';

  String price = '';
  String quantity = '';
  String uid = '';
  int rand = Random().nextInt(1000000);
  DatabaseService _db = DatabaseService();
  String desc = '';
  var _controller = ScrollController();
  ScrollPhysics _physics = ClampingScrollPhysics();
  final id = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      if (_controller.position.pixels <= 56) {
        setState(() {
          _physics = ClampingScrollPhysics();
        });
      } else {
        setState(() {
          _physics = BouncingScrollPhysics();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: col.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: col.white,
        iconTheme: IconThemeData(color: col.primarycolor),
        title: Text('منتجاتي', style: TextStyle(color: col.primarycolor)),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Products")
              .where("id", isEqualTo: id)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('error'),
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Color.fromARGB(255, 255, 89, 89),
              ));
            }

            len = snapshot.data!.docs.length;
            if (len == 0) {
              return Center(
                child: Column(
                  children: [
                    Image(image: AssetImage('assets/images (2).jpeg')),
                    Text(
                      'ليس هناك منتجات',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            }
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _controller,
                      physics: _physics,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot _ds = snapshot.data!.docs[index];
                        Name = snapshot.data!.docs[index]["name"];
                        String location = snapshot.data!.docs[index]["loc"];
                        username = snapshot.data!.docs[index]["username"];
                        phone = snapshot.data!.docs[index]["phone"];
                        uid = snapshot.data!.docs[index]["uid"];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          child: InkWell(
                            onTap: () async {
                              setState(() {
                                name = snapshot.data!.docs[index]['name']
                                    .toString();

                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        addpropage(
                                      uid: uid,
                                      name: Name!,
                                      loc: location,
                                      username: username!,
                                      phone: phone!,
                                    ),
                                  ),
                                );
                              });
                            },
                            child: Card(
                              elevation: 10,
                              child: Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      child: Image(
                                        fit: BoxFit.fill,
                                        image:
                                            AssetImage('assets/download.jpeg'),
                                        width: 100,
                                        height: 100,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data!.docs[index]['name']
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_pin,
                                              color: col.primarycolor,
                                            ),
                                            Text(
                                              snapshot.data!.docs[index]['loc']
                                                  .toString(),
                                              maxLines: 10,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: 11),
        child: SizedBox(
          width: 170,
          height: 50,
          child: ElevatedButton(
            child: Row(
              children: [
                Icon(Icons.save),
                SizedBox(
                  width: 10,
                ),
                Text('اضافة منتج',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 17,
                      color: Color.fromARGB(255, 255, 255, 255),
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
            onPressed: () {
              _showdialog(context);
            },
          ),
        ),
      ),
    );
  }

  void _showdialog(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SingleChildScrollView(
        child: AlertDialog(
          title: const Text(
            'ادخل اسم و موقع المصنع',
            style: TextStyle(fontFamily: 'jannah'),
          ),
          content: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
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
                        floatingLabelBehavior: FloatingLabelBehavior.always,
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
                      height: 20,
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
                        floatingLabelBehavior: FloatingLabelBehavior.always,
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
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        hintText: 'منظفات,تعدين,غذائي,زراعي',
                        hintStyle: TextStyle(
                          fontFamily: 'jannah',
                          fontSize: 17.4,
                          letterSpacing: 1,
                        ),
                        labelStyle: TextStyle(
                          fontSize: 23,
                          color: Colors.black87,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(),
                        filled: true,
                      ),
                      onChanged: (val) {
                        name = val;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "ارجوك ادخل اسم المنتجات";
                        } else if (value == Name) {
                          return "هذا الاسم مستخدم";
                        } else
                          return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        hintText: 'ادخل موقع المنتجات',
                        hintStyle: TextStyle(
                          fontFamily: 'jannah',
                          fontSize: 17.4,
                          letterSpacing: 1,
                        ),
                        labelStyle: TextStyle(
                          fontSize: 23,
                          color: Colors.black87,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(),
                        filled: true,
                      ),
                      onChanged: (val) {
                        loc = val;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "ارجوك ادخل موقع المنتجات";
                        } else
                          return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 40,
                      width: 400,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: col.primarycolor,
                        ),

                        //-------Switch to Next Page 'Main'------
                        onPressed: () async {
                          setState(() {
                            uid = "$rand";
                          });
                          if (_formKey.currentState!.validate()) {
                            try {
                              _db.insertuserdata(
                                  uid, name!, loc!, username!, phone!);
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) => addpropage(
                                    uid: uid,
                                    name: name!,
                                    loc: loc!,
                                    username: username!,
                                    phone: phone!,
                                  ),
                                ),
                              );
                            } catch (e) {}
                          }
                        },
                        child: const Text('التالي',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                            )),
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      height: 40,
                      width: 400,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: col.primarycolor,
                        ),
                        //-------Switch to Next Page 'Main'------
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        child: Text('رجوع',
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
            ],
          ),
        ),
      ),
    );
  }
}
