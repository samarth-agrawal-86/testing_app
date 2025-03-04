// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart' as svg;
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:vocab_builder/screens/phone_signup_page.dart';
import 'package:vocab_builder/screens/signin_page.dart';
import 'package:vocab_builder/services/auth_service.dart';
import 'package:vocab_builder/services/goto_home_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  fb_auth.FirebaseAuth auth = fb_auth.FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  bool _isLoading = false;
  AuthClass authClass = AuthClass();

  googleSignUp() async {
    authClass.googleSignIn(context);
  }

  emailSignUp() async {
    setState(() {
      _isLoading = true;
    });
    try {
      fb_auth.UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _pwdController.text,
      );
      //print(userCredential.user!.email);
      setState(() {
        _isLoading = false;
      });
      gotoHomePage(context);
    } catch (e) {
      //print(e);
      final snackBar = SnackBar(
        content: Text(e.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget buildButtomItem(
      {required String imgPath,
      required String buttonText,
      required Function() function}) {
    return InkWell(
      onTap: function,
      child: SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width - 60,
        child: Card(
          color: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              svg.SvgPicture.asset(
                imgPath,
                height: 25,
                width: 25,
              ),
              SizedBox(width: 20),
              Text(
                buttonText,
                style: TextStyle(color: Colors.white, fontSize: 17),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign up',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              buildButtomItem(
                imgPath: 'assets/google.svg',
                buttonText: 'Continue with Google',
                function: googleSignUp,
              ),
              SizedBox(height: 15),
              buildButtomItem(
                imgPath: 'assets/phone.svg',
                buttonText: 'Continue with Phone',
                function: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhoneSignUpPage(),
                    ),
                  );
                },
              ),
              SizedBox(height: 25),
              Text(
                'Or',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: 55,
                width: MediaQuery.of(context).size.width - 70,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  style: TextStyle(fontSize: 17, color: Colors.white),
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(fontSize: 17, color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.amber,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: 55,
                width: MediaQuery.of(context).size.width - 70,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  obscuringCharacter: '*',
                  controller: _pwdController,
                  style: TextStyle(fontSize: 17, color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(fontSize: 17, color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.amber,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              InkWell(
                onTap: emailSignUp,
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width - 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [
                        Color(0XFFFD746C),
                        Color(0XFFFF9068),
                        Color(0XFFFD746C)
                      ],
                    ),
                  ),
                  child: Center(
                    child: _isLoading
                        ? CircularProgressIndicator()
                        : Text(
                            'Sign up',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Do you already have an account? ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInPage(),
                          ),
                          (route) => false);
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
