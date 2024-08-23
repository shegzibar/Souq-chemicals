import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:souq_chemicals/pages/manager/transactions.dart';
import 'package:souq_chemicals/pages/manager/useritemslist.dart';
import 'package:souq_chemicals/pages/manager/userlist.dart';
import 'package:souq_chemicals/pages/models/colors.dart';

class manlist extends StatefulWidget {
  const manlist({super.key});

  @override
  State<manlist> createState() => _manlistState();
}

class _manlistState extends State<manlist> {
  appcolors col = appcolors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const userlist(),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Card(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: col.primarycolor,
                            ),
                            Text(
                              '   معلومات المستخدمين',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => useritemlist(),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.shopping_bag_rounded,
                                color: col.primarycolor,
                              ),
                              Text(
                                'المنتجات',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const transactions(),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.line_style_sharp,
                                color: col.primarycolor,
                              ),
                              Text(
                                'معاملات المستخدمين',
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
