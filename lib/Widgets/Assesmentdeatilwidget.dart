import 'package:flutter/material.dart';
import 'package:sal_user/UI/Assesmentdetail.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
var total=0;
class Assesmentdetailwidget extends StatefulWidget{
  var question;
  dynamic option;
  var number;
  var questionid;
  Assesmentdetailwidget({this.question,this.number,this.option,this.questionid});
  @override
  _AssesmentdetailwidgetState createState() => _AssesmentdetailwidgetState();
}

class _AssesmentdetailwidgetState extends State<Assesmentdetailwidget> {
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
  var i;
  int _selectedIndex ;
  bool isError = true;
  bool isLoading = false;
  _onSelected(int index) {

    setState(() => _selectedIndex = index);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if(widget.question.length<50){
     return Container(
        height: SizeConfig.screenHeight*0.32,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                "Question"+widget.number.toString(),
                style: TextStyle(color: Color(fontColorGray), fontSize: 14),
              ),
            ),
            SizedBox(height: 5,),
            Container(
              child: Text(
                widget.question,
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
SizedBox(height: 5,),
            Container(
              height: SizeConfig.screenHeight*0.22,
              child: ListView.builder(

                physics: NeverScrollableScrollPhysics(),
                //scrollDirection: Axis.horizontal,
                itemCount: _listViewData.length,
                itemBuilder: (context, index) => Container(
                  child: GestureDetector(
                    onTap: () {
                      print(i);
                      _onSelected(index);
                      total=total+int.parse(_listViewData[index]);
                      print(total);
                      // if(i==index){
                      //   print(total);
                      // }
                      // else{
                      //
                      // //
                      //
                      // }
                      i=index;
                    },
                    child: Container(
                      margin: EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Container(
                          //   height: _selectedIndex != null &&
                          //       _selectedIndex == index
                          //       ? 20
                          //       : size,
                          //   width: _selectedIndex != null &&
                          //       _selectedIndex == index
                          //       ? 20
                          //       : size,
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(10),
                          //       border: Border.all(
                          //           color: _selectedIndex != null &&
                          //               _selectedIndex == index
                          //               ? Colors.blue
                          //               : Colors.grey)),
                          // ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          // Text(_listViewData[index]),
                          Container(
                            height: SizeConfig.screenHeight*0.40,
                            child: Column( mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,children: getOption(),),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Container(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         "STRONGLY\nDISAGREE",
            //         style:
            //         TextStyle(color: Color(fontColorGray), fontSize: 12),
            //       ),
            //       Text(
            //         "SOMEWHAT\nDISAGREE",
            //         style:
            //         TextStyle(color: Color(fontColorGray), fontSize: 12),
            //       ),
            //       Text(
            //         "STRONGLY\nDISAGREE",
            //         style:
            //         TextStyle(color: Color(fontColorGray), fontSize: 12),
            //       ),
            //     ],
            //   ),
            // ),

          ],),
      );
    }
 else{
      return    Container(
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Container(
            child: Text(
              "Question"+widget.number.toString(),
              style: TextStyle(color: Color(fontColorGray), fontSize: 14),
            ),
          ),
            SizedBox(
              height: 10,
            ),
          Container(
            child: Text(
              widget.question,
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _listViewData.length,
              itemBuilder: (context, index) => Container(
                child: GestureDetector(
                  onTap: () {
                    print(i);
                    _onSelected(index);
                    total=total+int.parse(_listViewData[index]);
                    print(total);
                    // if(i==index){
                    //   print(total);
                    // }
                    // else{
                    //
                    // //
                    //
                    // }
                    i=index;
                  },
                  child: Container(
                    margin: EdgeInsets.all(9),
                    child: Column(
                      children: [
                        Container(
                          height: _selectedIndex != null &&
                              _selectedIndex == index
                              ? 20
                              : size,
                          width: _selectedIndex != null &&
                              _selectedIndex == index
                              ? 20
                              : size,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: _selectedIndex != null &&
                                      _selectedIndex == index
                                      ? Colors.blue
                                      : Colors.grey)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                         Text(_listViewData[index]),
                        //Row(children: getOption(),)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "STRONGLY\nDISAGREE",
                  style:
                  TextStyle(color: Color(fontColorGray), fontSize: 12),
                ),
                Text(
                  "SOMEWHAT\nDISAGREE",
                  style:
                  TextStyle(color: Color(fontColorGray), fontSize: 12),
                ),
                Text(
                  "STRONGLY\nDISAGREE",
                  style:
                  TextStyle(color: Color(fontColorGray), fontSize: 12),
                ),
              ],
            ),
          ),

        ],),
      );
    }
  }

  List <Widget>getOption() {
    List<Widget>optionlist = new List();
    for(int i =0; i<widget.option['${widget.questionid}'].length;i++){
      optionlist.add(Container(
        margin: EdgeInsets.all(5),
        child: GestureDetector(
          onTap: ()=>_onSelected(i),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: _selectedIndex != null &&
                    _selectedIndex == i
                    ? 20
                    : size,
                width: _selectedIndex != null &&
                    _selectedIndex == i
                    ? 20
                    : size,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                 color: _selectedIndex != null &&
                _selectedIndex == i
                ? Colors.blue
                    : Colors.white,
                    border: Border.all(
                        color:  Colors.grey)),
              ),
              SizedBox(width: 10,),
              Container(
                width: SizeConfig.screenWidth*0.75,
                child: Text(

                  widget.option['${widget.questionid}'][i]['option'].toString().substring(2),maxLines: 2,textAlign: TextAlign.start,overflow: TextOverflow.ellipsis,softWrap: true,
            ),
              )
          ],),
        ),
      ));
    }
    return optionlist;
  }
}