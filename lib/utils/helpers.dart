import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

mixin Helpers {
  void showSnackBar(BuildContext context,
      {required String message, bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(textAlign: TextAlign.center,message,style: GoogleFonts.cairo(
        ),),
        backgroundColor: error ? Colors.red : const Color(0xff46594e),
        duration: const Duration(seconds: 3),
        dismissDirection: DismissDirection.horizontal,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
