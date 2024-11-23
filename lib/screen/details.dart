import 'package:flutter/material.dart';

class det extends StatefulWidget {
  final data_det;

  const det({super.key, this.data_det});

  @override
  State<det> createState() => _MyAppState();
}

class _MyAppState extends State<det> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const Drawer(),
      bottomNavigationBar: BottomNavigationBar(
          iconSize: 40,
          selectedItemColor: Colors.orange,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: '*',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined), label: '*'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: '*')
          ]),
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        iconTheme: const IconThemeData(color: Colors.grey, size: 28),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shop_outlined,
              color: Colors.orange[300],
            ),
            const Text(
              ' E-Commerce ',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const Text(
              'Khttab',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange),
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.grey[200],
        child: ListView(
          children: [
            // ignore: avoid_unnecessary_containers
            SizedBox(
              height: 100,
            ),
            SizedBox(
              height: 400,
              child: Image.network(widget.data_det['image_link']),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                widget.data_det['full_name'],
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              child: Text(
                widget.data_det['description'],
                style: const TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 20),
              alignment: Alignment.center,
              child: Text(
                widget.data_det['price'],
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Color : ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.grey[500]),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.orange)),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Grey',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.grey[700]),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.orange)),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Black',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.grey[700]),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Price : 37 38 39 40 ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 60,
              ),
              height: 50,
              width: 30,
              child: MaterialButton(
                minWidth: 50,
                color: Colors.black,
                onPressed: () {},
                child: const Text(
                  'Add To Cart',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
