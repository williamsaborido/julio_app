import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Service responsible for capturing widgets and converting them to PDF.
class PdfService {
  /// Captures a widget identified by [key] and returns its PDF bytes.
  /// 
  /// The widget must be wrapped in a [RepaintBoundary] with the provided [key].
  /// [pixelRatio] determines the quality of the capture (3.0 is recommended for printing).
  Future<Uint8List> captureWidgetToPdf(GlobalKey key, {double pixelRatio = 3.0}) async {
    final boundary = key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    
    if (boundary == null) {
      throw Exception('Could not find RenderRepaintBoundary. Ensure the widget is wrapped in a RepaintBoundary.');
    }

    // Capture the widget as an image
    final ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    
    if (byteData == null) {
      throw Exception('Could not convert image to byte data.');
    }

    final Uint8List pngBytes = byteData.buffer.asUint8List();

    // Create the PDF document
    final pdf = pw.Document();
    final pdfImage = pw.MemoryImage(pngBytes);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(pdfImage),
          );
        },
      ),
    );

    return pdf.save();
  }
}
