import 'dart:io';
import 'package:CityScoop/app/components/utilities.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideoPreview extends StatefulWidget {
  final File videoFile;
  final VideoPlayerController controller;
  final VoidCallback onSubmit;

  const FullScreenVideoPreview({super.key,
    required this.videoFile,
    required this.controller,
    required this.onSubmit,
  });

  @override
  FullScreenVideoPreviewState createState() => FullScreenVideoPreviewState();
}

class FullScreenVideoPreviewState extends State<FullScreenVideoPreview> {
  bool isPlaying = true;
  StateSetter? fullScreenState;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(checkVideo);
  }

  void togglePlayPause() {
    fullScreenState?.call(() {
      if (widget.controller.value.isPlaying) {
        widget.controller.pause();
        isPlaying = false;
      } else {
        widget.controller.play();
        isPlaying = true;
      }
    });
  }

  void checkVideo() {
    if (widget.controller.value.position == widget.controller.value.duration) {
        fullScreenState?.call(() {
          isPlaying = false;
        });
    } else {
      fullScreenState?.call(() {
        isPlaying = true;
      });
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(checkVideo);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          fullScreenState = setState;
          return Scaffold(
            backgroundColor: Colors.black,
            body: Column(
              children: [
                SizedBox(height: 40),
                Container(
                    padding: EdgeInsets.all(16),
                    color: Colors.white,
                    height: 60,
                    width: Utilities.getDeviceWidth(context),
                    child: Center(child: Text("Choose Video", style: TextStyle(fontSize:22, color: Colors.black, fontWeight: FontWeight.bold)))
                ),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: widget.controller.value.aspectRatio,
                    child: VideoPlayer(widget.controller),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            fullScreenState?.call(() {
                              Navigator.pop(context);
                            });
                          },
                          child: Text('Cancel', style: TextStyle(fontSize: 20, color: Colors.white))
                      ),
                      GestureDetector(
                        onTap: () {
                          fullScreenState?.call(() {
                            togglePlayPause();
                          });
                        },
                        child: Icon(size: 50, color: Colors.white, isPlaying ? Icons.pause : Icons.play_arrow),
                      ),
                      GestureDetector(
                          onTap: () {
                            fullScreenState?.call(() {
                              widget.controller.pause();
                              widget.onSubmit();
                              Navigator.pop(context);
                            });
                          },
                          child: Text('Choose', style: TextStyle(fontSize: 20, color: Colors.white))
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}