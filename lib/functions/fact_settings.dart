import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsData extends StatelessWidget {
  final setbullets;
  final settext;
  final setbutton;

  const SettingsData({
    Key? key,
    required this.setbullets,
    required this.settext,
    this.setbutton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () {},
          child: Row(
            children: [
              Icon(
                setbullets,
                color: Colors.black,
                size: 30,
              ),
              const SizedBox(width: 15),
              Text(
                settext,
                style: GoogleFonts.nunito(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
    // ListTile(
    //   leading: Icon(
    //     setbullets,

    //   ),
    //   title: Text(
    //     settext,

    //   ),
    //   trailing: setbutton,
    // );
  }
}
