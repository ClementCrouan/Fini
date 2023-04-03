//import 'dart:html';

// ignore_for_file: library_prefixes

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:musique_v5/music_management_shortcut.dart';
//import 'package:flutter/foundation.dart';
//import 'package:json_annotation/json_annotation.dart';
import 'custom_list_title.dart';
import 'add_music.dart';
import 'my_home_page.dart';
//import 'package:flutter/cupertino.dart';
import 'app_colors.dart' as AppColors;
import 'package:flutter/material.dart';
//import 'package:musique_v4/custom_list_title.dart';

class MusicPage extends StatefulWidget {
  final List playlistsData;
  final List musicsData;
  final int index;
  final int i;
  final List listMusics;
  final bool isPlaying;
  final bool isAleatory;
  final int currentPlaylist;
  final int currentMusic;
  final bool isLooping;
  final Duration position;
  const MusicPage({
    Key? key,
    required this.playlistsData,
    required this.musicsData,
    required this.index,
    required this.i,
    required this.listMusics,
    required this.isPlaying,
    required this.isAleatory,
    required this.currentPlaylist,
    required this.currentMusic,
    required this.isLooping,
    required this.position,
  }) : super(key: key);

  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  List<IconData> img = [
    Icons.music_note_rounded,
    Icons.favorite_rounded,
    Icons.star_rounded,
  ];
  late List musics;
  late List playlists;
  late List mostListen;
  late List listMusics;

  int playlistsLen = 0;
  String currentTitle = "";
  String currentSong = "";
  String currentCover = "";
  int currentMusic = 0;
  int currentPlaylist = 0;
  IconData currentIcon = Icons.my_library_music_rounded;
  IconData btnIcon = Icons.play_arrow_rounded;

  AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  bool isPlaying = false;
  bool lire = false;
  bool isAleatory = false;
  bool isLooping = false;

  Duration duration = const Duration();
  Duration position = const Duration();

  void playMusic(String url) async {
    if (isPlaying) {
      if (currentSong != url) {
        audioPlayer.stop();
        int result = await audioPlayer.play(url);
        if (result == 1) {
          isPlaying = true;
          btnIcon = Icons.pause_rounded;
        }
      } else {
        audioPlayer.pause();
        isPlaying = false;
        btnIcon = Icons.play_arrow_rounded;
      }
    } else if (!isPlaying && currentSong != url) {
      int result = await audioPlayer.play(url);
      if (result == 1) {
        isPlaying = true;
        btnIcon = Icons.pause_rounded;
      }
    } else {
      audioPlayer.resume();
      isPlaying = true;
      btnIcon = Icons.pause_rounded;
    }
    setState(() {
      currentSong = url;
      currentTitle =
          musics[playlists[widget.index]["musics"][currentPlaylist]]["title"];
      if (widget.index > 2 && widget.playlistsData[widget.index]['img'] != "") {
        currentCover = widget.playlistsData[widget.index]['img'];
      } else if (widget.index <= 2) {
        currentIcon = img[widget.index];
      } else {
        currentIcon = Icons.queue_music_rounded;
      }
    });
    print(currentSong);
    print(isPlaying);

    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    listMusics = [];
    musics = widget.musicsData;
    playlists = widget.playlistsData;
    mostListen = [0];
    if (widget.index == 2) {
      for (int x = 1; x < musics.length; x++) {
        int j = 0;
        while (musics[mostListen[j]]["nbHear"] >= musics[x]["nbHear"]) {
          if (j != mostListen.length - 1) {
            j++;
          } else {
            break;
          }
        }
        mostListen.insert(j, x);
      }
      playlists[2]["musics"] = mostListen;
    }
    playlistsLen = widget.playlistsData[widget.index]["musics"].length;
    if (playlistsLen != 0) {
      currentTitle = musics[widget.i]["title"];
    } else {
      currentTitle = "";
    }
    currentPlaylist = widget.index;
    if (widget.index > 3 && widget.playlistsData[widget.index]['img'] != "") {
      currentCover = widget.playlistsData[widget.index]["img"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        shadowColor: AppColors.disabledColor2,
        backgroundColor: AppColors.backgroundColor,
        title: Expanded(
          child: Text(
            widget.playlistsData[widget.index]["name"],
            style: TextStyle(
              fontSize: 20,
              fontFamily: "Avenir",
              color: AppColors.defaultColor,
            ),
          ),
        ),
        centerTitle: true,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios, color: AppColors.mainColor),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(
                      i: currentMusic,
                      index: currentPlaylist,
                      playlistsData: playlists,
                      musicsData: musics,
                      currentMusic: currentMusic,
                      isAleatory: isAleatory,
                      currentPlaylist: currentPlaylist,
                      isLooping: isLooping,
                      isPlaying: isPlaying,
                      listMusics: listMusics,
                      position: position,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.search, color: AppColors.mainColor),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.remove, color: AppColors.mainColor),
                onPressed: () {},
              )
            ],
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: playlistsLen + 1,
              itemBuilder: (context, index) => index == 0
                  ? Column(
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          width: 250,
                          height: 250,
                          decoration: BoxDecoration(
                            color: AppColors.disabledColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: widget.index <= 2
                              ? Icon(
                                  img[widget.index],
                                  color: AppColors.mainColor,
                                  size: 250,
                                )
                              : widget.playlistsData[widget.index]["img"] != ""
                                  ? Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              widget.playlistsData[widget.index]
                                                  ["img"]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : Icon(
                                      Icons.queue_music_rounded,
                                      color: AppColors.mainColor,
                                      size: 250,
                                    ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.playlistsData[widget.index]["name"],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Avenir",
                            color: AppColors.defaultColor,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 150,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.disabledColor),
                                onPressed: () {
                                  setState(() {
                                    lire = true;
                                    currentPlaylist = 0;
                                    playMusic(musics[playlists[widget.index]
                                        ["musics"][currentPlaylist]]["audio"]!);
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.play_arrow,
                                        color: AppColors.mainColor),
                                    const SizedBox(width: 10),
                                    Text(
                                      "Lire",
                                      style:
                                          TextStyle(color: AppColors.mainColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.disabledColor),
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(
                                      image: const AssetImage('img/loop.png'),
                                      width: 15,
                                      height: 15,
                                      color: AppColors.mainColor,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "Aléatoire",
                                      style:
                                          TextStyle(color: AppColors.mainColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(width: 23),
                            Expanded(
                              child: Text(
                                widget.playlistsData[widget.index]
                                    ["description"],
                                style: TextStyle(
                                  fontFamily: "Avenir",
                                  color: AppColors.disabledColor2,
                                ),
                              ),
                            ),
                          ],
                        ),
                        widget.index != 2
                            ? const SizedBox(height: 10)
                            : Container(),
                        widget.index != 2
                            ? Row(
                                children: [
                                  const SizedBox(width: 23),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(1),
                                      color: AppColors.disabledColor,
                                    ),
                                  )
                                ],
                              )
                            : Container(),
                        widget.index != 2
                            ? const SizedBox(height: 10)
                            : Container(),
                        widget.index != 2
                            ? Row(
                                children: [
                                  const SizedBox(width: 23),
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.mainColor),
                                      onPressed: () async {
                                        if (widget.index == 0) {
                                          final result = await FilePicker
                                              .platform
                                              .pickFiles(allowMultiple: true);
                                          if (result == null) return;
                                          final file = result.files;
                                          List pathMusic = [];
                                          for (int y = 0;
                                              y < musics.length;
                                              y++) {
                                            pathMusic += [musics[y]["audio"]];
                                          }

                                          for (int x = 0;
                                              x < file.length;
                                              x++) {
                                            if (!pathMusic
                                                .contains(file[x].path!)) {
                                              late String nameFile;
                                              late int indexPoint;
                                              nameFile = file[x].name;
                                              indexPoint =
                                                  nameFile.lastIndexOf(".");
                                              nameFile = nameFile.substring(
                                                  0, indexPoint);
                                              setState(() {
                                                musics.add(
                                                  {
                                                    "audio": file[x].path!,
                                                    "nbHear": 0,
                                                    "favorite": false,
                                                    "title": nameFile
                                                  },
                                                );
                                                playlists[widget.index]
                                                        ["musics"]
                                                    .add(musics.length - 1);
                                                playlistsLen =
                                                    playlists[widget.index]
                                                            ["musics"]
                                                        .length;
                                              });
                                            }
                                          }
                                        } else {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => AddMusic(
                                                musicsData: musics,
                                                playlistsData: playlists,
                                                index: widget.index,
                                                i: currentMusic,
                                                currentMusic: currentMusic,
                                                isAleatory: isAleatory,
                                                currentPlaylist:
                                                    currentPlaylist,
                                                isLooping: isLooping,
                                                isPlaying: isPlaying,
                                                listMusics: listMusics,
                                                position: position,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Ajouter de la musique",
                                            style: TextStyle(
                                                color:
                                                    AppColors.backgroundColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 23),
                                ],
                              )
                            : Container(),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const SizedBox(width: 23),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(1),
                                color: AppColors.disabledColor,
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  : customListTitle(
                      onTap: () {
                        playMusic(
                            musics[playlists[widget.index]["musics"][index - 1]]
                                ["audio"]!);
                        setState(() {
                          currentTitle = musics[playlists[widget.index]
                              ["musics"][index - 1]]["title"];
                          currentMusic =
                              playlists[widget.index]["musics"][index - 1];
                          currentPlaylist = widget.index;
                        });
                      },
                      title:
                          musics[playlists[widget.index]["musics"][index - 1]]
                              ["title"],
                      index: index,
                      colorTitle: AppColors.defaultColor,
                    ),
            ),
          ),
          musicManagementShortcut(
            musics: musics,
            playlists: playlists,
            img: img,
            i: widget.i,
            index: widget.index,
            currentMusic: currentMusic,
            currentPlaylist: currentPlaylist,
            currentTitle: currentTitle,
            btnIcon: btnIcon,
            isPlaying: isPlaying,
            isAleatory: isAleatory,
            isLooping: isLooping,
            listMusics: listMusics,
            position: position,
            context: context,
          ),
        ],
      ),
    );
  }
}
