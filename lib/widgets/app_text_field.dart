import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextFiled extends StatelessWidget {
  const AppTextFiled({
    Key? key,
    required TextEditingController EditingController,
    required String hint,
    required IconData prefixIcon,
    IconData? sufixixIcon,
    TextInputType textInputType = TextInputType.text,
    bool obscure = false,
    bool enabled = true,
    int? maxlength,
    TextInputAction textInputAction = TextInputAction.next,
    final void Function(String value)? onSubmitted,
    final void Function()? onpreeseddate,
  })  : _EditingController = EditingController,
        _hint = hint,
        _prefixIcon = prefixIcon,
        _sufixixIcon = sufixixIcon,
        _textInputType = textInputType,
        _obscuretext = obscure,
        _readonly = enabled,
        _textInputAction = textInputAction,
        _onSubmitted = onSubmitted,
        _maxlength = maxlength,
        _onpreeseddate = onpreeseddate,
        super(key: key);

  final TextEditingController _EditingController;
  final String _hint;
  final IconData _prefixIcon;
  final IconData? _sufixixIcon;
  final TextInputType _textInputType;
  final bool _obscuretext;
  final bool _readonly;
  final int? _maxlength;
  final TextInputAction _textInputAction;
  final void Function(String value)? _onSubmitted;
  final void Function()? _onpreeseddate;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {
        if (_EditingController.selection ==
            TextSelection.fromPosition(
                TextPosition(offset: _EditingController.text.length - 1))) {
          _EditingController.selection = TextSelection.fromPosition(
              TextPosition(offset: _EditingController.text.length));
        }
      },
      enabled: _readonly,
      controller: _EditingController,
      keyboardType: _textInputType,
      textInputAction: _textInputAction,
      obscureText: _obscuretext,
      maxLength: _maxlength,
      style: GoogleFonts.cairo(color: const Color(0xff04B8673), fontSize: 14),
      onSubmitted: _onSubmitted,
      decoration: InputDecoration(
        labelText: _hint,
        counterText: '',
        hintStyle: GoogleFonts.cairo(fontSize: 14),
        contentPadding: EdgeInsets.symmetric(vertical: 8),
        prefixIcon: Icon(_prefixIcon, size: 22),
        suffixIcon: IconButton(
          icon: Icon(
            _sufixixIcon,
            size: 22,
          ),
          onPressed: _onpreeseddate,
        ),
        enabledBorder: buildOutlineInputBorder(color: const Color(0xff94B49F)),
        focusedBorder: buildOutlineInputBorder(color: const Color(0xff18978F)),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder({required Color color}) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: BorderSide(width: 1, color: color));
  }
}
