import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:souq_chemicals/pages/models/colors.dart';

class transdetail extends StatefulWidget {
  String? id, username, phone;
  transdetail({required this.id, required this.username, required this.phone});

  @override
  State<transdetail> createState() => _transdetailState();
}

class _transdetailState extends State<transdetail> {
  appcolors col = appcolors();

  int? len;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: col.white,
      appBar: AppBar(
        title: Text(
          "معلومات العمليه",
          style: TextStyle(color: col.primarycolor),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: col.primarycolor,
            )),
        centerTitle: true,
        backgroundColor: col.white,
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Cart")
            .where("id", isEqualTo: widget.id)
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
                  Icon(Icons.no_accounts),
                  Text(
                    'السله فارغه',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                        return Card(
                            elevation: 2,
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          snapshot.data!.docs[index]['username']
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          snapshot.data!.docs[index]['phone']
                                              .toString(),
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          snapshot.data!.docs[index]['proname']
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
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          snapshot.data!.docs[index]['quantity']
                                              .toString(),
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              snapshot.data!.docs[index]['loc']
                                                  .toString(),
                                              style:
                                                  TextStyle(color: Colors.grey),
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
                            ));
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
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
                Text('انتهاء العمليه',
                    style: TextStyle(
                      letterSpacing: 1.5,
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
              _showDialog(context);
            },
          ),
        ),
      ),
    );
  }

  void _showDialog(context) {
    showDialog(
        context: context,
        builder: (context) => SingleChildScrollView(
              child: AlertDialog(
                content: Column(
                  children: [
                    Text(
                      "هل انت متاكد من انتهاء العمليه",
                      style: TextStyle(color: col.primarycolor, fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
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
                              Text('نعم',
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
                          onPressed: () async {
                            Query<Map<String, dynamic>> _pb = FirebaseFirestore
                                .instance
                                .collection('trans')
                                .where("id", isEqualTo: widget.id);
                            var snapshots = await _pb.get();
                            for (var doc in snapshots.docs) {
                              await doc.reference.delete();
                            }
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
