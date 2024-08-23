import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:souq_chemicals/pages/models/colors.dart';
import 'package:souq_chemicals/services/database.dart';

class updatepro extends StatelessWidget {
  late String name, loc, price, quantity, desc;
  late DocumentSnapshot ds;
  updatepro({
    required this.name,
    required this.desc,
    required this.loc,
    required this.price,
    required this.quantity,
    required this.ds,
  });
  appcolors col = appcolors();
  final CollectionReference procollection =
      FirebaseFirestore.instance.collection('Products');
  final _formKey = GlobalKey<FormState>();
  DatabaseService _db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: col.white,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              procollection.doc(ds.id).delete();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.delete,
              color: Color.fromARGB(255, 255, 73, 73),
            ),
          ),
        ],
        iconTheme: IconThemeData(color: col.primarycolor),
        elevation: 0,
        backgroundColor: col.white,
        title: Text(
          'تعديل المنتج',
          style: TextStyle(
            color: col.primarycolor,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
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
                          hintText: name,
                          label: Text("ادخل اسم المنتج"),
                          hintStyle: TextStyle(
                            fontSize: 17.4,
                            fontFamily: 'montserrat',
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
                            return "الرجاء كتابة اسم المنتج الخاص بك";
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
                        maxLines: 10,
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        decoration: InputDecoration(
                          hintText: desc,
                          label: Text('تفاصيل المنتج'),
                          hintStyle: TextStyle(
                            fontSize: 17.4,
                            letterSpacing: 1,
                            fontFamily: 'montserrat',
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
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 20.0),
                          hintText: price,
                          label: Text('سعر المنتج'),
                          hintStyle: TextStyle(
                            fontSize: 17.4,
                            fontFamily: 'montserrat',
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
                    Container(
                      child: TextFormField(
                        initialValue: quantity,
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 20.0),
                          hintText: quantity,
                          label: Text('كميه المنتج'),
                          hintStyle: TextStyle(
                            fontSize: 17.4,
                            fontFamily: 'montserrat',
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
                          quantity = val;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "الرجاء كتابة كميه المنتج";
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
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 20.0),
                          hintText: loc,
                          label: Text('موقع المنتج الحالي'),
                          hintStyle: TextStyle(
                            fontSize: 17.4,
                            letterSpacing: 1,
                          ),
                          labelStyle: TextStyle(
                            fontSize: 23,
                            fontFamily: 'montserrat',
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
                            return "الرجاء كتابة موقع المنتج الحالي";
                          } else
                            return null;
                        },
                      ),
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
                                letterSpacing: 1.5,
                                fontFamily: 'montserrat',
                                fontSize: 17,
                                color: col.white,
                              )),
                          style: ElevatedButton.styleFrom(
                            primary: col.primarycolor,
                          ),
                          //-------Switch to Next Page 'Main'------
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await procollection.doc(ds.id).update({
                                'name': name,
                                'loc': loc,
                                'price': price,
                                'quantity': quantity,
                                'desc': desc,
                              });
                              Navigator.pop(context);
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
}
