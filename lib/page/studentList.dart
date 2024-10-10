import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpteacher/data/data.dart';
import 'package:helpteacher/main.dart';
import 'package:helpteacher/page/addReport.dart';
import 'package:helpteacher/page/StudentTabBooks.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shamsi_date/shamsi_date.dart';

class StudentList extends StatelessWidget {
  final bool activeaddStu;

  final boxstu = Hive.box<Student>(studentBoxName);
  final TextEditingController _nameTxt = TextEditingController();

  StudentList({super.key, required this.activeaddStu});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: themeData.colorScheme.onTertiary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'افزودن دانش آموز',
                          style: themeData.textTheme.bodySmall!
                              .copyWith(color: Colors.black),
                        ),
                        const Icon(CupertinoIcons.plus_circled),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'لیست دانش آموزان',
                      style: themeData.textTheme.bodyMedium!.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Icon(Icons.people_alt_rounded)
                  ],
                ),
              ],
            ),
            AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              child: activeaddStu
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextField(
                              controller: _nameTxt,
                              textAlign: TextAlign.right,
                              style: themeData.textTheme.bodyMedium!.copyWith(
                                  color: Colors.black.withOpacity(0.5)),
                              decoration: InputDecoration(
                                  prefixIcon:
                                      const Icon(Icons.account_circle_rounded),
                                  label: Text('نام دانش آموز',
                                      style: themeData.textTheme.bodyMedium!
                                          .copyWith(
                                              color: Colors.black
                                                  .withOpacity(0.5))),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            if (_nameTxt.text.isNotEmpty) {
                              final Box<Student> box = Hive.box(studentBoxName);
                              Student newStu = Student();
                              newStu.name = _nameTxt.text;
                              await box.add(newStu);
                              _nameTxt.text = '';
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Text('نام دانش آموز را وارد کنید')),
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
                    )
                  : const SizedBox.shrink(), // Empty widget that takes no space
            ),
            const SizedBox(
              height: 8,
            ),
            ValueListenableBuilder(
                valueListenable: boxstu.listenable(),
                builder: (context, value, child) {
                  return ListView.builder(
                    itemCount: boxstu.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      Student data = Student();
                      data = boxstu.values.toList()[index];
                      return _StudentItem(themeData: themeData, data: data);
                    },
                  );
                })
          ],
        ),
      ),
    );
  }
}

class _StudentItem extends StatelessWidget {
  const _StudentItem({
    required this.themeData,
    required this.data,
  });

  final ThemeData themeData;
  final Student data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => InfoStudent(stuid: data.id),
        //     ));
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StudentTabBooks(stuid: data.id,),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              decoration: BoxDecoration(
                  color: themeData.colorScheme.onTertiary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text('${data.id}- ',
                        style: themeData.textTheme.bodyMedium!
                            .copyWith(color: Colors.black)),
                    Text(
                      data.name,
                      style: themeData.textTheme.bodyMedium!
                          .copyWith(color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
