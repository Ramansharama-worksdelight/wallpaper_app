import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:mobile_wallpaper_app/CategorySelectionScreen.dart';
import 'package:mobile_wallpaper_app/SubscriptionScreen.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:video_player/video_player.dart';
import 'package:intl/intl.dart';
import 'package:gallery_saver/gallery_saver.dart';

// ignore: must_be_immutable
class Selectedcategory extends StatefulWidget {
  bool firstclick = false;

  dynamic imgurl;
  dynamic title;
  dynamic clickindex;

  Selectedcategory(this.imgurl, this.title, this.clickindex);

  //  Homepage({Key? key }) : super(key: key);

  @override
  _Selectedcategory createState() => _Selectedcategory();
}

class _Selectedcategory extends State<Selectedcategory> {
  bool isvisible = true;
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;
  String? _timeString;
  String? _dateStrng;
  // method to save video in gallery_saver
  // void _saveNetworkVideo() async {
  //   String path =
  //       'https://d1jlcges7hs29p.cloudfront.net/live-wallpaper/wallpaper/video/580/1610375167_iphone.mp4';
  //   GallerySaver.saveVideo(path,
  //           albumName:
  //               'data/user/0/com.example.mobile_wallpaper_app/download/1610375167_iphone.mp4')
  //       .then((success) {
  //     setState(() {
  //       print('Video is saved');
  //     });
  //   });
  // }

  // /method to creat a folder in app
  Future<String> createFolder(String wallpapers) async {
    final folderName = wallpapers;
    final path = Directory("storage/emulated/0/$folderName");
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if ((await path.exists())) {
      return path.path;
    } else {
      path.create();
      return path.path;
    }
  }

// method to display  Date and time;
// dio save video
  // Future downloadFile(String url) async {
  //   Dio dio = Dio();

  //   try {
  //     var dir = await getApplicationDocumentsDirectory();
  //     await dio.download(url, "${dir.path}/mywallapaper",
  //         onReceiveProgress: (rec, total) {
  //       print("Rec: $rec , Total: $total");
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  //   print("Download completed");
  // }
// Date methood
  void _getdate() {
    // await _askPermission();
    final String formattedDate =
        DateFormat('EE,dd,MMMM ').format(DateTime.now()).toString();
    _dateStrng = formattedDate;
  }

  String formatDate(DateTime dateTime) {
    return DateFormat('MM/dd/yyyy hh:mm').format(dateTime);
  }

// date time methood
  void _getTime() {
    // await _askPermission();
    final String formattedDateTime =
        DateFormat(' kk:mm  \n EE,dd,MMMM ').format(DateTime.now()).toString();
    _timeString = formattedDateTime;
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('MM/dd/yyyy hh:mm').format(dateTime);
  }

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      'https://d1jlcges7hs29p.cloudfront.net/live-wallpaper/wallpaper/video/580/1610375167_iphone.mp4',
    );

    _initializeVideoPlayerFuture = _controller!.initialize();
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    _dateStrng = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getdate());

    this._getTime();
    super.initState();
    this._getdate();
    {
      if (!_controller!.value.isPlaying) {
        _controller!.play();
      }
    }
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller!.dispose();
    print("controller Dispose");
    super.dispose();
  }

  // _save(url) async {
  //   await _askPermission();
  //   // var response = await Dio().get(
  //   //     'https://d2o2d07mcokwyq.cloudfront.net/app/uploads/2020/09/08145740/Domcake-Dancing-Alien.gif',
  //   //     options: Options(responseType: ResponseType.bytes));
  //   // final result =
  //       // await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
  //       // await ImageGallerySaver.saveFile('https://d2o2d07mcokwyq.cloudfront.net/app/uploads/2020/09/08145740/Domcake-Dancing-Alien.gif');
  //   // print(result['filePath']);
  //   // alertbox(url);

  // }

  // save video to gallery
  // final Dio dio = Dio();
  // bool loading = false;
  // double progress = 0;
  // Future<bool> saveVideo(String url, String fileName) async {
  //   Directory directory;
  //   try {
  //     if (Platform.isAndroid) {
  //       if (await _requestPermission(Permission.storage)) {
  //         directory = (await getExternalStorageDirectory())!;
  //         String newPath = "";
  //         print(directory);
  //         List<String> paths = directory.path.split("/");
  //         for (int x = 1; x < paths.length; x++) {
  //           String folder = paths[x];
  //           if (folder != "Android") {
  //             newPath += "/" + folder;
  //           } else {
  //             break;
  //           }
  //         }
  //         newPath = newPath + "/Mobile wallpaper";
  //         directory = Directory(newPath);
  //       } else {
  //         return false;
  //       }
  //     } else {
  //       if (await _requestPermission(Permission.photos)) {
  //         directory = await getTemporaryDirectory();
  //       } else {
  //         return false;
  //       }
  //     }

  // File saveFile = File(directory.path + "$fileName");

  //     if (!await directory.exists()) {
  //       await directory.create(recursive: true);
  //     }
  //     if (await directory.exists()) {
  //       await dio.download(url, saveFile.path,
  //           onReceiveProgress: (value1, value2) {
  //         setState(() {
  //           progress = value1 / value2;
  //         });
  //       });
  //       if (Platform.isIOS) {
  //         await ImageGallerySaver.saveFile(saveFile.path,
  //             isReturnPathOfIOS: true);
  //       }
  //       return true;
  //     }
  //     return false;
  //   } catch (e) {
  //     print(e);
  //     return false;
  //   }
  // }
//method for permisssion
  // Future<bool> _requestPermission(Permission permission) async {
  //   if (await permission.isGranted) {
  //     return true;
  //   } else {
  //     var result = await permission.request();
  //     if (result == PermissionStatus.granted) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  // downloadFile() async {
  //   setState(() {
  //     loading = true;
  //     progress = 0;
  //   });
  //   bool downloaded = await saveVideo(
  //       "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
  //       "video.mp4");
  //   if (downloaded) {
  //     print("File Downloaded");
  //   } else {
  //     print("Problem Downloading File");
  //   }
  //   setState(() {
  //     loading = false;
  //   });
  // }

  Future<void> setwallpaper(String path, int x) async {
    int location = x == 0
        ? WallpaperManager.HOME_SCREEN
        : x == 1
            ? WallpaperManager.LOCK_SCREEN
            : WallpaperManager.BOTH_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(path);
    await WallpaperManager.setWallpaperFromFile(
        'https://d1jlcges7hs29p.cloudfront.net/live-wallpaper/wallpaper/images/580/1610375167_iphone.jpg',
        location);
    Navigator.of(context);
  }

  void _saveNetworkVideo() async {
    String path =
        'https://d1jlcges7hs29p.cloudfront.net/live-wallpaper/wallpaper/video/580/1610375167_iphone.mp4';
    GallerySaver.saveVideo(path, albumName: 'Mobile wall/videos')
        .then((success) {
      setState(() {
        print('Video is saved  $success');
      });
    });
  }

  alertbox(String path) {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
              backgroundColor: Colors.white.withOpacity(0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Card(
                      elevation: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            setwallpaper(path, 0);
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 200,
                          child:
                              Center(child: Text('Set HomeScreen Wallpaper')),
                        ),
                      )),
                  Card(
                      elevation: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            setwallpaper(path, 1);
                          });
                        },
                        child: Container(
                            height: 50,
                            width: 200,
                            child: Center(
                                child: Text('Set LockScreen Wallpaper'))),
                      )),
                  Card(
                      elevation: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            setwallpaper(path, 2);
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 200,
                          child: Center(
                              child: Text('Set Wallpaper on BothScreen')),
                        ),
                      ))
                ],
              ),
            ));
  }

  PermissionStatus? _permissionStatus;

  _askPermission() async {
    if (await Permission.storage.request().isGranted) {
      _permissionStatus = await Permission.storage.status;
      setState(() {});
    }
  }

  exitScreen() {
    SystemNavigator.pop();
  }

  PageController controller =
      PageController(initialPage: 1, keepPage: true, viewportFraction: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            PageView.builder(
              scrollDirection: Axis.vertical,
              reverse: false,
              physics: BouncingScrollPhysics(),
              controller: controller,
              itemCount: 3,
              itemBuilder: (BuildContext context, index) => Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isvisible = !isvisible;
                      });
                    },
                    child: GestureDetector(
                      onLongPress: () {
                        setState(() {
                          _controller!.play();
                        });
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.transparent,
                        child: Hero(
                          transitionOnUserGestures: true,
                          tag: 'e${widget.clickindex}',
                          child: FutureBuilder(
                            future: _initializeVideoPlayerFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                // If the VideoPlayerController has finished initialization, use
                                // the data it provides to limit the aspect ratio of the video.
                                return AspectRatio(
                                  aspectRatio: _controller!.value.aspectRatio,
                                  // Use the VideoPlayer widget to display the video.
                                  child: VideoPlayer(_controller!),
                                );
                              } else {
                                // If the VideoPlayerController is still initializing, show a
                                // loading spinner.
                                return Image(
                                  image: CachedNetworkImageProvider(
                                      'https://d1jlcges7hs29p.cloudfront.net/live-wallpaper/wallpaper/images/580/1610375167_iphone.jpg'),
                                  fit: BoxFit.fill,
                                );
                              }
                            },
                          ),
                          // child: Image(
                          //     image: CachedNetworkImageProvider(
                          //         '${widget.imgurl[index]}'),
                          //     fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.88,
                    left: 65,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: isvisible ? 0 : 1,
                      child: !isvisible
                          ? InkWell(
                              onTap: () {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (BuildContext context) =>
                                //         HomeScreen(false)));

                                setState(() {
                                  _askPermission();
                                  _saveNetworkVideo();
                                  // downloadFile('https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4');
                                  // _askPermission();
                                  // alertbox(
                                  //     'https://d1jlcges7hs29p.cloudfront.net/live-wallpaper/wallpaper/images/580/1610375167_iphone.jpg');
                                  // // _saveNetworkVideo();
                                  // _save(
                                  //     'https://d1jlcges7hs29p.cloudfront.net/live-wallpaper/wallpaper/video/580/1610375167_iphone.mp4');
                                  // print(index);
                                });
                              },
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                width: MediaQuery.of(context).size.width * 0.65,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white.withOpacity(0.6),
                                ),
                                child: Center(
                                    child: Text(
                                  'Get This Wallpaper',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.9)),
                                )),
                              ),
                            )
                          : IgnorePointer(),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.08,
                    left: MediaQuery.of(context).size.height * 0.02,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: isvisible ? 0 : 1,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.align_horizontal_left),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.08,
                    left: MediaQuery.of(context).size.height * 0.10,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: isvisible ? 0 : 1.0,
                      child: Container(
                        color: Colors.transparent,
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.60,
                        child: Center(
                          child: Text(
                            widget.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Platform.isIOS?Positioned(
                      height: MediaQuery.of(context).size.height * 0.02,
                      left: 20,
                      bottom: 50,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: isvisible ? 1.0 : 0.0,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.light),
                          color: Colors.white,
                        ),
                      )):Positioned(
                      height: MediaQuery.of(context).size.height * 0.02,
                      left: 20,
                      bottom: 50,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: isvisible ? 1.0 : 0.0,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.phone),
                          color: Colors.white,
                        ),
                      )),
                   Positioned(
                      height: MediaQuery.of(context).size.height * 0.02,
                      right: 20,
                      bottom: 50,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: isvisible ? 1.0 : 0.0,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.camera),
                          color: Colors.white.withOpacity(1),
                        ),
                      )),
                  Platform.isIOS?Positioned(
                      height: MediaQuery.of(context).size.height * 0.15,
                      left: 180,
                      right: 180,
                      child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 500),
                          opacity: isvisible ? 1.0 : 0,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.lock),
                            color: Colors.white,
                          ))):Positioned(
                      height: MediaQuery.of(context).size.height * 0.15,
                      left: 180,
                      right: 180,
                      child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 500),
                          opacity: isvisible ? 1.0 : 0,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.lock),
                            color: Colors.transparent,
                          ))),
                  Positioned(
                    // top: MediaQuery.of(context).size.height * 0.20,
                    // left: 0,
                    // right: 0,
                    left: 30,
                      bottom: MediaQuery.of(context).size.height*0.65,

                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: isvisible ? 1.0 : 0,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _timeString.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 45,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Cairo'),
                          ),
                        ),
                        // AnimatedOpacity(
                        //   duration: const Duration(milliseconds: 500),
                        //   opacity: isvisible ? 1.0 : 0,
                        //   child: Container(height: 200,
                        //   width: 400,
                        //     child: Positioned(
                        //       top: MediaQuery.of(context).size.height * 0.30,
                        //       right: 40,
                        //       left: 60,
                        //       child: AnimatedOpacity(
                        //         duration: const Duration(milliseconds: 500),
                        //         opacity: isvisible ? 1.0 : 0.0,
                        //         child: Text(
                        //           _timeString.toString(),
                        //           textAlign: TextAlign.center,
                        //           style: TextStyle(
                        //             fontSize: 20,
                        //             color: Colors.white,
                        //             fontWeight: FontWeight.bold,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ),
                    ),
                  ),
                  Positioned(
                      // top: MediaQuery.of(context).size.height * 0.20,
                      // left: 0,
                      // right: 0,
                      // height: MediaQuery.of(context).size.height*0.30,
                      left: 30,
                      bottom: MediaQuery.of(context).size.height*0.50,
                    
                      child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 500),
                          opacity: isvisible ? 1.0 : 0,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.30,
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                _dateStrng.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Cairo'),
                              ),
                            ),
                          )))
                ],
              ),
            ),
          ],
        ));
  }
}
