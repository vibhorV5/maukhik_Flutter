import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maukhik_audio_book_app/constants/colors.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:maukhik_audio_book_app/constants/text_style.dart';

class AudioPlayerScreen extends StatefulWidget {
  List listBooks;
  int selectedIndex;

  AudioPlayer myAudioPlayer = AudioPlayer();

  AudioPlayerScreen({required this.listBooks, required this.selectedIndex});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  Duration duration = Duration();
  Duration position = Duration();

  bool isPlaying = true;
  bool isComplete = false;

  @override
  void initState() {
    super.initState();

    widget.myAudioPlayer.onDurationChanged.listen((Duration d) {
      print('Maximum duration = $d');
      setState(() {
        duration = d;
      });
    });

    widget.myAudioPlayer.onAudioPositionChanged.listen((Duration p) {
      setState(() {
        position = p;
      });
    });

    widget.myAudioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        position = duration;
        position = Duration(seconds: 0);
        isComplete = true;
        isPlaying = false;
      });
    });

    widget.myAudioPlayer
        .setUrl(widget.listBooks[widget.selectedIndex]["audioUrl"]);

    playAudio();
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await widget.myAudioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kNotSelected,
        body: Container(
          margin: EdgeInsets.only(top: 40),
          padding: EdgeInsets.only(top: 20, left: 15, right: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25), topLeft: Radius.circular(25)),
            color: kBackground,
          ),
          width: MediaQuery.of(context).size.width,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            // color: Colors.red.withOpacity(0.1),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        child: Icon(
                          Icons.arrow_back_ios_sharp,
                          size: 30,
                          color: kIcons.withOpacity(0.85),
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(2),
                            child: Text(
                              'Currently playing',
                              style: kAuthorText.copyWith(
                                  fontSize: 12,
                                  letterSpacing: 0.3,
                                  color: kAuthor.withOpacity(0.7),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(2),
                            child: Text(
                                widget.listBooks[widget.selectedIndex]
                                    ["author"],
                                style: kAuthorText.copyWith(
                                    letterSpacing: 0.6,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white70.withOpacity(
                                      0.7,
                                    ))),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Icon(
                        Icons.menu,
                        size: 30,
                        color: kIcons.withOpacity(0.85),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.red.withOpacity(0.1),
                  child: Container(
                    // color: Colors.red.withOpacity(0.4),
                    width: 180,
                    height: 250,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.asset(
                        widget.listBooks[widget.selectedIndex]["imgUrl"],
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: kNotSelected.withOpacity(0.3),
                  ),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      FittedBox(
                        child: Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          // color: Colors.white70.withOpacity(0.3),
                          padding: EdgeInsets.only(
                              top: 5, bottom: 5, left: 10, right: 10),
                          alignment: Alignment.center,
                          child: Text(
                            widget.listBooks[widget.selectedIndex]["title"],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                height: 1.4,
                                color: kIcons,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        child: FittedBox(
                          child: Text(
                            widget.listBooks[widget.selectedIndex]["author"],
                            style: kAuthorText.copyWith(
                                fontSize: 13,
                                letterSpacing: 0.3,
                                color: kAuthor.withOpacity(0.7),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(position.toString().split('.')[0],
                                  style: kAuthorText.copyWith(
                                      fontSize: 13,
                                      letterSpacing: 0.3,
                                      color: kIcons.withOpacity(0.7),
                                      fontWeight: FontWeight.bold)),
                            ),
                            Container(
                              width: 160,
                              // color: Colors.red.withOpacity(0.3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (position.inSeconds > 10) {
                                          widget.myAudioPlayer.seek(Duration(
                                              seconds:
                                                  position.inSeconds - 10));
                                        } else if (position.inSeconds < 10) {
                                          return;
                                        }
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: EdgeInsets.all(8),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 18,
                                            width: 18,
                                            child: Icon(
                                              Icons.arrow_back_ios_rounded,
                                              color: kIcons.withOpacity(0.8),
                                              size: 18,
                                            ),
                                          ),
                                          Text(
                                            '10',
                                            style: TextStyle(
                                                color: kIcons.withOpacity(0.8),
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (isPlaying == false) {
                                        setState(() {
                                          playAudio();
                                          isPlaying = true;
                                        });
                                      } else if (isPlaying == true) {
                                        setState(() {
                                          pauseAudio();
                                          isPlaying = false;
                                        });
                                      }
                                    },
                                    child: Container(
                                      height: 55,
                                      width: 55,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: kSelected),
                                      child: (isPlaying == false)
                                          ? Icon(Icons.play_arrow_rounded,
                                              color: kIcons.withOpacity(0.8),
                                              size: 40)
                                          : Icon(
                                              Icons.pause_rounded,
                                              color: kIcons.withOpacity(0.8),
                                              size: 40,
                                            ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if ((position < duration &&
                                            position.inSeconds <
                                                duration.inSeconds - 11)) {
                                          widget.myAudioPlayer.seek(Duration(
                                              seconds:
                                                  position.inSeconds + 10));
                                        }
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      child: Row(
                                        children: [
                                          Text(
                                            '10',
                                            style: TextStyle(
                                                color: kIcons.withOpacity(0.8),
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            height: 18,
                                            width: 18,
                                            child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: kIcons.withOpacity(0.8),
                                              size: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Text(duration.toString().split('.')[0],
                                  style: kAuthorText.copyWith(
                                      fontSize: 13,
                                      letterSpacing: 0.3,
                                      color: kAuthor.withOpacity(0.7),
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                      mySlider(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> playAudio() async {
    await widget.myAudioPlayer
        .play(widget.listBooks[widget.selectedIndex]["audioUrl"]);
  }

  Future<void> pauseAudio() async {
    await widget.myAudioPlayer.pause();
  }

  Slider mySlider() {
    return Slider(
      min: 0.0,
      max: duration.inSeconds.toDouble() + 2,
      onChanged: (double value) {
        setState(() {
          convert(value.toInt());
        });
      },
      value: position.inSeconds.toDouble(),
      activeColor: kSelected,
      inactiveColor: kNotSelected,
      thumbColor: Colors.white,
    );
  }

  convert(int value) {
    Duration newValue = Duration(seconds: value);
    widget.myAudioPlayer.seek(newValue);
  }
}
