enum UserTableKeys {
  id,
  name,
  identification_number,
  group_name,
  password,
  users
}

class User {
  late int id;
  late String name;
  late int identificationNumber;
  late String groupName;
  late String password;
  static const tableName = 'users';

  User();

  User.fromMap(Map<String, dynamic> rowMap) {
    id = rowMap[UserTableKeys.id.name];
    name = rowMap[UserTableKeys.name.name];
    identificationNumber = rowMap[UserTableKeys.identification_number.name];
    groupName = rowMap[UserTableKeys.group_name.name];
    password = rowMap[UserTableKeys.password.name];
    // password = rowMap['id']; لا نقراها باعتبار الخصوصية ولكن نتاكد من خلال الاستعلام
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map[UserTableKeys.name.name] = name;
    map[UserTableKeys.identification_number.name] = identificationNumber;
    map[UserTableKeys.group_name.name] = groupName;
    map[UserTableKeys.password.name] = password;
    return map;
  }
}
