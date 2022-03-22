import 'package:flutter/material.dart';
import 'package:maukhik_audio_book_app/constants/colors.dart';
import 'package:maukhik_audio_book_app/constants/text_style.dart';
import 'package:maukhik_audio_book_app/screens/audio_player_screen.dart';

class CategoriesBookList extends StatelessWidget {
  List listBooks;

  CategoriesBookList({required this.listBooks});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: 120,
            height: 200,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AudioPlayerScreen(
                            listBooks: listBooks, selectedIndex: index),
                      ),
                    );
                  },
                  child: Container(
                    height: 180,
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(listBooks[index]["imgUrl"]),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 10, bottom: 5),
                  child: FittedBox(
                    child: Text(listBooks[index]["author"], style: kAuthorText),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    listBooks[index]["title"],
                    style: kTitleText,
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 10.0,
          );
        },
        itemCount: listBooks.length);
  }
}
