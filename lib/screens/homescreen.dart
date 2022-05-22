import 'package:chordsic/interfaces/1%20home.dart';
import 'package:chordsic/interfaces/2%20player.dart';
import 'package:chordsic/interfaces/3%20favorite.dart';
import 'package:chordsic/interfaces/4%20playlist.dart';
import 'package:chordsic/interfaces/5%20settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentSelectedIndex = 0;

  //Change Pages as per Navbar
  final _pages = [
    const Home(),
    const Player(),
    //const AlbumArtists(),
    const Playlist(),
    const Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 221, 255, 252),
      body: _pages[_currentSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[600],
        showSelectedLabels: true,
        currentIndex: _currentSelectedIndex,
        onTap: (newIndex) {
          setState(
            () {
              _currentSelectedIndex = newIndex;
            },
          );
        },
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.headphones),
            label: '',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(CupertinoIcons.music_albums),
          //   label: '',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_play_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            label: '',
          ),
        ],
      ),
    );
  }
}
