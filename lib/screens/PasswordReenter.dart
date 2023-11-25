import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';



import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:weatherapp/globals/variable.dart';
import '../components/buttons/CustomButton.dart';
import '../components/textfield/textfield.dart';
import '../main.dart';
import '../pages/Homepage.dart';
import '../utility/utility.dart';

class PasswordRenter extends StatefulWidget {
  const PasswordRenter({Key? key, required this.email}) : super(key: key);
  final String email;

  @override
  State<PasswordRenter> createState() => _PasswordRenterState();
}

class _PasswordRenterState extends State<PasswordRenter> {

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerPassword1 = TextEditingController();
  bool passwordVisibility = false;
  final passwordRegex =
  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$');
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(body: Container(
        margin: EdgeInsets.only(
          top: deviceSize.height * 0.009,
        ),
        padding: EdgeInsets.only(
            right: deviceSize.width * 0.05,
            left: deviceSize.width * 0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: deviceSize.height*0.009,),
            SizedBox(height: deviceSize.height*0.009,),
            SizedBox(height: deviceSize.height*0.009),
            Text("Enter your new password and Otp",style: TextStyle(fontSize: Variables().getFontSize(context)),),
            SizedBox(height: deviceSize.height*0.009,),
            SizedBox(height: deviceSize.height*0.009,),
            SizedBox(height: deviceSize.height*0.009),
            CustomTextField(
              controller: controllerPassword1,
              hintText: " Enter otp received ",
              autovalidateMode: AutovalidateMode.onUserInteraction,
              val: false,
              labelText: 'Otp',
            ),
            // Text("Please provide an account email and we will send a 4-digit confirmation code to reset the password. Make sure you enter correct code.",style: GlobalVariables.myTheme2.textTheme.displaySmall,),
            SizedBox(height: deviceSize.height*0.009,),
            SizedBox(height: deviceSize.height*0.009,),
            SizedBox(height: deviceSize.height*0.009),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                controller: controllerPassword,
                decoration: InputDecoration(
                  labelText: 'New password',
                  hintText: "Enter new password",
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          if (passwordVisibility == false) {
                            passwordVisibility = true;
                          } else {
                            passwordVisibility = false;
                          }
                        });
                      },
                      icon: Icon(passwordVisibility
                          ? Icons.visibility
                          : Icons.visibility_off)),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: const EdgeInsets.all(20.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(0, 36, 10, 10)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (!passwordRegex.hasMatch(value)) {
                    return 'Password must be characters';
                  }
                  return null;
                },
                maxLines: 1,
                obscureText: !passwordVisibility,
                enableSuggestions: false,
                autocorrect: false,
              ),
            ),
            SizedBox(height: deviceSize.height*0.009,),
            SizedBox(height: deviceSize.height*0.009,),
            SizedBox(height: deviceSize.height*0.009),
            CustomButton(
                 onPressed: () async {
                final bool isConnected =
                await InternetConnectionChecker().hasConnection;
                if (isConnected) {
                  if(controllerPassword1.text.isEmpty){
                    // ignore: use_build_context_synchronously
                    showSnackBarForSuccess(context,"Otp is empty");
                    return;
                  }
                  if(controllerPassword.text.isEmpty){
                    // ignore: use_build_context_synchronously
                    showSnackBarForSuccess(context,"Password is empty");
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
           label: 'Save Password',
              width: deviceSize.width*0.9,
              height: 50,
              backgroundColor: Colors.black,
            ),
          ],),
      ),),
    );
  }
}
