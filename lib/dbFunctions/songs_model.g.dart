// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songs_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongsModelAdapter extends TypeAdapter<SongsModel> {
  @override
  final int typeId = 0;

  @override
  SongsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SongsModel()
      ..artist = fields[0] as String?
      ..songname = fields[1] as String?
      ..songurl = fields[2] as String?
      ..id = fields[3] as int?;
  }

  @override
  void write(BinaryWriter writer, SongsModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.artist)
      ..writeByte(1)
      ..write(obj.songname)
      ..writeByte(2)
      ..write(obj.songurl)
      ..writeByte(3)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
