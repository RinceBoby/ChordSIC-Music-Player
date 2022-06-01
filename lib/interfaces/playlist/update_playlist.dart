import 'package:chordsic/dbFunctions/songmodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdatePlaylist extends StatelessWidget {
  String playListNames;
  UpdatePlaylist({Key? key, required this.playListNames}) : super(key: key);
  final box = StorageBox.getInstance();
  String? title;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:const Color.fromARGB(255, 230, 194, 236),
      title: Center(
        child: Text(
          'Edit Your Playlist Name',
          style: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      content: Form(
        key: formKey,
        child: TextFormField(
          initialValue: playListNames,
          onChanged: (value) {
            title = value.trim();
          },
          validator: (value) {
            final keys = box.keys.toList();
            if (value!.trim() == "") {
              return "Name Required";
            }
            return null;
          },
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                //width: 5,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                //width: 50,
              ),
            ),
            fillColor: Colors.pinkAccent[100],
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  List? currentPlayListName = box.get(playListNames);
                  box.put(title, currentPlayListName!);
                  box.delete(playListNames);
                  Navigator.pop(context);
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.purple[100],
                    behavior: SnackBarBehavior.floating,
                    content: Text(
                      "Playlist Renamed",
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              },
              child: Text(
                "Update",
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
