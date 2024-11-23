import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/custom/button.dart';
import 'package:firebase_app/custom/textfiled.dart';
import 'package:flutter/material.dart';

class update extends StatefulWidget {
  const update({super.key});

  @override
  State<update> createState() => _addState();
}

GlobalKey<FormState> formkey = GlobalKey();
TextEditingController name = TextEditingController();
TextEditingController desc = TextEditingController();
TextEditingController price = TextEditingController();
TextEditingController image = TextEditingController();
CollectionReference additem = FirebaseFirestore.instance.collection('item');

Future<void> addUser() {
  // Call the user's CollectionReference to add a new user
  return additem
      .add({
        'full_name': name.text,
        'description': desc.text,
        'price': price.text,
        'image_link': image.text,
      })
      .then((value) => print("item added"))
      .catchError((error) => print("Failed to add item: $error"));
}

class _addState extends State<update> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new Item"),
      ),
      body: Form(
        key: formkey,
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            SizedBox(
              height: 30,
            ),
            CustomTextField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This Field Must not be empty ';
                  }
                },
                keyboardType: TextInputType.name,
                labelText: 'Item name',
                icon: (Icons.category),
                controller: name),
            SizedBox(
              height: 30,
            ),
            CustomTextField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This Field Must not be empty ';
                  }
                },
                labelText: 'Item description',
                icon: (Icons.description),
                keyboardType: TextInputType.name,
                controller: desc),
            SizedBox(
              height: 30,
            ),
            CustomTextField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This Field Must not be empty ';
                  }
                },
                keyboardType: TextInputType.number,
                labelText: 'Item price',
                icon: (Icons.price_change),
                controller: price),
            SizedBox(
              height: 30,
            ),
            CustomTextField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This Field Must not be empty ';
                  }
                },
                labelText: 'Item image link',
                icon: (Icons.add_link),
                controller: image),
            SizedBox(
              height: 30,
            ),
            CustomButton(
              text: 'add',
              onPressed: () async {
                if (formkey.currentState!.validate()) {
                  await addUser();
                  setState(() {});
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
