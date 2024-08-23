import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:souq_chemicals/pages/authentication/sign%20in.dart';
import 'package:souq_chemicals/pages/home/home.dart';
import 'package:provider/provider.dart';
import 'package:souq_chemicals/pages/home/navbar.dart';

class wrapper extends StatefulWidget {
  const wrapper({super.key});

  @override
  State<wrapper> createState() => _wrapperState();
}

class _wrapperState extends State<wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    if (user == null) {
      return sign_in();
    } else {
      return navbar();
    }
  }

  // getuser() async {
  //   final FirebaseAuth _auth = FirebaseAuth.instance;
  //   User? currentuser;
  //   if (currentuser != null) {
  //     await currentuser.reload();
  //   }
  // }
}
