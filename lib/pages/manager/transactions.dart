import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:souq_chemicals/pages/manager/transdetail.dart';
import 'package:souq_chemicals/pages/models/colors.dart';

class transactions extends StatefulWidget {
  const transactions({super.key});

  @override
  State<transactions> createState() => _transactionsState();
}

class _transactionsState extends State<transactions> {
  int? len;
  appcolors col = appcolors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: col.white,
      appBar: AppBar(
          title: Text(
            "المعاملات",
            style: TextStyle(color: col.primarycolor),
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
              ))),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("trans").snapshots(),
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
                          final id = snapshot.data!.docs[index]["id"];
                          final username =
                              snapshot.data!.docs[index]["username"];
                          final phone = snapshot.data!.docs[index]["phone"];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      transdetail(
                                          id: id,
                                          username: username,
                                          phone: phone),
                                ),
                              );
                            },
                            child: Card(
                                elevation: 2,
                                child: ListTile(
                                  leading: Icon(
                                    Icons.attach_money_sharp,
                                    color: col.primarycolor,
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                  ),
                                  trailing: Column(
                                    children: [
                                      Text(
                                        snapshot.data!.docs[index]['rand']
                                            .toString(),
                                        style: TextStyle(
                                            color: col.primarycolor,
                                            fontSize: 20),
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
    );
  }
}
