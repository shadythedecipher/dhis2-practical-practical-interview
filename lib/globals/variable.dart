import 'package:flutter/material.dart';

class Variables {
  static double smallScreenSize = 14.0;
  static double mediumScreenSize = 16.0;
  static double largeScreenSize = 18.0;

  double getFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      return Variables.smallScreenSize;
    } else if (screenWidth < 900) {
      return Variables.mediumScreenSize;
    } else {
      return Variables.largeScreenSize;
    }
  }

  double getHeadlineFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      return Variables.smallScreenSize + 7.0; // Adjust headline size as needed
    } else if (screenWidth < 900) {
      return Variables.mediumScreenSize + 8.0; // Adjust headline size as needed
    } else {
      return Variables.largeScreenSize + 10.0; // Adjust headline size as needed
    }
  }


  double buttonSizePerWidth(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      return screenWidth/1.1; // Adjust headline size as needed
    } else if (screenWidth > 900 &&  screenWidth < 1200) {
      return  screenWidth/4.5; // Adjust headline size as needed
    } else if (screenWidth > 1200 &&  screenWidth < 1600) {
      return screenWidth/5.1; // Adjust headline size as needed
    }else{
      return screenWidth/7.8;
    }
  }

  Size getDeviceSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }
  double getTextScaleFactor(BuildContext context) {
    return MediaQuery.of(context).textScaleFactor;
  }

  SizedBox getVerticalSpace(BuildContext context, {double factor = 1}) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / (50 * factor),
    );
  }

  SizedBox getHorizontalSpace(BuildContext context, {double factor = 1}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / (20 * factor),
    );
  }

 static Map<int, Color> yellowShades = const {
    50: Color.fromRGBO(255, 255, 0, 0.1),
    100: Color.fromRGBO(255, 255, 0, 0.2),
    200: Color.fromRGBO(255, 255, 0, 0.3),
    300: Color.fromRGBO(255, 255, 0, 0.4),
    400: Color.fromRGBO(255, 255, 0, 0.5),
    500: Color.fromRGBO(255, 255, 0, 0.6),
    600: Color.fromRGBO(255, 255, 0, 0.7),
    700: Color.fromRGBO(255, 255, 0, 0.8),
    800: Color.fromRGBO(255, 255, 0, 0.9),
    900: Color.fromRGBO(255, 255, 0, 1),
  };


static Map<int, Color> color = {
  50: const Color.fromRGBO(255, 92, 87, .1),
  100: const Color.fromRGBO(255, 92, 87, .2),
  200: const Color.fromRGBO(255, 92, 87, .3),
  300: const Color.fromRGBO(255, 92, 87, .4),
  400: const Color.fromRGBO(255, 92, 87, .5),
  500: const Color.fromRGBO(255, 92, 87, .6),
  600: const Color.fromRGBO(255, 92, 87, .7),
  700: const Color.fromRGBO(255, 92, 87, .8),
  800: const Color.fromRGBO(255, 92, 87, .9),
  900: const Color.fromRGBO(255, 92, 87, 1),
};

  static Map<int, Color> blueShades = const {
  50: Color.fromRGBO(0, 0, 255, 0.1),
  100: Color.fromRGBO(0, 0, 255, 0.2),
  200: Color.fromRGBO(0, 0, 255, 0.3),
  300: Color.fromRGBO(0, 0, 255, 0.4),
  400: Color.fromRGBO(0, 0, 255, 0.5),
  500: Color.fromRGBO(0, 0, 255, 0.6),
  600: Color.fromRGBO(0, 0, 255, 0.7),
  700: Color.fromRGBO(0, 0, 255, 0.8),
  800: Color.fromRGBO(0, 0, 255, 0.9),
  900: Color.fromRGBO(0, 0, 255, 1),
};
}
