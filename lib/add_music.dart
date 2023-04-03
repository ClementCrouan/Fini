// ignore_for_file: library_prefixes

import 'package:flutter/material.dart';
//import 'package:json_annotation/json_annotation.dart';
import 'custom_list_title.dart';
import 'music_page.dart';
import 'app_colors.dart' as AppColors;

class AddMusic extends StatefulWidget {
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
  const AddMusic({
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
  _AddMusicState createState() => _AddMusicState();
}

class _AddMusicState extends State<AddMusic> {
  int playlistsLen = 0;
  List chooseMusics = [];
  late List musics;
  late List playlist;

  @override
  void initState() {
    super.initState();
    playlist = widget.playlistsData;
    playlistsLen = widget.playlistsData[0]["musics"].length;
    musics = widget.musicsData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: AppColors.disabledColor2,
        backgroundColor: AppColors.backgroundColor,
        leadingWidth: 100,
        title: Expanded(
          child: Text(
            "Nouvelle musique",
            style: TextStyle(
              fontFamily: "Avenir",
              color: AppColors.defaultColor,
            ),
          ),
        ),
        centerTitle: true,
        leading: Row(
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MusicPage(
                      index: widget.index,
                      playlistsData: widget.playlistsData,
                      musicsData: widget.musicsData,
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
              child: Text(
                "Annuler",
                style: TextStyle(color: AppColors.mainColor),
              ),
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                List iSong = playlist[widget.index]["musics"];
                for (int x = 0; x < chooseMusics.length; x++) {
                  if (!iSong.contains(chooseMusics[x])) {
                    playlist[widget.index]["musics"] += [chooseMusics[x]];
                    if (widget.index == 1) {
                      musics[chooseMusics[x]]["favorite"] = true;
                    }
                  }
                }
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MusicPage(
                    index: widget.index,
                    playlistsData: playlist,
                    musicsData: musics,
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
            child: Text(
              "OK",
              style: TextStyle(color: AppColors.mainColor),
            ),
          ),
        ],
      ),
      body: Container(
        color: AppColors.backgroundColor,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: playlistsLen,
                itemBuilder: (context, index) => customListTitle(
                  onTap: () {
                    setState(() {
                      if (!chooseMusics.contains(index)) {
                        chooseMusics += [index];
                      } else {
                        chooseMusics.remove(index);
                      }
                    });
                  },
                  title: widget
                          .musicsData[widget.playlistsData[0]["musics"][index]]
                      ["title"],
                  colorTitle: chooseMusics.contains(index)
                      ? AppColors.mainColor
                      : AppColors.defaultColor,
                  index: index + 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
