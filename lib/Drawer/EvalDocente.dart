import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:printing/printing.dart';
import 'package:flutter/services.dart' show rootBundle;

class EvaluacionDocente extends StatefulWidget {
  const EvaluacionDocente({super.key});

  @override
  State<EvaluacionDocente> createState() => _EvaluacionDocenteState();
}

class _EvaluacionDocenteState extends State<EvaluacionDocente> {
  String? _filePath;
  bool _isLoading = true;
  double _zoomLevel = 1.0;
  final TransformationController _transformationController =
      TransformationController();

  @override
  void initState() {
    super.initState();
    generateAndSavePDF();
  }

  Future<void> generateAndSavePDF() async {
    try {
      final pdf = pw.Document();
      final Uint8List imageData1 =
          await loadImageFromAssets('images/EDUCACION.png');
      final Uint8List imageData2 =
          await loadImageFromAssets('images/TecNM.png');
      Uint8List pdfContent = await EscribirPdf(pdf, imageData1, imageData2);
      String filePath = await guardarPdf(pdfContent);
      setState(() {
        _filePath = filePath;
        _isLoading = false;
      });
    } catch (e) {
      print('Error generating PDF: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error generating PDF')),
      );
    }
  }

  Future<Uint8List> loadImageFromAssets(String path) async {
    final ByteData data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }

  Future<Uint8List> EscribirPdf(
      pw.Document pdf, Uint8List imageData1, Uint8List imageData2) async {
    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return pw.Column(
          children: <pw.Widget>[
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Image(pw.MemoryImage(imageData1), width: 120),
                  pw.SizedBox(width: 20), // Espacio entre las imágenes
                  pw.Image(pw.MemoryImage(imageData2), width: 120),
                ]),
            pw.SizedBox(height: 80),
            pw.Center(
              child: pw.Text(
                "CONSTANCIA DE EVALUACIÓN DOCENTE",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.SizedBox(height: 90),
            pw.RichText(
              text: pw.TextSpan(
                style: pw.TextStyle(),
                children: [
                  pw.TextSpan(
                    text:
                        "Por medio de la presente se hace CONSTAR que la estudiante ",
                  ),
                  pw.TextSpan(
                    text: "FLORES RAMIREZ ALMA",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                  pw.TextSpan(
                    text: ", número de control ",
                  ),
                  pw.TextSpan(
                    text: "22090633",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                  pw.TextSpan(
                    text: ", con Plan de Estudios ",
                  ),
                  pw.TextSpan(
                    text: "ISIC-2010-224",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                  pw.TextSpan(
                    text:
                        ", contestó en su totalidad el cuestionario de Evaluación Docente de acuerdo a su horario registrado en el sistema, correspondiendo este al período ENERO - JUNIO 2024",
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 55), 
            pw.Align(
              alignment: pw.Alignment.topRight,
              child: pw.Paragraph(
                text: ('Zacatepec, Morelos, a 25 de junio de 2024.'),
                //DateFormat('dd \'de\' MMMM \'de\' yyyy', 'es_MX')
                    //.format(DateTime.now()),
              ),
            ),
            pw.SizedBox(height: 70),
            pw.Align(
              alignment: pw.Alignment.topLeft,
              child: pw.Paragraph(
                text: "ATENTAMENTE,",
              ),
            ),
            pw.SizedBox(height: 25),
            pw.Align(
              alignment: pw.Alignment.topLeft,
              child: pw.Paragraph(
                text: "DEPARTAMENTO DE DESARROLLO ACADÉMICO.",
              ),
            ),
            pw.Align(
              alignment: pw.Alignment.topRight,
              child: pw.Paragraph(
                text:
                    "Calzada Tecnológico No. 27 Col. Centro, C.P.62780 Zacatepec, Morelos, Tel. (734) 3432110y 3432111 Ext. 228 e-mail: desarrollo_academico@itzacatepec.edu.mx | zacatepec.tecnm.mx",
              ),
            ),
          ],
        );
      },
    ));
    return pdf.save();
  }

  Future<String> guardarPdf(Uint8List pdfContent) async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    String filePath = "$path/ejemplo.pdf";
    File file = File(filePath);
    await file.writeAsBytes(pdfContent);
    return filePath;
  }

  Future<void> imprimirPdf() async {
    try {
      if (_filePath != null) {
        Printing.layoutPdf(onLayout: (_) => File(_filePath!).readAsBytesSync());
      }
    } catch (e) {
      print('Error generating PDF: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error generating PDF: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Evaluación Docente'),
        actions: [
          IconButton(
            icon: Icon(Icons.zoom_in),
            onPressed: () {
              setState(() {
                _zoomLevel += 0.1;
                _transformationController.value = Matrix4.identity()
                  ..scale(_zoomLevel);
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.zoom_out),
            onPressed: () {
              setState(() {
                _zoomLevel -= 0.1;
                _transformationController.value = Matrix4.identity()
                  ..scale(_zoomLevel);
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.print),
            onPressed: imprimirPdf,
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : InteractiveViewer(
              transformationController: _transformationController,
              child: PDFView(
                filePath: _filePath!,
              ),
            ),
    );
  }
}
