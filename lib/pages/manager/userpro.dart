import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:souq_chemicals/pages/manager/userprolist.dart';
import 'package:souq_chemicals/pages/models/colors.dart';

class userpro extends StatefulWidget {
  String? id, name;
  userpro({required this.id, required this.name});

  @override
  State<userpro> createState() => _userproState();
}

class _userproState extends State<userpro> {
  int? len;

  appcolors col = appcolors();
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
        elevation: 0,
        iconTheme: IconThemeData(color: col.primarycolor),
        title: Text(
          widget.name!,
          style: TextStyle(color: col.primarycolor),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Veiwpro")
              .where("id", isEqualTo: widget.id)
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
                        String name = snapshot.data!.docs[index]["name"];
                        String loc = snapshot.data!.docs[index]["loc"];
                        String uid = snapshot.data!.docs[index]["uid"];
                        String username =
                            snapshot.data!.docs[index]["username"];
                        String phone = snapshot.data!.docs[index]["phone"];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          child: InkWell(
                            onTap: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      userprolist(
                                    uid: uid,
                                    name: name,
                                    loc: loc,
                                    userid: widget.id,
                                    username: username,
                                    phone: phone,
                                  ),
                                ),
                              );
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
    );
  }
}
