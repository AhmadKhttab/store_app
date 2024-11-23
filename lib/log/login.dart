import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_app/custom/button.dart';
import 'package:firebase_app/custom/textfiled.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _LoginState();
}

TextEditingController emailcontroller = TextEditingController();
TextEditingController passwordcontroller = TextEditingController();
GlobalKey<FormState> formstate = GlobalKey();
bool loading = false;

class _LoginState extends State<login> {
  Future signInWithGoogle() async {
    loading = true;
    setState(() {});
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      loading = false;
      setState(() {});
      return;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);

    Navigator.of(context).pushReplacementNamed('home');
  }

  void initState() {
    loading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // الخلفية الرئيسية
          Container(
            padding: EdgeInsets.all(20),
            child: Form(
              key: formstate,
              child: ListView(
                children: [
                  SizedBox(height: 70),
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: Image.asset('images/shop.png'),
                  ),
                  SizedBox(height: 70),
                  Text(
                    'Log In',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Login to continue using the app ...',
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  SizedBox(height: 30),
                  CustomTextField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "email must not be empty";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    labelText: "Email Address",
                    icon: Icons.email,
                    controller: emailcontroller,
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "password must not be empty";
                      }
                      return null;
                    },
                    isPassword: true,
                    labelText: "Password",
                    icon: Icons.lock,
                    controller: passwordcontroller,
                  ),
                  SizedBox(height: 10),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () async {
                        loading = true;
                        setState(() {});
                        if (emailcontroller.text == "") {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.rightSlide,
                            title: 'Email not found',
                            desc: 'please enter your email address',
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {},
                          ).show();
                          loading = false;
                          setState(() {});
                        } else {
                          try {
                            await FirebaseAuth.instance.sendPasswordResetEmail(
                                email: emailcontroller.text);
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.rightSlide,
                              title: 'Email found',
                              desc: 'please check your email address',
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {},
                            ).show();
                            loading = false;
                            setState(() {});
                          } catch (e) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'Email not found',
                              desc:
                                  'please verify that your email address is correct',
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {},
                            ).show();
                            loading = false;
                            setState(() {});
                          }
                        }
                      },
                      child: Text(
                        "Forget password ? ",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  CustomButton(
                    text: 'Log in',
                    onPressed: () async {
                      if (formstate.currentState!.validate()) {
                        try {
                          loading = true;
                          setState(() {});
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: emailcontroller.text,
                            password: passwordcontroller.text,
                          );
                          if (FirebaseAuth
                              .instance.currentUser!.emailVerified) {
                            Navigator.of(context).pushReplacementNamed('home');
                          } else {
                            loading = false;
                            setState(() {});
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.warning,
                              animType: AnimType.rightSlide,
                              title: 'Confirm email',
                              desc: 'You should confirm your email to continue',
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {},
                            ).show();
                          }
                        } on FirebaseAuthException catch (e) {
                          loading = false;
                          setState(() {});
                          if (e.code == 'user-not-found') {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.warning,
                              animType: AnimType.rightSlide,
                              title: 'No user',
                              desc: 'No user found for that email.',
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {},
                            ).show();
                          } else if (e.code == 'wrong-password') {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.warning,
                              animType: AnimType.rightSlide,
                              title: 'Wrong password',
                              desc: 'Wrong password provided for that user.',
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {},
                            ).show();
                          }
                        }
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Image.asset(
                              "images/facebook.png"),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          signInWithGoogle();
                        },
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Image.asset("images/google.png"),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Image.asset("images/ios.png"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don’t have an account?',
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(width: 5),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('signup');
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // شاشة التحميل
          if (loading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.orange,
                  size: 75,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
