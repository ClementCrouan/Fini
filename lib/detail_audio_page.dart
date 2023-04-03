//import 'dart:html';

// ignore_for_file: library_prefixes

import 'package:audioplayers/audioplayers.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:json_annotation/json_annotation.dart';
import 'music_page.dart';
//import 'my_home_page.dart';
//import 'audio_file.dart';
import 'app_colors.dart' as AppColors;

class DetailAudioPage extends StatefulWidget {
  final List musicsData;
  final List playlistData;
  final int index;
  final int i;
  final bool isPlaying;
  final bool isAleatory;
  final List listMusics;
  final int currentPlaylist;
  final int currentMusic;
  final bool isLooping;
  final Duration position;
  const DetailAudioPage(
      {Key? key,
      required this.musicsData,
      required this.playlistData,
      required this.index,
      required this.i,
      required this.isPlaying,
      required this.isAleatory,
      required this.currentPlaylist,
      required this.currentMusic,
      required this.isLooping,
      required this.position,
      required this.listMusics})
      : super(key: key);

  @override
  _DetailAudioPageState createState() => _DetailAudioPageState();
}

class _DetailAudioPageState extends State<DetailAudioPage> {
  bool isPlaying = false;
  bool isAleatory = false;
  bool isLooping = false;
  List listMusics = [];
  late int currentMusic;
  late int currentPlaylist;
  Color? aleaColor = AppColors.disabledColor2;
  Color? loopColor = AppColors.disabledColor2;
  IconData playBtn = Icons.play_arrow_rounded;
  IconData favoriteBtn = Icons.favorite_rounded;

  late List musics;
  late List playlists;

  List<IconData> img = [
    Icons.music_note_rounded,
    Icons.favorite_rounded,
    Icons.star_rounded,
  ];

  AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  Duration position = const Duration();
  Duration musicLength = const Duration();

  Widget slider() {
    return SizedBox(
      width: 300,
      child: Slider(
        activeColor: AppColors.mainColor,
        inactiveColor: AppColors.disabledColor,
        value: position.inSeconds.toDouble(),
        min: 0.0,
        max: musicLength.inSeconds.toDouble(),
        onChanged: (double value) {
          seekToSec(value.toInt());
        },
      ),
    );
  }

  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    audioPlayer.seek(newPos);
  }

  @override
  void initState() {
    super.initState();
    currentPlaylist = widget.currentPlaylist;
    currentMusic = widget.currentMusic;
    musics = widget.musicsData;
    playlists = widget.playlistData;
    listMusics += [widget.i];
    if (widget.musicsData[widget.i]["favorite"]) {
      favoriteBtn = Icons.favorite_rounded;
    } else {
      favoriteBtn = Icons.favorite_border_rounded;
    }
    audioPlayer.onDurationChanged.listen((d) {
      setState(() {
        musicLength = d;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((p) {
      setState(() {
        position = p;
      });
    });
    audioPlayer.setUrl(widget.musicsData[widget.i]["audio"]);
    audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        position = const Duration(seconds: 0);
        if (isLooping == true) {
          isPlaying = true;
        } else if (isAleatory == true) {
          isPlaying = true;
        } else {
          isPlaying = false;
          isLooping = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: IconButton(
          icon: Icon(Icons.remove_rounded, color: AppColors.mainColor),
          iconSize: 60,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MusicPage(
                  index: widget.index,
                  playlistsData: playlists,
                  musicsData: musics,
                  i: widget.i,
                  isAleatory: isAleatory,
                  currentPlaylist: currentPlaylist,
                  isLooping: isLooping,
                  isPlaying: isPlaying,
                  listMusics: listMusics,
                  position: position,
                  currentMusic: currentMusic,
                ),
              ),
            );
          },
        ),
        centerTitle: true,
        elevation: 0,
        leading: Container(),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: AppColors.backgroundColor),
        child: Padding(
          padding: const EdgeInsets.only(top: 48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 250.0,
                      height: 250.0,
                      decoration: BoxDecoration(
                        color: AppColors.disabledColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: widget.index <= 2
                          ? Icon(
                              img[widget.index],
                              color: AppColors.mainColor,
                              size: 250.0,
                            )
                          : playlists[widget.index]["img"] != ""
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          playlists[widget.index]["img"]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Icon(
                                  Icons.queue_music_rounded,
                                  color: AppColors.mainColor,
                                  size: 250.0,
                                ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      playlists[widget.index]["name"],
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Avenir",
                        color: AppColors.defaultColor,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      musics[widget.i]["title"],
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: "Avenir",
                        color: AppColors.defaultColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 500.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${position.inMinutes}:${position.inSeconds.remainder(60)}",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: AppColors.defaultColor,
                              ),
                            ),
                            slider(),
                            Text(
                              "${musicLength.inMinutes}:${musicLength.inSeconds.remainder(60)}",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: AppColors.defaultColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: ImageIcon(
                              const AssetImage('img/repeat.png'),
                              size: 25,
                              color: loopColor,
                            ),
                            onPressed: () {
                              setState(() {
                                isLooping = !isLooping;
                                if (isLooping) {
                                  loopColor = AppColors.mainColor;
                                } else {
                                  loopColor = AppColors.disabledColor2;
                                }
                                if (isAleatory) {
                                  isAleatory = false;
                                  aleaColor = AppColors.disabledColor2;
                                }
                              });
                            },
                          ),
                          IconButton(
                            iconSize: 45.0,
                            color: AppColors.mainColor,
                            onPressed: () {
                              setState(() {
                                if (position != const Duration(seconds: 0)) {
                                  position = const Duration(seconds: 0);
                                } else if (currentMusic != 0) {
                                  currentMusic -= 1;
                                  audioPlayer.play(musics[
                                          playlists[widget.index]
                                                  ["musics"]
                                              [listMusics[currentMusic]]!]
                                      ["audio"]);
                                  isLooping = false;
                                  loopColor = AppColors.disabledColor2;
                                }
                              });
                            },
                            icon: const Icon(Icons.skip_previous_rounded),
                          ),
                          IconButton(
                            iconSize: 62.0,
                            color: AppColors.mainColor,
                            onPressed: () {
                              if (!isPlaying) {
                                setState(() {
                                  audioPlayer.play(musics[widget.i]["audio"]!);
                                  playBtn = Icons.pause_rounded;
                                  isPlaying = true;
                                });
                              } else {
                                audioPlayer.pause();
                                setState(() {
                                  playBtn = Icons.play_arrow_rounded;
                                  isPlaying = false;
                                });
                              }
                            },
                            icon: Icon(playBtn),
                          ),
                          IconButton(
                            iconSize: 45.0,
                            color: AppColors.mainColor,
                            onPressed: () {
                              setState(() {
                                if (!isAleatory) {
                                  position = const Duration(seconds: 0);
                                  if (currentMusic + 1 == listMusics.length) {
                                    currentMusic += 1;
                                    audioPlayer.stop();
                                    listMusics += [
                                      playlists[widget.index]["musics"]
                                          [currentMusic]
                                    ];
                                    audioPlayer.play(musics[
                                            playlists[widget.index]
                                                    ["musics"]
                                                [listMusics[currentMusic]]!]
                                        ["audio"]);
                                  } else {
                                    currentMusic += 1;
                                    audioPlayer.play(musics[
                                            playlists[widget.index]
                                                    ["musics"]
                                                [listMusics[currentMusic]]!]
                                        ["audio"]);
                                  }
                                }
                              });
                            },
                            icon: const Icon(Icons.skip_next_rounded),
                          ),
                          IconButton(
                            icon: ImageIcon(
                              const AssetImage('img/loop.png'),
                              size: 25,
                              color: aleaColor,
                            ),
                            onPressed: () {
                              setState(() {
                                isAleatory = !isAleatory;
                                if (isAleatory) {
                                  aleaColor = AppColors.mainColor;
                                } else {
                                  aleaColor = AppColors.disabledColor2;
                                }
                                if (isLooping) {
                                  isLooping = false;
                                  loopColor = AppColors.disabledColor2;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            iconSize: 30.0,
                            color: AppColors.mainColor,
                            onPressed: () {
                              List musicsFavorite = playlists[1]["musics"];
                              if (musics[widget.i]["favorite"]) {
                                setState(() {
                                  favoriteBtn = Icons.favorite_border_rounded;
                                  musics[widget.i]["favorite"] = false;
                                  musicsFavorite.remove(widget.i);
                                });
                              } else {
                                setState(() {
                                  favoriteBtn = Icons.favorite_rounded;
                                  musics[widget.i]["favorite"] = true;
                                  musicsFavorite += [widget.i];
                                });
                              }
                              playlists[1]["musics"] = musicsFavorite;
                            },
                            icon: Icon(favoriteBtn),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
