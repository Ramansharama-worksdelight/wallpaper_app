import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mobile_wallpaper_app/SelectedCategoryScreen.dart';
import 'Dummy_model_Data.dart';
import 'dart:async';
import 'dart:io';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:flutter/foundation.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  

  List<Dummydata> imgurl = [];
  void displayDummyimage() {
    Dummydata imageurl1 = Dummydata('DAILY WALLPAPER', [
      'https://wallpapercave.com/wp/wp6342926.jpg',
      'https://wallpaperaccess.com/full/3678502.png',
      'https://wi.wallpapertip.com/wsimgs/14-140974_8k-wallpaper-for-mobile-ultra-hd-wallpapers-8k.jpg',
      'https://cutewallpaper.org/21/wallpapers-ultra-hd-8k/8k-Wallpapers-Free-by-ZEDGE_tm_.jpg',
    ]);
    Dummydata imageurl2 = Dummydata('WILD LIFE', [
      'https://d1jlcges7hs29p.cloudfront.net/live-wallpaper/wallpaper/video/580/1610375167_iphone.mp4',
      'https://wallpaperaccess.com/full/3678502.png',
      'https://cutewallpaper.org/21/wallpapers-ultra-hd-8k/8k-Wallpapers-Free-by-ZEDGE_tm_.jpg',
      'https://cutewallpaper.org/21/wallpapers-ultra-hd-8k/8k-Wallpapers-Free-by-ZEDGE_tm_.jpg'
    ]);
    Dummydata imageurl3 = Dummydata('DAILY ARCHIVE', [
      'https://wi.wallpapertip.com/wsimgs/14-140974_8k-wallpaper-for-mobile-ultra-hd-wallpapers-8k.jpg',
      'https://wallpapercave.com/wp/wp6342926.jpg',
      'https://cutewallpaper.org/21/wallpapers-ultra-hd-8k/8k-Wallpapers-Free-by-ZEDGE_tm_.jpg',
      ''
    ]);
    Dummydata imageurl4 = Dummydata('SPRING FLING', [
      'https://cutewallpaper.org/21/wallpapers-ultra-hd-8k/8k-Wallpapers-Free-by-ZEDGE_tm_.jpg',
      'https://wi.wallpapertip.com/wsimgs/14-140974_8k-wallpaper-for-mobile-ultra-hd-wallpapers-8k.jpg',
      'https://cutewallpaper.org/21/wallpapers-ultra-hd-8k/8k-Wallpapers-Free-by-ZEDGE_tm_.jpg',
      'https://wallpapercave.com/wp/wp6342926.jpg',
    ]);

    imgurl.add(imageurl1);
    imgurl.add(imageurl2);
    imgurl.add(imageurl3);
    imgurl.add(imageurl4);
  }
  // var data;
  // final String url = 'https://randomuser.me/api/?results=50';
  // var isloading = true;

  // Future getapi() async {
  //   var response = await http.get(Uri.parse(url));

  //   if (response.statusCode == 200) {
  //     return convert.jsonDecode(response.body);

  //   } else {
  //     throw HttpStatus.expectationFailed;
  //   }
  // }

  @override
  void initState() {
    super.initState();
    displayDummyimage();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0X717171).withOpacity(0.5),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, index) => Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(0),
                        ),
                        color: Colors.transparent),
                    child: Hero(
                      transitionOnUserGestures: true,
                      tag: 'e$index',
                      child: Image(
                        image: CachedNetworkImageProvider(
                            imgurl[index].imageurl[1]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
                      Selectedcategory(
                              imgurl[index].imageurl, imgurl[index].title,index)));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black.withOpacity(0.3),
                      child: Center(
                        child: Text(
                          imgurl[index].title,
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 25,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'pasific',
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          itemCount: imgurl.length),
    );
  }
}
