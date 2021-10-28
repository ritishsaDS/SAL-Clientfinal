import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sal_user/UI/Splash1.dart';
import 'package:sal_user/Utils/SizeConfig.dart';

import 'components/calanderSceeenWidget.dart';

class CalanderScreen extends StatefulWidget {
  @override
  _CalanderScreenState createState() => _CalanderScreenState();
}

class _CalanderScreenState extends State<CalanderScreen> {
  MoodController controller = Get.put(MoodController());

  @override
  void initState() {
    super.initState();
    controller.setInitialIsDay();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.back();
            },
          ),
          actions: [
            GetBuilder<MoodController>(
              builder: (con) {
                return Center(
                    child: GestureDetector(
                  onTap: () {
                    controller.setIsDay();
                  },
                  child: Container(
                      padding: EdgeInsets.only(right: 10),
                      child: Text(
                        con.isDay.value ? "Day" : 'Month',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.w700),
                      )),
                ));
              },
            )
          ],
          title: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Splash1()));
              },
              child: Text(
                "Mood Diary",
                style: TextStyle(color: Colors.black, fontSize: 22),
              )),
        ),
        body: CalanderScreenWidget(),
      ),
    );
  }
}

class MoodController extends GetxController {
  RxBool _isDay = true.obs;

  RxBool get isDay => _isDay;

  void setIsDay() {
    _isDay.toggle();
    update();
  }
  void setInitialIsDay(){
    _isDay=true.obs;
    update();
  }
}
