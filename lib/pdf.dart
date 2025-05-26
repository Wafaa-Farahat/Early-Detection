import 'dart:io';
import 'dart:typed_data';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';


class PdfGenerator{
  static get _newprediction => null;

  static get valueChoose => null;


  static createPdf(_newprediction, valueChoose)async{
    String path =( await getApplicationDocumentsDirectory()).path;
    File file = File(path + "MY_Examination_Result.pdf");

    Document pdf = Document();
    pdf.addPage(_createPage(_newprediction,valueChoose));

    Uint8List bytes = await pdf.save();
    await file.writeAsBytes(bytes);

    await OpenFile.open(file.path);
  }

  static Page _createPage(var _newprediction , var valueChoose) {



    return Page(
        pageFormat: PdfPageFormat.roll80 ,
        build: (context) {
          return Center(
              child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(border: Border.all(style: BorderStyle.solid)),
                  child: Column(
                    children: [
                      Text("$valueChoose",style: TextStyle( fontWeight: FontWeight.bold ,fontSize: 18)),
                      Text("------------------------------",style: TextStyle( fontWeight: FontWeight.bold ,fontSize: 15)),
                      SizedBox(height: 15),
                      Text("$_newprediction", style: TextStyle( fontWeight: FontWeight.bold ,fontSize: 15)),

                    ],
                  ),
                ),

              );

        });
  }




}





