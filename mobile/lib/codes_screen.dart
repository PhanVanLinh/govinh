import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;

class CodesScreen extends StatefulWidget {
  final String? id;

  const CodesScreen({super.key, required this.id});

  @override
  State<StatefulWidget> createState() {
    return CodesScreenState1();
  }
}

class CodesScreenState1 extends State<CodesScreen> {
  @override
  Widget build(BuildContext context) {
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
    final doc = pw.Document(title: 'My Résumé', author: 'David PHAM-VAN');
    // doc.addPage(
    //   pw.Page(
    //     build: (pw.Context context) => pw.Text('Hello World!'),
    //   ),
    // );

    // final image = await imageFromAssetBundle('assets/images/logo.png');
    final img = await rootBundle.load('assets/images/logo.png');
    final imageBytes = img.buffer.asUint8List();
    pw.Image image1 = pw.Image(pw.MemoryImage(imageBytes), width: 120, height: 120);

    print("LINHSSS");
    // print("LINHSSS $image");

    List<pw.Widget> children = List.empty(growable: true);
    var i = 0;
    while(i < 18) {
      children.add(buildItem(image1),);
      i++;
    }

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
                children: children)),
      ),
    );
    // final profileImage = pw.MemoryImage(
    //   (await rootBundle.load('assets/profile.jpg')).buffer.asUint8List(),
    // );
    doc.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Text('Hello World!'),
      ),
    );

    return doc.save();
  }

  pw.Widget buildItem(pw.Image image1) {
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
            pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.SizedBox(
                  height: 48,
                  width: 48,
                  child: pw.ConstrainedBox(
                    constraints: pw.BoxConstraints.expand(),
                    child: pw.FittedBox(
                      child: pw.BarcodeWidget(
                        width: 1,
                        height: 1,
                        color: PdfColor.fromHex("#000000"),
                        barcode: pw.Barcode.qrCode(),
                        data: "test qr",
                      ),
                    ),
                  ),
                ),
                pw.SizedBox(height: 4),
                pw.Text("Quét mã\nđổi điểm", style: pw.TextStyle(fontSize: 10))
              ]
            )
          ],
        ));
  }
}
