import 'package:hive/hive.dart';
part 'songs_model.g.dart';

@HiveType(typeId: 0)
class SongsModel extends HiveObject {
  @HiveField(0)
  String? artist;

  @HiveField(1)
  String? songname;

  @HiveField(2)
  String? songurl;

  @HiveField(3)
  int? id;
  // SongsModel({
  //   required this.id,
  //   required this.artist,
  //   required this.songname,
  //   required this.songurl,
  // });
}
