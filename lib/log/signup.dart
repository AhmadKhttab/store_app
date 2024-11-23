import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_app/custom/button.dart';
import 'package:firebase_app/custom/textfiled.dart';
import 'package:firebase_app/log/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formkey,
        child: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              SizedBox(
                height: 50,
              ),
              SizedBox(
                  height: 80, width: 80, child: Image.asset('images/shop.png')),
              SizedBox(
                height: 70,
              ),
              Container(
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  'Enter Your Personal Info ...',
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Text(
                  'Username',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "username must not be empty";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  labelText: "username",
                  icon: Icons.person,
                  controller: namecontroller),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  'Email',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "email must not be empty";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  labelText: "email address",
                  icon: Icons.email,
                  controller: emailcontroller),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  'Password',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "passwords must not be empty";
                    }
                    return null;
                  },
                  isPassword: true,
                  labelText: "Password",
                  icon: Icons.lock,
                  controller: passwordcontroller),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  'Confirm Password',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "passwords must not be empty";
                    }
                    return null;
                  },
                  isPassword: true,
                  labelText: "Confirm Password",
                  icon: Icons.lock,
                  controller: confirmpasswordcontroller),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                text: "Sign up",
                onPressed: () async {
                  if (formkey.currentState!.validate()) {
                    try {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: emailcontroller.text,
                        password: passwordcontroller.text,
                      );
                      FirebaseAuth.instance.currentUser!
                          .sendEmailVerification();
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.rightSlide,
                        title: 'email saved',
                        desc: 'please check your email and log in',
                        btnCancelOnPress: () {
                          Navigator.of(context).pushReplacementNamed('login');
                        },
                        btnOkOnPress: () {
                          Navigator.of(context).pushReplacementNamed('login');
                        },
                      ).show();
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.warning,
                          animType: AnimType.rightSlide,
                          title: 'weak-password',
                          desc: 'The password provided is too weak.',
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {},
                        ).show();
                      } else if (e.code == 'email-already-in-use') {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.warning,
                          animType: AnimType.rightSlide,
                          title: 'email-already-in-use',
                          desc: 'The account already exists for that email.',
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {},
                        ).show();
                      }
                    } catch (e) {
                      print(e);
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
