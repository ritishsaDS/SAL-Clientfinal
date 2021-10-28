import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sal_user/UI/CafeEvents.dart';
import 'package:sal_user/UI/Connect.dart';
import 'package:sal_user/UI/Exploreall.dart';
import 'package:sal_user/UI/Home.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'Colors.dart';

class NavigationBar extends StatefulWidget {
  int index;

  NavigationBar({Key key, this.index}) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      showUnselectedLabels: true,
      currentIndex: widget.index,
      unselectedItemColor: Color(fontColorGray),
      selectedLabelStyle: GoogleFonts.openSans(
        color: Color(backgroundColorBlue),
      ),
      unselectedLabelStyle: GoogleFonts.openSans(color: Color(fontColorGray)),
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          widget.index = index;
        });
        print('INDEX :$index');
        if (index == 0) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeMain()));
        } else if (index == 1) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Connect();
          }));
        } else if (index == 2) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ExploreAll();
          }));
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CafeEvents()));
        }
      },
      items: [
        BottomNavigationBarItem(
            icon: Container(
              child: Image.asset(
                'assets/icons/nav home.png',
                color: widget.index == 0 ? Colors.white : Color(fontColorGray),
                scale: SizeConfig.blockSizeVertical * 0.4,
              ),
              decoration: BoxDecoration(
                  color: widget.index == 0
                      ? Color(backgroundColorBlue)
                      : Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.all(SizeConfig.blockSizeVertical),
            ),
            label: "Home"),
        BottomNavigationBarItem(
            icon: Container(
              child: Image.asset(
                'assets/icons/nav booking.png',
                color: widget.index == 1 ? Colors.white : Color(fontColorGray),
                scale: SizeConfig.blockSizeVertical * 0.4,
              ),
              decoration: BoxDecoration(
                  color: widget.index == 1
                      ? Color(backgroundColorBlue)
                      : Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.all(SizeConfig.blockSizeVertical),
            ),
            label: "Connect"),
        BottomNavigationBarItem(
          icon: Container(
            child: Image.asset(
              'assets/icons/nav explore.png',
              scale: SizeConfig.blockSizeVertical * 0.4,
              color: widget.index == 2 ? Colors.white : Color(fontColorGray),
            ),
            decoration: BoxDecoration(
                color: widget.index == 2
                    ? Color(backgroundColorBlue)
                    : Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5)),
            padding: EdgeInsets.all(SizeConfig.blockSizeVertical),
          ),
          label: "Explore",
        ),
        BottomNavigationBarItem(
            icon: Container(
              child: Image.asset(
                'assets/icons/nav cafe.png',
                scale: SizeConfig.blockSizeVertical * 0.4,
                color: widget.index == 3 ? Colors.white : Color(fontColorGray),
              ),
              decoration: BoxDecoration(
                  color: widget.index == 3
                      ? Color(backgroundColorBlue)
                      : Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.all(SizeConfig.blockSizeVertical),
            ),
            label: "Cafe"),
      ],
    );
  }
}
