import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:chordsic/interfaces/2%20player.dart';
import 'package:chordsic/interfaces/6%20search.dart';
import 'package:chordsic/interfaces/mini_player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
final OnAudioQuery audioQuery = OnAudioQuery();
List<SongModel> allSongs = [];
List<Audio> songDetails = [];

class _HomeState extends State<Home> {
//
//====================Request_Permission====================//

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  void requestPermission() async {
    Permission.storage.request();

//====================Fetching_Songs====================//

    allSongs = await audioQuery.querySongs();
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
  }

//====================Assets_Audio====================//
  // @override
  // void initState() {
  //   super.initState();
  //   songLists();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 255, 252),

//====================Mini_Player====================//

      bottomSheet: const MiniPlayer(),

//====================Appbar====================//

      appBar: AppBar(
        title: Text(
          'Home',
          style: GoogleFonts.nunito(
            fontSize: 30,
            letterSpacing: 1,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
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
        ],
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 221, 255, 252),
        elevation: 0,
      ),

//====================Song_List_Internal====================//

      body: FutureBuilder<List<SongModel>>(
        future: audioQuery.querySongs(
          sortType: null,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        ),
        builder: (context, item) {
          if (item.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (item.data!.isEmpty) {
            return const Center(
              child: Text('No songs found'),
            );
          }

          return ListView.builder(
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
              child: Container(
                height: 90,
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
                child: Center(
                  child: ListTile(
                    onTap: () async {
                      await player.open(
                        Playlist(
                          audios: songDetails,
                          startIndex: index,
                        ),
                        showNotification: true,
                        autoStart: true,
                        loopMode: LoopMode.playlist,
                        playInBackground: PlayInBackground.enabled,
                      );
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => const MiniPlayer(),
                      //   ),
                      // );
                    },

                    //Thumb_Titile_Artist

                    leading: QueryArtworkWidget(
                      id: item.data![index].id,
                      type: ArtworkType.AUDIO,
                      nullArtworkWidget: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(50),
                        ),
                        child: Image.asset(
                          'assets/images/Apple-Music-Artist-Lover.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: SizedBox(
                      height: 30,
                      child: Marquee(
                        blankSpace: 20,
                        velocity: 20,
                        text: item.data![index].title.toString(),
                        style: GoogleFonts.nunito(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Text(
                    //     item.data![index].title.toString(),
                    //     style: GoogleFonts.nunito(
                    //       fontSize: 20,
                    //       fontWeight: FontWeight.w600,
                    //       color: Colors.black,
                    //     ),
                    //   ),
                    // ),
                    subtitle: SizedBox(
                      height: 20,
                      child: Marquee(
                        blankSpace: 20,
                        velocity: -20,
                        pauseAfterRound: const Duration(seconds: 2),
                        startPadding: 10,
                        text: "${item.data![index].artist}",
                        style: GoogleFonts.nunito(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Text(
                    //     "${item.data![index].artist}",
                    //     style: GoogleFonts.nunito(
                    //       fontSize: 15,
                    //       fontWeight: FontWeight.w600,
                    //       color: Colors.black,
                    //     ),
                    //   ),
                    // ),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_vert_outlined,
                      ),
                      iconSize: 30,
                    ),
                  ),
                ),
              ),
            ),
            itemCount: item.data!.length,
          );
        },
      ),
    );
  }
}
