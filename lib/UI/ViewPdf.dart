import 'dart:io';
import 'dart:typed_data';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:pdf_flutter/pdf_flutter.dart';

class PdfView extends StatefulWidget{
  var url;
  var name;
  PdfView({this.url,this.name});
  @override
  _PdfViewState createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name!=null?widget.name:"Your Invoice"),
        backgroundColor: Colors.black,
        actions: <Widget>[
          GestureDetector(
            onTap: (){
              share();
            },
            child: Padding(padding: EdgeInsets.only(right: 20),
                child: Icon(Icons.share)),
          )
        ],
      ),
      body: PDF.network(
        widget.url,
        height: MediaQuery.of(context).size.height,
        width:  MediaQuery.of(context).size.width,
        placeHolder: Image.asset("assets/images/pdf.png",
            height: 200, width: 100),
      ),
    );
  }
  Future<void> share() async {
    _shareImageFromUrl();
  }
  Future<void> _shareImageFromUrl() async {
    try {
      var request = await HttpClient().getUrl(Uri.parse(
          widget.url));
      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      await Share.file('SAL Invoice', 'Invoice.pdf', bytes, 'document/pdf');
    } catch (e) {
      print('error: $e');
    }
  }
}