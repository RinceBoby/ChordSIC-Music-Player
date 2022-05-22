// ignore_for_file: file_names
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:chordsic/functions/fact_player.dart';
import 'package:chordsic/interfaces/1%20home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Player extends StatefulWidget {
  const Player({Key? key}) : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

Audio find(List<Audio> source, String fromPath) {
  return source.firstWhere((element) => element.path == fromPath);
}

class _PlayerState extends State<Player> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 255, 252),

//===============Appbar===============//

      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 221, 255, 252),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.add_circled,
              color: Colors.grey,
              size: 35,
            ),
          ),
        ),
        title: Text(
          'Now Playing',
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
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.heart,
                color: Colors.grey,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: player.builderCurrent(
        builder: (context, playing) {
          final myAudio = find(songDetails, playing.audio.assetAudioPath);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
//
//===============Thumbnail===============//

              Center(
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(250)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.9),
                        spreadRadius: 0.3,
                        blurRadius: 5,
                        offset: const Offset(3, 3),
                      ),
                    ],
                  ),
                  child: QueryArtworkWidget(
                    artworkQuality: FilterQuality.high,
                    quality: 100,
                    size: 2000,
                    artworkFit: BoxFit.contain,
                    artworkBorder: BorderRadius.circular(250),
                    id: int.parse(myAudio.metas.id!),
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(250),
                      ),
                      child: Image.asset(
                        'assets/images/Apple-Music-Artist-Lover.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // Container(
                //   height: 250,
                //   width: 250,

                // ),
              ),

//===============Title_&_Artist===============//

              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                //child: SingleChildScrollView(
                //scrollDirection: Axis.horizontal,
                // child: buildAnimatedText(
                //   player.getCurrentAudioTitle,
                // ),
                // Text(
                //   player.getCurrentAudioTitle,
                //   style: GoogleFonts.nunito(
                //     fontSize: 25,
                //     fontWeight: FontWeight.w600,
                //     color: Colors.black,
                //   ),
                // ),
                //),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    player.getCurrentAudioArtist,
                    style: GoogleFonts.nunito(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 0,
              ),

//===============Progress_Bar===============//

              const Padding(
                padding: EdgeInsets.only(left: 30, right: 30, top: 50),
                child: SeekBar(),
              ),

//===============Player_Controls===============//

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.shuffle_rounded),
                    iconSize: 25,
                    color: Colors.purpleAccent,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.backward_end),
                    iconSize: 40,
                    color: Colors.purpleAccent,
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      //border: Border.all(width: 5, color: Colors.purpleAccent),
                      //color: Colors.purpleAccent,
                    ),
                    child: PlayerBuilder.isPlaying(
                      player: player,
                      builder: (context, isPlaying) {
                        return IconButton(
                          icon: Icon(
                            isPlaying
                                ? Icons.pause_circle_outline_rounded
                                : Icons.play_circle_outline_rounded,
                            size: 90,
                          ),
                          onPressed: () {
                            player.playOrPause();
                          },
                          color: Colors.purpleAccent,
                        );
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.forward_end),
                    iconSize: 40,
                    color: Colors.purpleAccent,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.loop_rounded),
                    iconSize: 25,
                    color: Colors.purpleAccent,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  // Widget buildAnimatedText(String text) => Marquee(
  //       text: text,
  //       style: GoogleFonts.nunito(
  //           fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
  //       blankSpace: 90,
  //       velocity: 150,
  //     );
}
