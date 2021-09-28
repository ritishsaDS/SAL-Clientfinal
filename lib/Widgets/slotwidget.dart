import 'package:flutter/material.dart';
import 'package:sal_user/Utils/SizeConfig.dart';

class Slotwidget extends StatefulWidget{
  dynamic val;
  Slotwidget({this.val});
  @override
  _SlotwidgetState createState() => _SlotwidgetState();
}

class _SlotwidgetState extends State<Slotwidget> {
  int _selectedIndex = 0;
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
  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: (){
       setState(() {
         _selectedIndex=int.parse(widget.val);
       });
      },
      child: Container(
        width: SizeConfig.screenWidth * 0.2,
        padding:EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color:_selectedIndex != null && _selectedIndex == int.parse(widget.val)
                ? Colors.blue
                : Colors.grey,
          ),
        ),
        child: Text(moodstatic[int.parse(widget.val)].toString()),
        alignment: Alignment.center,
      ),
    );
  }
}