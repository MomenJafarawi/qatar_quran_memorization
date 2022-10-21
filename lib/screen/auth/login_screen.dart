import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qatar_quran_memorization/database/controller/user_db_controller.dart';
import 'package:qatar_quran_memorization/model/process_response.dart';
import 'package:qatar_quran_memorization/utils/helpers.dart';
import 'package:qatar_quran_memorization/widgets/app_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helpers {
  late TextEditingController _idNumberEditingController;
  late TextEditingController _passwordEditingController;

  @override
  void initState() {
    super.initState();
    _idNumberEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _idNumberEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  // clipBehavior: Clip.antiAlias,
                  height: 200,
                  width: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'images/quran_logo.png',
                      ),
                    ),
                  )),
              Text(
                'حلقات القرآن',
                style: GoogleFonts.cairo(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: const Color(0xff646b67)),
              ),

              const SizedBox(
                height: 55,
              ),
              AppTextFiled(
                  EditingController: _idNumberEditingController,
                  hint: 'رقم الهوية',
                  textInputType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  maxlength: 9,
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
                height: 90,
              ),
              ElevatedButton(
                onPressed: () async => await _performLogin(),

                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    minimumSize: const Size(double.infinity, 45),
                    elevation: 0,
                    textStyle: GoogleFonts.cairo(),
                    primary: const Color(0xff94B49F)),
                child: const Text('تسجيل الدخول'),
              ),
              Padding(
                padding: const EdgeInsets.only(top:12),
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ليس لديك حساب',
                      style: GoogleFonts.cairo(),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register_screen');
                      },
                      child: Text(
                        'أنشئ حساب',
                        style: GoogleFonts.cairo(
                            fontSize: 12,
                            color: const Color(0xff646b67),
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationThickness: 1),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _performLogin() async {
    if (_checkData()) {
      return await _login();
    }
  }

  bool _checkData() {
    if (_idNumberEditingController.text.isNotEmpty &&
        _passwordEditingController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, message: 'Enter Required Data!', error: true);
    return false;
  }

  Future<void> _login() async {
    ProcessResponse processResponse = await UserDbController().login(
        identification: _idNumberEditingController.text,
        password: _passwordEditingController.text);
    if (processResponse.success) {
      Navigator.pushReplacementNamed(context, '/home_screen');
    }
    showSnackBar(context,
        message: processResponse.message, error: !processResponse.success);
  }
}
