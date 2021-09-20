import 'dart:async';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:mobile_wallpaper_app/CategorySelectionScreen.dart';
import 'package:mobile_wallpaper_app/SubscriptionScreen.dart';
import 'package:mobile_wallpaper_app/in_app_purchase.dart';
import 'SelectedCategoryScreen.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:flutter/foundation.dart';

void main() {
  if(defaultTargetPlatform==TargetPlatform.android){
    InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
    
  }
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'Live Wallpaper',
home: HomeScreen(true),


    );
  }
}