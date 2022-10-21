import 'package:get/get.dart';
import 'package:qatar_quran_memorization/database/controller/student_db_controller.dart';
import 'package:qatar_quran_memorization/model/student.dart';

import '../model/process_response.dart';

class StudentGetxController extends GetxController {
  List<Student> students = <Student>[];

  StudentDbController _dbController = StudentDbController();

  static StudentGetxController get to => Get.find<StudentGetxController>();

  @override
  void onInit() {
    read();
    super.onInit();
  }

  Future<ProcessResponse> create({required Student student}) async {
    int newRowId = await _dbController.create(student);
    if (newRowId != 0) {
      student.id = newRowId;
      students.add(student);
      update();
    }

    return ProcessResponse(
        message: newRowId != 0 ? 'created successfully' : 'create failed',
        success: newRowId != 0);
  }

  void read() async {
    students = await _dbController.read();
    update();
  }

  Future<ProcessResponse> updateStudent(
      {required Student updatedStudent}) async {
    bool updated = await _dbController.update(updatedStudent);
    if (updated) {
      int index =
          students.indexWhere((element) => element.id == updatedStudent.id);
      if (index != -1) {
        students[index] = updatedStudent;
        update();
      }
    }
    return ProcessResponse(
        message: updated ? 'Updated sucessfully' : 'Updates failed!',
        success: updated);
  }

  Future<ProcessResponse> delete({required int index}) async {
    bool deleted = await _dbController.delete(students[index].id);
    if (deleted) {
      students.removeAt(index);
      update();
    }
    return ProcessResponse(
        message: deleted ? 'deleted sucessfully' : 'deleted failed!',
        success: deleted);
  }
}
