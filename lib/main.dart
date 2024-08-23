// ignore_for_file: prefer_const_constructors

import 'dart:html';
import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:souq_chemicals/pages/authentication/sign%20in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:souq_chemicals/pages/home/home.dart';
import 'package:souq_chemicals/services/auth.dart';
import 'package:souq_chemicals/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyCZaQrp8B6VPM_RqbtP4iAN7Sw854VbRZk",
        authDomain: "souq-chemicals.firebaseapp.com",
        projectId: "souq-chemicals",
        storageBucket: "souq-chemicals.appspot.com",
        messagingSenderId: "774901762585",
        appId: "1:774901762585:web:7636d3f06d6fb17f4e3888"),
  );
  runApp(MaterialApp(
    home: MaterialApp(debugShowCheckedModeBanner: false, home: route()),
  ));
}

class route extends StatelessWidget {
  const route({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: Authservice().user,
      initialData: null,
      child: MaterialApp(
        home: wrapper(),
      ),
    );
  }
}
