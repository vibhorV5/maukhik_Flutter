import 'package:flutter/material.dart';
import 'package:maukhik_audio_book_app/constants/colors.dart';
import 'package:maukhik_audio_book_app/constants/text_style.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: kNotSelected,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 40),
          padding: EdgeInsets.only(top: 20, left: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25), topLeft: Radius.circular(25)),
            color: kBackground,
          ),
          child: Column(
            children: [
              searchBar(),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Container(
                        child: Text(
                          'List Goes Here',
                          style: kAuthorText,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 2),
                    itemCount: 5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  searchBar() {
    return TextField();
  }
}
