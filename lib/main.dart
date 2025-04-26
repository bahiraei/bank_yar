import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        fontFamily: 'IranSans',
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'تبدیل اعداد'),
      locale: const Locale("fa", "IR"),
      supportedLocales: const [Locale("fa", "IR"), Locale("en", "US")],
      localizationsDelegates: const [
        // Add Localization
        PersianMaterialLocalizations.delegate,
        PersianCupertinoLocalizations.delegate,

        // DariMaterialLocalizations.delegate, Dari
        // DariCupertinoLocalizations.delegate,
        // PashtoMaterialLocalizations.delegate, Pashto
        // PashtoCupertinoLocalizations.delegate,
        // SoraniMaterialLocalizations.delegate, Kurdish
        // SoraniCupertinoLocalizations.delegate,
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController priceController = TextEditingController();

  TextEditingController fromDateController = TextEditingController();

  Jalali? fromDate;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          centerTitle: true,
          elevation: 16,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'تبدیل عدد به حروف:',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Gap(12),
                  TextFormField(
                    controller: priceController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignLabelWithHint: true,
                      hintText: 'رقم ورودی',
                      hintStyle: const TextStyle(fontSize: 14),
                    ),
                    textDirection: TextDirection.ltr,
                    keyboardType: TextInputType.number,
                    autocorrect: false,
                    maxLines: 1,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  Gap(24),
                  if (priceController.text != '')
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${priceController.text.toWord()} تومان'),
                          ],
                        ),
                        Gap(16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text(priceController.text.seRagham())],
                        ),
                        Gap(16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${priceController.text.beRial().toWord()} ریال',
                            ),
                          ],
                        ),
                        Gap(16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(priceController.text.beRial().seRagham()),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ),
            Divider(height: 0, indent: 16, endIndent: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'تبدیل تاریخ به حروف:',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Gap(12),
                  TextFormField(
                    controller: fromDateController,
                    readOnly: true,
                    onTap: () async {
                      Jalali? picked = await showPersianDatePicker(
                        context: context,
                        initialDate: fromDate ?? Jalali.now(),
                        firstDate: Jalali(1385, 8),
                        lastDate: Jalali.now(),
                        locale: Locale('fa', 'IR'),
                        initialEntryMode:
                            PersianDatePickerEntryMode.calendarOnly,
                        initialDatePickerMode: PersianDatePickerMode.year,
                        textDirection: TextDirection.rtl,
                      );

                      if (picked != null) {
                        fromDateController.text = picked.formatCompactDate();
                      } else {
                        fromDateController.text = '';
                      }

                      setState(() {
                        fromDate = picked;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 0,
                      ),
                      alignLabelWithHint: true,
                      hintText: 'از تاریخ',
                      hintStyle: const TextStyle(fontSize: 14),
                    ),
                    keyboardType: TextInputType.none,
                    textAlign: TextAlign.center,
                  ),
                  Gap(24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //تبدیل تاریخ میلادی به متن تاریخ شمسی
                          Text(
                            fromDate?.toDateTime().toPersianDateStr(
                                  strDay: false,
                                  strMonth: true,
                                  strYear: false,
                                  showDayStr: false,
                                ) ??
                                '',
                          ),
                        ],
                      ),
                      Gap(16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //تبدیل تاریخ میلادی به متن تاریخ شمسی
                          Text(
                            fromDate?.toDateTime().toPersianDateStr(
                                  strDay: false,
                                  strMonth: true,
                                  strYear: true,
                                  showDayStr: false,
                                ) ??
                                '-',
                          ),
                        ],
                      ),
                      Gap(16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //تبدیل تاریخ میلادی به متن تاریخ شمسی
                          Text(
                            fromDate?.toDateTime().toPersianDateStr(
                                  strDay: true,
                                  strMonth: true,
                                  strYear: true,
                                  showDayStr: false,
                                ) ??
                                '',
                          ),
                        ],
                      ),
                      Gap(16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //تبدیل تاریخ میلادی به متن تاریخ شمسی
                          Text(
                            fromDate?.toDateTime().toPersianDateStr(
                                  strDay: true,
                                  strMonth: true,
                                  strYear: true,
                                  showDayStr: true,
                                ) ??
                                '-',
                          ),
                        ],
                      ),
                      Gap(16),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
