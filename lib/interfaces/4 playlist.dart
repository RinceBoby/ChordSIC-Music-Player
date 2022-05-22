import 'package:chordsic/functions/fact_playlist.dart';
import 'package:chordsic/interfaces/6%20search.dart';
import 'package:chordsic/interfaces/mini_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Playlist extends StatelessWidget {
  const Playlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 255, 252),

//====================Mini_Player====================//
      bottomSheet: const MiniPlayer(),

      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 221, 255, 252),
        elevation: 0,
        title: Text(
          'Playlist',
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
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 5),
            child: createpl(),
          ),
          Expanded(
            child: ListView(
              children: const [
                PlayList(
                  plThumb: "assets/images/Apple-Music-Artist-Lover.png",
                  plTitle: 'My Favourites',
                  plSongsNo: '48 Songs',
                  index: 1,
                ),
                PlayList(
                  plThumb: "assets/images/Apple-Music-Artist-Lover.png",
                  plTitle: 'Recently Added',
                  plSongsNo: '03 Songs',
                  index: 2,
                ),
                PlayList(
                  plThumb: "assets/images/Apple-Music-Artist-Lover.png",
                  plTitle: 'Recently Played',
                  plSongsNo: '13 Songs',
                  index: 3,
                ),
                // PlayList(
                //     plThumb: "assets/images/Apple-Music-Artist-Lover.png",
                //     plTitle: 'Most Played',
                //     plSongsNo: '9 Songs',
                //     index: 4,),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container createpl() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 0.3,
            blurRadius: 1,
            offset: const Offset(3, 3),
          ),
        ],
        gradient: LinearGradient(
          colors: [
            Colors.purpleAccent.withOpacity(0.3),
            Colors.purpleAccent.withOpacity(0.015),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.add_rounded,
              color: Colors.black,
            ),
            label: Text(
              'Create New Playlist',
              style: GoogleFonts.nunito(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
