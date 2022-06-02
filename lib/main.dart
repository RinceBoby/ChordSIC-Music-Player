import 'package:chordsic/dbFunctions/songmodel.dart';
import 'package:chordsic/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_room/on_audio_room.dart';

String boxname = "songname";
void main(List<String> args) async {
  //<<<<<Hive>>>>>//
  WidgetsFlutterBinding.ensureInitialized();
  await OnAudioRoom().initRoom();//On_Audio_Room_Intialize
  await Hive.initFlutter(); //Hive_Intialize
  Hive.registerAdapter(SongsAdapter()); //Register_Adapter
  await Hive.openBox<List>(boxname);//Hive_Box

  //<<<<<Screen_Orientation>>>>>//
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: const Color.fromARGB(255, 221, 255, 252),
        appBarTheme: const AppBarTheme(elevation: 0.0),
        iconTheme: const IconThemeData(color: Colors.grey),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

