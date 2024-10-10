import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:helpteacher/page/bookmanager.dart';
import 'package:helpteacher/page/studentList.dart';

bool activeaddStu = false;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: InkWell(
        onTap: () {
          if (activeaddStu == true) {
            setState(() {
              activeaddStu = false;
            });
          } else {
            setState(() {
              activeaddStu = true;
            });
          }
          print(activeaddStu);
        },
        child: Container(
          width: activeaddStu ? 100 : 180,
          height: 50,
          decoration: BoxDecoration(
              color: themeData.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  activeaddStu ? 'کافیه' : 'افزودن دانش آموز ',
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  width: 8,
                ),
                const Icon(
                  CupertinoIcons.plus_circled,
                  color: Colors.white,
                  size: 30,
                ),
              ],
            ),
          ),
        ),
      ),
      endDrawer: Drawer(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Center(
                  child: Text(
                    'تنظیمات',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.menu_book_rounded),
                title: const Text('مدیریت درس ها'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BookManager(),));
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text('Logout'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  flex: 6,
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        color: themeData.colorScheme.primary,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10)
                        ]),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '  چهار شنبه 11 مهر 1403',
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.white,
                          size: 28,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  flex: 1,
                  child: Builder(
                    builder: (context) => InkWell(
                      onTap: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      child: Container(
                        width: 50,
                        height: 60,
                        decoration: BoxDecoration(
                            color: themeData.colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.menu_rounded,
                              size: 35,
                              color: Colors.white,
                            ),
                            Text(
                              'منو',
                              style: TextStyle(fontSize: 15, height: 0.2),
                            ),
                            SizedBox(
                              height: 6,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: double.infinity,
              height: 130,
              decoration: BoxDecoration(
                  color: themeData.colorScheme.error,
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text('یادآور دارید!',
                                style: themeData.textTheme.bodyMedium)),
                        const SizedBox(
                          width: 4,
                        ),
                        const Icon(
                          Icons.alarm_on_outlined,
                          color: Colors.white,
                          size: 25,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color:
                              themeData.colorScheme.onTertiary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(4, 2, 8, 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: themeData.colorScheme.primary,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        'بررسی شد',
                                        style: themeData.textTheme.titleLarge!
                                            .copyWith(fontSize: 12),
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(
                                  'بررسی جریمه ها',
                                  style: themeData.textTheme.bodyLarge,
                                )),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color:
                              themeData.colorScheme.onTertiary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(4, 2, 8, 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: themeData.colorScheme.primary,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        'بررسی شد',
                                        style: themeData.textTheme.titleLarge!
                                            .copyWith(fontSize: 12),
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(
                                  'پرسش کلاسی',
                                  style: themeData.textTheme.bodyLarge,
                                )),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            StudentList(
              activeaddStu: activeaddStu,
            )
          ],
        ),
      )),
    );
  }
}
