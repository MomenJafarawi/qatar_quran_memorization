enum StudentTableKey {
  id,
  student_name,
  arrived_to,
  level,
  average,
  date_of_birthday,
  identification,
  address,
  phone_number,
  parent_phone_number,
  user_id
}

class Student {
  late int id;
  late String studentName;
  late String arrivedTo;
  late String level;
  late double average;
  late String dateOfBirthday;
  late int identification;
  late String address;
  late int phoneNumber;
  late int parentPhoneNumber;
  late int userId;

  static const tableName = 'students';

  Student();

  Student.fromMap(Map<String, dynamic> rowMap) {
    id = rowMap[StudentTableKey.id.name];
    studentName = rowMap[StudentTableKey.student_name.name];
    arrivedTo = rowMap[StudentTableKey.arrived_to.name];
    level = rowMap[StudentTableKey.level.name];
    average = rowMap[StudentTableKey.average.name];
    dateOfBirthday = rowMap[StudentTableKey.date_of_birthday.name];
    identification = rowMap[StudentTableKey.identification.name];
    address = rowMap[StudentTableKey.address.name];
    phoneNumber = rowMap[StudentTableKey.phone_number.name];
    parentPhoneNumber = rowMap[StudentTableKey.parent_phone_number.name];
    userId = rowMap[StudentTableKey.user_id.name];
    // password لا نقراها باعتبار الخصوصية ولكن نتاكد من خلال الاستعلام
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map[StudentTableKey.student_name.name] = studentName;
    map[StudentTableKey.arrived_to.name] = arrivedTo;
    map[StudentTableKey.level.name] = level;
    map[StudentTableKey.average.name] = average;
    map[StudentTableKey.date_of_birthday.name] = dateOfBirthday;
    map[StudentTableKey.identification.name] = identification;
    map[StudentTableKey.address.name] = address;
    map[StudentTableKey.phone_number.name] = phoneNumber;
    map[StudentTableKey.parent_phone_number.name] = parentPhoneNumber;
    map[StudentTableKey.user_id.name] = userId;
    return map;
  }
}
