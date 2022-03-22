import 'package:flutter/material.dart';
import 'package:maukhik_audio_book_app/constants/colors.dart';
import 'package:maukhik_audio_book_app/constants/text_style.dart';

class PopularBookList extends StatelessWidget {
  List listBooks;

  PopularBookList({required this.listBooks});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(right: 15),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: kNotSelected,
            ),
            child: Row(
              children: [
                Container(
                  height: 180,
                  width: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      listBooks[index]["imgUrl"],
                      fit: BoxFit.fill,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: kNotSelected,
                  ),
                ),
                Expanded(
                  child: Container(
                    // color: Colors.red.shade50.withOpacity(0.4),
                    height: 160,
                    margin: EdgeInsets.only(top: 20, left: 20, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Container(
                            height: 20,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemBuilder: (context, value) {
                                  return Container(
                                    padding: EdgeInsets.only(
                                        top: 4, left: 2, right: 2, bottom: 4),
                                    decoration: BoxDecoration(
                                        color: ((listBooks[index]["tags"]
                                                    [value]) ==
                                                'Recommended')
                                            ? kRecommended
                                            : kTop,
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Text(
                                      listBooks[index]["tags"][value],
                                      style: TextStyle(
                                          color: kIcons.withOpacity(0.8),
                                          fontSize: 8,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w600),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, value) =>
                                    SizedBox(width: 2),
                                itemCount: (listBooks[index]["tags"]).length),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20, bottom: 5),
                          child: Text(listBooks[index]["author"],
                              style: kAuthorText.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(listBooks[index]["title"],
                              style: kTitleText.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.play_arrow_rounded,
                                  size: 30,
                                  color: Colors.white.withOpacity(0.2)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 10);
        },
        itemCount: 9);
  }
}
