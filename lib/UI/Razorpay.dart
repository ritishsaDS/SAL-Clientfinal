import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:sal_user/data/repo/Eventpaymentrepo.dart';
import 'package:sal_user/data/repo/paymentrepo.dart';


class Razor extends StatefulWidget {
  dynamic order;
  dynamic payment;
  dynamic data;
  var date;
  dynamic type;
  var screen;
  Razor({this.order,this.payment,this.data,this.date,this.type,this.screen});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Razor> {
  static const platform = const MethodChannel("razorpay_flutter");

   Razorpay _razorpay;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Razorpay'),
        ),
        body: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(onPressed: openCheckout, child: Text('Open Razorpay for payment' ))
                ])),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    openCheckout();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_6TdfVgJzVLhMwc',
      'amount':(widget.payment),
      'name': 'SAL Appointment',
      'description': '${widget.order}',

      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, toastLength: Toast.LENGTH_SHORT);
    print("jjasdvjdvji"+widget.order);
    print("jjasdvjdvji"+response.paymentId);
    if(widget.screen=="Event"){
      Eventpaymentrepo.diomwthod(context,widget.order,response.paymentId,widget.data,widget.date,widget.type,widget.screen);
    }
    Succespaymentrepo.diomwthod(context,widget.order,response.paymentId,widget.data,widget.date,widget.type,widget.screen);
  //  successapi();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, toastLength: Toast.LENGTH_SHORT);
  }
}