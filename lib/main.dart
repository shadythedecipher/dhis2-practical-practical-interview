import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/globals/variable.dart';
import 'package:weatherapp/pages/Homepage.dart';
import 'package:weatherapp/pages/MainScreen.dart';
import 'package:weatherapp/providers/PageProvider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => PageProvider(),
    ),
  ], child: const MyApp()));}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {


     Map<int, Color> blueShades = const {
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
    MaterialColor colorCustom = MaterialColor(0xFFFF5C57, blueShades);

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Wauzie',
        theme: ThemeData(
            primarySwatch: colorCustom,
            useMaterial3: true,
            fontFamily: "lato",),
        //home: const CustomerMainScreen(),
        home: const MyInitHomePage(),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}

class MyInitHomePage extends StatefulWidget {
  const MyInitHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyInitHomePage> createState() => _MyInitHomePageState();
}

class _MyInitHomePageState extends State<MyInitHomePage> {
  late SharedPreferences preferences;
  String? ownerName;
  String? mail;
  String? ownerDisplayName;

  void saveToNotifiers() async {
    preferences = await SharedPreferences.getInstance();
    final String? companyName = preferences.getString('Company');
    final String? mailAddress = preferences.getString('mailAddress');
    final String? ownerD = preferences.getString('ownerName');
    ownerName = companyName;
    mail = mailAddress;
    ownerDisplayName = ownerD;
    Map<dynamic, dynamic> owner = {
      'companyName': companyName,
      'mailAddress': mailAddress,
      'ownerName': ownerD
    };
    print("Printing the owner object map at first$owner");
  }

  @override
  void initState() {
    super.initState();
    saveToNotifiers();
    Timer(
        const Duration(seconds: 10),
            ()  {
          if (ownerName == null && mail == null) {
            Get.off(const MyHomePage());
          } else {
            Get.to(const MainScreen());
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final Size sizeContainer = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: sizeContainer.height / 2,
            width: sizeContainer.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/logo.png"),
                  fit: BoxFit.contain),
            ),
          ),
          Variables().getVerticalSpace(context),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }
}


