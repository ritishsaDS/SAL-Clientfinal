import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:sal_user/data/repo/Eventpaymentrepo.dart';
import 'package:sal_user/data/repo/paymentrepo.dart';
import 'Razorpay.dart';

class payment extends StatefulWidget {
  final dynamic getData;
  final String mediaUrl;
  final String sessionNumbers;
  String client_id;
  String counsellor_id;
  String appointment_id;
  dynamic billing;
  var order;
  var type;
  var date;
  var slot;
  dynamic bill;
  var screen;

  payment(
      {Key key,
      this.screen,
      this.date,
      this.slot,
      this.getData,
      this.billing,
      this.order,
      this.mediaUrl,
      this.type,
      this.bill,
      this.sessionNumbers,
      this.appointment_id,
      this.client_id,
      this.counsellor_id})
      : super(key: key);

  @override
  _paymentState createState() => _paymentState();
}

class _paymentState extends State<payment> {
  var moodstatic = [
    "0:30",
    "1:00",
    "1:30",
    "2:00",
    "2:30",
    "3:00",
    "3:30",
    "4:00",
    "4:30",
    "5:00",
    "5:30",
    "6:00",
    "6:30",
    "7:00",
    "7:30",
    "8:00",
    "8:30",
    "9:00",
    "9:30",
    "10:00",
    "10:30",
    "11:00",
    "11:30",
    "12:00",
    "12:30",
    "13:00",
    "13:30",
    "14:00",
    "14:30",
    "15:00",
    "15:30",
    "16:00",
    "16:30",
    "17:00",
    "17:30",
    "18:00",
    "18:30",
    "19:00",
    "19:30",
    '20:00',
    '20:30',
    "21:00",
    "21:30",
    "22:00",
    "22:30",
    "23:00",
    "23:30"
        "24:00"
  ];
  Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    print("widget.billing");
    print(widget.billing);
    // openCheckout();
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
    print(widget.type);
    if (widget.type == "2") {
      Succespaymentrepo.diomwthod(
          context,
          widget.order,
          "FREE",
          widget.getData,
          widget.date,
          widget.type,
          widget.screen,
          moodstatic[int.parse(widget.slot)]);
    } else {
      var options = {
        'key': 'rzp_test_6TdfVgJzVLhMwc',
        'amount': (widget.billing == null ? "0.00" : widget.billing),
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
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, toastLength: Toast.LENGTH_SHORT);
    print("jjasdvjdvji" + widget.order);
    print("jjasdvjdvji" + response.paymentId);
    // if(widget.screen=="Event"){
    //   Eventpaymentrepo.diomwthod(context,widget.order,response.paymentId,widget.data,widget.date,widget.type,widget.screen);
    // }
    Succespaymentrepo.diomwthod(
        context,
        widget.order,
        response.paymentId,
        widget.getData,
        widget.date,
        widget.type,
        widget.screen,
        moodstatic[int.parse(widget.slot)]);
    //  successapi();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName,
        toastLength: Toast.LENGTH_SHORT);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/bg/Frame.png",
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              padding: EdgeInsets.only(
                  top: 20, left: SizeConfig.blockSizeHorizontal * 40),
              height: SizeConfig.screenHeight,
              width: SizeConfig.screenWidth,
              child: Positioned(
                  left: 10,
                  top: 10,
                  child: Container(
                    child: Text(
                      "Summary ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  )),
            ),
            Container(
              padding: EdgeInsets.only(top: 20, left: 10),
              child: Container(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(70),
                ),
              ),
              height: SizeConfig.screenHeight * 0.8,
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.only(top: 150),
            ),
            Positioned(
              top: 100,
              right: 140,
              child: Container(
                child: Column(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: widget.getData['photo'] != null &&
                                widget.getData['photo'] != ""
                            ? Image.network(
                                widget.mediaUrl + widget.getData['photo'],
                                fit: BoxFit.cover,
                                scale: 3,
                              )
                            : Image.asset(
                                'assets/bg/person.png',
                                fit: BoxFit.cover,
                                scale: 4,
                              )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.getData['first_name'] +
                          " " +
                          widget.getData['last_name'],
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                          fontSize: SizeConfig.blockSizeVertical * 2),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.type == "1"
                          ? "Counsellor"
                          : widget.type == "2"
                              ? "Listener"
                              : "Therapist",
                      style: TextStyle(
                          color: Color(fontColorGray),
                          fontSize: SizeConfig.blockSizeVertical * 2),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: SizeConfig.screenHeight * 0.38, left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "BOOKING DATE",
                        style: TextStyle(
                            color: Color(fontColorGray),
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "BOOKING TIME",
                        style: TextStyle(
                            color: Color(fontColorGray),
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${DateFormat('dd MMMM yyyy').format(DateTime.parse(widget.date))}',
                        style: TextStyle(
                          color: Color(fontColorGray),
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "${moodstatic[int.parse(widget.slot)]}",
                        style: TextStyle(
                          color: Color(fontColorGray),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("NUMBER OF SESSIONs",
                      style: TextStyle(
                          color: Color(fontColorGray),
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 7,
                  ),
                  Text(widget.sessionNumbers,
                      style:
                          TextStyle(color: Color(fontColorGray), fontSize: 16)),
                  SizedBox(
                    height: 20,
                  ),
                  Text("TOTAL PAYABLE AMOUNT",
                      style: TextStyle(
                          color: Color(fontColorGray),
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                      "₹ ${widget.bill['billing'] == null ? "FREE" : widget.bill['billing']['paid_amount']}",
                      style:
                          TextStyle(color: Color(fontColorGray), fontSize: 16)),
                  Container(
                    margin: EdgeInsets.only(
                        top: SizeConfig.screenHeight * 0.3,
                        left: SizeConfig.screenWidth * 0.05,
                        right: SizeConfig.screenWidth * 0.05),
                    child: MaterialButton(
                      onPressed: () {
                        openCheckout();
                      },
                      child: Text(
                        "PROCEED TO PAYMENT",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                      minWidth: SizeConfig.screenWidth,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      color: Color(backgroundColorBlue),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
