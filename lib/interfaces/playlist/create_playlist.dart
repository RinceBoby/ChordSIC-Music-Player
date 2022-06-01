import 'package:chordsic/dbFunctions/songmodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreatePl extends StatefulWidget {
  const CreatePl({Key? key}) : super(key: key);

  @override
  State<CreatePl> createState() => _CreatePlState();
}

class _CreatePlState extends State<CreatePl> {
  @override
  Widget build(BuildContext context) {
    List<Songs> playlist = [];
    final box = StorageBox.getInstance();
    String? title;
    final formKey = GlobalKey<FormState>();

    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 230, 194, 236),
      alignment: Alignment.center,
      title: Center(
        child: Text(
          "Name your Playlist",
          style: GoogleFonts.nunito(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),

      //==============Form_Validation==============//
      content: Form(
        key: formKey,
        child: TextFormField(
          onChanged: (value) {
            title = value.trim();
          },
          validator: (value) {
            List keys = box.keys.toList();
            if (value!.trim() == "") {
              return "Name Required";
            }
            if (keys.where((element) => element == value.trim()).isNotEmpty) {
              return "This Name Already Exist";
            }
            return null;
          },
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 64, 45, 67),
                //width: 50,
              ),
            ),
            hintText: 'Playlist Name',
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 64, 45, 67),
                //width: 50,
              ),
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: Text(
                  "Cancel",
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),

              //===============Add_playlist_from_DB===============//
              TextButton(
                child: Text(
                  "Create",
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    box.put(title, playlist);
                    Navigator.pop(context);
                    setState(() {});
                  }
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
