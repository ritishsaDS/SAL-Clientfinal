import 'package:flutter/material.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({Key key}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {

  String price;
  String rating;
  double experience = 0;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Search Results",
          style: TextStyle(
            color: Color(midnightBlue),
            fontWeight: FontWeight.w600,
          ),),
        elevation: 0.0,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_rounded,color: Color(midnightBlue),),
        ),
      ),
      floatingActionButton: Container(
        width: SizeConfig.screenWidth * 0.2,
        height: SizeConfig.blockSizeVertical * 9,
        child: FloatingActionButton(
          child: ImageIcon(AssetImage('assets/icons/sort.png'),
          color: Colors.white,
          size: SizeConfig.blockSizeVertical * 4,),
          backgroundColor: Color(backgroundColorBlue),
          onPressed: (){
            showModalBottomSheet(context: context, builder: (BuildContext context)=> Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight * 0.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                  color: Colors.white,
                  boxShadow: [BoxShadow(
                    color: Colors.grey[200],
                    spreadRadius: 3.0,
                    blurRadius: 5.0,
                    offset: Offset(1,1),
                  )],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 2,
                        horizontal: SizeConfig.screenWidth * 0.4
                    ),
                    alignment: Alignment.center,
                    child: Divider(
                      color: Color(backgroundColorBlue),
                      thickness: 2.0,
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.symmetric(
                      vertical: SizeConfig.blockSizeVertical * 2,
                      horizontal: SizeConfig.screenWidth * 0.05
                    ),
                    child: Text("Sort",
                    style: TextStyle(
                      color: Color(midnightBlue),
                      fontWeight: FontWeight.w600,
                      fontSize: SizeConfig.blockSizeVertical * 3
                    ),),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth * 0.05
                    ),
                    child: Text("Price",
                      style: TextStyle(
                          color: Color(backgroundColorBlue),
                          fontWeight: FontWeight.w600,
                          fontSize: SizeConfig.blockSizeVertical * 1.75
                      ),),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical,
                        horizontal: SizeConfig.screenWidth * 0.05),
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
                      items: <String>['Price 1', 'Price 2', 'Price 3']
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
                        "Sort By Price",
                        style: TextStyle(
                            color: Color(fontColorGray),
                            fontSize: SizeConfig.blockSizeVertical * 1.75,
                            fontWeight: FontWeight.w400),
                      ),
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Color(fontColorGray),
                      ),
                      value: price,
                      onChanged: (value) {
                        setState(() {
                          price = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth * 0.05
                    ),
                    child: Text("Rating",
                      style: TextStyle(
                          color: Color(backgroundColorBlue),
                          fontWeight: FontWeight.w600,
                          fontSize: SizeConfig.blockSizeVertical * 1.75
                      ),),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical,
                        horizontal: SizeConfig.screenWidth * 0.05),
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
                      items: <String>['5', '4', '3','2','1']
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
                        "Sort By Rating",
                        style: TextStyle(
                            color: Color(fontColorGray),
                            fontSize: SizeConfig.blockSizeVertical * 1.75,
                            fontWeight: FontWeight.w400),
                      ),
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Color(fontColorGray),
                      ),
                      value: rating,
                      onChanged: (value) {
                        setState(() {
                          rating = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth * 0.05
                    ),
                    child: Text("Experience",
                      style: TextStyle(
                          color: Color(backgroundColorBlue),
                          fontWeight: FontWeight.w600,
                          fontSize: SizeConfig.blockSizeVertical * 1.75
                      ),),
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbColor: Colors.white,
                      activeTrackColor: Color(backgroundColorBlue),
                      inactiveTrackColor: Color(fontColorGray),
                    ),
                    child: StatefulBuilder(
                      builder: (context, setState){
                        return Slider(
                          min: 0,
                          max: 20,
                          value: experience,
                          divisions: 20,
                          label: experience.round().toString(),
                          onChanged: (value){
                            setState(() {
                              experience = value;
                            });
                          },
                        );
                      }
                    ),
                  ),
                ],
              ),
            ),);
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Container(
            width: SizeConfig.screenWidth,
            margin: EdgeInsets.only(
              left: SizeConfig.screenWidth * 0.05,
              top: SizeConfig.blockSizeVertical,
              bottom: SizeConfig.blockSizeVertical
            ),
            height: SizeConfig.blockSizeVertical * 5,
            child: ListView.builder(itemBuilder: (context,int index){
              return Container(
                decoration: BoxDecoration(
                  color: Color(backgroundColorBlue),
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Text("Anxiety",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600
                    ),),
                    Icon(Icons.clear,color: Colors.white,size: SizeConfig.blockSizeVertical * 2,),
                  ],
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal,
                ),
                padding: EdgeInsets.all(8),
                height: SizeConfig.blockSizeVertical * 2,
              );
            },
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: 10,
            physics: BouncingScrollPhysics(),
            primary: false,),
          ),
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical,
                horizontal: SizeConfig.screenWidth * 0.05
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
                          onPressed: (){},
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
    ));
  }
}
