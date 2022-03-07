
import 'dart:convert';

import 'package:sal_user/models/Metadata.dart';

PdfDownload getPdfDownloadJson(String str) => PdfDownload.fromJson(json.decode(str));
class PdfDownload{
  String fileName;
  String mediaUrl;
  Meta meta;

  PdfDownload();

  factory PdfDownload.fromJson(Map<String, dynamic> parsedJson) {
    PdfDownload agoraToken = PdfDownload();
    agoraToken.meta = Meta.fromJson(parsedJson["meta"]);
    agoraToken.fileName = parsedJson['file'];
    agoraToken.mediaUrl = parsedJson['media_url'];
    return agoraToken;
  }

  Map<String, dynamic> toJson() {
    return {'meta': meta.toJson(), 'file': fileName, 'media_url': mediaUrl};
  }
}
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);


Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.mediaUrl,
    this.meta,
    this.pdfName,
  });

  String mediaUrl;
  Meta meta;
  String pdfName;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    mediaUrl: json["media_url"],
    meta: Meta.fromJson(json["meta"]),
    pdfName: json["pdf_name"],
  );

  Map<String, dynamic> toJson() => {
    "media_url": mediaUrl,
    "meta": meta.toJson(),
    "pdf_name": pdfName,
  };
}

class Meta {
  Meta({
    this.message,
    this.messageType,
    this.status,
  });

  String message;
  String messageType;
  String status;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    message: json["message"],
    messageType: json["message_type"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "message_type": messageType,
    "status": status,
  };
}
