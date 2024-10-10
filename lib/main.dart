import 'package:flutter/material.dart';
import 'package:helpteacher/data/data.dart';
import 'package:helpteacher/page/home.dart';
import 'package:hive_flutter/hive_flutter.dart';

const studentBoxName = 'Student';
const dataStuBoxName = 'DataStu';
const booksBoxName = 'Books';
const fontName = 'IranYekan';
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(StudentAdapter());
  Hive.registerAdapter(DataStuAdapter());
  Hive.registerAdapter(BooksAdapter());
  await Hive.openBox<Student>(studentBoxName);
  await Hive.openBox<DataStu>(dataStuBoxName);
  await Hive.openBox<Books>(booksBoxName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'کمک معلم',
      theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xfff4f1f1),
          colorScheme: const ColorScheme.light(
              //primary: Color(0xff00aeff),
              primaryContainer: Color(0xff2196f3),
              primary: Color(0xff00b894),
              onTertiary: Color(0xff737395),
              error: Color(0xfff32149),
              onPrimary: Colors.white,
              secondary: Color(0xffedf2f5),
              onSecondary: Colors.black),
          textTheme: TextTheme(
              bodySmall: TextStyle(
                  fontFamily: fontName,
                  fontSize: 17,
                  fontWeight: FontWeight.w100,
                  color: Theme.of(context).colorScheme.onPrimary),
              bodyMedium: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontFamily: fontName,
                  fontSize: 17,
                  color: Colors.white),
              bodyLarge: const TextStyle(
                  fontFamily: fontName,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
              titleLarge: const TextStyle(
                  fontFamily: fontName,
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  color: Colors.white)),
          snackBarTheme: const SnackBarThemeData(
            contentTextStyle: TextStyle(
              fontFamily: fontName,
            ),
          )),
      home: Home(),
    );
  }
}
