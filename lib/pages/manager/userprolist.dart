import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:souq_chemicals/pages/home/addpro.dart';
import 'package:souq_chemicals/pages/home/navbar.dart';
import 'package:souq_chemicals/pages/models/colors.dart';
import 'package:souq_chemicals/services/database.dart';

class userprolist extends StatefulWidget {
  String? uid, name, loc, userid, username, phone;
  userprolist(
      {required this.name,
      required this.uid,
      required this.loc,
      required this.userid,
      required this.username,
      required this.phone});

  @override
  State<userprolist> createState() => _userprolistState();
}

class _userprolistState extends State<userprolist> {
  appcolors col = appcolors();
  final searchKey = TextEditingController();

  int? len;

  DatabaseService _db = DatabaseService();
  @override
  @override
  Widget build(BuildContext context) {
    String Name = widget.name.toString();
    Query<Map<String, dynamic>> _pb = FirebaseFirestore.instance
        .collection('Products')
        .where("id", isEqualTo: widget.userid);
    Query<Map<String, dynamic>> _ab = FirebaseFirestore.instance
        .collection('Adminpro')
        .where("id", isEqualTo: widget.userid);

    Query<Map<String, dynamic>> _ib = FirebaseFirestore.instance
        .collection('Items')
        .where("id", isEqualTo: widget.userid);
    Query<Map<String, dynamic>> _vb = FirebaseFirestore.instance
        .collection('Veiwpro')
        .where("id", isEqualTo: widget.userid);

    return Scaffold(
      backgroundColor: col.white,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              var snapshotss = await _ab.get();
              for (var doc in snapshotss.docs) {
                await doc.reference.delete();
              }
              var snapshot = await _ib.get();
              for (var doc in snapshot.docs) {
                await doc.reference.delete();
              }
              var snapshots = await _pb.get();
              for (var doc in snapshots.docs) {
                await doc.reference.delete();
              }
              var snapshotsss = await _vb.get();
              for (var doc in snapshotsss.docs) {
                await doc.reference.delete();
              }

              Navigator.pop(context);
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
        title: SizedBox(
          height: 50,
          width: 200,
          child: TextFormField(
            onChanged: (value) {
              Name = value;
            },
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              hintText: Name,
              hintStyle: TextStyle(
                fontSize: 15,
                letterSpacing: 1,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(60))),
            ),
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: col.primarycolor,
            )),
        backgroundColor: col.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Items")
              .where("id", isEqualTo: widget.userid)
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
                          fontFamily: 'montserrat',
                          fontWeight: FontWeight.bold),
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
                          return InkWell(
                            onTap: () {},
                            child: Card(
                                elevation: 2,
                                child: ListTile(
                                  leading: Image(
                                    image: AssetImage('assets/download.jpeg'),
                                    height: 40,
                                    width: 40,
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data!.docs[index]['name']
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          snapshot.data!.docs[index]['desc']
                                              .toString(),
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: Column(
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          await _db.deletepro(_ds.id);
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color:
                                              Color.fromARGB(255, 255, 90, 78),
                                        ),
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
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [

      //       SizedBox(
      //         height: 80,
      //       ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 40,
          ),
          Padding(
            padding: EdgeInsets.only(left: 11),
            child: SizedBox(
              width: 170,
              height: 50,
              child: ElevatedButton(
                child: Row(
                  children: [
                    Icon(
                      Icons.post_add,
                      color: col.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('نشر المنتج',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 17,
                          color: col.white,
                        )),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  primary: col.yellow,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                ),
                //-------Switch to Next Page 'Main'------
                onPressed: () async {
                  Navigator.pop(context);
                  var snapshot = await _ab.get();
                  for (var doc in snapshot.docs) {
                    await doc.reference.delete();
                  }
                  await _db.insertveiwprodata(widget.uid!, widget.userid!, Name,
                      widget.username!, widget.phone!, widget.loc!);
                },
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 11),
            child: SizedBox(
              width: 170,
              height: 50,
              child: ElevatedButton(
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: col.white,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('اضافت منتج',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 17,
                          color: col.white,
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
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => addpro(
                        uid: widget.uid!,
                        uname: Name,
                        username: widget.username!,
                        phone: widget.phone!,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
