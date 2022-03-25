import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maukhik_audio_book_app/constants/colors.dart';
import 'package:maukhik_audio_book_app/constants/text_style.dart';

class Categories extends StatelessWidget {
  final List database;
  final Function callback;
  final int selected;

  Categories(
      {required this.database, required this.callback, required this.selected});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemCount: database.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              callback(index);
            },
            child: Container(
              decoration: BoxDecoration(
                color: selected == index ? kSelected : kNotSelected,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.only(left: 20, right: 20),
              alignment: Alignment.center,
              child: Text(
                database[index].keys.first,
                style: kCategoryTitles,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(width: 5.0);
        });
  }
}
