// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'dart:convert';
import 'my_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late List playlists;
  late List musics;

  ReadData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/playlists.json")
        .then((s) {
      setState(() {
        playlists = json.decode(s);
      });
    });
    await DefaultAssetBundle.of(context)
        .loadString("json/musics.json")
        .then((s) {
      setState(() {
        musics = json.decode(s);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    ReadData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Audio App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        i: 0,
        index: 0,
        playlistsData: playlists,
        musicsData: musics,
        currentMusic: -1,
        currentPlaylist: 0,
        isAleatory: false,
        isLooping: false,
        isPlaying: false,
        listMusics: const [],
        position: const Duration(seconds: 0),
      ),
    );
  }
}
