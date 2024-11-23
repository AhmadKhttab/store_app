import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/custom/button.dart';
import 'package:firebase_app/custom/textfiled.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class add extends StatefulWidget {
  const add({super.key});

  @override
  State<add> createState() => _addState();
}

GlobalKey<FormState> formkey = GlobalKey();
TextEditingController name = TextEditingController();
TextEditingController desc = TextEditingController();
TextEditingController price = TextEditingController();
TextEditingController image = TextEditingController();

bool loading = false;

class _addState extends State<add> {
CollectionReference item = FirebaseFirestore.instance.collection('item');
  additem() async {
    try {
      loading = true;
      setState(() {});
      DocumentReference response = await item.add({
        'full_name': name.text,
        'description': desc.text,
        'price': price.text,
        'image_link': image.text,
      });
      Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
    } catch (e) {
      loading = false;
      setState(() {});
    }
  }

  void initState() {
    loading = false;
    super.initState();
  }

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
                  await additem();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
