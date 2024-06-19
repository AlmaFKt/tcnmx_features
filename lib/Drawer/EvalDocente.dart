import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';

class EvaluacionDocente extends StatefulWidget {
  const EvaluacionDocente({super.key});

  @override
  State<EvaluacionDocente> createState() => _EvaluacionDocenteState();
}

class _EvaluacionDocenteState extends State<EvaluacionDocente> {
  String? _filePath;
  bool _isLoading = true;
  double _zoomLevel = 1.0;
  final TransformationController _transformationController = TransformationController();

  @override
  void initState() {
    super.initState();
    generateAndSavePDF();
  }

  Future<void> generateAndSavePDF() async {
    final pdf = pw.Document();
    Uint8List pdfContent = await EscribirPdf(pdf);
    String filePath = await guardarPdf(pdfContent);
    setState(() {
      _filePath = filePath;
      _isLoading = false;
    });
  }

  Future<Uint8List> EscribirPdf(pw.Document pdf) async {
    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return pw.Column(
          children: <pw.Widget>[
            pw.Header(
              level: 0,
              child: pw.Text("CONSTANCIA DE EVALUACIÓN DOCENTE"),
            ),
            pw.Paragraph(
              text:
                  "Por medio de la presente se hace CONSTAR que la estudiante FLORES RAMIREZ ALMA, número de control 22090633, con Plan de Estudios ISIC-2010-224, contestó en su totalidad el cuestionario de Evaluación Docente de acuerdo a su horario registrado en el sistema, correspondiendo este al período ENERO - JUNIO 2024",
            ),
            pw.Paragraph(
              text: "Zacatepec, Morelos, a 18 de junio de 2024.",
            ),
            pw.Paragraph(
              text: "ATENTAMENTE,",
            ),
            pw.Paragraph(
              text: "DEPARTAMENTO DE DESARROLLO ACADÉMICO.",
            ),
          ],
        );
      },
    ));
    return pdf.save();
  }

  Future<String> guardarPdf(Uint8List pdfContent) async {
    Directory directorioDoc = await getApplicationDocumentsDirectory();
    String documentoPath = directorioDoc.path;
    String filePath = "$documentoPath/ejemplo.pdf";
    File archivo = File(filePath);
    await archivo.writeAsBytes(pdfContent);
    return filePath;
  }

  Future<void> descargarPdf() async {
    if (await Permission.storage.request().isGranted) {
      Directory? externalDir = await getExternalStorageDirectory();
      String downloadPath = "${externalDir!.path}/ejemplo.pdf";
      File archivo = File(downloadPath);
      if (_filePath != null) {
        File(_filePath!).copy(downloadPath);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PDF descargado a $downloadPath')),
        );
      }
    }
  }

  Future<void> imprimirPdf() async {
    if (_filePath != null) {
      Printing.layoutPdf(onLayout: (_) => File(_filePath!).readAsBytesSync());
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
                _transformationController.value = Matrix4.identity()..scale(_zoomLevel);
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.zoom_out),
            onPressed: () {
              setState(() {
                _zoomLevel -= 0.1;
                _transformationController.value = Matrix4.identity()..scale(_zoomLevel);
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: descargarPdf,
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
