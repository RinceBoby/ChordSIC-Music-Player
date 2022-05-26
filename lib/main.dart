import 'package:chordsic/dbFunctions/songs_model.dart';
import 'package:chordsic/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/services.dart';

void main(List<String> args) async {
  //
  //==========Setup_Hive==========//

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  //==========Register Adapter==========//

  Hive.registerAdapter(SongsModelAdapter());

  //==========Orientation Setup==========//

  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

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
