import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:chordsic/dbFunctions/songmodel.dart';
import 'package:chordsic/interfaces/1%20home.dart';
import 'package:chordsic/screens/homescreenn.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

final AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
final OnAudioRoom audioRoom = OnAudioRoom();

List<SongModel> allSongs = [];
List<Songs> mappedSongs = [];
List<Audio> songDetails = [];
List<Songs> dbSongs = [];
final box = Boxes.getInstance();

class _SplashScreenState extends State<SplashScreen> {
//
//<<<<<Request_Permission>>>>>//
  @override
  void initState() {
    super.initState();
    storagePermission();
  }
  storagePermission() async {
    bool permissionStatus = await audioQuery.permissionsStatus();
    if (!permissionStatus) {
      await audioQuery.permissionsRequest();
    }
    setState(() {});
    allSongs = await audioQuery.querySongs();
    mappedSongs = allSongs
        .map((audio) => Songs(
            id: audio.id,
            artist: audio.artist,
            duration: audio.duration,
            songname: audio.title,
            songurl: audio.uri))
        .toList();

    for (var i in allSongs) {
      songDetails.add(
        Audio.file(
          i.uri.toString(),
          metas: Metas(
            title: i.title,
            id: i.id.toString(),
            artist: i.artist,
          ),
        ),
      );
    }
    setState(() {});
    await Future.delayed(
      const Duration(seconds: 2),
    );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const HomeScreen1(),
      ),
    );
  }

  //<<<<<Splash_Design>>>>>//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 255, 252),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Chordsic_Logo.png',
              height: 250,
            ),
          ],
        ),
      ),
    );
  }
}
