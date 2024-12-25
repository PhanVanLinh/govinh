import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:govinh/data/model/code.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;
import 'package:dio/dio.dart';

class CodesScreen extends StatefulWidget {
  final int? from;
  final int? to;
  final String adminCode;

  const CodesScreen({super.key, this.from, this.to, required this.adminCode});

  @override
  State<StatefulWidget> createState() {
    return CodesScreenState();
  }
}

class CodesScreenState extends State<CodesScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.adminCode.isEmpty) {
      return const Scaffold(
          body: Column(
        children: [
          Text("No permission"),
        ],
      ));
    }
    return Scaffold(
      body: Container(
        color: Colors.red,
        child: PdfPreview(
          maxPageWidth: 2000,
          dynamicLayout: false,
          enableScrollToPage: true,
          padding: EdgeInsets.zero,
          build: (format) {
            return generateResume(format);
          },
          previewPageMargin: EdgeInsets.zero,
          actions: [],
          // onPrinted: _showPrintedToast,
          // onShared: _showSharedToast,
        ),
      ),
    );
  }

  Future<Uint8List> generateResume(PdfPageFormat format) async {
    final doc = pw.Document(title: 'Code', author: 'Phan Van Linh');
    final dio = Dio();
    final response = await dio.get('https://mocki.io/v1/5b848dc4-ef95-451d-9f22-d6d1aadab625');

    // Extract items list and parse it into a List<Code>
    List<Code> codes = (response.data['items'] as List<dynamic>).map((item) => Code.fromJson(item)).toList();

    final img = await rootBundle.load('assets/images/logo.png');
    final imageBytes = img.buffer.asUint8List();
    pw.Image image1 = pw.Image(pw.MemoryImage(imageBytes), width: 120, height: 120);

    List<List<pw.Widget>> pages = List.empty(growable: true);
    List<pw.Widget> children = List.empty(growable: true);
    var i = 0;
    while (i < codes.length - 1) {
      children.add(
        buildItem(image1, codes[i]),
      );
      i++;
      final realI = i % 18;
      if (realI % 18 == 0) {
        pages.add(children);
        children = List.empty(growable: true);
      }
    }
    for (var page in pages) {
      doc.addPage(
        pw.Page(
          pageTheme: pw.PageTheme(
            pageFormat: format.copyWith(
              marginBottom: 0,
              marginLeft: 0,
              marginRight: 0,
              marginTop: 0,
            ),
            orientation: pw.PageOrientation.portrait,
            theme: pw.ThemeData.withFont(
              base: await PdfGoogleFonts.openSansRegular(),
              bold: await PdfGoogleFonts.openSansBold(),
            ),
          ),
          build: (context) => pw.Padding(
              padding: const pw.EdgeInsets.only(right: 0),
              child: pw.GridView(
                  crossAxisCount: 3,
                  direction: pw.Axis.vertical,
                  // crossAxisSpacing: 10,
                  // mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                  // padding: const pw.EdgeInsets.all(10),
                  children: page)),
        ),
      );
    }
    return doc.save();
  }

  pw.Widget buildItem(pw.Image image1, Code code) {
    return pw.Container(
        alignment: pw.Alignment.center,
        decoration: pw.BoxDecoration(
          border: pw.Border.all(
            color: PdfColors.black,
          ),
          // color: PdfColor(1, 0, 0)
        ),
        child: pw.Row(
          mainAxisSize: pw.MainAxisSize.min,
          children: [
            image1,
            pw.SizedBox(width: 6),
            pw.Stack(children: [
              pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.SizedBox(
                      height: 48,
                      width: 48,
                      child: pw.ConstrainedBox(
                        constraints: const pw.BoxConstraints.expand(),
                        child: pw.FittedBox(
                          child: pw.BarcodeWidget(
                            width: 1,
                            height: 1,
                            color: PdfColor.fromHex("#000000"),
                            barcode: pw.Barcode.qrCode(),
                            data: "https://govinh.com/${code.value}",
                          ),
                        ),
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text("Quét mã", style: const pw.TextStyle(fontSize: 10))
                    // pw.Text("Quét mã\ntích điểm", style: const pw.TextStyle(fontSize: 10))
                  ]),
              pw.Align(
                  alignment: pw.Alignment.topRight,
                  child: pw.Container(
                      padding: const pw.EdgeInsets.only(left: 48, top: 8),
                      child: pw.Text(code.id, style: const pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.end)))
            ])
          ],
        ));
  }
}
