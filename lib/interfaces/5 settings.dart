// ignore_for_file: file_names

import 'package:chordsic/functions/fact_settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 255, 252),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 221, 255, 252),
        title: Text(
          'Settings',
          style: GoogleFonts.nunito(
            fontSize: 30,
            letterSpacing: 1,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

    //<<<<<Settings_List>>>>>//
      body: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10),
        child: ListView(
          children: [
            const SettingsData(
              setbullets: Icons.share_outlined,
              settext: ' Share',
            ),
            const SettingsData(
              setbullets: Icons.privacy_tip_outlined,
              settext: ' Privacy Policy',
            ),
            const SettingsData(
              setbullets: Icons.event_note_outlined,
              settext: ' Trems and Conditions',
            ),
            const SettingsData(
              setbullets: Icons.feedback_outlined,
              settext: ' Feedback',
            ),
            const SettingsData(
              setbullets: Icons.info_outline,
              settext: ' About',
            ),

          //<<<<<Version>>>>>//
            Padding(
              padding: const EdgeInsets.only(top: 410),
              child: Column(
                children: const [
                  Text(
                    'Version',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      fontFamily: "Montserrat Alter3",
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    '1.0.0',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      fontFamily: "Montserrat Alter3",
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
