// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentAdapter extends TypeAdapter<Student> {
  @override
  final int typeId = 0;

  @override
  Student read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Student()
      ..id = fields[0] as int
      ..name = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, Student obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DataStuAdapter extends TypeAdapter<DataStu> {
  @override
  final int typeId = 1;

  @override
  DataStu read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataStu()
      ..id = fields[0] as int
      ..info = fields[1] as String
      ..date = fields[2] as String
      ..status = fields[3] as bool
      ..book = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, DataStu obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.info)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.book);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataStuAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BooksAdapter extends TypeAdapter<Books> {
  @override
  final int typeId = 2;

  @override
  Books read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Books()
      ..id = fields[0] as int
      ..name = fields[1] as String
      ..active = fields[2] as bool;
  }

  @override
  void write(BinaryWriter writer, Books obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.active);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BooksAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
