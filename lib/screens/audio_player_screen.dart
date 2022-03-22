import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:maukhik_audio_book_app/constants/colors.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerScreen extends StatefulWidget {
  List listBooks;
  int selectedIndex;

  AudioPlayerScreen({required this.listBooks, required this.selectedIndex});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kNotSelected,
        body: Container(
          margin: EdgeInsets.only(top: 40),
          padding: EdgeInsets.only(top: 20, left: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25), topLeft: Radius.circular(25)),
            color: kIcons.withOpacity(0.2),
          ),
          width: MediaQuery.of(context).size.width,
        ));
  }
}
