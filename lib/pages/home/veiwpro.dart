import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:souq_chemicals/pages/cart.dart';
import 'package:souq_chemicals/pages/models/colors.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:souq_chemicals/services/database.dart';
import 'package:souq_chemicals/services/userdb.dart';

class veiwpro extends StatefulWidget {
  late String uid, name, loc;
  veiwpro({required this.uid, required this.name, required this.loc});

  @override
  State<veiwpro> createState() => _veiwproState();
}

class _veiwproState extends State<veiwpro> {
  appcolors col = appcolors();
  DatabaseService _db = DatabaseService();
  String? proname;
  String? price;
  String? username;
  String? phone;
  String? uquan;
  String? desc;
  String? quan;
  final user = FirebaseAuth.instance.currentUser;
  late userdb _udb = userdb(uid: user!.uid);
  final id = FirebaseAuth.instance.currentUser!.uid;
  int? len;
  String? quantity;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: col.white,
      body: Observer(
          builder: ((context) => NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      actions: [
                        IconButton(
                          color:
                              !innerBoxIsScrolled ? Colors.black : Colors.black,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => const cart(),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.shopping_cart,
                            color: !innerBoxIsScrolled
                                ? Colors.black
                                : Colors.black,
                          ),
                        ),
                      ],
                      expandedHeight: 200.0,
                      floating: false,
                      pinned: true,
                      titleSpacing: 0,
                      backgroundColor: col.primarycolor,
                      actionsIconTheme: IconThemeData(opacity: 0),
                      leading: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: !innerBoxIsScrolled
                                ? Colors.black
                                : Colors.black,
                          )),
                      title: Text(
                        widget.name,
                        style: TextStyle(color: Colors.black, fontSize: 22),
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                          background: Image(
                        image: AssetImage('assets/download.jpeg'),
                        fit: BoxFit.cover,
                      )),
                    ),
                  ];
                },
                body: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Items")
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
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
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
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "المنتجات",
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'montserrat',
                                          color: col.primarycolor),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "اضغط على المنتج الذي تريد شرائه",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 104, 104, 104)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              // ignore: deprecated_member_use

                              Expanded(
                                child: ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    final DocumentSnapshot _ds =
                                        snapshot.data!.docs[index];
                                    return InkWell(
                                      onTap: () {
                                        proname =
                                            snapshot.data!.docs[index]['name'];
                                        desc =
                                            snapshot.data!.docs[index]['desc'];
                                        price =
                                            snapshot.data!.docs[index]['price'];
                                        quantity = snapshot.data!.docs[index]
                                            ['quantity'];
                                        username = snapshot.data!.docs[index]
                                            ['username'];
                                        phone =
                                            snapshot.data!.docs[index]['phone'];

                                        _showdialog(context);
                                      },
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        Text("سعر"),
                                                        Text(
                                                          snapshot.data!.docs[
                                                                      index]
                                                                  ['price'] +
                                                              " SDG",
                                                          maxLines: 10,
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        Text("الكميه"),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              snapshot.data!
                                                                          .docs[
                                                                      index]
                                                                  ['scale'],
                                                              maxLines: 10,
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              snapshot.data!
                                                                          .docs[
                                                                      index]
                                                                  ['quantity'],
                                                              maxLines: 10,
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        Text("الاسم"),
                                                        Text(
                                                          snapshot.data!
                                                                  .docs[index]
                                                              ['name'],
                                                          maxLines: 10,
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Divider(
                                                height: 1,
                                                color: Colors.grey,
                                              )
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
                      );
                    }),
              ))),
    );
  }

  void _showdialog(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SingleChildScrollView(
        child: AlertDialog(
          title: const Text(
            'ادخل الكميه الاتي تريدها',
            style: TextStyle(
              fontFamily: 'montserrat',
            ),
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
                    Text(
                      'التفاصيل',
                      style: TextStyle(fontSize: 20, color: col.primarycolor),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      '$desc',
                      style: TextStyle(fontSize: 18),
                      maxLines: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]'))
                            ],
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 20.0),
                              hintText: 'ادخل الكميه التي تريدها',
                              hintStyle: TextStyle(
                                fontFamily: 'montserrat',
                                fontSize: 17.4,
                                letterSpacing: 1,
                              ),
                              labelStyle: TextStyle(
                                fontSize: 23,
                                fontFamily: 'montserrat',
                                color: Colors.black,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              border: OutlineInputBorder(),
                              filled: true,
                            ),
                            onChanged: (val) {
                              quan = val;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "ارجوك ادخل الكميه";
                              } else
                                return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 40,
                      width: 400,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: col.primarycolor,
                        ),
                        //-------Switch to Next Page 'Main'------
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              int? x = int.parse(price!);
                              int? y = int.parse(quantity!);
                              int? q = int.parse(quan!);
                              double? prc = (x * q) as double;
                              int p = prc.round();

                              _db.insertCartdata(
                                  widget.name,
                                  proname!,
                                  username!,
                                  phone!,
                                  "$p",
                                  quan!,
                                  desc!,
                                  widget.loc);

                              Navigator.pop(context);
                            } catch (e) {
                              print(e);
                            }
                          }
                        },
                        child: const Text('اضافه الى السله',
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
                        child: const Text('رجوع',
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
