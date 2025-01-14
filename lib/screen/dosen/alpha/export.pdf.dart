import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:typed_data';

Future<void> exportToPDF(
    List<Map<String, dynamic>> data, BuildContext context) async {
  final pdf = await generatePDF(data, context);
  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf,
  );
}

Future<Uint8List> generatePDF(
    List<Map<String, dynamic>> data, BuildContext context) async {
  final pdf = pw.Document();

  // Load image for web and mobile
  final ByteData bytes = await rootBundle.load('assets/image/polinema-bw.png');
  final Uint8List imgBytes = bytes.buffer.asUint8List();

  pdf.addPage(
    pw.Page(
      build: (context) => pw.Column(
        children: [
          pw.Table(
            border: pw.TableBorder.all(width: 0),
            children: [
              pw.TableRow(
                children: [
                  pw.Container(
                    width: 100,
                    height: 100,
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Image(pw.MemoryImage(imgBytes)),
                  ),
                  pw.Expanded(
                    child: pw.Container(
                      padding:
                          pw.EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Text(
                            'KEMENTERIAN PENDIDIKAN, KEBUDAYAAN, RISET, DAN TEKNOLOGI',
                            style: pw.TextStyle(
                              fontSize: 11,
                              fontWeight: pw.FontWeight.bold,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            'POLITEKNIK NEGERI MALANG',
                            style: pw.TextStyle(
                              fontSize: 13,
                              fontWeight: pw.FontWeight.bold,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            'Jl. Soekarno-Hatta No. 9 Malang 65141',
                            style: pw.TextStyle(
                              fontSize: 10,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            'Telepon (0341) 404424 Pes. 101-105, 0341-404420, Fax. (0341) 404420',
                            style: pw.TextStyle(
                              fontSize: 10,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            'Laman: www.polinema.ac.id',
                            style: pw.TextStyle(
                              fontSize: 10,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 20),
          pw.Container(
            alignment: pw.Alignment.center,
            child: pw.Text(
              'LAPORAN DATA MAHASISWA ALPHA',
              style: pw.TextStyle(
                fontSize: 16,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Table(
            border: pw.TableBorder.all(),
            children: [
              pw.TableRow(
                children: [
                  pw.Container(
                    alignment: pw.Alignment.center,
                    padding: pw.EdgeInsets.all(4),
                    child: pw.Text(
                      'No',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  pw.Container(
                    alignment: pw.Alignment.center,
                    padding: pw.EdgeInsets.all(4),
                    child: pw.Text(
                      'NIM',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  pw.Container(
                    alignment: pw.Alignment.center,
                    padding: pw.EdgeInsets.all(4),
                    child: pw.Text(
                      'Nama',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  pw.Container(
                    alignment: pw.Alignment.center,
                    padding: pw.EdgeInsets.all(4),
                    child: pw.Text(
                      'Semester',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  pw.Container(
                    alignment: pw.Alignment.center,
                    padding: pw.EdgeInsets.all(4),
                    child: pw.Text(
                      'Jam Alpha',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  pw.Container(
                    alignment: pw.Alignment.center,
                    padding: pw.EdgeInsets.all(4),
                    child: pw.Text(
                      'Jam Kompen',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              ...data.asMap().entries.map((entry) {
                int index = entry.key + 1;
                Map<String, dynamic> item = entry.value;
                return pw.TableRow(
                  children: [
                    pw.Container(
                      alignment: pw.Alignment.center,
                      padding: pw.EdgeInsets.all(4),
                      child: pw.Text(index.toString()),
                    ),
                    pw.Container(
                      alignment: pw.Alignment.center,
                      padding: pw.EdgeInsets.all(4),
                      child: pw.Text(item['ni']),
                    ),
                    pw.Container(
                      alignment: pw.Alignment.center,
                      padding: pw.EdgeInsets.all(4),
                      child: pw.Text(item['nama'].toString()),
                    ),
                    pw.Container(
                      alignment: pw.Alignment.center,
                      padding: pw.EdgeInsets.all(4),
                      child: pw.Text(item['semester']),
                    ),
                    pw.Container(
                      alignment: pw.Alignment.center,
                      padding: pw.EdgeInsets.all(4),
                      child: pw.Text(item['jam_alpha'].toString()),
                    ),
                    pw.Container(
                      alignment: pw.Alignment.center,
                      padding: pw.EdgeInsets.all(4),
                      child: pw.Text(item['jam_kompen']?.toString() ?? 'N/A'),
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
        ],
      ),
    ),
  );

  return pdf.save();
}
