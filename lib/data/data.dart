import 'package:hive_flutter/hive_flutter.dart';
  part 'data.g.dart';

@HiveType(typeId: 0)
class Student extends HiveObject {
  @HiveField(0)
  int id = 0;
  @HiveField(1)
  String name = '';


   static int _nextId = 1;

  Student() {
    initializeNextId();
    id = _nextId; // مقداردهی خودکار id به مقدار nextId
    _nextId++; // افزایش مقدار nextId برای نمونه بعدی
  }
  void initializeNextId() async {
    var box = await Hive.openBox<Student>('Student');
    var student = box.values.toList();
    if (student.isNotEmpty) {
      _nextId = student.map((student) => student.id).reduce((a, b) => a > b ? a : b) + 1;
    }
  }
}

@HiveType(typeId: 1)
class DataStu extends HiveObject {
  @HiveField(0)
  int id=0 ;
  @HiveField(1)
  String info = '';
  @HiveField(2)
  String date = '';
  @HiveField(3)
  bool status= true;
  @HiveField(4)
  String book= '';
}

@HiveType(typeId: 2)
class Books extends HiveObject {
  @HiveField(0)
  int id = 0;
  @HiveField(1)
  String name = '';
  @HiveField(2)
  bool active = true;


   static int _nextId = 1;

  Books() {
    initializeNextId();
    id = _nextId; // مقداردهی خودکار id به مقدار nextId
    _nextId++; // افزایش مقدار nextId برای نمونه بعدی
  }
  void initializeNextId() async {
    var box = await Hive.openBox<Books>('Books');
    var books = box.values.toList();
    if (books.isNotEmpty) {
      _nextId = books.map((books) => books.id).reduce((a, b) => a > b ? a : b) + 1;
    }
  }
}
