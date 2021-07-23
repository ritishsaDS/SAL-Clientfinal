import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:sal_user/Utils/Colors.dart';

class Connect extends StatefulWidget {
  const Connect({Key key}) : super(key: key);

  @override
  _ConnectState createState() => _ConnectState();
}

class _ConnectState extends State<Connect> {

  String topic;
  String language;
  bool expand = false;
  int checkboxValue = 0;
  double price = 0;
  DateTime selectedDate = DateTime.now();

  TextEditingController date = TextEditingController();


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

    date.text = DateFormat.yMd().format(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Filter Search",
          style: TextStyle(
            color: Color(midnightBlue),
            fontWeight: FontWeight.w600,
          ),),
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          width: SizeConfig.screenWidth,
          margin: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth * 0.05,
            vertical: SizeConfig.blockSizeVertical
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: SizeConfig.screenWidth,
                child: Text("Connect for",
                style: TextStyle(
                  color: Color(backgroundColorBlue),
                  fontWeight: FontWeight.w600
                ),),
              ),
              Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color(fontColorGray)),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color(fontColorGray)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color(fontColorGray)),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color(fontColorGray)),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color(fontColorGray)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color(fontColorGray)),
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.all(12),
                  ),
                  items: <String>['Topic 1', 'Topic 2', 'Topic 3']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                            color: Color(midnightBlue),
                            fontWeight: FontWeight.w400,
                            fontSize: SizeConfig.blockSizeVertical * 2),
                      ),
                    );
                  }).toList(),
                  hint: Text(
                    "Select a Topic",
                    style: TextStyle(
                        color: Color(fontColorGray),
                        fontSize: SizeConfig.blockSizeVertical * 1.75,
                        fontWeight: FontWeight.w400),
                  ),
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Color(fontColorGray),
                  ),
                  value: topic,
                  onChanged: (value) {
                    setState(() {
                      topic = value;
                    });
                  },
                ),
              ),
              InkWell(
                onTap: (){
                  if(expand == false)
                  setState(() {
                    expand = true;
                  });
                  else
                    setState(() {
                      expand = false;
                    });
                },
                child: Container(
                  width: SizeConfig.screenWidth,
                  margin: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Advance Filter",
                        style: TextStyle(
                            color: Color(midnightBlue),
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0XFFE0EDF6),
                        ),
                        child: Icon(expand == false ? Icons.add : Icons.remove,color: Color(backgroundColorBlue),),
                      ),
                    ],
                  ),
                ),
              ),
              if(expand == true )
                Column(
                  children: [
                    Container(
                      width: SizeConfig.screenWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Connect with",
                          style: TextStyle(
                            color: Color(backgroundColorBlue),
                            fontWeight: FontWeight.w600
                          ),),
                          Icon(Icons.info_outline,color: Color(fontColorGray),)
                        ],
                      ),
                    ), // Connect with
                    Container(
                      width: SizeConfig.screenWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: SizeConfig.screenWidth * 0.4,
                                child: RadioListTile(
                                  title: Text("Counsellor",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(fontColorGray)
                                  ),),
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  activeColor: Color(backgroundColorBlue),
                                  value: 1,
                                  groupValue: checkboxValue,
                                  onChanged: (value){
                                    setState(() {
                                      checkboxValue = value;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                width: SizeConfig.screenWidth * 0.4,
                                child: RadioListTile(
                                  title: Text("Listener",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Color(fontColorGray)
                                    ),),
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  activeColor: Color(backgroundColorBlue),
                                  value: 2,
                                  groupValue: checkboxValue,
                                  onChanged: (value){
                                    setState(() {
                                      checkboxValue = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: SizeConfig.screenWidth * 0.8,
                                child: RadioListTile(
                                  title: Text("Alternative Therapist",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Color(fontColorGray)
                                    ),),
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  activeColor: Color(backgroundColorBlue),
                                  value: 3,
                                  groupValue: checkboxValue,
                                  onChanged: (value){
                                    setState(() {
                                      checkboxValue = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ), // Radios
                    Container(
                      width: SizeConfig.screenWidth,
                      child: Text("Date",
                        style: TextStyle(
                            color: Color(backgroundColorBlue),
                            fontWeight: FontWeight.w600
                        ),),
                    ), // Date
                    Container(
                      width: SizeConfig.screenWidth,
                      margin: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Select Date",
                          hintStyle: TextStyle(
                              color: Color(fontColorGray),
                              fontSize: SizeConfig.blockSizeVertical * 1.75,
                              fontWeight: FontWeight.w400),
                          suffixIcon: Icon(Icons.arrow_forward_ios,color: Color(fontColorGray),),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Color(fontColorGray)),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Color(fontColorGray)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Color(fontColorGray)),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Color(fontColorGray)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Color(fontColorGray)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Color(fontColorGray)),
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.all(12),
                        ),
                        readOnly: true,
                        controller: date,
                        onTap: (){
                          selectDate(context);
                        },
                      ),
                    ), //Calendar
                    Container(
                      width: SizeConfig.screenWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Price",
                                style: TextStyle(
                                    color: Color(backgroundColorBlue),
                                    fontWeight: FontWeight.w600
                                ),),
                              Text("₹ 0 - ₹ 650",
                              style: TextStyle(
                                color: Color(fontColorSteelGrey),
                                fontWeight: FontWeight.w600
                              ),)
                            ],
                          ),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              thumbColor: Colors.white,
                              activeTrackColor: Color(backgroundColorBlue),
                              inactiveTrackColor: Color(fontColorGray),
                            ),
                            child: Slider(
                              min: 0,
                              max: 650,
                              value: price,
                              divisions: 300,
                              label: price.round().toString(),
                              onChanged: (value){
                                setState(() {
                                  price = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      child: Text("Language",
                        style: TextStyle(
                            color: Color(backgroundColorBlue),
                            fontWeight: FontWeight.w600
                        ),),
                    ), // Date
                    Container(
                      width: SizeConfig.screenWidth,
                      margin: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockSizeVertical),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Color(fontColorGray)),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Color(fontColorGray)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Color(fontColorGray)),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Color(fontColorGray)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Color(fontColorGray)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Color(fontColorGray)),
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.all(12),
                        ),
                        items: <String>['English', 'Hindi', 'Punjabi','Language 1','Language 2']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                  color: Color(midnightBlue),
                                  fontWeight: FontWeight.w400,
                                  fontSize: SizeConfig.blockSizeVertical * 2),
                            ),
                          );
                        }).toList(),
                        hint: Text(
                          "Select a Language",
                          style: TextStyle(
                              color: Color(fontColorGray),
                              fontSize: SizeConfig.blockSizeVertical * 1.75,
                              fontWeight: FontWeight.w400),
                        ),
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Color(fontColorGray),
                        ),
                        value: language,
                        onChanged: (value) {
                          setState(() {
                            language = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical * 2
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(onPressed:(){},
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: Color(fontColorGray),
                      ),
                    ),
                    child: Text("CLEAR",style: TextStyle(
                      color: Color(fontColorGray)
                    ),),
                    minWidth: SizeConfig.screenWidth * 0.4,),
                    MaterialButton(onPressed:(){
                      Navigator.of(context).pushNamed('/SearchResult');
                    },
                      color: Color(backgroundColorBlue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text("SEARCH",style: TextStyle(
                          color: Colors.white
                      ),),
                    minWidth: SizeConfig.screenWidth * 0.4,),
                  ],
                ),
              ),
              Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical
                ),
                child: ListView.builder(itemBuilder: (context,int index){
                  return Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.symmetric(
                      vertical: SizeConfig.blockSizeVertical * 0.5
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              width: SizeConfig.screenWidth * 0.25,
                              height: SizeConfig.screenHeight * 0.1,
                              margin:EdgeInsets.symmetric(
                                vertical: SizeConfig.blockSizeVertical * 0.5
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset('assets/bg/person.png',fit: BoxFit.cover,),
                              ),
                            ),
                            Container(
                              margin:EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 2,
                                top: SizeConfig.blockSizeVertical * 0.5
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text("Avinash Kothari",
                                      style: TextStyle(
                                        color: Color(fontColorSteelGrey),
                                        fontWeight: FontWeight.w600,
                                        fontSize: SizeConfig.blockSizeVertical * 2
                                      ),),
                                      Container(
                                          child: Image.asset('assets/icons/dot.png',width: SizeConfig.blockSizeHorizontal,),
                                      margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 2),),
                                      Row(
                                        children: [
                                          Text("4.5",
                                          style: TextStyle(
                                            color: Color(fontColorSteelGrey),
                                            fontSize: SizeConfig.blockSizeVertical * 1.50
                                          ),),
                                          Icon(Icons.star,color: Color(0XFFF0CA03),size: SizeConfig.blockSizeVertical * 2,)
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Counsellor",
                                        style: TextStyle(
                                            color: Color(fontColorSteelGrey),
                                            fontSize: SizeConfig.blockSizeVertical * 2
                                        ),),
                                      Container(
                                        child: Image.asset('assets/icons/dot.png',width: SizeConfig.blockSizeHorizontal,),
                                        margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 2),),
                                      Text("₹ 500",
                                        style: TextStyle(
                                            color: Color(fontColorSteelGrey),
                                            fontSize: SizeConfig.blockSizeVertical * 2
                                        ),),
                                    ],
                                  ),
                                  Text("7+ years experience",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Color(fontColorSteelGrey)
                                  ),)
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: SizeConfig.screenWidth,
                          margin: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical
                          ),
                          child: Text("Next available Today",
                          style: TextStyle(
                            color: Color(fontColorSteelGrey),
                            fontWeight: FontWeight.w600
                          ),),
                        ),
                        Container(
                          margin:EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical
                          ),
                          height: SizeConfig.blockSizeVertical * 6,
                          child: ListView.builder(itemBuilder: (context, int index){
                            return Container(
                              width: SizeConfig.screenWidth * 0.2,
                              padding:EdgeInsets.all(8),
                              margin: EdgeInsets.symmetric(
                                horizontal: SizeConfig.blockSizeHorizontal
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Color(fontColorGray),
                                ),
                              ),
                              child: Text("9:00"),
                              alignment: Alignment.center,
                            );
                          },
                          primary: false,
                          itemCount: 4,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          )
                        ),
                        Container(
                          margin:EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical * 2
                          ),
                          child: MaterialButton(
                            onPressed: (){
                              Navigator.of(context).pushNamed('/CounsellorProfile');
                            },
                            child: Text("BOOK APPOINTMENT",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600
                            ),),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: Color(backgroundColorBlue),
                            minWidth: SizeConfig.screenWidth,
                            height: SizeConfig.blockSizeVertical * 6,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                shrinkWrap: true,
                itemCount: 10,
                  primary: false,
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}