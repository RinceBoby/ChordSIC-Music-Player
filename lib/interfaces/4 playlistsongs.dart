import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:chordsic/interfaces/1%20home.dart';
import 'package:chordsic/interfaces/mini_player.dart';
import 'package:chordsic/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

// ignore: must_be_immutable
class PlayListSongs extends StatefulWidget {
  String name;
  int playlistkey;

  PlayListSongs({Key? key, required this.name, required this.playlistkey})
      : super(key: key);

  @override
  State<PlayListSongs> createState() => _PlayListSongsState();
}

class _PlayListSongsState extends State<PlayListSongs> {
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
          widget.name.capitalised(),
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
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Home(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              color: Colors.grey,
              iconSize: 30,
            ),
          ),
        ],
      ),

      //<<<<<Body>>>>>//
      body: Center(
        child: FutureBuilder<List<SongEntity>>(
          future: OnAudioRoom().queryAllFromPlaylist(widget.playlistkey),
          builder: (context, item) {
            if (item.data == null || item.data!.isEmpty) {
              return Text(
                "No Songs found!",
                style: GoogleFonts.nunito(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              );
            }
            List<SongEntity> playlistsongs = item.data!;

            List<Audio> playListList = [];

            for (var songs in playlistsongs) {
              playListList.add(
                Audio.file(
                  songs.lastData,
                  metas: Metas(
                    title: songs.title,
                    artist: songs.artist,
                    id: songs.id.toString(),
                  ),
                ),
              );
            }
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
                        onLongPress: () async {
                          await audioRoom.deleteFrom(
                              RoomType.PLAYLIST, playlistsongs[index].id,
                              playlistKey: widget.playlistkey);
                          setState(() {});
                          // Navigator.pop(context, 'OK');
                        },
                        onTap: () async {
                          await player.open(
                              Playlist(audios: playListList, startIndex: index),
                              showNotification: true,
                              loopMode: LoopMode.playlist,
                              notificationSettings:
                                  const NotificationSettings(stopEnabled: false));
                        },
                        leading: Container(
                          width: 60,
                          height: 60,
                          child: QueryArtworkWidget(
                            id: item.data![index].id,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(300),
                              ),
                              child: Image.asset('assets/images/Apple-Music-Artist-Lover.png'),
                            ),
                          ),
                        ),
                        title: Text(
                          item.data![index].title,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.nunito(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          item.data![index].artist.toString(),
                          overflow: TextOverflow.ellipsis,
                          //"${item.data![index].artist}",//
                          //====This is another way without toString()====//
                          style: GoogleFonts.nunito(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
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
      ),
    );
  }
}
//<<<<<Capitalize_First_Letter>>>>>//
extension CapitalExtension on String {
  String capitalised() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
