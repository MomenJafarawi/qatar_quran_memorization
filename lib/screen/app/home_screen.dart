import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:qatar_quran_memorization/model/student.dart';
import 'package:qatar_quran_memorization/prefernces/shared_pref_controller.dart';
import 'package:qatar_quran_memorization/screen/app/pdf_view.dart';
import 'package:qatar_quran_memorization/screen/app/student_screen.dart';
import 'package:qatar_quran_memorization/utils/helpers.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../get/student_getx_controller.dart';
import '../../model/process_response.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with Helpers {
  StudentGetxController noteGetxController =
      Get.put<StudentGetxController>(StudentGetxController());
  String userName = SharedPrefController().getValueFor(key: prefKeys.name.name);
  String groupName =
      SharedPrefController().getValueFor(key: prefKeys.groupname.name);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff94B49F),
        title: Text(
          'الرئيسية',
          style: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StudentScreen(),
                ),
              );
            },
            icon: const Icon(Icons.person_add)),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.of(context).push(
                await MaterialPageRoute(
                  builder: (_) => PdfViewPage(
                    generate: _generatePdf,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.picture_as_pdf),
          ),
          IconButton(
            onPressed: () async => await _logout(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12, right: 18),
            child: Text(
              'المحفظ :${userName}',
              style: GoogleFonts.cairo(
                  color: Colors.teal,
                  fontSize: 14,
                  decoration: TextDecoration.underline),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 220, top: 12),
            child: Text(
              'الحلقة :${groupName}',
              style: GoogleFonts.cairo(
                  color: Colors.teal,
                  fontSize: 14,
                  decoration: TextDecoration.underline),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: GetBuilder<StudentGetxController>(
              builder: (StudentGetxController controller) {
                if (controller.students.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.students.length,
                    itemBuilder: (context, index) {
                      return Card(
                          margin:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StudentScreen(
                                      student: controller.students[index],
                                    ),
                                  ),
                                );
                              },
                              leading: const Icon(Icons.person),
                              title: Text(
                                controller.students[index].studentName,
                                style: GoogleFonts.cairo(),
                              ),
                              subtitle: Text(
                                  controller.students[index].arrivedTo,
                                  style: GoogleFonts.cairo()),
                              trailing: IconButton(
                                onPressed: () async =>
                                    await deleteStudent(index: index),
                                icon: const Icon(Icons.delete),
                              ),
                            ),
                          ));
                    },
                  );
                } else {
                  return Center(
                    child: Text(
                      'لا يوجد بيانات لعرضها',
                      style: GoogleFonts.cairo(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black45,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _logout() async {
    await SharedPrefController().logout();
    bool removed = await Get.delete<StudentGetxController>();

    Navigator.pushNamedAndRemoveUntil(
        context, '/login_screen', (route) => false);
  }

  Future<void> deleteStudent({required int index}) async {
    ProcessResponse processResponse =
        await StudentGetxController.to.delete(index: index);
    showSnackBar(context,
        message: processResponse.message, error: !processResponse.success);
  }

  //
  // Future<Uint8List> _generatePdf() async {
  //   List<Student> data = StudentGetxController().students;
  //   final pdf = pw.Document();
  //   pdf.addPage(pw.Page(
  //       pageFormat: PdfPageFormat.a4,
  //       build: (context) {
  //         return pw.Table.fromTextArray(data: <List<String>>[
  //           <String>['Name', 'to'],
  //           ...data.map((item) => [item.studentName, item.arrivedTo])
  //         ]);
  //       }));
  //   String dir = (await getApplicationDocumentsDirectory()).path;
  //   String path = '$dir/student.pdf';
  //   final File file = File(path);
  //   return pdf.save();
  // }

  Future<Uint8List> _generatePdf() async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    List<Student> data = StudentGetxController.to.students;
    var arabicFont =
        pw.Font.ttf(await rootBundle.load("fonts/HacenTunisia.ttf"));

    // final pdf = pw.Document();
    pdf.addPage(pw.Page(
        textDirection: pw.TextDirection.rtl,
        theme: pw.ThemeData.withFont(
          base: arabicFont,
        ),
        pageFormat: PdfPageFormat.roll80,
        build: (context) {
          return pw.Table.fromTextArray(data: <List<String>>[
            <String>[
              'حفظ إلى',
              'رقم الهوية',
              'الإسم',

            ],
            ...data.map((item) => [
              item.arrivedTo,
                  item.identification.toString(),
                  item.studentName,

                ])
          ]);
        }));

    String dir = (await getApplicationDocumentsDirectory()).path;
    String path = '$dir/student.pdf';
    final File file = File(path);
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
    return pdf.save();
  }
}
