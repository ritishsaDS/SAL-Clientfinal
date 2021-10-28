import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sal_user/UI/Articledetail.dart';
import 'package:sal_user/UI/SeeMoreExploreList.dart';
import 'package:sal_user/UI/Audioplayer.dart';
import 'package:sal_user/UI/likedExploreList.dart';
import 'package:sal_user/UI/videoplayer.dart';
import 'package:sal_user/Utils/Colors.dart';
import 'package:sal_user/Utils/NavigationBar.dart';
import 'package:sal_user/Utils/SizeConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sal_user/models/get_contents_response_model.dart';

class ExploreAll extends StatefulWidget {
  @override
  _ExploreAllState createState() => _ExploreAllState();
}

class _ExploreAllState extends State<ExploreAll> {
  List<String> categories = ['All', 'Liked', 'Anxiety', 'Sleep', 'Anger'];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        index: 2,
      ),
      body: SafeArea(
        child: Column(
          children: [
            upperHeader(),
            Expanded(
                child: selectedIndex == 0
                    ? AllContents()
                    : selectedIndex == 1
                        ? LikedExploreList()
                        : Center(
                            child: Text('Pending from api side'),
                          ))
          ],
        ),
      ),
    );
  }

  Container upperHeader() {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.blockSizeVertical * 5,
      margin: EdgeInsets.symmetric(
          vertical: SizeConfig.blockSizeVertical * 2,
          horizontal: SizeConfig.screenWidth * 0.02),
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              alignment: Alignment.center,
              height: SizeConfig.blockSizeVertical * 4,
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal * 4,
                  vertical: SizeConfig.blockSizeVertical),
              decoration: BoxDecoration(
                  color: selectedIndex != null && selectedIndex == index
                      ? Color(0xff0066B3)
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 3,
                  left: SizeConfig.blockSizeHorizontal),
              child: Text(
                categories[index],
                style: GoogleFonts.openSans(
                    color: selectedIndex != null && selectedIndex == index
                        ? Colors.white
                        : Color(fontColorSteelGrey)),
              ),
            ),
          );
        },
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        primary: false,
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
      ),
    );
  }
}

class AllContents extends StatefulWidget {
  @override
  _AllContentsState createState() => _AllContentsState();
}

class _AllContentsState extends State<AllContents> {
  @override
  void initState() {
    super.initState();
  }

  String imgBasePath = "https://sal-prod.s3.ap-south-1.amazonaws.com/";

  Future<GetContentsResponseModel> getAllContents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString("cleintid");
    try {
      String url =
          "https://yvsdncrpod.execute-api.ap-south-1.amazonaws.com/prod/content?user_id=$userId&category_id=3";

      print('CLIENT ID:${prefs.getString("cleintid")}');
      print('URL:$url');

      http.Response response = await http.get(url);
      print('satus code :${response.statusCode}');
      print('body:${response.body}');
      if (response.statusCode == 200) {
        return getContentsResponseModelFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GetContentsResponseModel>(
        future: getAllContents(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Server Error'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data == null) {
            return Center(
              child: Text('Server Error'),
            );
          }
          GetContentsResponseModel result = snapshot.data;
          return SizedBox(
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'POPULAR AUDIOS',
                      style: TextStyle(
                          color: Color(0xff77849C),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 140,
                      width: Get.width,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                            result.audios.length + 1,
                            (index) => index == result.audios.length
                                ? GestureDetector(
                                    onTap: () {
                                      Get.to(SeeMoreExplore(
                                        dataList: result.audios,
                                        extension: 'Audio',
                                      ));
                                    },
                                    child: seeMoreContainer(
                                        result.audios[index - 1]))
                                : GestureDetector(
                                    onTap: () {
                                      Get.to(PlayerPage(
                                        data: result.audios[index],
                                      ));
                                    },
                                    child: containerBox(result.audios[index]))),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'POPULAR VIDEO',
                      style: TextStyle(
                          color: Color(0xff77849C),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 140,
                      width: Get.width,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                            result.videos.length + 1,
                            (index) => index == result.videos.length
                                ? GestureDetector(
                                    onTap: () {
                                      Get.to(SeeMoreExplore(
                                        dataList: result.videos,
                                        extension: 'Video',
                                      ));
                                    },
                                    child: seeMoreContainer(
                                        result.videos[index - 1]))
                                : GestureDetector(
                                    onTap: () {
                                      Get.to(ButterFlyAssetVideo(
                                        data: result.videos[index],
                                      ));
                                    },
                                    child: containerBox(result.videos[index]))),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'POPULAR ARTICLES',
                      style: TextStyle(
                          color: Color(0xff77849C),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 140,
                      width: Get.width,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                            result.articles.length + 1,
                            (index) => index == result.articles.length
                                ? GestureDetector(
                                    onTap: () {
                                      Get.to(SeeMoreExplore(
                                        dataList: result.articles,
                                        extension: 'Articles',
                                      ));
                                    },
                                    child: seeMoreContainer(
                                        result.articles[index - 1]))
                                : GestureDetector(
                                    onTap: () {
                                      Get.to(ArticleDetail(
                                        title: result.articles[index].title,
                                        description: result.articles[index].description,
                                        id: result.articles[index].id,
                                        image: result.articles[index].photo,
                                      ));
                                    },
                                    child:
                                        containerBox(result.articles[index]))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Container containerBox(ContentsArticle e) {
    return Container(
      height: 140,
      width: 190,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: NetworkImage(imgBasePath + e.photo), fit: BoxFit.fill)),
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 50,
        width: 190,
        decoration: BoxDecoration(
            color: Colors.black38,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        padding: EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.centerLeft,
        child: Text(
          '${e.title ?? ''}',
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }

  Container seeMoreContainer(ContentsArticle e) {
    return Container(
      width: SizeConfig.screenWidth * 0.45,
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xff0066B3).withOpacity(0.5),
        image: DecorationImage(
            image: NetworkImage(imgBasePath + e.photo), fit: BoxFit.fill),
      ),
      child: Container(
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.only(
            left: SizeConfig.screenWidth * 0.02,
            right: SizeConfig.screenWidth * 0.02),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          'SEE MORE',
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sal_user/Utils/AlertDialog.dart';
// import 'package:sal_user/Utils/Colors.dart';
// import 'package:sal_user/Utils/DrawerMenu.dart';
// import 'package:sal_user/Utils/NavigationBar.dart';
// import 'package:sal_user/Utils/SharedPref.dart';
// import 'package:sal_user/Utils/SizeConfig.dart';
//
// import 'package:sal_user/models/ExploreAllrepo.dart';
//
// import 'package:sal_user/models/Exploreallmodle.dart';
// import 'package:sal_user/UI/videoplayer.dart';
// import 'package:sal_user/UI/likedExploreList.dart';
// import 'package:sal_user/UI/Audioplayer.dart';
// import 'package:sal_user/UI/Articledetail.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sal_user/Widgets/ExploreWidgets.dart';
//
// class ExploreAll extends StatefulWidget {
//   const ExploreAll({Key key}) : super(key: key);
//
//   @override
//   _ExploreAllState createState() => _ExploreAllState();
// }
//
// class _ExploreAllState extends State<ExploreAll> {
//   List<String> categories = ['All', 'Liked', 'Anxiety', 'Sleep', 'Anger'];
//
//   List<String> images = [
//     'assets/bg/gridCard1.png',
//     'assets/bg/gridCard2.png',
//     'assets/bg/gridCard1.png',
//     'assets/bg/gridCard4.png',
//     'assets/bg/gridCard4.png',
//     'assets/bg/gridCard4.png'
//   ];
//
//   List<String> imagesVideos = [
//     'https://wallpaperaccess.com/full/170249.jpg',
//     'https://wallpapercave.com/wp/wp2005597.jpg',
//     'https://wallpaperaccess.com/full/16082.jpg',
//     'https://wallpaperaccess.com/full/170249.jpg',
//     'https://wallpapercave.com/wp/wp2005597.jpg'
//   ];
//   var getHomeContent = Explorerepo();
//   var getHomeContentModal = ExploreallModel();
//   List<String> imagesArticles = [
//     'https://cdn.wallpapersafari.com/63/25/ME53bd.jpg',
//     'https://i.pinimg.com/originals/fd/79/fd/fd79fd5d1d23c08762112a4bb8618cee.jpg',
//     'https://wallpaperaccess.com/full/1687326.jpg',
//     'https://c4.wallpaperflare.com/wallpaper/716/258/567/golden-sky-landscape-wallpapers-path-rocky-mountains-forest-banff-national-park-alberta-canadian-1920%C3%971200-wallpaper-preview.jpg',
//     'https://wallpaperbat.com/img/448570-pink-mountains-wallpaper-top-free-pink-mountains-background.jpg'
//   ];
//
//   List<Color> colors = [
//     Color.fromRGBO(42, 138, 163, 0.75),
//     Color.fromRGBO(48, 37, 33, 0.75),
//     Color.fromRGBO(42, 138, 163, 0.75),
//     Color.fromRGBO(0, 90, 100, 0.75),
//     Color.fromRGBO(0, 90, 100, 0.75),
//     Color.fromRGBO(0, 90, 100, 0.75)
//   ];
//
//   List<String> desc = [
//     "How to have a\npeaceful mind",
//     "Worlds of the\nwaterfall",
//     "How to have a\npeaceful mind",
//     "Worlds of the\nwaterfall",
//     "Worlds of the\nwaterfall",
//     "Worlds of the\nwaterfall"
//   ];
//   var therapistId;
//   int selectedIndex = 0;
//   List audio = [];
//   List video = [];
//   List article = [];
//
//   // AudioCache audioCache = AudioCache();
//   // AudioPlayer advancedPlayer = AudioPlayer();
//   onSelected(int index) {
//     setState(() {
//       selectedIndex = index;
//     });
//   }
//
//   bool isloding = false;
//
//   @override
//   void initState() {
//     getTherapistId();
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return SafeArea(
//         child: Scaffold(
//       // drawer: DrawerMenu(),
//       bottomNavigationBar: NavigationBar(
//         index: 2,
//       ),
//       body: SingleChildScrollView(
//         physics: BouncingScrollPhysics(),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: SizeConfig.screenWidth,
//               height: SizeConfig.blockSizeVertical * 5,
//               margin: EdgeInsets.symmetric(
//                   vertical: SizeConfig.blockSizeVertical * 2,
//                   horizontal: SizeConfig.screenWidth * 0.02),
//               child: ListView.builder(
//                 itemBuilder: (BuildContext context, int index) {
//                   return InkWell(
//                     onTap: () {
//                       onSelected(index);
//                     },
//                     child: Container(
//                       alignment: Alignment.center,
//                       height: SizeConfig.blockSizeVertical * 4,
//                       padding: EdgeInsets.symmetric(
//                           horizontal: SizeConfig.blockSizeHorizontal * 4,
//                           vertical: SizeConfig.blockSizeVertical),
//                       decoration: BoxDecoration(
//                           color: selectedIndex != null && selectedIndex == index
//                               ? Colors.blue
//                               : Colors.grey[200],
//                           borderRadius: BorderRadius.circular(20)),
//                       margin: EdgeInsets.only(
//                           right: SizeConfig.blockSizeHorizontal * 3,
//                           left: SizeConfig.blockSizeHorizontal),
//                       child: Text(
//                         categories[index],
//                         style: GoogleFonts.openSans(
//                             color:
//                                 selectedIndex != null && selectedIndex == index
//                                     ? Colors.white
//                                     : Color(fontColorSteelGrey)),
//                       ),
//                     ),
//                   );
//                 },
//                 physics: BouncingScrollPhysics(),
//                 shrinkWrap: true,
//                 primary: false,
//                 scrollDirection: Axis.horizontal,
//                 itemCount: categories.length,
//               ),
//             ),
//             selectedIndex == 1 ? LikedExploreList() : selectedIndex==0?allData():Center(
//               child: Padding(
//                 padding: EdgeInsets.only(top: Get.height / 3),
//                 child: Text('Not data found'),
//               ),
//             )
//           ],
//         ),
//       ),
//     ));
//   }
//
//   Column allData() {
//     return Column(
//       children: [
//         popularVideoText(),
//         Container(
//             margin: EdgeInsets.symmetric(
//                 horizontal: SizeConfig.screenWidth * 0.02,
//                 vertical: SizeConfig.blockSizeVertical),
//             width: SizeConfig.screenWidth,
//             height: SizeConfig.screenHeight * 0.2,
//             child: ListView(
//               scrollDirection: Axis.horizontal,
//               children: getAuidos(),
//             )),
//         popularAudioText(),
//         Container(
//             margin: EdgeInsets.symmetric(
//                 horizontal: SizeConfig.screenWidth * 0.02,
//                 vertical: SizeConfig.blockSizeVertical),
//             width: SizeConfig.screenWidth,
//             height: SizeConfig.screenHeight * 0.2,
//             child: ListView(
//               scrollDirection: Axis.horizontal,
//               children: getvideo(),
//             )),
//         popularArticles(),
//         Container(
//             margin: EdgeInsets.symmetric(
//                 horizontal: SizeConfig.screenWidth * 0.02,
//                 vertical: SizeConfig.blockSizeVertical),
//             width: SizeConfig.screenWidth,
//             height: SizeConfig.screenHeight * 0.2,
//             child: ListView(
//               scrollDirection: Axis.horizontal,
//               children: getArticle(),
//             )),
//       ],
//     );
//   }
//
//   getTherapistId() async {
//     // SharedPreferences prefs= await SharedPreferences.getInstance();
//
//     //print("sdvvs"+prefs.getString("therapistid"));
//     // setState(() {
//     //   therapistId=prefs.getString("therapistid");
//     // });
//     getHomeContent
//         .avialabilityRepo(context: context, therapistId: "wppk5")
//         .then((value) {
//       if (value != null) {
//         print(value.meta.status);
//         if (value.meta.status == "200") {
//           setState(() {
//             isloding = false;
//             getHomeContentModal = value;
//             for (int i = 0; i < getHomeContentModal.training.length; i++) {
//               print(getHomeContentModal.training[i].type);
//               if (getHomeContentModal.training[i].type == "1") {
//                 print("audio");
//                 audio.add(getHomeContentModal.training[i]);
//                 print(audio);
//               } else if (getHomeContentModal.training[i].type == "2") {
//                 video.add(getHomeContentModal.training[i]);
//                 print(video);
//               } else {
//                 article.add(getHomeContentModal.training[i]);
//               }
//             }
//           });
//         } else {
//           setState(() {
//             isloding = false;
//           });
//           showAlertDialog(
//             context,
//             value.meta.message,
//             "",
//           );
//         }
//       } else {
//         setState(() {
//           isloding = false;
//         });
//         print(value.meta.status);
//         showAlertDialog(
//           context,
//           value.meta.message,
//           "",
//         );
//       }
//     }).catchError((error) {
//       setState(() {
//         isloding = false;
//       });
//       showAlertDialog(
//         context,
//         error.toString(),
//         "",
//       );
//     });
//   }
//
//   List<Widget> getAuidos() {
//     List<Widget> productList = new List();
//
//     for (int i = 0; i < audio.length; i++) {
//       productList.add(GestureDetector(
//           onTap: () {
//             var url = "https://sal-prod.s3.ap-south-1.amazonaws.com/" +
//                 "${audio[i].content}";
//             print(url);
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => ButterFlyAssetVideo(data: audio[i])));
//           },
//           child: Container(
//             width: SizeConfig.screenWidth * 0.45,
//             alignment: Alignment.bottomCenter,
//             margin:
//                 EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.02),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               image: DecorationImage(
//                   image: NetworkImage(
//                       "https://sal-prod.s3.ap-south-1.amazonaws.com/" +
//                           audio[i].photo),
//                   fit: BoxFit.fitWidth),
//             ),
//             child: Container(
//               width: SizeConfig.screenWidth,
//               padding: EdgeInsets.only(
//                   left: SizeConfig.screenWidth * 0.02,
//                   right: SizeConfig.screenWidth * 0.02),
//               height: SizeConfig.blockSizeVertical * 8,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                   color: colors[i],
//                   borderRadius: BorderRadius.only(
//                       bottomRight: Radius.circular(20),
//                       bottomLeft: Radius.circular(20))),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     audio[i].title,
//                     style: GoogleFonts.openSans(
//                         color: Colors.white, fontWeight: FontWeight.w600),
//                   ),
//                   Text(
//                     "3m",
//                     style: GoogleFonts.openSans(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )));
//     }
//     return productList;
//   }
//
//   List<Widget> getvideo() {
//     List<Widget> productList = new List();
//
//     for (int i = 0; i < video.length; i++) {
//       productList.add(GestureDetector(
//           onTap: () {
//             // var url="https://sal-prod.s3.ap-south-1.amazonaws.com/"+"${video[i].content}";
//             // print(url);
//             print('type:${video[i]}');
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => PlayerPage(
//                           data: video[i],
//                         )));
//
//             //   name:dishfromserver[i]['name'],
//             //   chefname: dishfromserver[i]["chef_name"]['full_name'].toString(),
//             //   price: dishfromserver[i]['price'],
//             //   image: dishfromserver[i]['image'],
//             //   time:dishfromserver[i]['time_taken'],
//             // ) ));
//           },
//           child: Container(
//             width: SizeConfig.screenWidth * 0.45,
//             alignment: Alignment.bottomCenter,
//             margin:
//                 EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.02),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               image: DecorationImage(
//                   image: NetworkImage(
//                       "https://sal-prod.s3.ap-south-1.amazonaws.com/" +
//                           video[i].photo),
//                   fit: BoxFit.fitWidth),
//             ),
//             child: Container(
//               width: SizeConfig.screenWidth,
//               padding: EdgeInsets.only(
//                   left: SizeConfig.screenWidth * 0.02,
//                   right: SizeConfig.screenWidth * 0.02),
//               height: SizeConfig.blockSizeVertical * 8,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                   color: colors[i],
//                   borderRadius: BorderRadius.only(
//                       bottomRight: Radius.circular(20),
//                       bottomLeft: Radius.circular(20))),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     video[i].title,
//                     style: GoogleFonts.openSans(
//                         color: Colors.white, fontWeight: FontWeight.w600),
//                   ),
//                   Text(
//                     "3m",
//                     style: GoogleFonts.openSans(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )));
//     }
//     return productList;
//   }
//
//   List<Widget> getArticle() {
//     List<Widget> productList = new List();
//
//     for (int i = 0; i < article.length; i++) {
//       productList.add(GestureDetector(
//           onTap: () {
//             print(article[i].content);
//             Training data = article[i];
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => ArticleDetail(
//                           title: data.title,
//                           image: data.photo,
//                           id: data.id,
//                           description: data.description,
//                         )));
//             //   name:dishfromserver[i]['name'],
//             //   chefname: dishfromserver[i]["chef_name"]['full_name'].toString(),
//             //   price: dishfromserver[i]['price'],
//             //   image: dishfromserver[i]['image'],
//             //   time:dishfromserver[i]['time_taken'],
//             // ) ));
//           },
//           child: Container(
//             width: SizeConfig.screenWidth * 0.45,
//             alignment: Alignment.bottomCenter,
//             margin:
//                 EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.02),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               image: DecorationImage(
//                   image: NetworkImage(
//                       "https://sal-prod.s3.ap-south-1.amazonaws.com/" +
//                           article[i].photo),
//                   fit: BoxFit.fitWidth),
//             ),
//             child: Container(
//               width: SizeConfig.screenWidth,
//               padding: EdgeInsets.only(
//                   left: SizeConfig.screenWidth * 0.02,
//                   right: SizeConfig.screenWidth * 0.02),
//               height: SizeConfig.blockSizeVertical * 8,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                   color: colors[i],
//                   borderRadius: BorderRadius.only(
//                       bottomRight: Radius.circular(20),
//                       bottomLeft: Radius.circular(20))),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     article[i].title,
//                     style: GoogleFonts.openSans(
//                         color: Colors.white, fontWeight: FontWeight.w600),
//                   ),
//                   Text(
//                     "3m",
//                     style: GoogleFonts.openSans(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )));
//     }
//     return productList;
//   }
// }
