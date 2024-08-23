import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:souq_chemicals/pages/manager/userpro.dart';
import 'package:souq_chemicals/pages/models/colors.dart';

class userlist extends StatefulWidget {
  const userlist({super.key});

  @override
  State<userlist> createState() => _userlistState();
}

class _userlistState extends State<userlist> {
  int? len;
  appcolors col = appcolors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: col.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: col.primarycolor),
        backgroundColor: col.white,
        elevation: 0,
        title: Text(
          "userlist",
          style: TextStyle(color: col.primarycolor),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Flexible(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Userdetails")
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
                                String id = snapshot.data!.docs[index]['id'];
                                String name =
                                    snapshot.data!.docs[index]['name'];
                                String usernum =
                                    snapshot.data!.docs[index]['number'];
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            userpro(
                                          id: id.toString(),
                                          name: name.toString(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Card(
                                      elevation: 2,
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.person,
                                          size: 30,
                                          color: col.primarycolor,
                                        ),
                                        title: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot
                                                    .data!.docs[index]['name']
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                snapshot
                                                    .data!.docs[index]['number']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
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
          ),
        ],
      ),
    );
  }
}
