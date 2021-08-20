import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart' as utils;
import 'package:sal_user/UI/Sessions.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/validator.dart';

class ClientDetails extends StatefulWidget {
  final Map<String, dynamic> getData;
  final String mediaUrl;
  const ClientDetails({Key key, this.getData, this.mediaUrl}) : super(key: key);

  @override
  _ClientDetailsState createState() => _ClientDetailsState();
}

class _ClientDetailsState extends State<ClientDetails> {
  GlobalKey<FormState> FormKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController phn = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController email = TextEditingController();

  int gender = 0;
  bool agree = false;
  DateTime selectedDate = DateTime.now();

  selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });

    dob.text = DateFormat.yMd().format(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Details",
          style: TextStyle(
            color: Color(midnightBlue),
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: Color(midnightBlue),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          width: SizeConfig.screenWidth,
          margin:
              EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical * 2),
                child: Text(
                  "Please provide us the following details",
                  style: TextStyle(
                      color: Color(fontColorSteelGrey),
                      fontWeight: FontWeight.w600,
                      fontSize: SizeConfig.blockSizeVertical * 2.5),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical),
                child: Form(
                  key: FormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: SizeConfig.screenWidth,
                        margin: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical),
                        child: Text(
                          "Name",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(fontColorGray),
                          ),
                        ),
                      ),
                      Container(
                        width: SizeConfig.screenWidth,
                        margin: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical),
                        child: TextFormField(
                          controller: name,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray)),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray)),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray)),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray)),
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.all(12),
                            hintText: "Enter Name",
                            hintStyle: TextStyle(
                                color: Color(fontColorGray),
                                fontWeight: FontWeight.w400,
                                fontSize:
                                    SizeConfig.blockSizeVertical * 1.75),
                          ),
                          validator: (s) {
                            if (s.trim().isEmpty)
                              return utils.errorThisFieldRequired;
                            return null;
                          },
                        ),
                      ),
                      Container(
                        width: SizeConfig.screenWidth,
                        margin: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical),
                        child: Text(
                          "EMAIL ID",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(fontColorGray),
                          ),
                        ),
                      ),
                      Container(
                        width: SizeConfig.screenWidth,
                        margin: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical),
                        child: TextFormField(
                          controller: email,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray)),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray)),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray)),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray)),
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.all(12),
                            hintText: "Enter Email ID",
                            hintStyle: TextStyle(
                                color: Color(fontColorGray),
                                fontWeight: FontWeight.w400,
                                fontSize:
                                    SizeConfig.blockSizeVertical * 1.75),
                          ),
                          validator: (s) {
                            if (s.trim().isEmpty)
                              return utils.errorThisFieldRequired;
                            if (!validateEmail(email.text))
                              return "Invalid Email";
                            return null;
                          },
                        ),
                      ),
                      Container(
                        width: SizeConfig.screenWidth,
                        margin: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical),
                        child: Text(
                          "Mobile Number",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(fontColorGray),
                          ),
                        ),
                      ),
                      Container(
                        width: SizeConfig.screenWidth,
                        margin: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical),
                        child: TextFormField(
                          controller: phn,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray)),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray)),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray)),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Color(fontColorGray)),
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.all(12),
                            hintText: "Enter Mobile Number",
                            hintStyle: TextStyle(
                                color: Color(fontColorGray),
                                fontWeight: FontWeight.w400,
                                fontSize:
                                    SizeConfig.blockSizeVertical * 1.75),
                          ),
                          validator: (s) {
                            if (s.trim().isEmpty)
                              return utils.errorThisFieldRequired;
                            /*   if (!validateEmail(emailController.text))
                              return invalid_email;*/
                            return null;
                          },
                        ),
                      ),
                      Container(
                        width: SizeConfig.screenWidth,
                        margin: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical),
                        child: Text(
                          "Gender",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(fontColorGray),
                          ),
                        ),
                      ),
                      Container(
                        width: SizeConfig.screenWidth,
                        margin: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: SizeConfig.screenWidth * 0.3,
                              child: RadioListTile(
                                value: 1,
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value;
                                  });
                                },
                                activeColor: Color(backgroundColorBlue),
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  "Male",
                                  style:
                                      TextStyle(color: Color(fontColorGray)),
                                ),
                              ),
                            ),
                            Container(
                              width: SizeConfig.screenWidth * 0.3,
                              child: RadioListTile(
                                value: 2,
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value;
                                  });
                                },
                                activeColor: Color(backgroundColorBlue),
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  "Female",
                                  style:
                                      TextStyle(color: Color(fontColorGray)),
                                ),
                              ),
                            ),
                            Container(
                              width: SizeConfig.screenWidth * 0.3,
                              child: RadioListTile(
                                value: 3,
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value;
                                  });
                                },
                                activeColor: Color(backgroundColorBlue),
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  "Others",
                                  style:
                                      TextStyle(color: Color(fontColorGray)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: SizeConfig.screenWidth,
                        margin: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical),
                        child: Text(
                          "Date Of Birth",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(fontColorGray),
                          ),
                        ),
                      ),
                      Container(
                        width: SizeConfig.screenWidth,
                        margin: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical),
                        child: InkWell(
                          child: IgnorePointer(
                            child: TextFormField(
                              controller: dob,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: Color(fontColorGray)),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: Color(fontColorGray)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: Color(fontColorGray)),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: Color(fontColorGray)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: Color(fontColorGray)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: Color(fontColorGray)),
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.all(12),
                                hintText: "Enter Dob",
                                hintStyle: TextStyle(
                                    color: Color(fontColorGray),
                                    fontWeight: FontWeight.w400,
                                    fontSize:
                                        SizeConfig.blockSizeVertical * 1.75),
                                suffixIcon: Padding(
                                  padding: EdgeInsets.zero,
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Color(fontColorGray),
                                  ),
                                ),
                              ),
                              onTap: () {
                                selectDate(context);
                              },
                              validator: (s) {
                                if (s.trim().isEmpty)
                                  return utils.errorThisFieldRequired;
                                /*   if (!validateEmail(emailController.text))
                              return invalid_email;*/
                                return null;
                              },
                            ),
                          ),
                          onTap: () {
                            selectDate(context);
                          },
                        ),
                      ),
                      CheckboxListTile(
                        value: agree,
                        onChanged: (value) {
                          setState(() {
                            agree = value;
                          });
                        },
                        title: Row(
                          children: [
                            Text(
                              "I agree to the",
                              style: TextStyle(
                                  color: Color(fontColorGray),
                                  fontSize: SizeConfig.blockSizeVertical * 2),
                            ),
                            Text(
                              " Terms & Conditions",
                              style: TextStyle(
                                  color: Color(backgroundColorBlue),
                                  fontSize: SizeConfig.blockSizeVertical * 2),
                            )
                          ],
                        ),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        activeColor: Color(backgroundColorBlue),
                        checkColor: Colors.white,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 8,
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            if (FormKey.currentState.validate()) {
                              if (gender > 0 && agree) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Sessions(mediaUrl: widget.mediaUrl,getData:widget.getData ,)));
                              } else {
                                utils.toast("Please fill required fields");
                              }
                            }
                          },
                          child: Text(
                            "CONTINUE",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
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
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
