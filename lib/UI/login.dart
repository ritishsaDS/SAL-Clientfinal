import 'dart:convert';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:sal_user/UI/Professionalinfo.dart';
import 'package:sal_user/UI/Signup.dart';
import 'package:sal_user/UI/webview.dart';
import 'package:sal_user/Utils/AlertDialog.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:sal_user/data/repo/sendOtpRepo.dart';
import 'Otp.dart';
import 'package:sal_user/Utils/Dialog.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:linkedin_auth/linkedin_auth.dart';


TextEditingController mobileController = TextEditingController();

class LoginScreen extends StatefulWidget {
  var screen;
   LoginScreen({this.screen});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Map userfb = {};
  GlobalKey<FormState> loginForm = GlobalKey<FormState>();
  final String redirectUrl = 'https://smarttersstudio.com';
  final String clientId = '78el5r2y1dwp4j';
  final String clientSecret = 'RnyXiCNz3cahNx1g';

  final GlobalKey<State> loginLoader = new GlobalKey<State>();
  var sendOtp = SendOtptoPhoneRepo();
  String countryCode = "";
 // static  FacebookAuth facebookAuth ;
  @override
  void initState() {
    super.initState();
    countryCode = "91";
    // LinkedInLogin.initialize(context,
    //     clientId: clientId,
    //     clientSecret: clientSecret,
    //     redirectUri: redirectUrl);
  }
  GoogleSignInAccount _userObj;
  Map _userObjfb = {};
  bool isLoggedIn = false;
  var profileData;
 // Map userfb = {};
  //var facebookLogin = FacebookLogin();

  GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
              height: SizeConfig.screenHeight,
              width: SizeConfig.screenWidth,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(70),
                ),
              ),
              height: SizeConfig.screenHeight * 0.7,
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.only(
                top: SizeConfig.screenHeight * 0.3,
              ),
              child: Container(
                margin: EdgeInsets.only(
                  top: SizeConfig.screenHeight * 0.10,
                  left: SizeConfig.screenWidth * 0.05,
                  right: SizeConfig.screenWidth * 0.05,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Welcome To SAL!",
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: SizeConfig.blockSizeVertical * 2.5),
                        ),
                        GestureDetector(
                          onTap: (){

                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfessionalInfo1()));



                          },
                          child: Text(
                            "Skip",
                            style: GoogleFonts.openSans(
                                color: Colors.blue,
                                fontWeight: FontWeight.w700,
                                fontSize: SizeConfig.blockSizeVertical * 1.5),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "We are glad to see you here.",
                      style: GoogleFonts.openSans(
                        color: Color(fontColorGray),
                        fontWeight: FontWeight.w400,
                        fontSize: SizeConfig.blockSizeVertical * 1.5,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 4,
                      ),
                      child: Form(
                        key: loginForm,
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    child: CountryCodePicker(
                                      onChanged: (v) {
                                        setState(() {
                                          countryCode = v.dialCode;
                                        });
                                      },
                                      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                      initialSelection: 'IN',
                                      showFlagDialog: true,
                                      comparator: (a, b) =>
                                          b.name.compareTo(a.name),
                                      //Get the country information relevant to the initial selection
                                      onInit: (code) => print(
                                          "on init ${code.name} ${code.dialCode} ${code.name}"),
                                    ),
                                    width: SizeConfig.blockSizeHorizontal * 30,
                                  ),
                                  Container(
                                    width: SizeConfig.blockSizeHorizontal * 55,
                                    child: TextFormField(
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(10)
                                      ],
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.all(
                                            SizeConfig.blockSizeVertical * 1.5),
                                        hintText: "Enter Mobile Number",
                                        hintStyle: GoogleFonts.openSans(
                                          color: Color(fontColorGray),
                                          fontWeight: FontWeight.w400,
                                          fontSize:
                                              SizeConfig.blockSizeVertical *
                                                  1.5,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      controller: mobileController,
                                      keyboardType: TextInputType.phone,
                                      textInputAction: TextInputAction.done,
                                      validator: (s) {
                                        return validateMobile(
                                            mobileController.text);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                color: Color(fontColorGray),
                                width: 1.0,
                              )),
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 2,
                            ),
                            MaterialButton(
                              onPressed: () {
                                if (loginForm.currentState.validate()) {
                                  loginForm.currentState.save();
                                  Dialogs.showLoadingDialog(
                                      context, loginLoader);
                                  sendOtp
                                      .sendOtp(
                                    context: context,
                                    phone: countryCode + mobileController.text,
                                  )
                                      .then((value) {
                                        print('SEND OTP :${value.meta.status}${value.meta.message}');
                                    if (value != null) {
                                      if (value.meta.status == "200") {
                                        Navigator.of(loginLoader.currentContext,
                                                rootNavigator: true)
                                            .pop();
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (conext) {
                                          return OTPScreen(phonenumber:mobileController.text,screen:widget.screen);
                                        }));
                                      } else {
                                        Navigator.of(loginLoader.currentContext,
                                                rootNavigator: true)
                                            .pop();
                                        showAlertDialog(
                                          context,
                                          value.meta.message,
                                          "",
                                        );
                                      }
                                    } else {
                                      Navigator.of(loginLoader.currentContext,
                                              rootNavigator: true)
                                          .pop();
                                      showAlertDialog(
                                        context,
                                        value.meta.message,
                                        "",
                                      );
                                    }
                                  }).catchError((error) {
                                    Navigator.of(loginLoader.currentContext,
                                            rootNavigator: true)
                                        .pop();
                                    showAlertDialog(
                                      context,
                                      error.toString(),
                                      "",
                                    );
                                  });
                                }
                              },
                              minWidth: SizeConfig.screenWidth,
                              color: Color(backgroundColorBlue),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              height: SizeConfig.blockSizeVertical * 6,
                              child: Text(
                                "LOGIN",
                                style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: SizeConfig.blockSizeVertical * 4),
                              child: Text("or continue with",
                                  style: GoogleFonts.openSans(
                                      fontSize:
                                          SizeConfig.blockSizeVertical * 1.85,
                                      color: Color(fontColorSteelGrey),
                                      fontWeight: FontWeight.w400)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: ()=>googlelogin(),
                                  child: Container(
                                    child: SvgPicture.asset("assets/icons/googleIcon.svg"),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(borderColor),width: 1
                                                ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0))),
                                    width: SizeConfig.blockSizeHorizontal * 20,
                                    height: SizeConfig.blockSizeVertical * 6,
                                    padding: EdgeInsets.all(8),
                                  ),
                                ),
                                SizedBox(width: SizeConfig.blockSizeHorizontal * 4,),
                                GestureDetector(
                                  onTap: (){
                                  //  _login();
                                  },
                                  child: Container(
                                    child: SvgPicture.asset("assets/icons/facebookIcon.svg"),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(borderColor),width: 1
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0))),
                                    width: SizeConfig.blockSizeHorizontal * 20,
                                    height: SizeConfig.blockSizeVertical * 6,
                                    padding: EdgeInsets.all(8),
                                  ),
                                ),
                                SizedBox(width: SizeConfig.blockSizeHorizontal * 4,),
                                GestureDetector(
                                  onTap: (){
                                    // LinkedInLogin.loginForAccessToken(
                                    //     destroySession: true,
                                    //     appBar: AppBar(
                                    //       title: Text('Demo Login Page'),
                                    //     ))
                                    //     .then((accessToken) => print(accessToken))
                                    //     .catchError((error) {
                                    //   print(error.errorDescription);
                                    // });

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            LinkedInUserWidget(
                                              appBar: AppBar(
                                                title: Text("SAL USer"),
                                              ),
                                              redirectUrl: redirectUrl,
                                              clientId: clientId,
                                              clientSecret: clientSecret,
                                              onGetUserProfile: (LinkedInUserModel linkedInUser) async{

                                                Map<String, dynamic> postJson = {
                                                  "user_id": linkedInUser.userId,
                                                  "email": linkedInUser.email.elements[0].handleDeep.emailAddress,
                                                 // "pic_url": profilePic,
                                                  "name": linkedInUser.firstName.localized.label + ' ' + linkedInUser.lastName.localized.label,
                                                  "token": linkedInUser.token.accessToken,
                                                  "expires_in": linkedInUser.token.expiresIn
                                                };
                                                setState(() {
                                                  var result;
                                                  result = postJson;
                                                });
                                                Navigator.of(context).pop();
                                              },
                                              catchError: (LinkedInErrorObject error) {
                                                print('Error description: ${error.description} Error code: ${error.statusCode.toString()}');
                                              },
                                            ),
                                        fullscreenDialog: true,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    child: SvgPicture.asset("assets/icons/linkedIn.svg"),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(borderColor),width: 1
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0))),
                                    width: SizeConfig.blockSizeHorizontal * 20,
                                    height: SizeConfig.blockSizeVertical * 6,
                                    padding: EdgeInsets.all(8),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 4,),
                    Container(
                      child: Text(
                        "By tapping continue or Login you agree to our",
                        style: GoogleFonts.openSans(
                            color: Color(fontColorGray),
                            fontSize: SizeConfig.blockSizeVertical * 1.5,
                            fontWeight: FontWeight.w400),
                      ),
                      width: SizeConfig.screenWidth,
                      alignment: Alignment.center,
                    ),
                    Container(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewClass(link:"https://sal-foundation.com/about-sal")));

                        },
                        child: Text(
                          "Terms of service & Privacy Policy.",
                          style: GoogleFonts.openSans(
                              color: Color(backgroundColorBlue),
                              fontSize: SizeConfig.blockSizeVertical * 1.5,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      width: SizeConfig.screenWidth,
                      alignment: Alignment.center,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  String validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }
  googlelogin() {
    print("jejk");
    _googleSignIn.signIn().then((userData) {
      setState(() async {
       // _isLoggedIn = true;
        _userObj = userData;
        print("jejjjnkjnkek");
        print(_userObj.displayName);
        if (_userObj.displayName != null) {

        }
      });
    }).catchError((e) {
      print(e);
    });
  }

  // Future<UserCredential> signInWithFacebook() async {
  //   // Trigger the sign-in flow
  //   final LoginResult loginResult = await FacebookAuth.instance.login();
  //
  //   // Create a credential from the access token
  //   final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken.token);
  //
  //   // Once signed in, return the UserCredential
  //   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  // }
  // Future<Null> _login() async {
  //   final Face result =
  //   await facebookSignIn.logIn(['email']);
  //
  //   switch (result.status) {
  //     case FacebookLoginStatus.loggedIn:
  //       final FacebookAccessToken accessToken = result.accessToken;
  //       print('''
  //        Logged in!
  //
  //        Token: ${accessToken.token}
  //        User id: ${accessToken.userId}
  //        Expires: ${accessToken.expires}
  //        Permissions: ${accessToken.permissions}
  //        Declined permissions: ${accessToken.declinedPermissions}
  //        ''');
  //       break;
  //     case FacebookLoginStatus.cancelledByUser:
  //       print('Login cancelled by the user.');
  //       break;
  //     case FacebookLoginStatus.error:
  //       print('Something went wrong with the login process.\n'
  //           'Here\'s the error Facebook gave us: ${result.errorMessage}');
  //       break;
  //   }
  // }

}
