import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:chordsic/interfaces/1%20home.dart';
import 'package:chordsic/interfaces/2%20player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({Key? key}) : super(key: key);

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

Audio find(List<Audio> source, String fromPath) {
  return source.firstWhere((element) => element.path == fromPath);
}

class _MiniPlayerState extends State<MiniPlayer> {
  @override
  Widget build(BuildContext context) {
    //Main_Container

    return Container(
      color: const Color.fromARGB(255, 221, 255, 252),
      child: player.builderCurrent(
        builder: ((
          context,
          playing,
        ) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),

            //Container_ListTile

            child: Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              //height: 100,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                    Colors.purpleAccent.withOpacity(0.5),
                    Colors.purpleAccent.withOpacity(0.015),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 5),

                //ListTile

                child: Center(
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const Player(),
                        ),
                      );
                    },

                    //Thumbnail

                    leading: player.builderCurrent(
                      builder: (context, playing) {
                        final myAudio =
                            find(songDetails, playing.audio.assetAudioPath);
                        return QueryArtworkWidget(
                          id: int.parse(myAudio.metas.id.toString()),
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
                        );
                      },
                    ),
                    //Song_Name

                    title: SizedBox(
                      height: 22,
                      child: Marquee(
                        blankSpace: 20,
                        velocity: 20,
                        text: player.getCurrentAudioTitle,
                        style: GoogleFonts.nunito(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Text(player.getCurrentAudioTitle,
                    //       style: GoogleFonts.nunito(
                    //           fontSize: 20,
                    //           fontWeight: FontWeight.w600,
                    //           color: Colors.black)),
                    // ),

                    //Artist_Name

                    subtitle: SizedBox(
                      height: 15,
                      child: Marquee(
                        blankSpace: 20,
                        velocity: 20,
                        text: player.getCurrentAudioArtist,
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
                    //     player.getCurrentAudioArtist,
                    //     style: GoogleFonts.nunito(
                    //         fontSize: 15,
                    //         fontWeight: FontWeight.w600,
                    //         color: Colors.black),
                    //   ),
                    // ),
                    trailing: PlayerBuilder.isPlaying(
                      player: player,
                      builder: (context, isPlaying) {
                        //PlayOrPause
                        return IconButton(
                          onPressed: () {
                            player.playOrPause();
                          },
                          icon: Icon(isPlaying
                              ? FontAwesomeIcons.circlePause
                              : FontAwesomeIcons.circlePlay),
                              iconSize: 40,
                              color: Colors.purpleAccent,
                        );
                        
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
