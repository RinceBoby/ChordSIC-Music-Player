import 'package:chordsic/dbFunctions/songmodel.dart';
import 'package:flutter/material.dart';

class UpdatePlaylist extends StatelessWidget {
  String playListNames;
  UpdatePlaylist({Key? key, required this.playListNames}) : super(key: key);
  final box = StorageBox.getInstance();
  String? title;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.pinkAccent[100],
      title: Center(
        child: Text(
          'Edit Your Playlist Name',
        ),
      ),
      content: Form(
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
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.green,
                width: 5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
                width: 50,
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
              child: Text("Cancel"),
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
                    behavior: SnackBarBehavior.floating,
                    content: Text("Playlist Renamed"),
                  ),
                );
              },
              child: Text("Update"),
            ),
          ],
        ),
      ],
    );
  }
}
