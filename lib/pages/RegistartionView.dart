import 'dart:convert';


import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';


import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:weatherapp/globals/variable.dart';


import '../components/buttons/CustomButton.dart';
import '../components/textfield/textfield.dart';
import '../main.dart';
import '../utility/utility.dart';
import 'Homepage.dart';
import 'MainScreen.dart';
import 'OtpVerification.dart';
import 'WeatherPage.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  bool isLoading = false;
  var numberOfuser = '';
  final _formKey1 = GlobalKey<FormState>();
  String _phoneNumber = '';
  bool passwordVisibility = false;
  List<String> includedCountries = ['TZ'];
  final passwordRegex =
  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$');
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    final TextEditingController phoneNumber = TextEditingController();
    String initialCountry = 'TZ';
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
              right: deviceSize.width * 0.05,
              left: deviceSize.width * 0.08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: deviceSize.aspectRatio*150,
                    child:  Container(
                      height: deviceSize.height / 5,
                      width: deviceSize.width,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/logo.png"),
                            fit: BoxFit.contain),
                      ),
                    ),
                  ),

                ],
              ),


              Text(
                "Sign Up",
                style: TextStyle(fontSize:  Variables().getHeadlineFontSize(context)),
              ),
              SizedBox(
                height: deviceSize.height * 0.02,
              ),

                SizedBox(
                  width: deviceSize.width<700?deviceSize.width/1.1:1000,
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomTextField(
                      controller: fullNameController,
                      hintText: " Enter full name ",
                      val: false,
                      labelText: 'Full name',
                    ),


                    SizedBox(
                      height: deviceSize.height * 0.009,
                    ),
                    SizedBox(
                      height: deviceSize.height * 0.009,
                    ),
                    SizedBox(height: deviceSize.height * 0.009),
                    CustomTextField(
                      controller: email,
                      hintText: " Enter email",
                      val: false,
                      labelText: 'Email',
                    ),
                    SizedBox(
                      height: deviceSize.height * 0.009,
                    ),
                    SizedBox(
                      height: deviceSize.height * 0.009,
                    ),
                    SizedBox(height: deviceSize.height * 0.009),
                    Form(
                      key: _formKey1,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(12),
                        ],
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Phone number',
                          hintText: "Enter phone number",
                          border: InputBorder.none,
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
                          final tanzanianRegex = RegExp(r'^255\d{9}$');
                          if (value == null || value.isEmpty) {
                            return 'Please enter a phone number';
                          } else if (!tanzanianRegex.hasMatch(value)) {
                            if (value.length > 3 &&
                                value.length < 12 &&
                                !tanzanianRegex.hasMatch(value)) {
                              return 'Phone number too short';
                            }
                            return 'Please enter a valid Tanzanian phone number 255';
                          }

                          return null;
                        },
                        onSaved: (value) {
                          _phoneNumber = value!;
                        },
                        onFieldSubmitted: (value) {
                          _phoneNumber = value;
                        },
                        maxLines: 1,
                        enableSuggestions: false,
                        autocorrect: false,
                      ),
                    ),
                    SizedBox(
                      height: deviceSize.height * 0.009,
                    ),
                    SizedBox(
                      height: deviceSize.height * 0.009,
                    ),
                    SizedBox(height: deviceSize.height * 0.009),

                    Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: TextFormField(
                        controller: controllerPassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: "Enter password",
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
                    SizedBox(
                      height: deviceSize.height * 0.009,
                    ),
                    SizedBox(
                      height: deviceSize.height * 0.009,
                    ),

                    SizedBox(
                      height: deviceSize.height * 0.009,
                    ),
                    SizedBox(height: deviceSize.height * 0.009),

                    Row(
                      children: [
                        Text(
                          "By signing up you agree to our",
                          style:TextStyle(fontSize: Variables().getFontSize(context)),
                        ),
                        Text(
                          " Terms &",
                          style:
                          TextStyle(fontSize: Variables().getFontSize(context)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Condition ",
                          style:
                          TextStyle(fontSize: Variables().getFontSize(context)),
                        ),
                        Text(
                          "and ",
                          style:
                          TextStyle(fontSize: Variables().getFontSize(context)),
                        ),
                        Text(
                          "Privacy Policy.",
                          style:
                          TextStyle(fontSize: Variables().getFontSize(context)),
                        ),
                        const Text(
                          "*",
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: deviceSize.height * 0.009,
                    ),
                    // SizedBox(height: deviceSize.height*0.009,),
                    // SizedBox(height: deviceSize.height*0.009,),
                    SizedBox(
                      height: deviceSize.height * 0.009,
                    ),
                    SizedBox(
                      height: deviceSize.height * 0.009,
                    ),

                    CustomButton(
                      onPressed:   () async {
                        if (_formKey1.currentState!.validate()) {
                          // Do something with the phone number
                          _formKey1.currentState!.save();
                          print('Phone number: $_phoneNumber');
                        }
                        final bool isConnected =
                        await InternetConnectionChecker().hasConnection;
                        if (isConnected) {

                          setState(() {
                            isLoading = true;
                          });


                        } else {
                          // ignore: use_build_context_synchronously
                          showSnackBarForError1(context, "No internet");
                        }
                      },
                      label: "Continue",
                      width: deviceSize.width * 0.9,
                      fontSize:Variables().getFontSize(context)+5,
                      fontWeight: FontWeight.w900,
                      height: deviceSize.height/15,
                      backgroundColor: Colors.black,
                    ),

                    Variables().getVerticalSpace(context),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already signed up ?",
                          style:
                          TextStyle(fontSize: Variables().getFontSize(context)+4),
                        ),
                        GestureDetector(
                          child: Text(
                            " Login",
                            style:TextStyle(
                                color: Variables.blueShades[500],
                                fontWeight: FontWeight.w900,
                                fontSize: Variables().getFontSize(context)+4),
                          ),
                          onTap: () {
                            Get.off(const MyHomePage());
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      )
    );
  }
}
