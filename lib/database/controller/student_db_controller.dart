import 'package:qatar_quran_memorization/database/database_controller.dart';
import 'package:qatar_quran_memorization/database/db_operations.dart';
import 'package:qatar_quran_memorization/model/student.dart';
import 'package:qatar_quran_memorization/prefernces/shared_pref_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class StudentDbController implements DbOperation<Student> {
  Database _database = DBController().database;

  @override
  Future<int> create(Student model) {
    return _database.insert(Student.tableName, model.toMap());
  }

  @override
  Future<bool> delete(int id) async {
    int countOfDeleteRows = await _database
        .delete(Student.tableName, where: 'id=?', whereArgs: [id]);
    return countOfDeleteRows > 0;
  }

  @override
  Future<List<Student>> read() async {
    int userId =
        await SharedPrefController().getValueFor(key: prefKeys.id.name) ?? -1;
    List<Map<String, dynamic>> rowsMap = await _database
        .query(Student.tableName, where: 'user_id=?', whereArgs: [userId]);
    return rowsMap.map((rowMap) => Student.fromMap(rowMap)).toList();
  }

  @override
  Future<Student?> show(int id) async {
    List<Map<String, dynamic>> rowMap = await _database
        .query(Student.tableName, where: 'id=?', whereArgs: [id]);
    return rowMap.isNotEmpty ? Student.fromMap(rowMap.first) : null;
  }

  @override
  Future<bool> update(Student model) async {
    int countOFUpdateRows = await _database.update(
        Student.tableName, model.toMap(),
        where: 'id=?', whereArgs: [model.id]);
    return countOFUpdateRows > 0;
  }
}
