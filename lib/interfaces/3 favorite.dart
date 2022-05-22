import 'package:chordsic/functions/fact_favorite.dart';
import 'package:chordsic/interfaces/6%20search.dart';
import 'package:chordsic/interfaces/mini_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Favorite extends StatelessWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 255, 252),

//====================Mini_Player====================//
      bottomSheet: const MiniPlayer(),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 221, 255, 252),
        elevation: 0,
        title: Text(
          'Favorites',
          style: GoogleFonts.nunito(
            fontSize: 30,
            letterSpacing: 1,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearch(),
                );
              },
              icon: const Icon(
                Icons.search,
                size: 35,
                color: Colors.grey,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert_rounded,
              size: 35,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      body: ListView(
        children: const [
          Favorites(
              favThumb: "assets/images/Apple-Music-Artist-Lover.png",
              favSongName: 'Song Name',
              favArtistAlbum: 'Artist Name | Album Name',
              favTime: '03:20'),
          Favorites(
              favThumb: "assets/images/Apple-Music-Artist-Lover.png",
              favSongName: 'Song Name',
              favArtistAlbum: 'Artist Name | Album Name',
              favTime: '03:20'),
          Favorites(
              favThumb: "assets/images/Apple-Music-Artist-Lover.png",
              favSongName: 'Song Name',
              favArtistAlbum: 'Artist Name | Album Name',
              favTime: '03:20'),
          Favorites(
              favThumb: "assets/images/Apple-Music-Artist-Lover.png",
              favSongName: 'Song Name',
              favArtistAlbum: 'Artist Name | Album Name',
              favTime: '03:20'),
          Favorites(
              favThumb: "assets/images/Apple-Music-Artist-Lover.png",
              favSongName: 'Song Name',
              favArtistAlbum: 'Artist Name | Album Name',
              favTime: '03:20'),
          Favorites(
              favThumb: "assets/images/Apple-Music-Artist-Lover.png",
              favSongName: 'Song Name',
              favArtistAlbum: 'Artist Name | Album Name',
              favTime: '03:20'),
          Favorites(
              favThumb: "assets/images/Apple-Music-Artist-Lover.png",
              favSongName: 'Song Name',
              favArtistAlbum: 'Artist Name | Album Name',
              favTime: '03:20'),
          Favorites(
              favThumb: "assets/images/Apple-Music-Artist-Lover.png",
              favSongName: 'Song Name',
              favArtistAlbum: 'Artist Name | Album Name',
              favTime: '03:20'),
        ],
      ),
    );
  }
}
