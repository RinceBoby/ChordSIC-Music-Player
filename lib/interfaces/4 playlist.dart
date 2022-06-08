// ignore_for_file: file_names

import 'package:chordsic/interfaces/4%20playlistsongs.dart';
import 'package:chordsic/interfaces/mini_player.dart';
import 'package:chordsic/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_room/on_audio_room.dart';

// ignore: must_be_immutable
class Playlist extends StatefulWidget {
  const Playlist({Key? key}) : super(key: key);

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  TextEditingController playlistControl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 255, 252),

      //<<<<<Mini_Player>>>>>//
      bottomSheet: const MiniPlayer(),

      //<<<<<Appbar>>>>>//
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
          //<<<<<+_Pl>>>>>//
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: IconButton(
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    backgroundColor:const Color.fromARGB(255, 235, 180, 243),
                    title: Text(
                      "Create New Playlist",
                      style: GoogleFonts.nunito(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    actions: [
                      Form(
                        key: formKey,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty || value == "") {
                              return "Name Required";
                            }
                            return null;
                          },
                          controller: playlistControl,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter Playlist Name",
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            audioRoom.createPlaylist(playlistControl.text);
                            playlistControl.clear();
                            Navigator.pop(context, 'Create');
                            setState(() {});
                          }
                        },
                        child: Text(
                          "Create",
                          style: GoogleFonts.nunito(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(
                Icons.playlist_add,
                size: 35,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),

      //<<<<<Body>>>>>//
      body: FutureBuilder<List<PlaylistEntity>>(
        future: audioRoom.queryPlaylists(),
        builder: (context, item) {
          if (item.data == null || item.data!.isEmpty) {
            return const Center(
              child: Text(
                'No Playlists Found!',
                style: TextStyle(color: Colors.black),
              ),
            );
          }

          List<PlaylistEntity> playList = item.data!;
          return ListView.builder(
            itemCount: playList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
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
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: ListTile(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlayListSongs(
                              name: item.data![index].playlistName,
                              playlistkey: playList[index].key,
                            ),
                          ),
                        );
                        setState(() {});
                      },
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            backgroundColor:
                                const Color.fromARGB(255, 222, 149, 235),
                            title: Text(
                              'Delete Playlist?',
                              style: GoogleFonts.nunito(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text(
                                  'Yes',
                                  style: GoogleFonts.nunito(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                onPressed: () {
                                  audioRoom
                                      .deletePlaylist(item.data![index].key);
                                  setState(
                                    () {
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                              ),
                              TextButton(
                                child: Text(
                                  'No',
                                  style: GoogleFonts.nunito(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      textColor: Colors.black,
                      title: Text(
                        item.data![index].playlistName.capitalise(),
                        style: GoogleFonts.nunito(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      leading: Container(
                        width: 60,
                        height: 60,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(50),
                          ),
                          child: Image.asset(
                            'assets/images/Apple-Music-Artist-Lover.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      subtitle: Text(
                        item.data![index].playlistSongs.length.toString() +
                            " Songs",
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 80, 73, 73),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  //<<<<<Create_New_Pl>>>>>//
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
              // showDialog(
              //     context: context,
              //     builder: (BuildContext context) {
              //       return const CreatePl();
              //     });
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

//<<<<<Capitalize_First_Letter>>>>>//
extension CapitalExtension on String {
  String capitalise() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
