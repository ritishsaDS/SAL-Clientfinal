import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sal_user/models/Exploreallmodle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerPage extends StatefulWidget {
  final Training data;

  const PlayerPage({Key key, this.data}) : super(key: key);

  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> with TickerProviderStateMixin {
  Training data;
  String basePath = 'https://sal-prod.s3.ap-south-1.amazonaws.com/';
  Size size;

  final audioPlayer = AudioPlayer();

  AudioPlayerController _playerController = Get.put(AudioPlayerController());

  void initState() {
    super.initState();
    _playerController.setCompleteDuration(0);

    _playerController.setTotalDuration(100);
    data = widget.data;

    playAudio();
  }

  Future<void> playAudio() async {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    print('ClientId:${preferences.getString('cleintid')}');
    Duration duration = await audioPlayer.setUrl(
      basePath + data.content,
    );
    audioPlayer.play();

    _playerController.setIsPlay(true);

    _playerController.setTotalDuration(duration.inSeconds);

    audioPlayer.createPositionStream().listen((event) {
      _playerController.setCompleteDuration(event.inSeconds);

      if (event.inSeconds>=duration.inSeconds) {
        if(_playerController.isRepeat.value){
          audioPlayer.seek(Duration());
          return;
        }
        _playerController.setIsPlay(false);
      }
    });
  }

  @override
  void dispose() {
    audioPlayer?.stop();
    audioPlayer?.dispose();

    super.dispose();
  }

  Duration convertIntToDuration(int value) {
    int second = (value % 60).floor();
    int minute = (value / 60).floor();
    int hour = (minute / 60).floor();
    return Duration(hours: hour, minutes: minute, seconds: second);
  }

  String convertDurationString(int value) {
    int second = (value % 60).floor();
    int minute = (value / 60).floor();
    int hours = (minute / 60).floor();
    if (hours == 0) {
      return set0Value(minute) + ':' + set0Value(second);
    } else {
      return set0Value(hours) +
          ':' +
          set0Value(minute) +
          ':' +
          set0Value(second);
    }
  }

  String set0Value(int value) {
    if (value < 10) {
      return '0$value';
    } else {
      return value.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Material(
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Image(
              image: NetworkImage(basePath + data.photo),
              fit: BoxFit.cover,
              height: size.height,
              width: size.width,
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: size.width,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            data?.title ?? '',
                            style: TextStyle(color: Colors.white, fontSize: 28),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GetBuilder<AudioPlayerController>(
                          builder: (controller) {
                            return IconButton(
                              onPressed: () {
                                _playerController.setIsLikeStatus();
                              },
                              icon: Icon(
                                controller.isLikeStatus.value
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: controller.isLikeStatus.value
                                    ? Colors.red
                                    : Colors.white,
                              ),
                            );
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GetBuilder<AudioPlayerController>(
                      builder: (controller) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Slider(
                              activeColor: Colors.white,
                              inactiveColor: Colors.grey,
                              value:
                                  controller.completeDuration.value.toDouble(),
                              min: 0,
                              max: controller.totalDuration.value.toDouble(),
                              onChanged: (value) {
                                audioPlayer
                                    .seek(convertIntToDuration(value.floor()));
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    '${convertDurationString(controller.completeDuration.value)}'),
                                Text(
                                    '${convertDurationString(controller.totalDuration.value)}'),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: GetBuilder<AudioPlayerController>(
                          builder: (controller) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                                onTap: () {
                                  // _playerController.setIsPlay(true);
                                  //
                                  // audioPlayer.seek(Duration());
                                  _playerController.setIsRepeat();
                                },
                                child: Image(
                                    image:
                                        AssetImage('assets/icons/Repeat.png'),
                                  color: controller.isRepeat.value?Colors.yellow[800]:Colors.white,
                                )),
                            InkWell(
                                onTap: () {
                                  int duration =
                                      controller.completeDuration.value;
                                  int updateDue = duration - 10;
                                  if (updateDue < 0) {
                                    audioPlayer.seek(Duration());
                                    return;
                                  }
                                  audioPlayer
                                      .seek(convertIntToDuration(updateDue));
                                },
                                child: Image(
                                    image: AssetImage(
                                        'assets/icons/backword.png'))),
                            InkWell(
                                onTap: () {
                                  if (controller.isPlay.value) {
                                    audioPlayer.pause();
                                  } else {
                                    if (controller.completeDuration.value >=
                                        controller.totalDuration.value) {
                                      audioPlayer.seek(Duration());
                                      _playerController.setIsPlay(true);
                                      return;
                                    }
                                    audioPlayer.play();
                                  }
                                  _playerController
                                      .setIsPlay(!controller.isPlay.value);
                                },
                                child: Image(
                                    image: AssetImage(
                                        'assets/icons/${controller.isPlay.value ? "Pause.png" : "Play.png"}'))),
                            InkWell(
                                onTap: () {
                                  int duration =
                                      controller.completeDuration.value;
                                  int updateDue = duration + 10;
                                  if (updateDue >
                                      controller.totalDuration.value) {
                                    audioPlayer.seek(convertIntToDuration(
                                        controller.totalDuration.value));
                                    _playerController.setIsPlay(false);
                                    return;
                                  }

                                  audioPlayer
                                      .seek(convertIntToDuration(updateDue));
                                },
                                child: Image(
                                    image: AssetImage(
                                        'assets/icons/forword.png'))),
                            Opacity(
                              opacity: 0.6,
                              child: InkWell(
                                  onTap: () {},
                                  child: Image(
                                      image: AssetImage(
                                          'assets/icons/Shuffle.png'))),
                            ),
                          ],
                        );
                      }),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
/*@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Color(0XFFD8DFE9),
        elevation: 0.0,
        leading: InkWell(
          onTap:(){
            audioPlayer.stop();
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: Color(midnightBlue),
          ),
        ),
        centerTitle: true,
        title: Text("Audio",
          style: TextStyle(
              color: Color(midnightBlue),
              fontWeight: FontWeight.w600
          ),),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100.withOpacity(0.55),

        ),
        child: Container(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              width: (MediaQuery.of(context).size.width),
              height: (MediaQuery.of(context).size.height),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ClipOval(
                      child: Image(
                        image: AssetImage("assets/bg/Frame.png"),
                        width: (MediaQuery.of(context).size.width) - 200,
                        height: (MediaQuery.of(context).size.width) - 200,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Slider(
                      activeColor: Colors.white,
                      inactiveColor: Colors.grey,
                      value: _position.inMilliseconds.toDouble(),
                      max: _duration.inMilliseconds.toDouble() + 2,
                      onChanged: (double value) {
                        print('value:$value');




                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.navigate_before,
                          size: 55,
                          color: Colors.red,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(
                                  () {
                                if (!issongplaying) {

                                 audioPlayer.play('https://sal-prod.s3.ap-south-1.amazonaws.com/${widget.data.content}');
                                } else {
                                  audioPlayer.pause();
                                }
                                issongplaying
                                    ? _animationIconController1.reverse()
                                    : _animationIconController1.forward();
                                issongplaying = !issongplaying;
                              },
                            );
                          },
                          child: ClipOval(
                            child: Container(
                              color: Colors.pink[600],
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AnimatedIcon(
                                  icon: AnimatedIcons.play_pause,
                                  size: 55,
                                  progress: _animationIconController1,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.navigate_next,
                          size: 55,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }*/
}

class AudioPlayerController extends GetxController {
  RxBool _isRepeat=false.obs;

  RxBool get isRepeat => _isRepeat;

  void setIsRepeat() {
    _isRepeat.toggle();
    update();
  }

  RxBool _isLikeStatus = false.obs;

  RxBool get isLikeStatus => _isLikeStatus;

  void setIsLikeStatus() {
    _isLikeStatus.toggle();
    update();
  }

  RxBool _isPlay = false.obs;

  RxBool get isPlay => _isPlay;

  void setIsPlay(bool value) {
    _isPlay = value.obs;
    update();
  }

  RxInt _totalDuration = 100.obs;
  RxInt _completeDuration = 0.obs;

  RxInt get totalDuration => _totalDuration;

  void setTotalDuration(int value) {
    _totalDuration = value.obs;
    update();
  }

  RxInt get completeDuration => _completeDuration;

  void setCompleteDuration(int value) {
    _completeDuration = value.obs;
    update();
  }
}
