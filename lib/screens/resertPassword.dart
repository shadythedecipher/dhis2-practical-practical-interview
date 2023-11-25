import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:weatherapp/globals/variable.dart';
// import 'package:google_fonts/google_fonts.dart';

import '../components/buttons/CustomButton.dart';
import '../components/textfield/textfield.dart';
import '../utility/utility.dart';
import 'PasswordReenter.dart';
class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key,}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController email = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var deviceSize= MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(leading: IconButton(icon: const Icon(Icons.arrow_back),onPressed: (){
        Get.back();
      }),),
      body: Container(
        margin: EdgeInsets.only(
          top: deviceSize.height * 0.009,
        ),
        padding: EdgeInsets.only(
            right: deviceSize.width * 0.05,
            left: deviceSize.width * 0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text("Forgot your password?",style: TextStyle(fontSize: Variables().getFontSize(context)+5),),

            Text("Please provide an account email and we will send a 4-digit confirmation code to reset the password. Make sure you enter correct code.",style: TextStyle(fontSize: Variables().getFontSize(context)),),

            SizedBox(
              height: 90,
              child: Padding(
                padding:  const EdgeInsets.only(right: 10),
                child:  CustomTextField(
                  controller: email,
                  hintText: " Enter email",
                  val: false,
                  labelText: 'Email',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),

              ),
            ),
            SizedBox(height: deviceSize.height*0.009,),
            SizedBox(height: deviceSize.height*0.009,),
            SizedBox(height: deviceSize.height*0.009),
            CustomButton(
                 onPressed:  () async {
                final bool isConnected =
                await InternetConnectionChecker().hasConnection;
                if (isConnected) {
                  if(email.text.isEmpty){
                    // ignore: use_build_context_synchronously
                    showSnackBarForSuccess(context, "Please enter email");
                    return;
                  }
                  // validation
                  setState(() {
                    isLoading = true;
                  });

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
