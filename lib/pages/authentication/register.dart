import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:restart_app/restart_app.dart';
import 'package:souq_chemicals/main.dart';
import 'package:souq_chemicals/pages/authentication/sign%20in.dart';
import 'package:souq_chemicals/pages/home/loading.dart';
import 'package:souq_chemicals/pages/models/colors.dart';
import 'package:souq_chemicals/services/auth.dart';

import 'package:souq_chemicals/services/database.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String username = '';
  String name = '';
  String number = '';
  String password = '';
  bool _Pass = true;
  String error = '';
  bool check = false;
  bool loading = false;
  Authservice _auth = Authservice();
  appcolors col = appcolors();

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: col.white,
            body: SafeArea(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                        image: AssetImage('assets/logo (2).jpg'),
                        width: 250,
                        height: 250),
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            child: TextFormField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 20.0),
                                prefix: Icon(
                                  Icons.person_outline_rounded,
                                  color: col.primarycolor,
                                ),
                                hintText: 'ادخل اسم المستخدم',
                                hintStyle: TextStyle(
                                  fontSize: 17.4,
                                  fontFamily: 'montserrat',
                                  letterSpacing: 1,
                                ),
                                labelText: 'اسم المستخدم',
                                labelStyle: TextStyle(
                                  fontSize: 23,
                                  fontFamily: 'montserrat',
                                  color: Colors.black87,
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(),
                                filled: true,
                              ),
                              onChanged: (val) {
                                name = val;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "الرجاء كتابة اسم المستخدم الخاص بك";
                                } else
                                  return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: TextFormField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 20.0),
                                prefix: Icon(
                                  Icons.email,
                                  color: col.primarycolor,
                                ),
                                hintText: 'أدخل بريدك الإلكتروني',
                                hintStyle: TextStyle(
                                  fontSize: 17.4,
                                  fontFamily: 'montserrat',
                                  letterSpacing: 1,
                                ),
                                labelText: 'البريد الإلكتروني',
                                labelStyle: TextStyle(
                                  fontSize: 23,
                                  fontFamily: 'montserrat',
                                  color: Colors.black87,
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(),
                                filled: true,
                              ),
                              onChanged: (val) {
                                email = val;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "الرجاء كتابة البريد الإلكتروني الخاص بك";
                                } else
                                  return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 20.0),
                                prefix: Icon(
                                  Icons.call,
                                  color: col.primarycolor,
                                ),
                                hintText: 'ادخل رقم الهاتف',
                                hintStyle: TextStyle(
                                  fontSize: 17.4,
                                  letterSpacing: 1,
                                ),
                                labelText: 'رقم الهاتف',
                                labelStyle: TextStyle(
                                  fontSize: 23,
                                  color: Colors.black87,
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(),
                                filled: true,
                              ),
                              onChanged: (val) {
                                number = val;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "الرجاء كتابة رقم الهاتف الخاص بك";
                                } else
                                  return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: TextFormField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 20.0),
                                hintText: 'أدخل كلمة المرور',
                                hintStyle: TextStyle(
                                  fontSize: 17,
                                  letterSpacing: 1,
                                ),
                                alignLabelWithHint: true,
                                labelText: 'كلمة المرور\n',
                                labelStyle: TextStyle(
                                  fontSize: 23,
                                  color: Colors.black87,
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder(),
                                filled: true,

                                //Display Password Button
                                prefixIcon: Icon(
                                  Icons.lock_open,
                                  color: col.primarycolor,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(_Pass
                                      ? Icons.remove_red_eye_outlined
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _Pass = !_Pass;
                                    });
                                  },
                                  iconSize: 30,
                                ),
                              ),
                              onChanged: (val) {
                                password = val;
                              },
                              obscureText: _Pass,
                              validator: (value) {
                                if (value!.length < 8) {
                                  return "يجب أن تتكون كلمة مرورك من 8 أرقام ";
                                } else
                                  return null;
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Checkbox(
                                value: check,
                                onChanged: (val) {
                                  setState(() {
                                    check = val!;
                                  });
                                },
                                activeColor: col.primarycolor,
                                tristate: true,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text("الشروط و الاحكام"),
                                        content: Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              '''
الشروط والاحكام
ينقسم مستخدم التطبيق الي 
١/مورد وهو المستخدم الذي  يعرض مواد كيماوي داخل التطيبق
٢/ مستهلك وهو المستخدم الذي يشتري من داخل التطبيق.

المورد
يلتزم بالتالي
١/اقر بملكيتي للمواد التي اعرضها داخل التطبيق.
٢/ أقر بصحه المواصفات والخدمات التي اضفتها داخل التطبيق واتحمل مسئوليه اي بيانات خاطئه قمت باضافتها او التزام لم اوفي به.
٣/اقر بصحه بيانات التسجيل واكتساب العضويه للتطبيق.
٤/ افوض التطبيق باستلام قيمه الفاتوره بالانابه عني على أن تصفي من اداره التطبيق وتحول الي بعد خصم نسبه ٥٪ عباره عن عموله للتطبيق

المستهلك
١/اقر بصحه بيناتي التي ادخلتها لتسجيل العضويه في التطبيق
٢/التزم بتسديد قيمه الفاتورة بتحويل ينكي ( بنكك) فور اتمامي عمليه الشراء 

موافق على الشروط والاحكام 
لا أوافق على الشروط والاحكام
''',
                                              maxLines: 20,
                                            ),
                                            ElevatedButton(
                                              child: Text('موفق',
                                                  style: TextStyle(
                                                    letterSpacing: 1.5,
                                                    fontSize: 17,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                  )),
                                              style: ElevatedButton.styleFrom(
                                                primary: col.primarycolor,
                                              ),
                                              //-------Switch to Next Page 'Main'------
                                              onPressed: () async {
                                                setState(() {
                                                  check = true;
                                                });
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'موافق على كل الاحكام و القواعد',
                                    style: TextStyle(color: Colors.blue),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 11),
                            child: SizedBox(
                              width: 200,
                              height: 50,
                              child: ElevatedButton(
                                child: Text('انشاء حساب',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    )),
                                style: ElevatedButton.styleFrom(
                                  primary: col.primarycolor,
                                ),
                                //-------Switch to Next Page 'Main'------
                                onPressed: () async {
                                  if (_formKey.currentState!.validate() &&
                                      check == true) {
                                    setState(() {
                                      loading = true;
                                    });
                                    await _auth
                                        .registerwithemailandpassword(
                                            email, password, name, number)
                                        .then((result) {
                                      if (result == null) {
                                        setState(() {
                                          error =
                                              "هناك خطاء في الادخال الرجاء اتحقق من المعلومات او اخرج و عد الى البرنامج ";
                                          print(result);
                                          loading = false;
                                        });
                                      }
                                      if (check == false) {
                                        setState(() {
                                          error =
                                              "الرجاء الموافقه على الشروط و الاحكام";
                                        });
                                      }
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextButton(
                            child: Text(
                              'تسجيل دخول',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.blue[500],
                              ),
                            ),
                            //---------Switch to Signup--------
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          const sign_in()));
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            error,
                            style: TextStyle(color: Colors.red),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
