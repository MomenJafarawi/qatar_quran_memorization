import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qatar_quran_memorization/get/student_getx_controller.dart';
import 'package:qatar_quran_memorization/model/student.dart';
import 'package:qatar_quran_memorization/prefernces/shared_pref_controller.dart';
import 'package:qatar_quran_memorization/utils/helpers.dart';
import 'package:qatar_quran_memorization/widgets/app_text_field.dart';

import '../../model/process_response.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({Key? key, this.student}) : super(key: key);
  final Student? student;

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> with Helpers {
  late TextEditingController _nameEditingcontroller;
  late TextEditingController _arrivedToEditingcontroller;
  late TextEditingController _levelEditingcontroller;
  late TextEditingController _averageEditingcontroller;
  late TextEditingController _dateOfBithDayEditingcontroller;
  late TextEditingController _identificationEditingcontroller;
  late TextEditingController _addressEditingcontroller;
  late TextEditingController _phoneNumberEditingcontroller;
  late TextEditingController _parentPhoneNumberEditingcontroller;

  @override
  void initState() {
    isNewStudent ? _enabled = true : _enabled = false;
    super.initState();
    _nameEditingcontroller =
        TextEditingController(text: widget.student?.studentName);
    _arrivedToEditingcontroller =
        TextEditingController(text: widget.student?.arrivedTo);
    _levelEditingcontroller =
        TextEditingController(text: widget.student?.level);
    _averageEditingcontroller =
        TextEditingController(text: widget.student?.average.toString());
    _dateOfBithDayEditingcontroller =
        TextEditingController(text: widget.student?.dateOfBirthday);
    _identificationEditingcontroller =
        TextEditingController(text: widget.student?.identification.toString());
    _addressEditingcontroller =
        TextEditingController(text: widget.student?.address);
    _phoneNumberEditingcontroller =
        TextEditingController(text: widget.student?.phoneNumber.toString());
    _parentPhoneNumberEditingcontroller = TextEditingController(
        text: widget.student?.parentPhoneNumber.toString());
  }

  @override
  void dispose() {
    _nameEditingcontroller.dispose();
    _arrivedToEditingcontroller.dispose();
    _levelEditingcontroller.dispose();
    _averageEditingcontroller.dispose();
    _dateOfBithDayEditingcontroller.dispose();
    _identificationEditingcontroller.dispose();
    _addressEditingcontroller.dispose();
    _phoneNumberEditingcontroller.dispose();
    _parentPhoneNumberEditingcontroller.dispose();
    super.dispose();
  }

  bool _enabled = false;

  @override
  Widget build(BuildContext context) {
    _nameEditingcontroller.selection = TextSelection.fromPosition(
        TextPosition(offset: _nameEditingcontroller.text.length - 1));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff94B49F),
        title: Text(
          'إضافة طالب جديد',
          style: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: Icon(Icons.save),
          onPressed: () async => await _performsave(),
        ),
        actions: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_forward,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              AppTextFiled(
                  EditingController: _nameEditingcontroller,
                  hint: 'الإسم',
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  prefixIcon: Icons.person),
              SizedBox(
                height: 15,
              ),
              AppTextFiled(
                  EditingController: _arrivedToEditingcontroller,
                  hint: 'وصل إلى',
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  prefixIcon: Icons.text_snippet),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ' معلومات أخرى ',
                    style: GoogleFonts.cairo(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff646b67),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _enabled = !_enabled;
                      });
                    },
                    icon: Icon(_enabled == true
                        ? null
                        : Icons.edit),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              AppTextFiled(
                  enabled: _enabled,
                  EditingController: _levelEditingcontroller,
                  hint: 'المرحلة الدراسية',
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  prefixIcon: Icons.class_),
              SizedBox(
                height: 15,
              ),
              AppTextFiled(
                  enabled: _enabled,
                  EditingController: _averageEditingcontroller,
                  hint: 'المعدل الدراسي',
                  textInputType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  prefixIcon: Icons.align_vertical_bottom),
              SizedBox(
                height: 15,
              ),
              AppTextFiled(
                enabled: _enabled,
                EditingController: _dateOfBithDayEditingcontroller,
                hint: 'تاريخ الميلاد',
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
                prefixIcon: Icons.date_range,
                sufixixIcon: Icons.add,
                onpreeseddate: () async {
                  await _selectDate(context);
                },
              ),
              SizedBox(
                height: 15,
              ),
              AppTextFiled(
                  enabled: _enabled,
                  EditingController: _identificationEditingcontroller,
                  hint: 'رقم الهوية',
                  textInputType: TextInputType.number,
                  maxlength: 9,
                  textInputAction: TextInputAction.done,
                  prefixIcon: Icons.perm_identity),
              SizedBox(
                height: 15,
              ),
              AppTextFiled(
                  enabled: _enabled,
                  EditingController: _addressEditingcontroller,
                  hint: 'العنوان',
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  prefixIcon: Icons.location_city),
              SizedBox(
                height: 15,
              ),
              AppTextFiled(
                  enabled: _enabled,
                  EditingController: _phoneNumberEditingcontroller,
                  hint: 'رقم الجوال',
                  textInputType: TextInputType.number,
                  maxlength: 10,
                  textInputAction: TextInputAction.done,
                  prefixIcon: Icons.phone_android),
              SizedBox(
                height: 15,
              ),
              AppTextFiled(
                  enabled: _enabled,
                  EditingController: _parentPhoneNumberEditingcontroller,
                  hint: 'رقم جوال ولي الأمر',
                  textInputType: TextInputType.number,
                  maxlength: 10,
                  textInputAction: TextInputAction.done,
                  prefixIcon: Icons.phone_android),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? d = await showDatePicker(
      //we wait for the dialog to return
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(20100),
    );
    if (d != null) //if the user has selected a date
      setState(() {
        // we format the selected date and assign it to the state variable
        _dateOfBithDayEditingcontroller.text =
            new DateFormat.yMMMMd("en_US").format(d);
      });
  }

  bool get isNewStudent => widget.student == null;

  Future<void> _performsave() async {
    if (_checkData()) {
      await _save();
    }
  }

  bool _checkData() {
    if (_nameEditingcontroller.text.isNotEmpty &&
        _arrivedToEditingcontroller.text.isNotEmpty &&
        _levelEditingcontroller.text.isNotEmpty &&
        _averageEditingcontroller.text.isNotEmpty &&
        _dateOfBithDayEditingcontroller.text.isNotEmpty &&
        _identificationEditingcontroller.text.isNotEmpty &&
        _addressEditingcontroller.text.isNotEmpty &&
        _phoneNumberEditingcontroller.text.isNotEmpty &&
        _parentPhoneNumberEditingcontroller.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, message: 'Enter required data!', error: true);
    return false;
  }

  Future<void> _save() async {
    ProcessResponse processResponse = isNewStudent
        ? await StudentGetxController.to.create(student: student)
        : await StudentGetxController.to.updateStudent(updatedStudent: student);
    showSnackBar(context,
        message: processResponse.message, error: !processResponse.success);
    if (processResponse.success) {
      isNewStudent ? clear() : Navigator.pop(context);
    }
  }

  Student get student {
    Student student = isNewStudent ? Student() : widget.student!;
    student.studentName = _nameEditingcontroller.text;
    student.arrivedTo = _arrivedToEditingcontroller.text;
    student.level = _levelEditingcontroller.text;
    student.average = double.parse(_averageEditingcontroller.text);
    student.dateOfBirthday = _dateOfBithDayEditingcontroller.text;
    student.identification = int.parse(_identificationEditingcontroller.text);
    student.address = _addressEditingcontroller.text;
    student.phoneNumber = int.parse(_phoneNumberEditingcontroller.text);
    student.parentPhoneNumber =
        int.parse(_parentPhoneNumberEditingcontroller.text);
    student.userId =
        SharedPrefController().getValueFor<int>(key: prefKeys.id.name)!;
    return student;
  }

  void clear() {
    _nameEditingcontroller.clear();
    _arrivedToEditingcontroller.clear();
    _levelEditingcontroller.clear();
    _averageEditingcontroller.clear();
    _dateOfBithDayEditingcontroller.clear();
    _identificationEditingcontroller.clear();
    _addressEditingcontroller.clear();
    _phoneNumberEditingcontroller.clear();
    _parentPhoneNumberEditingcontroller.clear();
  }
}
