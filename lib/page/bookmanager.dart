import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpteacher/data/data.dart';
import 'package:helpteacher/main.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BookManager extends StatelessWidget {
  final boxbooks = Hive.box<Books>(booksBoxName);
  final TextEditingController _bookneme=TextEditingController();

  BookManager({super.key});

  @override
  Widget build(BuildContext context) {
      final themeData = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Text(
                            'افزودن درس جدید',
                            style: TextStyle(color: Colors.black),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextField(
                                controller: _bookneme,
                                textAlign: TextAlign.right,
                                style: themeData.textTheme.bodyMedium!.copyWith(
                                    color: Colors.black.withOpacity(0.5)),
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.school),
                                    label: Text('نام درس',
                                        style: themeData.textTheme.bodyMedium!
                                            .copyWith(
                                                color: Colors.black
                                                    .withOpacity(0.5))),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              if (_bookneme.text.isNotEmpty) {
                                Books newbook = Books();
                                newbook.name = _bookneme.text;
                                await boxbooks.add(newbook);
                                _bookneme.text = '';
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Text('نام کتاب را وارد کنید')),
                                ));
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: themeData.colorScheme.primary),
                              child: const Center(
                                child: Text(
                                  'ثبت',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                    const SizedBox(
                    height: 8,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'لیست درس ها',
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Icon(Icons.menu_book_rounded),
                            ],
                          ),
                          ValueListenableBuilder(
                            valueListenable: boxbooks.listenable(),
                            builder: (context, value, child) {
                                  List<Books> activeBooks = boxbooks.values.where((book) => book.active).toList();

                              return ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: activeBooks.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  Books data = activeBooks[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: themeData.colorScheme.onTertiary
                                            .withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: InkWell(
                                              onTap: () async{
                                               await data.delete();
                                              },
                                              child: Container(
                                                width: 40,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    color: themeData
                                                        .colorScheme.error,
                                                    borderRadius:
                                                        BorderRadius.circular(8)),
                                                child: const Icon(
                                                  Icons.delete,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                data.name,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                              const SizedBox(
                                                width: 16,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          )
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
