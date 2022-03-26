import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maukhik_audio_book_app/constants/colors.dart';
import 'package:maukhik_audio_book_app/constants/text_style.dart';
import 'package:maukhik_audio_book_app/widgets/categories_book_list.dart';
import 'package:maukhik_audio_book_app/widgets/categories.dart';
import 'package:maukhik_audio_book_app/widgets/popular_book_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List loadDatabase = [];
  int selectedIndex = 0;
  bool isLoaded = false;

  Future _loadDatabase() async {
    await DefaultAssetBundle.of(context)
        .loadString('json/database.json')
        .then((value) {
      setState(() {
        loadDatabase = jsonDecode(value);
        isLoaded = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _loadDatabase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kNotSelected,
      extendBody: true,
      // bottomNavigationBar: ClipRRect(
      //   borderRadius: BorderRadius.only(
      //     topLeft: Radius.circular(40),
      //     topRight: Radius.circular(40),
      //   ),
      //   child: Container(
      //     decoration: BoxDecoration(
      //       color: kBackground,
      //     ),
      //     width: MediaQuery.of(context).size.width,
      //     height: 70,
      //     child: Container(
      //       padding: EdgeInsets.only(top: 18, left: 45, right: 45),
      //       // color: Colors.white.withOpacity(0.1),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Container(
      //             padding: EdgeInsets.symmetric(horizontal: 15),
      //             // color: Colors.red.withOpacity(0.1),
      //             child: MenuBarRow(
      //               icon: Icons.home_filled,
      //               txt: 'Home',
      //             ),
      //           ),
      //
      //           /// Search Button
      //           Container(
      //             padding: EdgeInsets.symmetric(horizontal: 25),
      //             // color: Colors.red.withOpacity(0.1),
      //             child: MenuBarRow(
      //               icon: Icons.search_rounded,
      //               txt: 'Search',
      //             ),
      //           ),
      //
      //           Container(
      //             padding: EdgeInsets.symmetric(horizontal: 15),
      //             // color: Colors.red.withOpacity(0.1),
      //             child: MenuBarRow(
      //               icon: Icons.account_circle_rounded,
      //               txt: 'Profile',
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      // backgroundColor: kNotSelected,
      body: SingleChildScrollView(
          child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            padding: EdgeInsets.only(top: 20, left: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25), topLeft: Radius.circular(25)),
              color: kBackground,
            ),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: kIcons.withOpacity(0.9)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/icons/library.png',
                      color: kNotSelected,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 25, bottom: 30),
                  child: Text('Book Catalog',
                      style: kHeadlines.copyWith(fontSize: 32)),
                ),
                Container(
                  child: Text('Categories',
                      style: kHeadlines.copyWith(fontSize: 20)),
                ),
                Container(
                  margin: EdgeInsets.only(top: 13),
                  width: MediaQuery.of(context).size.width,
                  height: 35,
                  child: Categories(
                      database: loadDatabase,
                      callback: (index) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      selected: selectedIndex),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  height: 290,
                  child: isLoaded == false
                      ? Center(
                          child: CircularProgressIndicator(
                              color: kIcons.withOpacity(0.5)),
                        )
                      : CategoriesBookList(
                          listBooks: loadDatabase[selectedIndex].values.first),
                ),
                Container(
                  child: Text('Popular Books',
                      style: kHeadlines.copyWith(fontSize: 20)),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  height: 330,
                  child: isLoaded == false
                      ? Center(
                          child: CircularProgressIndicator(
                              color: kIcons.withOpacity(0.5)),
                        )
                      : PopularBookList(listBooks: loadDatabase[8]["popular"]),
                ),
                // SizedBox(
                //   height: 80,
                // ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
