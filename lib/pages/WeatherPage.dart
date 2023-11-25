import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:weatherapp/globals/variable.dart';
import 'package:weatherapp/models/WeatherData.dart';

import '../components/buttons/CustomButton.dart';
import '../components/textfield/textfield.dart';
import '../utility/utility.dart';
import 'WeatherInformation.dart';
class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key,}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  TextEditingController location = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var deviceSize= MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(leading: IconButton(icon: const Icon(Icons.arrow_back),onPressed: (){
        Get.back();
      }),title:  Text("Global coverage",style: TextStyle(fontSize: Variables().getFontSize(context)+5),),),

      body: Container(
        padding: EdgeInsets.only(
            right: deviceSize.width * 0.05,
            left: deviceSize.width * 0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,



          children: [


            Variables().getVerticalSpace(context),

            Text("Choose any location on the globe to see weather details",style: TextStyle(fontSize: Variables().getFontSize(context)),),
            Variables().getVerticalSpace(context),

            SizedBox(
              height: 90,
              child: Padding(
                padding:  const EdgeInsets.only(right: 10),
                child:  CustomTextField(
                  controller: location,
                  hintText: " Enter Location",
                  val: false,
                  labelText: 'Location',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),

              ),
            ),

            Variables().getVerticalSpace(context),
            CustomButton(
              onPressed:  () async {
                final bool isConnected =
                await InternetConnectionChecker().hasConnection;
                if (isConnected) {
                  if(location.text.isEmpty){
                    // ignore: use_build_context_synchronously
                    showSnackBarForSuccess(context, "Please enter location");
                    return;
                  }
                  // validation
                  setState(() {
                    isLoading = true;
                  });
                  String url = "https://api.openweathermap.org/data/2.5/weather?q=${location.text}&APPID=db73938e3c37263e71a92bed8d9cf5fa";
                  final Map<String, String> headers = {"Content-Type": "application/json"};

                  try{
                    final http.Response response = await http.get(Uri.parse(url), headers: headers);

                    final Map<String, dynamic> data = json.decode(response.body);
                    setState(() {
                      isLoading = false;
                    });
                    if (response.statusCode == 200) {

                      // print(data);

                      var myRootNode = WeatherInformation.fromJson(data);


                      // ignore: use_build_context_synchronously
                      showSnackBarForSuccess(context, myRootNode.name!);
                      Get.to(WeatherDetailsScreen(weatherInfo: myRootNode));
                    } else {

                      showSnackBarForError(context, data['message']);


                    }
                  }catch(e){

                    // // ignore: use_build_context_synchronously
                    // showSnackBarForError1(context, );
                  }

                }else{
                  // ignore: use_build_context_synchronously
                  showSnackBarForError1(context, "No internet");
                }
              },
              label: 'Continue',
              width: deviceSize.width*0.9,
              height: 50,
              backgroundColor: Colors.black,
            ),
          ],),
      ),);
  }
}
