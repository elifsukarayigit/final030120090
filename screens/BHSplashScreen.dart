import 'dart:async';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hairsalon_prokit/screens/BHWalkThroughScreen.dart';
import 'package:hairsalon_prokit/main.dart';

class BHSplashScreen extends StatefulWidget {
  static String tag = '/BHSplashScreen';

  @override
  BHSplashScreenState createState() => BHSplashScreenState();
}

class BHSplashScreenState extends State<BHSplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    Timer(Duration(seconds: 5), () {
      finish(context);
      BHWalkThroughScreen().launch(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          'images/bh_logo.svg',
          height: 250,
          width: 250,
          colorFilter: appStore.isDarkModeOn
              ? ColorFilter.mode(Colors.white, BlendMode.srcATop)
              : ColorFilter.mode(
                  Colors.black.withOpacity(0.7), BlendMode.srcATop),
        ),
      ),
    );
  }
}
