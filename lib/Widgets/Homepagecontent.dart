import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snack.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sal_user/UI/Articledetail.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:sal_user/data/repo/ExploreLikeUnlikeRepo.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Homecontentwidget extends StatefulWidget{
  var description;
  var image;
  var id;
  var title;
  var bg;
  var url;
  var created_by;
var content;
  Homecontentwidget({this.description,this.image,this.id,this.title,this.created_by,this.bg,this.url,this.content});
  @override
  _HomecontentwidgetState createState() => _HomecontentwidgetState();
}

class _HomecontentwidgetState extends State<Homecontentwidget> {
  RxBool isLike = false.obs;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {

        Get.to(ArticleDetail(
            description: widget.description,
            image: widget.image,
            title: widget.title,
            id: widget.id,
            bg:widget.bg,
            created_by:widget.created_by,
            content:widget.content
        ));
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            width: SizeConfig.screenWidth * 0.4,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: Image.network(widget.url + widget.image).image,
                  fit: BoxFit.cover),
            ),
            child: Container(
              width: SizeConfig.screenWidth,
              padding: EdgeInsets.only(
                  left: SizeConfig.screenWidth * 0.02,
                  right: SizeConfig.screenWidth * 0.02),
              height: SizeConfig.blockSizeVertical * 8,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color:  Color.fromRGBO(42, 138, 163, 0.75),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: GoogleFonts.openSans(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "3m",
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                    ),
                  ),

                ],
              ),
            ),
          ),
          Positioned(
            top:0,
            right: 5,
            child:  Obx(() => IconButton(
              onPressed: () async {
                SharedPreferences prefs =
                await SharedPreferences.getInstance();
                if (prefs.getString("cleintid") == null) {
                  Get.showSnackbar(GetBar(
                    message: 'Please First Login',
                    duration: Duration(seconds: 2),
                  ));
                  return;
                }
                String response;

                if (isLike.value) {
                  response =
                  await ExploreLikeUnlikeRepo.exploreUnLike(
                      widget.id);
                } else {
                  response =
                  await ExploreLikeUnlikeRepo.exploreLike(
                      widget.id);
                }
                if (response != null) {
                  Get.showSnackbar(GetBar(
                    message: response,
                    duration: Duration(seconds: 2),
                  ));
                } else {
                  isLike.toggle();
                }
              },
              icon: Icon(
                isLike.value
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: isLike.value ? Colors.red : Colors.white,
              ),
            )),
          )
        ],
      ),
    );
  }
}