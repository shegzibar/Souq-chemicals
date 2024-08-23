import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:souq_chemicals/pages/authentication/register.dart';
import 'package:souq_chemicals/pages/home/home.dart';
import 'package:souq_chemicals/pages/home/loading.dart';
import 'package:souq_chemicals/pages/models/colors.dart';
import 'package:souq_chemicals/services/auth.dart';

class sign_in extends StatefulWidget {
  const sign_in({super.key});

  @override
  State<sign_in> createState() => _sign_inState();
}

class _sign_inState extends State<sign_in> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool loading = false;
  bool _Pass = true;
  String error = '';
  Authservice _auth = Authservice();
  appcolors col = appcolors();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                                hintText: 'أدخل بريدك الإلكتروني',
                                hintStyle: TextStyle(
                                  fontSize: 17.4,
                                  letterSpacing: 1,
                                  fontFamily: 'montserrat',
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
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 20.0),
                                hintText: 'أدخل كلمة المرور',
                                hintStyle: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'montserrat',
                                  letterSpacing: 1,
                                ),
                                alignLabelWithHint: true,
                                labelText: 'كلمة المرور\n',

                                labelStyle: TextStyle(
                                  fontSize: 23,
                                  fontFamily: 'montserrat',
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
                          Padding(
                            padding: EdgeInsets.only(left: 11),
                            child: SizedBox(
                              width: 200,
                              height: 50,
                              child: ElevatedButton(
                                child: Text('تسجيل دخول',
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
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      loading = true;
                                    });
                                    dynamic result =
                                        await _auth.signinwithemailandpassword(
                                            email, password);

                                    print(result);
                                    if (result == null) {
                                      setState(() {
                                        print(result);
                                        error =
                                            "هناك خطاء في الادخال الرجاء اتحقق من المعلومات ";
                                        loading = false;
                                      });
                                    }
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
                              "انشاء حساب جديد",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'montserrat',
                                color: Colors.blue[500],
                              ),
                            ),
                            //---------Switch to Signup--------
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) => register(),
                                ),
                              );
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
