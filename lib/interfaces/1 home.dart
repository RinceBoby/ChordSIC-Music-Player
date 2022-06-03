import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:chordsic/interfaces/4%20playlistclone.dart';
import 'package:chordsic/interfaces/6%20search.dart';
import 'package:chordsic/interfaces/mini_player.dart';
import 'package:chordsic/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

final OnAudioQuery audioQuery = OnAudioQuery();

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 255, 252),

      //<<<<<Mini_Player>>>>>//

      bottomSheet: const MiniPlayer(),

      //<<<<<Appbar>>>>>//
      appBar: AppBar(
        title: Text(
          'Library',
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

      //<<<<<Song_List_Internal>>>>>//
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
            return Center(
              child: Text(
                'No songs found!',
                style: GoogleFonts.nunito(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
            );
          }

          return FutureBuilder<List<FavoritesEntity>>(
            future: audioRoom.queryFavorites(
              //limit: 50,
              reverse: false,
              sortType: null,
            ),
            builder: (context, allFavorite) {
              if (allFavorite.data == null) {
                return const SizedBox();
              }
              List<FavoritesEntity> favorites = allFavorite.data!;
              List<Audio> favSongs = [];
              for (var favrSongs in favorites) {
                favSongs.add(
                  Audio.file(
                    favrSongs.lastData,
                    metas: Metas(
                      title: favrSongs.title,
                      artist: favrSongs.artist,
                      id: favrSongs.id.toString(),
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemCount: item.data!.length,
                itemBuilder: (context, index) {
                  bool isFav = false;
                  int? key;
                  for (var fav in favorites) {
                    if (songDetails[index].metas.title == fav.title) {
                      isFav = true;
                      key = fav.key;
                    }
                  }
                  return Padding(
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
                              notificationSettings: const NotificationSettings(
                                stopEnabled: false,
                              ),
                              autoStart: true,
                              loopMode: LoopMode.playlist,
                              playInBackground: PlayInBackground.enabled,
                            );
                          },

                          //<<<<<Thumb_Titile_Artist>>>>>//
                          leading: QueryArtworkWidget(
                            id: item.data![index].id,
                            type: ArtworkType.AUDIO,

                            //<<<<<If_No_Thumbnail>>>>>//
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
                          title: Text(
                            item.data![index].title.toString(),
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
                          trailing: Wrap(
                            children: [
                              InkWell(
                                onTap: () {
                                  if (!isFav) {
                                    ScaffoldMessenger.of(context)
                                      ..removeCurrentSnackBar()
                                      ..showSnackBar(
                                        SnackBar(
                                          backgroundColor: const Color.fromARGB(
                                              255, 211, 127, 225),
                                          content: Text(
                                            "Added to Favorites!",
                                            style: GoogleFonts.nunito(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      );
                                    audioRoom.addTo(
                                      RoomType.FAVORITES, //Specify Room Type
                                      allSongs[index]
                                          .getMap
                                          .toFavoritesEntity(),
                                      ignoreDuplicate: false, //Avoid Same Song
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context)
                                      ..removeCurrentSnackBar()
                                      ..showSnackBar(
                                        SnackBar(
                                          backgroundColor: const Color.fromARGB(
                                              255, 211, 127, 225),
                                          content: Text(
                                            "Removed From Favorites!",
                                            style: GoogleFonts.nunito(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      );
                                    audioRoom.deleteFrom(
                                      RoomType.FAVORITES,
                                      key!,
                                    );
                                  }
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.favorite_border_rounded,
                                  size: 30,
                                  color: isFav ? Colors.red : Colors.grey,
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              InkWell(
                                onTap: () => showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    backgroundColor: const Color.fromARGB(
                                        255, 230, 194, 236),
                                    title: Text(
                                      'Add to Playlist?',
                                      style: GoogleFonts.nunito(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'No'),
                                        child: Text(
                                          'No',
                                          style: GoogleFonts.nunito(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.pop(context, 'Yes');
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PlayListClone(
                                                      songIndex: index),
                                            ),
                                          );
                                          setState(() {});
                                        },
                                        child: Text(
                                          'Yes',
                                          style: GoogleFonts.nunito(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                child: const Icon(
                                  Icons.more_vert_rounded,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
