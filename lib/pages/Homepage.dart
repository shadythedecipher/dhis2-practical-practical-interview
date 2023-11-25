import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../components/buttons/CustomButton.dart';
import '../globals/variable.dart';
import 'LoginPage.dart';
import 'WeatherPage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < 1) {
        setState(() {
          _currentPage++;
        });
      } else {
        // Reset to the first page smoothly
        setState(() {
          _currentPage = 0;
        });
      }
    });


    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }


  @override
  Widget build(BuildContext context) {
    double fontSize = Variables().getFontSize(context);
    double headlineSize = Variables().getHeadlineFontSize(context);
    var size = Variables().getDeviceSize(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: PageView.builder(
              controller: PageController(initialPage: _currentPage),
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                final pageIndex = (index + _currentPage) % 4; // Looping pages
                return Image.asset(
                  'assets/images/homepage$pageIndex.jpg',
                  fit:BoxFit.contain,
                );
              },
              itemCount: 4,
            ),
          ),

          // More content goes here

          Variables().getVerticalSpace(context),

          SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child:        Column(

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "View Weather online",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: headlineSize+7,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ' with',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: headlineSize+7),
                    ),
                    Text(
                      ' Weather4U',
                      style: TextStyle(
                        color: Variables.blueShades[500],
                          fontWeight: FontWeight.w900,
                          fontSize: headlineSize+7),
                    ),
                  ],
                ),
                Variables().getVerticalSpace(context),
                Text(
                  'Weather4U is platform trusted by multiple people',
                  style: TextStyle(
                      fontSize: fontSize),
                ),
                Text(
                  'across the globe',
                  style: TextStyle(
                      fontSize: fontSize),
                ),
                Variables().getVerticalSpace(context),
                Center(
                  child: SizedBox(
                    width: size.width/1.35, // Set a fixed width to the container
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildRowWithIconAndText(
                          icon: Icons.widgets,
                          text: 'Live weather prediction',
                          fontSize: fontSize + 5,
                        ),
                        Variables().getVerticalSpace(context),
                        buildRowWithIconAndText(
                          icon: Icons.account_balance_wallet_rounded,
                          text: 'Plan and Know your day',
                          fontSize: fontSize + 5,
                        ),
                        Variables().getVerticalSpace(context),
                        buildRowWithIconAndText(
                          icon: Icons.ac_unit_outlined,
                          text: 'Access weather data     ',
                          fontSize: fontSize + 5,
                        ),
                      ],
                    ),
                  ),
                ),

                Variables().getVerticalSpace(context,factor: 0.5),

                CustomButton(
                  label: 'Get started',
                  onPressed: () {
                    Get.to(const WeatherPage());
                  },
                  width: size.width<700?size.width/1.1:1000,
                  height: size.height/15,
                  backgroundColor: Colors.black, // Customize the background color
                  textColor: Colors.white, // Customize the text color
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize+5,
                ),

                Variables().getVerticalSpace(context),

                CustomButton(
                  label: 'Log in',
                  onPressed: () {
                    Get.to(const LoginPage());
                  },
                  width: size.width<700?size.width/1.1:1000,
                  height: size.height/15,
                  backgroundColor: Colors.white, // Customize the background color
                  textColor: Variables.blueShades[500]!, // Customize the text color
                  fontWeight: FontWeight.w900,
                  fontSize: fontSize+5,
                  borderColor: Colors.grey,
                  borderRadius: 1,
                  showShadow: true,
                ),

                Variables().getVerticalSpace(context,factor: 0.4),

              ],
            ),
          ),
          // Add navigation buttons for next and previous
        ],
      ),
    );
  }

  Widget buildRowWithIconAndText({
    IconData? icon,
    String? text,
    double? fontSize,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Adjusted alignment to start
      crossAxisAlignment: CrossAxisAlignment.center, // Center vertically
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0,), // Adjusted padding
          child: Icon(icon, size: 24.0),
        ),
        Text(
          text!,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }



  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}

