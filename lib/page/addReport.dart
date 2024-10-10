import 'package:flutter/material.dart';
import 'package:helpteacher/data/data.dart';
import 'package:helpteacher/main.dart';
import 'package:helpteacher/widget/custom_switch.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shamsi_date/shamsi_date.dart';

bool _nextPage = true;
String bookname = '';

class AddReport extends StatefulWidget {
  final int stuid;
  const AddReport({super.key, required this.stuid});

  @override
  State<AddReport> createState() => _AddReportState();
}

class _AddReportState extends State<AddReport> {
  Future<List<Books>> getbooks() async {
    final boxsbooks = Hive.box<Books>(booksBoxName);
    List<Books> listbook = boxsbooks.values.toList();
    return listbook;
  }

  Future<bool> _onWillPop() async {
    if (!_nextPage) {
      setState(() {
        _nextPage = true; // اگر در صفحه دوم بودید به صفحه اول برگردید
      });
      return false; // جلوگیری از برگشت به صفحه قبل
    } else {
      return true; // اجازه بازگشت به صفحه قبلی
    }
  }

  @override
  Widget build(BuildContext context) {
    final boxstu = Hive.box<Student>(studentBoxName);
    final themeData = Theme.of(context);
    final TextEditingController infoTxt = TextEditingController();

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    'دانش آموز ${boxstu.values.toList().firstWhere(
                          (element) => element.id == widget.stuid,
                        ).name}',
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 8),
                _nextPage
                    ? FutureBuilder<List<Books>>(
                        future: getbooks(), // دریافت لیست کتاب‌ها از Hive
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child:
                                    CircularProgressIndicator()); // نشانگر بارگذاری
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text(
                                    'Error: ${snapshot.error}')); // نمایش خطا در صورت مشکل
                          } else if (snapshot.hasData) {
                            List<Books> activeBooks = snapshot.data!
                                .where((book) => book.active)
                                .toList();

                            return BookGrid(
                              books: activeBooks,
                              onLessonSelected: (String data) {
                                setState(() {
                                  _nextPage = false;
                                  bookname = data;
                                  print(bookname); // به صفحه دوم بروید
                                });
                              },
                            );
                          } else {
                            return const Center(child: Text('No books found'));
                          }
                        },
                      )
                    : SubmitReport(
                        stuid: widget.stuid,
                        book: bookname,
                      ), // صفحه دوم برای ثبت گزارش
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BookGrid extends StatelessWidget {
  final List<Books> books; // لیستی از عناوین دروس
  final Function(String) onLessonSelected; // تابعی برای بازگرداندن نام درس

  const BookGrid({super.key, required this.books, required this.onLessonSelected});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // دو ستون
        childAspectRatio: 2.5, // نسبت عرض به ارتفاع هر دکمه
        crossAxisSpacing: 8, // فاصله بین ستون‌ها
        mainAxisSpacing: 8, // فاصله بین ردیف‌ها
      ),
      itemCount: books.length, // تعداد آیتم‌ها برابر با تعداد دروس
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // وقتی روی دکمه کلیک شد، نام درس را به تابع والد ارسال می‌کنیم
            onLessonSelected(books[index].name);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                books[index].name, // نمایش نام درس
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        );
      },
      shrinkWrap: true, // برای استفاده از فضای کم
      physics: const NeverScrollableScrollPhysics(), // غیر فعال کردن اسکرول
    );
  }
}

class SubmitReport extends StatelessWidget {
  final int stuid;
  final String book;
  final TextEditingController infoTxt = TextEditingController();

  SubmitReport({super.key, required this.stuid, required this.book});
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    var nowdate = DateTime.now().toJalali();
    bool isreport = true;
    String jalalidatenow = '${nowdate.year}/${nowdate.month}/${nowdate.day}';
    String nowtime =
        '${DateTime.now().hour}:${DateTime.now().minute}';
    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
                color: themeData.colorScheme.onTertiary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                ' ثبت گزارش برای $bookname',
                style: const TextStyle(color: Colors.black),
              ),
            )),
        Text(
          jalalidatenow,
          style: const TextStyle(color: Colors.black),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextField(
              controller: infoTxt,
              textAlign: TextAlign.right,
              style: themeData.textTheme.bodyMedium!
                  .copyWith(color: Colors.black.withOpacity(0.5)),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.subject),
                label: Text('توضیحات',
                    style: themeData.textTheme.bodyMedium!
                        .copyWith(color: Colors.black.withOpacity(0.5))),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
        ),
        SlidingSwitch(
          value: isreport,
          width: 250,
          onChanged: (bool value) {
            if (isreport) {
              isreport = false;
            } else {
              isreport = true;
            }
          },
          height: 55,
          animationDuration: const Duration(milliseconds: 400),
          onTap: () {},
          onDoubleTap: () {},
          onSwipe: () {},
          textOff: "بد",
          textOn: "خوب",
          contentSize: 15,
          colorOff: themeData.colorScheme.error,
          colorOn: themeData.colorScheme.primaryContainer,
          background: const Color(0xffe4e5eb),
          buttonColor: const Color(0xfff7f5f7),
          inactiveColor: const Color(0xff636f7b),
        ),
        const SizedBox(
          height: 16,
        ),
        InkWell(
          onTap: () async{
            final Box<DataStu> boxDatastu = Hive.box(dataStuBoxName);

            DataStu newDatastu = DataStu();
            newDatastu.id = stuid;
            newDatastu.info = infoTxt.text;
            newDatastu.date = '$jalalidatenow $nowtime';
            newDatastu.book = book;
            newDatastu.status = isreport;

            await boxDatastu.add(newDatastu);
            _nextPage=true;
            Navigator.pop(context);
          },
          child: Container(
            width: 150,
            height: 50,
            decoration: BoxDecoration(
              color: themeData.colorScheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
                child: Text(
              'ثبت گزارش',
              style: themeData.textTheme.bodyMedium,
            )),
          ),
        )
      ],
    );
  }
}
