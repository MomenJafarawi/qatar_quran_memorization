import 'package:qatar_quran_memorization/database/database_controller.dart';
import 'package:qatar_quran_memorization/model/process_response.dart';
import 'package:qatar_quran_memorization/model/user.dart';
import 'package:qatar_quran_memorization/prefernces/shared_pref_controller.dart';
import 'package:sqflite/sqflite.dart';

class UserDbController {
  final Database _database = DBController().database;

  Future<ProcessResponse> login(
      {required String identification, required String password}) async {
    int parseidentification = int.parse(identification);
    List<Map<String, dynamic>> rowsMap = await _database.query(User.tableName,
        where: 'identification_number =? AND password=?',
        whereArgs: [parseidentification, password]);
    if (rowsMap.isNotEmpty) {
      User user = User.fromMap(rowsMap.first);
      await SharedPrefController().save(user: user);
    }
    String message = rowsMap.isNotEmpty
        ? 'Logged in successfully'
        : 'Login failed, check credentials';
    return ProcessResponse(message: message, success: rowsMap.isNotEmpty);
  }

  Future<ProcessResponse> register({required User user}) async {
    if (await _isUniqueIdentification(
        identification: user.identificationNumber.toString())) {
      int newRowId = await _database.insert(User.tableName, user.toMap());
      print(newRowId);
      print('nfihjvnbihdfbhudfvbudfvb');
      return ProcessResponse(
          message: newRowId != 0
              ? 'Account created successfully'
              : 'Failed to create account, try again',
          success: newRowId != 0);
    }
    return const ProcessResponse(
        message: 'ID exist , use another', success: false);
  }

  Future<bool> _isUniqueIdentification({required String identification}) async {
    int parseidentification = int.parse(identification);

    List<Map<String, dynamic>> rowMap = await _database.query(User.tableName,
        where: 'identification_number = ?', whereArgs: [parseidentification]);
    print(rowMap.toString());
    return rowMap.isEmpty;
  }
}
