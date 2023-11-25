import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:weatherapp/globals/variable.dart';

import '../components/buttons/CustomButton.dart';
import '../main.dart';
import '../utility/utility.dart';
import 'Homepage.dart';
import 'MainScreen.dart';
class OtpVerificationScreen extends StatefulWidget {
  final String email;
  const OtpVerificationScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  bool isLoading = false;
  String otp='';
  @override
  Widget build(BuildContext context) {
    var deviceSize= MediaQuery.of(context).size;
    return SafeArea(child: Scaffold(body: SingleChildScrollView(
      child: Container(
        margin:  EdgeInsets.only(top: deviceSize.height*0.1, bottom: deviceSize.height*0.1),
        padding:  EdgeInsets.only(right:  deviceSize.width*0.05,left:  deviceSize.width*0.08),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text("Check your email",style: TextStyle(fontSize: Variables().getFontSize(context)),),
              SizedBox(height: deviceSize.height*0.009,),
              SizedBox(height: deviceSize.height*0.009,),
              SizedBox(height: deviceSize.height*0.009),
              Text("We,ve sent a 4-digit confirmation code to ${widget.email}. Make sure you enter correct code.",style: TextStyle(fontSize: Variables().getFontSize(context)),),
              SizedBox(height: deviceSize.height*0.009,),
              SizedBox(height: deviceSize.height*0.009,),
              SizedBox(height: deviceSize.height*0.009),
              SizedBox(
                height: 90,
                child: Padding(
                  padding:  const EdgeInsets.only(right: 10),
                  child: OTPTextField(
                    length: 4,
                    width: MediaQuery.of(context).size.width*0.9,
                    fieldWidth: 50,
                    style: const TextStyle(
                        fontSize: 17
                    ),
                    keyboardType: TextInputType.number,
                    onCompleted: (pin) {
                      otp=pin;
                      print("Completed: $pin");
                    },
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    outlineBorderRadius: 10,
                    otpFieldStyle: OtpFieldStyle(
                      backgroundColor: Colors.grey,
                    ),
                  ),

                ),
              ),
              SizedBox(height: deviceSize.height*0.009,),
              SizedBox(height: deviceSize.height*0.009,),
              SizedBox(height: deviceSize.height*0.009),
              CustomButton(
                 onPressed:    () async {
                  final bool isConnected =
                  await InternetConnectionChecker().hasConnection;
                  if (isConnected) {

                    // validation
                    setState(() {
                      isLoading = true;
                    });
                    String url = "";
                    final Map<String, String> headers = {"Content-Type": "application/json"};
                    final Map<String, String> body = {
                      "email": widget.email,
                      "otp": otp,
                    };
                    final String jsonBody = json.encode(body);
                    try{
                      final http.Response response = await http.post(Uri.parse(url), headers: headers, body: jsonBody);
                      setState(() {
                        isLoading = false;
                      });

                    }catch(e){
                      // ignore: use_build_context_synchronously
                      showSnackBarForError1(context, "No internet");
                    }

                  }else{
                    showSnackBarForError1(context, "No internet");
                  }
                },
                label: 'Verify',
                width: deviceSize.width*0.9,
                height: 50,
                backgroundColor:Colors.black,
              ),
              SizedBox(height: deviceSize.height*0.009,),
              SizedBox(height: deviceSize.height*0.009,),
              SizedBox(height: deviceSize.height*0.009),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  const Text("Didn’t recieve code?"),
                  GestureDetector(
                    child: const Text(" Resend Code",style: TextStyle(color: Colors.blue,
                        fontWeight: FontWeight.bold),),
                    onTap: () async {
                      final bool isConnected =
                      await InternetConnectionChecker().hasConnection;
                      if (isConnected) {

                      }else{
                        // ignore: use_build_context_synchronously
                        showSnackBarForError1(context, "No internet");
                      }
                    },
                  )
                ],)
            ],),
        ),
      ),
    ),));
  }
}
