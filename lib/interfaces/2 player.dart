// ignore_for_file: file_names
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:chordsic/functions/fact_player.dart';
import 'package:chordsic/interfaces/1%20home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
              FontAwesomeIcons.creativeCommonsSamplingPlus,
              color: Colors.grey,
            ),
            iconSize: 30,
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
              icon:const Icon(FontAwesomeIcons.heart),
              color: Colors.grey,
              iconSize: 30,
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
              ),

//===============Title_&_Artist===============//

              const SizedBox(
                height: 20,
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              // child: SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,

              Column(
                children: [
                  Container(
                    height: 30,
                    width: 300,
                    child: Marquee(
                      blankSpace: 20,
                      velocity: 20,
                      text: player.getCurrentAudioTitle,
                      style: GoogleFonts.nunito(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: 150,
                    child: Marquee(
                      blankSpace: 20,
                      velocity: -20,
                      text: player.getCurrentAudioArtist,
                      style: GoogleFonts.nunito(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),

              // child: Text(
              //   player.getCurrentAudioTitle,
              // style: GoogleFonts.nunito(
              //   fontSize: 25,
              //   fontWeight: FontWeight.w600,
              //   color: Colors.black,
              // ),
              // ),
              //),
              //),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: SingleChildScrollView(
              //     scrollDirection: Axis.horizontal,
              //     child: Text(
              //       player.getCurrentAudioArtist,
              //       style: GoogleFonts.nunito(
              //           fontSize: 20,
              //           fontWeight: FontWeight.w600,
              //           color: Colors.black),
              //     ),
              //   ),
              // ),
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
                    icon: const Icon(FontAwesomeIcons.shuffle),
                    iconSize: 25,
                    color: Colors.purpleAccent,
                  ),

                  //Previous
                  IconButton(
                    onPressed: playing.index == 0
                        ? () {}
                        : () {
                            player.previous();
                          },
                    icon: playing.index == 0
                        ? const SizedBox()
                        : //Icon(fontawesomw)
                        const Icon(FontAwesomeIcons.backward),
                    iconSize: 40,
                    color: Colors.purpleAccent,
                  ),

                  //Play_Pause
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: PlayerBuilder.isPlaying(
                      player: player,
                      builder: (context, isPlaying) {
                        return IconButton(
                          icon: Icon(
                            isPlaying
                                ? FontAwesomeIcons.solidCirclePause
                                : FontAwesomeIcons.solidCirclePlay,
                            size: 80,
                          ),
                          onPressed: () {
                            player.playOrPause();
                          },
                          color: Colors.purpleAccent,
                        );
                      },
                    ),
                  ),

                  //Next
                  IconButton(
                    onPressed: playing.index == allSongs.length - 1
                        ? () {}
                        : () {
                            player.next();
                          },
                    icon: playing.index == allSongs.length
                        ? const SizedBox()
                        : const Icon(FontAwesomeIcons.forward),
                    iconSize: 40,
                    color: Colors.purpleAccent,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(FontAwesomeIcons.rotate),
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
}
