import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:sal_user/models/Exploreallmodle.dart';
import 'package:sal_user/models/forYouResponseModel.dart';
import 'package:sal_user/data/repo/ExploreLikeUnlikeRepo.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:sal_user/UI/AddNewEvent.dart';

class ArticleDetail extends StatefulWidget {
  final String id;
  final String title;
  final String image;
  final String description;



  const ArticleDetail(
      {Key key, this.id, this.title, this.image, this.description})
      : super(key: key);

  @override
  _EventSummaryState createState() => _EventSummaryState();
}

class _EventSummaryState extends State<ArticleDetail> {
  String basePath = "https://sal-prod.s3.ap-south-1.amazonaws.com/";

  RxBool isLike = false.obs;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Material(
      child: Column(
        children: [
          Container(
            height: Get.height / 2,
            color: Color(0xffD8DFE9),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                      ),
                    ),
                    Obx(() => IconButton(
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
                        ))
                  ],
                ),
                Spacer(),
                Text(
                  widget.title ?? 'N/A',
                  style: TextStyle(fontSize: 22, color: Color(0xff445066)),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: Color(0xffFAFAFA),
                      backgroundImage: NetworkImage(
                        basePath + widget.image,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'N/A',
                      style: TextStyle(fontSize: 14, color: Color(0xff445066)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SingleChildScrollView(
                  child: Text(
                widget.description,
                style: TextStyle(color: Color(0xff77849C), fontSize: 14),
              )),
            ),
          )
        ],
      ),
    ));
  }
}
