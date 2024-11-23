import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/screen/details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

List sub = [];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController? scroll;
  List Categories = [
    {
      "iconname": Icons.laptop,
      "title": "Laptops",
    },
    {
      "iconname": Icons.phone_android_rounded,
      "title": "Mobiles",
    },
    {
      "iconname": Icons.tv,
      "title": "TVs",
    },
    {
      "iconname": Icons.tablet_outlined,
      "title": "Tablets",
    },
  ];

  List<QueryDocumentSnapshot> data = [];

  getData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('item').get();
    data.addAll(querySnapshot.docs);
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          controller: scroll,
          children: [
            // شريط البحث والأيقونات الأخرى
            Row(
              children: [
                Expanded(
                    child: InkWell(
                        onTap: () {
                          showSearch(context: context, delegate: search());
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Icon(Icons.search),
                              SizedBox(width: 10),
                              Text(
                                'Search',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700]),
                              )
                            ],
                          ),
                        ))),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: PopupMenuButton(
                      iconSize: 30,
                      itemBuilder: (context) => [
                            PopupMenuItem(
                                onTap: () {
                                  showSearch(
                                      context: context, delegate: search());
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("Search"),
                                    Icon(Icons.search, size: 18),
                                  ],
                                )),
                            PopupMenuItem(
                                onTap: () {
                                  Navigator.of(context).pushNamed('add');
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("Add item"),
                                    Icon(Icons.add, size: 18),
                                  ],
                                )),
                            PopupMenuItem(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("Setting"),
                                Icon(Icons.settings, size: 18),
                              ],
                            )),
                            PopupMenuItem(
                                onTap: () async {
                                  await FirebaseAuth.instance.signOut();
                                  GoogleSignIn googleSignIn = GoogleSignIn();
                                  googleSignIn.disconnect();
                                  Navigator.of(context)
                                      .pushReplacementNamed('login');
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("Logout"),
                                    Icon(Icons.logout, size: 18),
                                  ],
                                )),
                          ]),
                )
              ],
            ),
            const SizedBox(height: 40),
            // فئة "الأفضل مبيعًا"
            Container(
              height: 50,
              child: const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Container(
                height: 100,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: Categories.length,
                  itemBuilder: (context, index) => Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(50)),
                        padding: const EdgeInsets.all(15),
                        child: Icon(
                          Categories[index]['iconname'],
                          size: 40,
                        ),
                      ),
                      Text(
                        Categories[index]['title'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                            fontSize: 20),
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 50),
            Container(
              height: 50,
              child: const Text(
                'Best Selling',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // زر للانتقال للأسفل
            Container(
              margin: EdgeInsets.only(bottom: 10),
              alignment: Alignment.bottomLeft,
              child: TextButton(
                onPressed: () {
                  scroll?.animateTo(860,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.linear);
                },
                child: Text(
                  "Go to Down",
                  style: TextStyle(fontSize: 20, color: Colors.black45),
                ),
              ),
            ),
            // عرض قائمة العناصر
            GridView.builder(
              controller: scroll,
              itemCount: data.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisExtent: 240),
              itemBuilder: (context, index) {
                var itemData = data[index].data() as Map<String, dynamic>;
                return InkWell(
                    onLongPress: () {},
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => det(
                                data_det: itemData,
                              )));
                    },
                    child: Card(
                      color: Colors.amber[100],
                      child: Column(
                        children: [
                          Container(
                            height: 150,
                            child: Image.network(
                              itemData['image_link'] ?? '',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.broken_image, size: 50);
                              },
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            itemData['full_name'] ?? '',
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            itemData['description'] ?? '',
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            itemData['price'] ?? '',
                            style: const TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ));
              },
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              alignment: Alignment.bottomLeft,
              child: TextButton(
                onPressed: () {
                  scroll?.animateTo(0,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.linear);
                },
                child: Text(
                  "Go to Up",
                  style: TextStyle(fontSize: 20, color: Colors.black45),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class search extends SearchDelegate {
  List? filter;
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(
            Icons.close,
            size: 30,
          )),
      SizedBox(
        width: 10,
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(
        Icons.arrow_back,
        size: 30,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Column(
      children: [
        Text('Result : $query'),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query == "") {
      return ListView.builder(
          itemCount: sub.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: InkWell(
                onTap: () {
                  showResults(context);
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      '${sub[index]['title']}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            );
          });
    } else {
      filter = sub
          .where((item) =>
              item['title'].toLowerCase().contains(query.toLowerCase()))
          .toList();

      return ListView.builder(
          itemCount: filter!.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: InkWell(
                onTap: () {
                  showResults(context);
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      '${filter![index]['title']}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            );
          });
    }
  }
}




  /*
                    showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(200, 550, 200, 200),
                      items: [
                        PopupMenuItem(
                          value: 'edit',
                          child: Text('Edit'),
                          onTap: () {
                            // إجراء التعديل
                          },
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Text('Delete'),
                          onTap: () {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.warning,
                              animType: AnimType.rightSlide,
                              title: 'Delete',
                              desc: 'Are you sure to delete this item ? ',
                              btnCancelOnPress: () {},
                              btnOkOnPress: () async {
                                await FirebaseFirestore.instance
                                    .collection('item')
                                    .doc(data[index].id)
                                    .delete();
                                Navigator.of(context)
                                    .pushReplacementNamed('home');
                              },
                            ).show();
                          },
                        ),
                        PopupMenuItem(
                          value: 'view more',
                          child: Text('view more'),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => det(
                                      data_det: itemData,
                                    )));
                          },
                        ),
                      ],
                    );
                   
                  },
                   */
                  