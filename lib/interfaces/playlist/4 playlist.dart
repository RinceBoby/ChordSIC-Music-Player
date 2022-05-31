import 'package:chordsic/functions/fact_playlist.dart';
import 'package:chordsic/interfaces/6%20search.dart';
import 'package:chordsic/interfaces/mini_player.dart';
import 'package:chordsic/interfaces/playlist/create_playlist.dart';
import 'package:chordsic/interfaces/playlist/update_playlist.dart';
import 'package:chordsic/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Playlist extends StatefulWidget {
  const Playlist({Key? key}) : super(key: key);

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  List playListName = [];

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
          createpl(),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: box.listenable(),
              builder: (context, boxes, child) {
                var playListName = box.keys.toList();
                return ListView.builder(
                  itemCount: playListName.length,
                  itemBuilder: (context, index) {
                    var playListSongs = box.get(playListName[index]);
                    return Container(
                      child: playListName[index] != "music" &&
                              playListName[index] != "favorites" &&
                              playListName[index] != "recentlyPlayed"
                          ? ListTile(
                              leading: const Icon(
                                Icons.queue_music_rounded,
                              ),
                              title: Text(
                                playListName[index].toString(),
                              ),
                              subtitle: Text(
                                "${playListSongs!.length}Song",
                              ),
                              trailing: PopupMenuButton(
                                color: Colors.purple[300],
                                icon: const Icon(
                                  Icons.more_vert_outlined,
                                  color: Colors.black,
                                ),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    onTap: () {},
                                    value: 0,
                                    child: const Text(
                                      "Rename Playlist",
                                    ),
                                  ),
                                  PopupMenuItem(
                                    onTap: () {},
                                    value: 1,
                                    child: const Text(
                                      "Remove Playlist",
                                    ),
                                  ),
                                ],
                                onSelected: (value) {
                                  if (value == "1") {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor:
                                              Colors.pinkAccent[100],
                                          title: const Center(
                                            child: Text(
                                              "Remove this Playlist",
                                            ),
                                          ),
                                          content: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Text(
                                                "Are you sure",
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    "Cancel",
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    box.delete(
                                                        playListName[index]);
                                                    setState(() {
                                                      playListName =
                                                          box.keys.toList();
                                                    });
                                                  },
                                                  child: const Text(
                                                    "Yes",
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  }
                                  ;
                                  if (value == "0") {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return UpdatePlaylist(
                                          playListNames: playListName[index],
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                            )
                          : Container(),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

//==========Create_New_Pl==========//
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
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const CreatePl();
                  });
            },
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
