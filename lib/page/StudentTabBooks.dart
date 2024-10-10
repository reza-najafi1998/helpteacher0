import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:helpteacher/data/data.dart';
import 'package:helpteacher/main.dart';
import 'package:helpteacher/page/addReport.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StudentTabBooks extends StatefulWidget {
  final int stuid;

  const StudentTabBooks({super.key, required this.stuid});
  
  @override
  _StudentTabBooksState createState() => _StudentTabBooksState();
}

class _StudentTabBooksState extends State<StudentTabBooks> {
  final boxstu = Hive.box<Student>(studentBoxName);
  
  Future<List<Books>> getbooks() async {
    final boxsbooks = Hive.box<Books>(booksBoxName);
    List<Books> listbook = boxsbooks.values.toList();
    return listbook;
  }

  final ValueNotifier<List<DataStu>> _dataStuNotifier = ValueNotifier([]);

  void _updateDataStu() {
    final boxdatastu = Hive.box<DataStu>(dataStuBoxName);
    List<DataStu> listdatastu = boxdatastu.values
        .toList()
        .where((data) => data.id == widget.stuid)
        .toList();
    _dataStuNotifier.value = listdatastu;
  }

  @override
  void initState() {
    super.initState();
    _updateDataStu();

    // Listen for changes in Hive
    Hive.box<DataStu>(dataStuBoxName).listenable().addListener(() {
      _updateDataStu();
    });
  }

  @override
  void dispose() {
    _dataStuNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('${boxstu.values.toList().firstWhere(
                  (element) => element.id == widget.stuid,
                ).name} دانش آموز '),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddReport(
                  stuid: widget.stuid,
                ),
              ));
        },
        child: Container(
          width: 150,
          height: 50,
          decoration: BoxDecoration(
              color: themeData.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(15)),
          child: const Padding(
            padding: EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'افزودن گزارش ',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 8,
                ),
                Icon(
                  CupertinoIcons.plus_circled,
                  color: Colors.white,
                  size: 30,
                ),
              ],
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Books>>(
        future: getbooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<Books> activeBooks =
                snapshot.data!.where((book) => book.active).toList();
            Books allBooks = Books();
            allBooks.name = 'همه دروس';
            allBooks.active = true;

            // Adding "all subjects" book at the start
            activeBooks.insert(0, allBooks);

            return DefaultTabController(
              length: activeBooks.length,
              child: Column(
                children: [
                  TabBar(
                    labelStyle: themeData.textTheme.bodyMedium!
                        .copyWith(color: Colors.black),
                    tabs: activeBooks.map((book) => Tab(text: book.name)).toList(),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: activeBooks.map((book) {
                        return ValueListenableBuilder<List<DataStu>>(
                          valueListenable: _dataStuNotifier,
                          builder: (context, dataList, child) {
                            if (book.name == 'همه دروس') {
                              return ListView.builder(
                                itemCount: dataList.length,
                                itemBuilder: (context, index) {
                                  final data = dataList[index];
                                  bool isbook=true;
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ItemReport(themeData: themeData, data: data, isbook: isbook),
                                  );
                                },
                              );
                            } else {
                              List<DataStu> filteredData = dataList
                                  .where((data) => data.book == book.name)
                                  .toList();

                              if (filteredData.isEmpty) {
                                return Center(child: Text('No data for ${book.name}'));
                              }

                              return ListView.builder(
                                itemCount: filteredData.length,
                                itemBuilder: (context, index) {
                                  final data = filteredData[index];
                                  bool isbook=false;
                                  return ItemReport(themeData: themeData, data: data, isbook: isbook);
                                },
                              );
                            }
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No books found'));
          }
        },
      ),
    );
  }
}

class ItemReport extends StatelessWidget {
  const ItemReport({
    super.key,
    required this.themeData,
    required this.data,
    required this.isbook,
  });

  final ThemeData themeData;
  final DataStu data;
  final bool isbook;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: isbook?80:60,
        decoration: BoxDecoration(
            color: themeData.colorScheme.onTertiary
                .withOpacity(0.2),
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: data.status
                        ? themeData.colorScheme.primary
                        : themeData.colorScheme.error,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                        data.status ? '+' : '-', style: const TextStyle(fontSize: 25),),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text('توضیحات : ${data.info}',style: const TextStyle(
                    color: Colors.black
                  ),)),
                isbook? 
                Directionality(
                  textDirection:TextDirection.rtl,
                  child: 
                   Text('درس : ${data.book}',style: const TextStyle(
                  color: Colors.black
                ))):const SizedBox(),
                Directionality(
                  textDirection:TextDirection.rtl,
                  child: 
                   Text('زمان : ${data.date}',style: const TextStyle(
                  color: Colors.black
                ))),
              ],)
            ],
          ),
        ),
      ),
    );
  }
}
