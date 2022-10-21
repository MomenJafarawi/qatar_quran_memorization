import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qatar_quran_memorization/model/group_name.dart';
import 'package:qatar_quran_memorization/utils/helpers.dart';
import 'package:qatar_quran_memorization/widgets/app_text_field.dart';

import '../../database/controller/user_db_controller.dart';
import '../../model/process_response.dart';
import '../../model/user.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Helpers {
  late TextEditingController _nameEditingController;
  late TextEditingController _idNumberEditingController;
  late TextEditingController _passwordEditingController;

  int? _selectedgroup;
  String _selectedgroupname = '';

  final List<GroupName> _group_name = <GroupName>[
    const GroupName(id: 1, groub_name: 'عمر بن عبد العزيز'),
    const GroupName(id: 2, groub_name: 'سعد بن معاذ'),
    const GroupName(id: 3, groub_name: 'أنس بن مالك'),
    const GroupName(id: 4, groub_name: 'أبو عبيدة الجراح'),
    const GroupName(id: 5, groub_name: 'عبادة بن الصامت'),
    const GroupName(id: 6, groub_name: 'معاذ ومعوذ ابن عفراء'),
    const GroupName(id: 7, groub_name: 'عمر بن الخطاب'),
    const GroupName(id: 8, groub_name: 'علي بن أبي طالب'),
    const GroupName(id: 9, groub_name: 'عثمان بن عفان'),
    const GroupName(id: 10, groub_name: 'أبو بكر الصديق'),
    const GroupName(id: 11, groub_name: 'معاوية بن أبي سفيان'),
    const GroupName(id: 12, groub_name: 'خالد بن الوليد'),
    const GroupName(id: 13, groub_name: 'صلاح الدين الأيوبي'),
  ];

  @override
  void initState() {
    super.initState();
    _nameEditingController = TextEditingController();
    _idNumberEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _nameEditingController.dispose();
    _idNumberEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'أهلا وسهلا بك',
              style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: const Color(0xff646b67)),
            ),
            Text(
              'أدخل المعلومات المطلوبة',
              style: GoogleFonts.cairo(
                  height: 1,
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  color: const Color(0xff646b67)),
            ),
            SizedBox(
              height: 80,
            ),
            AppTextFiled(
                EditingController: _nameEditingController,
                hint: 'الإسم',
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.next,
                prefixIcon: Icons.person),
            const SizedBox(
              height: 15,
            ),
            AppTextFiled(
                EditingController: _idNumberEditingController,
                hint: 'رقم الهوية',
                textInputType: TextInputType.number,
                maxlength: 9,
                textInputAction: TextInputAction.next,
                prefixIcon: Icons.perm_identity),
            const SizedBox(
              height: 15,
            ),
            AppTextFiled(
                EditingController: _passwordEditingController,
                hint: 'كلمة المرور',
                obscure: true,
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
                prefixIcon: Icons.lock),
            const SizedBox(
              height: 18,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: DropdownButton(
                  isExpanded: true,
                  value: _selectedgroup,
                  hint: const Text('إختر إسم الحلقة'),
                  elevation: 4,
                  menuMaxHeight: 350,
                  style: GoogleFonts.cairo(
                      color: Color(0xff04B8673), fontWeight: FontWeight.bold),
                  borderRadius: BorderRadius.circular(10),
                  items: _group_name.map((GroupName group) {
                    return DropdownMenuItem<int>(
                        value: group.id,
                        child: Text(group.groub_name),
                        onTap: () {
                          _selectedgroupname = group.groub_name;
                        });
                  }).toList(),
                  onChanged: (int? value) {
                    setState(() {
                      _selectedgroup = value;
                    });
                  }),
            ),
            const SizedBox(
              height: 100,
            ),
            ElevatedButton(
              onPressed: () async => _performRegister(),
              style: ElevatedButton.styleFrom(
                  textStyle: GoogleFonts.cairo(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  minimumSize: const Size(double.infinity, 45),
                  elevation: 0,
                  primary: const Color(0xff94B49F)),
              child: const Text('إنشاء حساب'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _performRegister() async {
    if (_checkData()) {
      return await _register();
    }
  }

  bool _checkData() {
    if (_nameEditingController.text.isNotEmpty &&
        _idNumberEditingController.text.isNotEmpty &&
        _passwordEditingController.text.isNotEmpty ) {
      return true;
    }
    showSnackBar(context, message: 'Enter Required Data!', error: true);

    return false;
  }

  Future<void> _register() async {
    ProcessResponse processResponse =
        await UserDbController().register(user: user);
    if (processResponse.success) {
      Navigator.pop(context);
    }

    showSnackBar(context,
        message: processResponse.message, error: !processResponse.success);
  }

  User get user {
    User user = User();
    user.name = _nameEditingController.text;
    user.identificationNumber = int.parse(_idNumberEditingController.text);
    user.groupName = _selectedgroupname;
    user.password = _passwordEditingController.text;
    return user;
  }
}
