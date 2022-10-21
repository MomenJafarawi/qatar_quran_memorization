import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class PdfViewPage extends StatefulWidget {
  final Future<Uint8List> Function() generate;

  const PdfViewPage({Key? key, required this.generate}) : super(key: key);

  @override
  State<PdfViewPage> createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  @override
  Widget build(BuildContext context) {
    return PdfPreview(
      build: (context) => widget.generate(),
    );
  }
}
