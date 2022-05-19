import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Ads extends StatefulWidget {

  @override
  State<Ads> createState() => _AdsState();
}

class _AdsState extends State<Ads> {
  final BannerAd myBanner = BannerAd(
    adUnitId: Platform.isAndroid ?'ca-app-pub-3940256099942544/6300978111':'ca-app-pub-3940256099942544/2934735716',
    size: AdSize.banner,
    request: AdRequest(),
    listener: AdListener(),
  );
  @override
  void initState() {
    super.initState();
    myBanner.load();
    // Load ads.
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child:Text('My App')),
      ),
      body: Stack(
        children: [
          Center(child: Text('This is'),),
          Positioned(
            top: 30.0,
              left: 30.0,
              child: Container(
            height: 50.0,
            width: 320.0,
            child: AdWidget(ad: myBanner,),
          ))
        ],
      ),
    );
  }
}
