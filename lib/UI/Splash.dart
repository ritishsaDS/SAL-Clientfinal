import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'OnBoardScreens.dart';
import 'mood.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  VideoPlayerController _controller;

  @override
    void initState(){
    videoplay();

      // TODO: implement initState
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        child:  SizedBox.expand(
          child: FittedBox(
            // If your background video doesn't look right, try changing the BoxFit property.
            // BoxFit.fill created the look I was going for.
            fit: BoxFit.fill,
            child: SizedBox(
              width: _controller.value.size?.width ?? 0,
              height: _controller.value.size?.height ?? 0,
              child: VideoPlayer(_controller),
            ),
          ),
        ),
      ),
    );
  }
  void videoplay(){

      _controller = VideoPlayerController.asset('assets/splashvideo.mp4')
        ..initialize().then((_) {
          // Once the video has been loaded we play the video and set looping to true.
          _controller.play();
          _controller.setLooping(true);
          _controller.setVolume(0.0);
          _controller.play();
          // Ensure the first frame is shown after the video is initialized.
          setState(() {});
        });
      Timer(Duration(seconds: 10),
              ()=>Navigator.pushReplacement(context,
              MaterialPageRoute(builder:
                  (context) =>
                  DTWalkThoughScreen()
              )
          )
      );
  }
}
