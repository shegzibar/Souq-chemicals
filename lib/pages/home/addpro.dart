// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:souq_chemicals/pages/home/addpage.dart';
import 'package:souq_chemicals/pages/home/navbar.dart';
import 'package:souq_chemicals/pages/models/colors.dart';
import 'package:souq_chemicals/services/database.dart';
import 'package:souq_chemicals/services/userdb.dart';

class addpro extends StatefulWidget {
  String uname = '';
  String username = '';
  String phone = '';
  String uid = ' ';
  addpro(
      {required this.uname,
      required this.uid,
      required this.username,
      required this.phone});

  @override
  State<addpro> createState() => _addproState();
}

class _addproState extends State<addpro> {
  appcolors col = appcolors();

  String? name;
  final id = FirebaseAuth.instance.currentUser!.uid;

  String dbl = 'جرام';
  String? dll;

  String? price;
  userdb? _ud;
  String? quan;

  String scale = '';

  // List products = [
  //   "سلفونك اسيد",
  //   "تكسابون",
  //   "صودا كاويه",
  //   "تايلوز",
  //   "كمبلان",
  //   "فورمالين",
  //   "بيتائن",
  //   "جلسرين",
  //   "سي ام سي",
  //   "سلكات",
  //   "اسيرين",
  //   "بدره تلك",
  //   "صودا اش",
  //   "كبريتات",
  //   "مبيض",
  //   "اتش سي ال",
  //   "صنبور",
  //   "كلور بدره"
  // ];

  final productselect = TextEditingController();

  String quantity = "";

  String desc = '';
  String q = "جرام";

  final _formKey = GlobalKey<FormState>();

  DatabaseService _db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: col.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: col.primarycolor),
        elevation: 0,
        backgroundColor: col.white,
        title: Text(
          'اضافة منتج',
          textDirection: TextDirection.rtl,
          style: TextStyle(
            color: col.primarycolor,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
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
            icon: Icon(Icons.arrow_back)),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      child: TextFormField(
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 20.0),
                          hintText: "ادخل اسم المنتج",
                          hintStyle: TextStyle(
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
                          if (name!.isEmpty) {
                            return "الرجاء كتابة اسم المنتج الخاص بك";
                          } else
                            return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("او اختر اسم المنتج"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                        ),
                        Expanded(
                          child: DropdownButton(
                              value: dll,
                              hint: Text("اسم المنتج"),
                              icon: Icon(Icons.arrow_drop_down),
                              items: [
                                DropdownMenuItem(
                                  child: Text("سلفونك اسيد"),
                                  value: "سلفونك اسيد",
                                ),
                                DropdownMenuItem(
                                  child: Text("تكسابون"),
                                  value: "تكسابون",
                                ),
                                DropdownMenuItem(
                                  child: Text("جركانه"),
                                  value: "جركانه",
                                ),
                                DropdownMenuItem(
                                  child: Text("صودا كاويه"),
                                  value: "صودا كاويه",
                                ),
                                DropdownMenuItem(
                                  child: Text("تايلوز"),
                                  value: "تايلوز",
                                ),
                                DropdownMenuItem(
                                  child: Text("كمبلان"),
                                  value: "كمبلان",
                                ),
                                DropdownMenuItem(
                                  child: Text("فورمالين"),
                                  value: "فورمالين",
                                ),
                                DropdownMenuItem(
                                  child: Text("بيتائن"),
                                  value: "بيتائن",
                                ),
                                DropdownMenuItem(
                                  child: Text("جلسرين"),
                                  value: "جلسرين",
                                ),
                                DropdownMenuItem(
                                  child: Text(
                                    "سي ام سي",
                                  ),
                                  value: "سي ام سي",
                                ),
                                DropdownMenuItem(
                                  child: Text("سلكات"),
                                  value: "سلكات",
                                ),
                                DropdownMenuItem(
                                  child: Text("اسيرين"),
                                  value: "اسيرين",
                                ),
                                DropdownMenuItem(
                                  child: Text("بدره تلك"),
                                  value: "بدره تلك",
                                ),
                                DropdownMenuItem(
                                  child: Text("صودا اش"),
                                  value: "صودا اش",
                                ),
                                DropdownMenuItem(
                                  child: Text("كبريتات"),
                                  value: "كبريتات",
                                ),
                                DropdownMenuItem(
                                  child: Text("مبيض"),
                                  value: "مبيض",
                                ),
                                DropdownMenuItem(
                                  child: Text("اتش سي ال"),
                                  value: "اتش سي ال",
                                ),
                                DropdownMenuItem(
                                  child: Text("صنبور"),
                                  value: "صنبور",
                                ),
                                DropdownMenuItem(
                                  child: Text("كلور بدره"),
                                  value: "كلور بدره",
                                ),
                              ],
                              onChanged: (String? val) {
                                setState(() {
                                  dll = val!;
                                  name = dll;
                                });
                              }),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: TextFormField(
                        maxLines: 10,
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        decoration: InputDecoration(
                          hintText:
                              ' تفاصيل المنتج:  المنشاء , تاريخ الانتاج و الانتهاء , اسم المصنع , التركيز , تصنيفات , الموقع , هل تتوفر خدمت التوصيل    ',
                          hintStyle: TextStyle(
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
                          desc = val;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "الرجاء كتابة التفاصيل الخاصه بالمنتج";
                          } else
                            return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: TextFormField(
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                        ],
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 20.0),
                          hintText: ' سعر المنتج الواحد',
                          hintStyle: TextStyle(
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
                          price = val;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "الرجاء كتابة سعر المنتج";
                          } else
                            return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        showtextfield(),
                        DropdownButton(
                            value: dbl,
                            icon: Icon(Icons.arrow_drop_down),
                            items: [
                              DropdownMenuItem(
                                child: Text("جرام"),
                                value: "جرام",
                              ),
                              DropdownMenuItem(
                                child: Text("كيلو"),
                                value: "كيلو",
                              ),
                              DropdownMenuItem(
                                child: Text("شوال"),
                                value: "شوال",
                              ),
                              DropdownMenuItem(
                                child: Text("جركانه"),
                                value: "جركانه",
                              ),
                              DropdownMenuItem(
                                child: Text("برميل"),
                                value: "برميل",
                              ),
                              // DropdownMenuItem(
                              //   child: Text("شوال-25"),
                              //   value: "شوال-25",
                              // ),
                              // DropdownMenuItem(
                              //   child: Text("شوال-50"),
                              //   value: "شوال-50",
                              // ),
                              // DropdownMenuItem(
                              //   child: Text("شوال-40"),
                              //   value: "شوال-40",
                              // ),
                              // DropdownMenuItem(
                              //   child: Text("جركانه-16"),
                              //   value: "جركانه-16",
                              // ),
                              // DropdownMenuItem(
                              //   child: Text("جركانه-30"),
                              //   value: "جركانه-30",
                              // ),
                              // DropdownMenuItem(
                              //   child: Text("جركانه-35"),
                              //   value: "جركانه-35",
                              // ),
                              // DropdownMenuItem(
                              //   child: Text("جركانه-65"),
                              //   value: "جركانه-65",
                              // ),
                              // DropdownMenuItem(
                              //   child: Text("جركانه-70"),
                              //   value: "جركانه-70",
                              // ),
                              // DropdownMenuItem(
                              //   child: Text("برميل-50"),
                              //   value: "برميل-50",
                              // ),
                              // DropdownMenuItem(
                              //   child: Text("برميل-70"),
                              //   value: "برميل-70",
                              // ),
                              // DropdownMenuItem(
                              //   child: Text("برميل-120"),
                              //   value: "برميل-120",
                              // ),
                              // DropdownMenuItem(
                              //   child: Text("برميل-170"),
                              //   value: "برميل-170",
                              // ),
                              // DropdownMenuItem(
                              //   child: Text("برميل-200"),
                              //   value: "برميل-200",
                              // ),
                              // DropdownMenuItem(
                              //   child: Text("برميل-220"),
                              //   value: "برميل-220",
                              // ),
                              // DropdownMenuItem(
                              //   child: Text("برميل-330"),
                              //   value: "برميل-330",
                              // ),
                              DropdownMenuItem(
                                child: Text("طن"),
                                value: "طن",
                              ),
                            ],
                            onChanged: (String? val) {
                              setState(() {
                                dbl = val!;
                                scale = val;
                              });
                            }),
                        Expanded(
                          child: Container(
                            child: TextFormField(
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]'))
                              ],
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 20.0),
                                hintText: 'كميه المنتج',
                                hintStyle: TextStyle(
                                  fontSize: 17.4,
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
                                quan = val;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "الرجاء كتابة كميه المنتج";
                                } else
                                  return null;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.only(left: 11),
                      child: SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          child: Text('حفظ',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontSize: 17,
                                color: col.white,
                              )),
                          style: ElevatedButton.styleFrom(
                            primary: col.primarycolor,
                          ),
                          //-------Switch to Next Page 'Main'------
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pop(context);

                              await _db.insertprodata(
                                  name!,
                                  widget.uid,
                                  price!,
                                  " ($q)" + scale,
                                  quan!,
                                  desc,
                                  widget.uname,
                                  widget.username,
                                  widget.phone);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  showtextfield() {
    if (dbl == "شوال" || dbl == "برميل" || dbl == "جركانه") {
      return Expanded(
        child: Container(
          child: TextFormField(
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
            ],
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              hintText: 'كم كيلو',
              hintStyle: TextStyle(
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
              q = val;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "الرجاء كتابة كميه المنتج";
              } else
                return null;
            },
          ),
        ),
      );
    }

    return SizedBox(
      width: 5,
    );
  }
}
