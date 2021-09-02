import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sal_user/UI/Result.dart';
import 'package:sal_user/Utils/AlertDialog.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:sal_user/Widgets/Assesmentdeatilwidget.dart';

import 'Assesmentcreate.dart';

class AssesmantDetail extends StatefulWidget {
  var id;
  var title;
  var subtitle;
  AssesmantDetail({this.id,this.title,this.subtitle});
  @override
  _AssesmantState createState() => _AssesmantState();
}

class _AssesmantState extends State<AssesmantDetail> {
  double size = 18;
  final List<String> _listViewData = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
  ];
  int _selectedIndex = 0;
bool isError = true;
  bool isLoading = false;
  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }
  @override
  void initState() {
  getAssesment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Assessments Detail",
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
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(


            children: [
              Container(
                child: Text(
                  widget.title,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  widget.subtitle,
                  style: TextStyle(color: Color(fontColorGray), fontSize: 14),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: SizeConfig.screenHeight*0.56,
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: ListView(
                //  physics: NeverScrollableScrollPhysics(),
                  children: questionwidget(),)
              ),

              Container(
                margin: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  child: Text("Done"),
                  textColor: Colors.white,
                  color: Colors.blue,
                  onPressed: () {
                   if(total==0){
                     toast("Please Select Value First");
                   }
                   else{
                     Navigator.push(
                         context,
                         MaterialPageRoute(
                             builder: (context) => Result()));
                   }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
dynamic assesmentquestion= new List();
  dynamic assesmentoption= new List();
dynamic assesmentid= new List();
  Future<void> getAssesment() async {
    setState(() {
      isLoading=true;
    });
print(widget.id);
    try {
      final response = await get(Uri.parse('https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/client/assessment?assessment_id=${widget.id}'));
      print("bjkb" + response.body.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        assesmentoption=responseJson['question_options'];
        assesmentquestion=responseJson['questions'];
print(responseJson);
        setState(() {
          isError = false;
          isLoading = false;
          print('setstate');
        });


      } else {
        print("bjkb" + response.statusCode.toString());
        // showToast("Mismatch Credentials");
        setState(() {
          isError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        isError = true;
        isLoading = false;
      });
      showAlertDialog(
        context,
        e.toString(),
        "",
      );
    }
  }
  List <Widget> questionwidget(){
    List <Widget> questionlist= new List();
    for(int i=0;i<assesmentquestion.length;i++){
      questionlist.add(
          GestureDetector(
            onTap: (){
            //  Navigator.push(context, MaterialPageRoute(builder: (context)=>AssesmantDetail()));
            },
            child: Assesmentdetailwidget(
              question:assesmentquestion[i]['question'],
                questionid:assesmentquestion[i]['assessment_question_id'],
                option:assesmentoption,
                number:i+1
            ),
          ));
    }
    return questionlist;
  }
}
