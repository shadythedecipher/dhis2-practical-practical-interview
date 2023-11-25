import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:weatherapp/globals/variable.dart';

import '../components/buttons/CustomButton.dart';
import '../components/textfield/textfield.dart';
import '../screens/resertPassword.dart';
import 'RegistartionView.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  bool isLoading = false;
  bool passwordVisibility = false;
  final passwordRegex =
  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$');
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    var deviceSize = Variables().getDeviceSize(context);
    var fontSize = Variables().getFontSize(context);
    var headline = Variables().getHeadlineFontSize(context);

    return      Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              right: deviceSize.width * 0.05,
              left: deviceSize.width * 0.08),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Variables().getVerticalSpace(context),

              Variables().getVerticalSpace(context),
              Variables().getVerticalSpace(context),

              Variables().getVerticalSpace(context),
              Variables().getVerticalSpace(context),

              Variables().getVerticalSpace(context),

              Text(
                "Login",
                style:TextStyle(
                  fontSize: headline ,
                  fontWeight: FontWeight.bold
                ),
              ),
              Variables().getVerticalSpace(context),

              Variables().getVerticalSpace(context),
              CustomTextField(
                controller: emailController,
                hintText: " Enter Email or PhoneNumber",
                val: false,
                labelText: 'Email or PhoneNumber',
              ),
              Variables().getVerticalSpace(context),

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
              Variables().getVerticalSpace(context),

              Padding(
                padding: EdgeInsets.only(
                    left: deviceSize.width * 0.5),
                child: GestureDetector(
                  child:  Text(
                    "Forgot Password?",
                    style: TextStyle(
                        color: Variables.blueShades[900],
                        fontSize: headline-5,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Get.to(const ResetPassword());
                  },
                ),
              ),

              Variables().getVerticalSpace(context),

              CustomButton(
                width: deviceSize.width/1.1,
                height: deviceSize.height/15,
                label: 'Log in',
                onPressed: (){

              },
                backgroundColor: Variables.blueShades[500],
                fontWeight: FontWeight.w900,

              ),
              Variables().getVerticalSpace(context),

              CustomButton(
                   onPressed:  () async {
                  Get.off((const RegistrationScreen()));
                },
                label: 'Sign Up',
                backgroundColor: Colors.black,
                fontWeight: FontWeight.w900,
                width: deviceSize.width/1.1,
                height: deviceSize.height/15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
