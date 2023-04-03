//import 'dart:html';

// ignore_for_file: unnecessary_null_comparison, library_prefixes

import 'package:musique_v5/music_management_shortcut.dart';

import 'package:audioplayers/audioplayers.dart';
import 'add_playlist.dart';
import 'music_page.dart';
//import 'package:flutter/cupertino.dart';
import 'app_colors.dart' as AppColors;
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  final int index;
  final int i;
  final List playlistsData;
  final List musicsData;
  final List listMusics;
  final bool isPlaying;
  final bool isAleatory;
  final int currentPlaylist;
  final int currentMusic;
  final bool isLooping;
  final Duration position;

  const MyHomePage({
    Key? key,
    required this.index,
    required this.i,
    required this.playlistsData,
    required this.musicsData,
    required this.listMusics,
    required this.isPlaying,
    required this.isAleatory,
    required this.currentPlaylist,
    required this.currentMusic,
    required this.isLooping,
    required this.position,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late List playlists;
  late List musics;
  late int i = 1;
  late int playlistsLen;
  late String currentTitle;

  IconData btnIcon = Icons.play_arrow_rounded;
  AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  bool isPlaying = false;

  List<IconData> img = [
    Icons.music_note_rounded,
    Icons.favorite_rounded,
    Icons.star_rounded,
  ];

  @override
  void initState() {
    super.initState();
    playlists = widget.playlistsData;
    musics = widget.musicsData;
    playlistsLen = widget.playlistsData[widget.index]["musics"].length;
    if (widget.currentMusic != -1) {
      currentTitle = widget.musicsData[
          widget.playlistsData[widget.currentPlaylist]["musics"]
              [widget.currentMusic]]["title"];
    } else {
      currentTitle = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: AppColors.disabledColor2,
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          "Playlists",
          style: TextStyle(
            fontFamily: "Avenir",
            color: AppColors.defaultColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.add_rounded, color: AppColors.mainColor),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddPlaylist(
                  i: widget.i,
                  index: widget.index,
                  playlistsData: playlists,
                  musicsData: musics,
                  currentMusic: widget.currentMusic,
                  isAleatory: widget.isAleatory,
                  currentPlaylist: widget.currentPlaylist,
                  isLooping: widget.isLooping,
                  isPlaying: widget.isPlaying,
                  listMusics: widget.listMusics,
                  position: widget.position,
                ),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: AppColors.mainColor),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.remove, color: AppColors.mainColor),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        color: AppColors.backgroundColor,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: playlists == null ? 0 : playlists.length,
                itemBuilder: (context, i) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MusicPage(
                          playlistsData: playlists,
                          musicsData: musics,
                          index: i,
                          i: widget.i,
                          currentMusic: widget.currentMusic,
                          currentPlaylist: widget.currentPlaylist,
                          isAleatory: widget.isAleatory,
                          isLooping: widget.isLooping,
                          isPlaying: widget.isPlaying,
                          listMusics: widget.listMusics,
                          position: widget.position,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    color: AppColors.backgroundColor,
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const SizedBox(width: 10),
                            Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                color: AppColors.disabledColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: i <= 2
                                  ? Icon(
                                      img[i],
                                      color: AppColors.mainColor,
                                      size: 90,
                                    )
                                  : playlists[i]["img"] != ""
                                      ? Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  playlists[i]["img"]),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      : Icon(
                                          Icons.queue_music_rounded,
                                          color: AppColors.mainColor,
                                          size: 90,
                                        ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      playlists[i]["name"],
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: "Avenir",
                                        color: AppColors.defaultColor,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.navigate_next,
                                        color: AppColors.disabledColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 110,
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(1),
                                color: AppColors.disabledColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            musicManagementShortcut(
              musics: musics,
              playlists: playlists,
              img: img,
              i: i,
              index: widget.index,
              currentMusic: widget.currentMusic,
              currentPlaylist: widget.currentPlaylist,
              currentTitle: currentTitle,
              btnIcon: btnIcon,
              isPlaying: isPlaying,
              isAleatory: widget.isAleatory,
              isLooping: widget.isLooping,
              listMusics: widget.listMusics,
              position: widget.position,
              context: context,
            ),
          ],
        ),
      ),
    );
  }
}
