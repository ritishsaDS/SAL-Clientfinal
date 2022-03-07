import 'package:http/http.dart' as http;
import 'package:sal_user/models/pdfdownload.dart';

class DownloadPdfRepo{
  static Future<PdfDownload> downloadPdf(String invoiceId) async {
    String url = 'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/appointment/download?invoice_id=$invoiceId';
    try {
      http.Response response = await http.get (url);
      if (response.statusCode == 200) {
        return getPdfDownloadJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

class AssesDownloadPdfRepo{
  static Future<Welcome> downloadPdf(String invoiceId) async {
    String url = 'https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/assessment/download?assessment_result_id=$invoiceId';
    try {
      http.Response response = await http.get (url);
      if (response.statusCode == 200) {
        return welcomeFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}