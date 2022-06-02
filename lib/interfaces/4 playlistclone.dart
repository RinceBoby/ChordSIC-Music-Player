// ignore: file_names
import 'package:chordsic/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_room/on_audio_room.dart';

// ignore: must_be_immutable
class PlayListClone extends StatefulWidget {
  int songIndex;

  PlayListClone({Key? key, required this.songIndex}) : super(key: key);

  @override
  State<PlayListClone> createState() => _PlayListCloneState();
}

class _PlayListCloneState extends State<PlayListClone> {
  TextEditingController playlistcontroller = TextEditingController();

  OnAudioRoom audioRoom = OnAudioRoom();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 255, 252),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 221, 255, 252),
        elevation: 0,
        title: Text(
          "Playlists",
          style: GoogleFonts.nunito(
            fontSize: 30,
            letterSpacing: 1,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  backgroundColor:const Color.fromARGB(255, 225, 173, 235),
                  title: Text(
                    "Create New Playlist",
                    style: GoogleFonts.nunito(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  actions: <Widget>[
                    Form(
                      key: formKey,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Name Required";
                          }
                          return null;
                        },
                        controller: playlistcontroller,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Playlist Name',
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          audioRoom.createPlaylist(
                              playlistcontroller.text.capitalise());
                          playlistcontroller.clear();
                          Navigator.pop(context, 'Create');
                          setState(() {});
                        }
                        //
                      },
                      child: Text(
                        'Create',
                        style: GoogleFonts.nunito(
                          fontSize: 20,
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
              color: Colors.grey,
              size: 30,
            ),
          ),
        ],
      ),

      //<<<<<Body>>>>>//
      body: FutureBuilder<List<PlaylistEntity>>(
        future: audioRoom.queryPlaylists(),
        builder: (context, item) {
          if (item.data == null || item.data!.isEmpty) {
            return Center(
              child: Text(
                'No Playlists Found!',
                style: GoogleFonts.nunito(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            );
          }
          List<PlaylistEntity> playList = item.data!;
          return ListView.builder(
            itemCount: item.data!.length,
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
                      onTap: () {
                        audioRoom.addTo(RoomType.PLAYLIST,
                            allSongs[widget.songIndex].getMap.toSongEntity(),
                            playlistKey: playList[index].key,
                            ignoreDuplicate: false);
                        ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(
                              backgroundColor:
                                  const Color.fromARGB(255, 219, 147, 232),
                              content: Text(
                                'Song Added to Playlist',
                                style: GoogleFonts.nunito(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                      },
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            backgroundColor:const Color.fromARGB(255, 223, 172, 233),
                            title: Text(
                              'Delete Playlist?',
                              style: GoogleFonts.nunito(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.red,
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
                                  audioRoom.deletePlaylist(item.data![index].key);
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
                      title: Text(
                        item.data![index].playlistName.capitalise(),
                        style: GoogleFonts.nunito(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        item.data![index].playlistSongs.length.toString() +
                            " Songs",
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color:const Color.fromARGB(255, 80, 73, 73),
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
}

//<<<<<Capitalize_First_Letter>>>>>//
extension CapitalExtension on String {
  String capitalise() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
