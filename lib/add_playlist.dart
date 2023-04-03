//import 'dart:convert';
// ignore_for_file: avoid_print, library_prefixes

import 'dart:io';

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'my_home_page.dart';
import 'app_colors.dart' as AppColors;

class AddPlaylist extends StatefulWidget {
  final int i;
  final int index;
  final List playlistsData;
  final List musicsData;
  final List listMusics;
  final bool isPlaying;
  final bool isAleatory;
  final int currentPlaylist;
  final int currentMusic;
  final bool isLooping;
  final Duration position;
  const AddPlaylist({
    Key? key,
    required this.i,
    required this.index,
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
  _AddPlaylistState createState() => _AddPlaylistState();
}

class _AddPlaylistState extends State<AddPlaylist>
    with SingleTickerProviderStateMixin {
  File? image;
  final _name = TextEditingController();
  final _description = TextEditingController();
  String name = "";
  String description = "";

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('failed $e');
    }
  }

  @override
  void initState() {
    super.initState();
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
            "Nouvelle playlist",
            style: TextStyle(
              fontFamily: "Avenir",
              color: AppColors.defaultColor,
            ),
          ),
        ),
        centerTitle: true,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(
                      i: widget.i,
                      index: widget.index,
                      playlistsData: widget.playlistsData,
                      musicsData: widget.musicsData,
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
                name = _name.text;
                description = _description.text;
                if (image != null) {
                  widget.playlistsData.add({
                    "name": name,
                    "img": image!.path,
                    "description": description,
                    "musics": []
                  });
                } else {
                  widget.playlistsData.add({
                    "name": name,
                    "img": "",
                    "description": description,
                    "musics": []
                  });
                }
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(
                    index: widget.index,
                    i: widget.i,
                    playlistsData: widget.playlistsData,
                    musicsData: widget.musicsData,
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
            child: Text("OK", style: TextStyle(color: AppColors.mainColor)),
          ),
        ],
      ),
      body: Container(
        color: AppColors.backgroundColor,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 0),
                Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    color: AppColors.disabledColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: image != null
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              image: FileImage(File(image!.path)),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: InkWell(
                            onTap: () async {
                              pickImage();
                            },
                          ),
                        )
                      : IconButton(
                          icon: Icon(
                            Icons.queue_music_rounded,
                            color: AppColors.mainColor,
                            size: 250,
                          ),
                          onPressed: () {
                            pickImage();
                          }),
                ),
                const SizedBox(width: 0),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _name,
              autofocus: true,
              cursorColor: AppColors.mainColor,
              decoration: InputDecoration(
                hintText: "Nom",
                hintStyle:
                    TextStyle(fontSize: 24, color: AppColors.disabledColor2),
                labelText: "Nom",
                labelStyle: TextStyle(fontSize: 24, color: AppColors.mainColor),
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.mainColor),
                ),
                enabled: true,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _description,
              autofocus: true,
              cursorColor: AppColors.mainColor,
              decoration: InputDecoration(
                hintText: "Description",
                hintStyle:
                    TextStyle(fontSize: 24, color: AppColors.disabledColor2),
                labelText: "Description",
                labelStyle: TextStyle(fontSize: 24, color: AppColors.mainColor),
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.mainColor),
                ),
                enabled: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
