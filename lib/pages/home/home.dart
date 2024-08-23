// ignore_for_file: prefer_const_constructors

import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:souq_chemicals/pages/authentication/sign%20in.dart';
import 'package:souq_chemicals/pages/cart.dart';
import 'package:souq_chemicals/pages/home/addpro.dart';
import 'package:souq_chemicals/pages/home/veiwpro.dart';
import 'package:souq_chemicals/pages/models/colors.dart';

import 'package:souq_chemicals/pages/myitems.dart';
import 'package:souq_chemicals/services/auth.dart';
import 'package:souq_chemicals/services/database.dart';
import 'package:souq_chemicals/services/userdb.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  String name = '';
  String loc = '';
  String _name = '';
  String number = '';
  String price = '';
  final user = FirebaseAuth.instance.currentUser;
  String quantity = '';
  String desc = '';
  DatabaseService _db = DatabaseService();
  appcolors col = appcolors();
  Authservice _auth = Authservice();
  final searchKey = TextEditingController();

  int? len;
  late userdb _udb = userdb(uid: user!.uid);

  var _controller = ScrollController();
  ScrollPhysics _physics = ClampingScrollPhysics();
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
        backgroundColor: col.white,
        iconTheme: IconThemeData(color: col.primarycolor),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const cart(),
                ),
              );
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ],
        title: SizedBox(
          height: 50,
          width: 200,
          child: TextFormField(
            onChanged: (value) {
              setState(() {
                searchKey.text = value.toString();
              });
            },
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              prefixIcon: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: col.primarycolor,
                ),
              ),
              hintText: 'بحث',
              hintStyle: TextStyle(
                fontSize: 15,
                letterSpacing: 1,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(60))),
            ),
          ),
        ),
      ),
      body: StreamBuilder(
          stream: searchKey.text == null || searchKey.text == ''
              ? FirebaseFirestore.instance.collection("Veiwpro").snapshots()
              : FirebaseFirestore.instance
                  .collection("Products")
                  .where('searchIndex', arrayContains: searchKey.text)
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
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'montserrat',
                          fontWeight: FontWeight.bold),
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
                        String Name = snapshot.data!.docs[index]["name"];
                        String location = snapshot.data!.docs[index]["loc"];
                        String uid = snapshot.data!.docs[index]['uid'];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          veiwpro(
                                            uid: uid,
                                            loc: location,
                                            name: Name,
                                          )),
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
                                        width: 40,
                                        height: 40,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
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
                                              fontFamily: 'montserrat',
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
    );
  }
}
