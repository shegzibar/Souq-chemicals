import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:souq_chemicals/pages/manager/manlist.dart';
import 'package:souq_chemicals/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class settings extends StatefulWidget {
  const settings({super.key});

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  Authservice _auth = Authservice();
  String? useremail;
  final _au = FirebaseAuth.instance;
  void getCurrentuser() async {
    useremail = await _au.currentUser?.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                children: [
                  InkWell(
                    onTap: () {
                      _auth.signout();
                    },
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Icon(Icons.logout),
                            Text(
                              '  تسجيل خروج',
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  // InkWell(
                  //   onTap: () {},
                  //   child: Card(
                  //     elevation: 5,
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(20.0),
                  //       child: Row(
                  //         children: [
                  //           Icon(Icons.person),
                  //           Text(
                  //             '  معلومات عن البرنامج',
                  //             style: TextStyle(fontSize: 20),
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
