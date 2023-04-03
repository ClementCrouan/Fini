// ignore_for_file: library_prefixes

import 'package:flutter/material.dart';
import 'app_colors.dart' as AppColors;

import 'detail_audio_page.dart';

Widget musicManagementShortcut({
  required List musics,
  required List playlists,
  required List img,
  required int i,
  required int index,
  required int currentMusic,
  required int currentPlaylist,
  required String currentTitle,
  required IconData btnIcon,
  required bool isPlaying,
  required bool isAleatory,
  required bool isLooping,
  required List listMusics,
  required Duration position,
  required BuildContext context,
}) {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.disabledColor2,
              blurRadius: 8.0,
            ),
          ],
        ),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 60.0,
                    width: 60.0,
                    decoration: BoxDecoration(
                      color: AppColors.disabledColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: currentPlaylist <= 2
                        ? Icon(
                            img[currentPlaylist],
                            color: AppColors.mainColor,
                            size: 60.0,
                          )
                        : playlists[currentPlaylist]["img"] != ""
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                    image: AssetImage(
                                        playlists[currentPlaylist]["img"]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Icon(
                                Icons.my_library_music_rounded,
                                color: AppColors.mainColor,
                                size: 60.0,
                              ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailAudioPage(
                                  playlistData: playlists,
                                  index: index,
                                  musicsData: musics,
                                  i: i,
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
                          child: Text(
                            currentTitle,
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Avenir",
                              color: AppColors.defaultColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      //setState(() {
                      if (isPlaying) {
                        //audioPlayer.pause();
                        btnIcon = Icons.pause_rounded;
                        isPlaying = false;
                      } else {
                        //audioPlayer.resume();
                        btnIcon = Icons.play_arrow_rounded;
                        isPlaying = true;
                      }
                      //});
                    },
                    iconSize: 42.0,
                    icon: Icon(
                      btnIcon,
                      color: AppColors.defaultColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    iconSize: 42.0,
                    icon: Icon(
                      Icons.skip_next_rounded,
                      color: AppColors.defaultColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
