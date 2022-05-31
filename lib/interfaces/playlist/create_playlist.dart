import 'package:chordsic/dbFunctions/songmodel.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: Colors.pink[100],
      alignment: Alignment.center,
      title: const Center(
        child: Text(
          "Give Your Playlist Name",
        ),
      ),

      // form validation
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
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green, width: 50),
              ),
              // fillColor: textWhite,
              hintText: 'Playlist Name',
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 50),
              ),
            )),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),

              // add playlist from db
              TextButton(
                child: const Text(
                  "Create",
                  style: TextStyle(
                    color: Colors.white,
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
