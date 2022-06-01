// ignore_for_file: file_names

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: createpl(),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: box.listenable(),
              builder: (context, boxes, child) {
                var playListName = box.keys.toList();
                return ListView.builder(
                  itemCount: playListName.length,
                  itemBuilder: (context, index) {
                    var playListSongs = box.get(playListName[index]);
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                      child: Container(
                        // height: 90,
                        // decoration: BoxDecoration(
                        //   borderRadius: const BorderRadius.all(
                        //     Radius.circular(10),
                        //   ),
                        //   boxShadow: [
                        //     BoxShadow(
                        //       color: Colors.grey.withOpacity(0.2),
                        //       spreadRadius: 0.3,
                        //       blurRadius: 1,
                        //       offset: const Offset(3, 3),
                        //     ),
                        //   ],
                        //   gradient: LinearGradient(
                        //     colors: [
                        //       Colors.purpleAccent.withOpacity(0.3),
                        //       Colors.purpleAccent.withOpacity(0.015),
                        //     ],
                        //     begin: Alignment.bottomCenter,
                        //     end: Alignment.topCenter,
                        //   ),
                        // ),
                        child: playListName[index] != "music" &&
                                playListName[index] != "favorites" &&
                                playListName[index] != "recentlyPlayed"
                            ? ListTile(
                                leading: const Icon(
                                  Icons.queue_music_rounded,
                                ),
                                title: Text(
                                  playListName[index].toString().capitalize(),
                                  style: GoogleFonts.nunito(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                subtitle: Text(
                                  "${playListSongs!.length} Song",
                                  style: GoogleFonts.nunito(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                  ),
                                ),
                                trailing: PopupMenuButton(
                                  color: Color.fromARGB(255, 230, 194, 236),
                                  icon: const Icon(
                                    Icons.more_vert_outlined,
                                    color: Colors.black,
                                  ),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      onTap: () {},
                                      value: "0",
                                      child: Text(
                                        "Rename Playlist",
                                        style: GoogleFonts.nunito(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      onTap: () {},
                                      value: "1",
                                      child: Text(
                                        "Remove Playlist",
                                        style: GoogleFonts.nunito(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
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
                                                Colors.purple[100],
                                            title: Center(
                                              child: Text(
                                                "Remove this Playlist",
                                                style: GoogleFonts.nunito(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            content: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Are you sure",
                                                    style: GoogleFonts.nunito(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text(
                                                        "Cancel",
                                                        style:
                                                            GoogleFonts.nunito(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        box.delete(playListName[
                                                            index]);
                                                        setState(() {
                                                          playListName =
                                                              box.keys.toList();
                                                        });
                                                      },
                                                      child: Text(
                                                        "Yes",
                                                        style:
                                                            GoogleFonts.nunito(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    }
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
                      ),
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

//==========Capitalize_First_Letter===========//
extension CapitalExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
