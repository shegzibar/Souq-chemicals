import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:souq_chemicals/pages/cart.dart';
import 'package:souq_chemicals/pages/home/home.dart';
import 'package:souq_chemicals/pages/home/settings.dart';
import 'package:souq_chemicals/pages/manager/manlist.dart';
import 'package:souq_chemicals/pages/models/colors.dart';
import 'package:souq_chemicals/pages/myitems.dart';
import 'package:souq_chemicals/services/auth.dart';

class navbar extends StatefulWidget {
  const navbar({super.key});

  @override
  State<navbar> createState() => _navbarState();
}

class _navbarState extends State<navbar> {
  int currentIndex = 0;
  late PageController _pageController;
  appcolors col = appcolors();
  final _auth = FirebaseAuth.instance;
  String? useremail;
  void getCurrentuser() async {
    useremail = await _auth.currentUser?.email;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
    getCurrentuser();
  }

  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          children: [
            home(),
            cart(),
            myitems(),
            settings(),
            if (useremail == "shegzibar@gmail.com" ||
                useremail == "alrabihmohd@gmail.com" ||
                useremail == "admin_1@gmail.com" ||
                useremail == "admin_2@gmail.com" ||
                useremail == "admin_3@gmail.com" ||
                useremail == "admin_4@gmail.com")
              manlist()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: currentIndex,
        onItemSelected: (index) {
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text("السوق"),
              activeColor: col.primarycolor),
          BottomNavyBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text("المشتريات"),
              activeColor: col.primarycolor),
          BottomNavyBarItem(
              icon: Icon(Icons.list_alt_outlined),
              title: Text("منتجاتي"),
              activeColor: col.primarycolor),
          BottomNavyBarItem(
              icon: Icon(Icons.settings),
              title: Text("الاعدادات"),
              activeColor: col.primarycolor),
          if (useremail == "shegzibar@gmail.com" ||
              useremail == "alrabihmohd@gmail.com" ||
              useremail == "admin_1@gmail.com" ||
              useremail == "admin_2@gmail.com" ||
              useremail == "admin_3@gmail.com" ||
              useremail == "admin_4@gmail.com")
            BottomNavyBarItem(
                icon: Icon(Icons.manage_accounts),
                title: Text("manager"),
                activeColor: col.primarycolor),
        ],
      ),
    );
  }
}
