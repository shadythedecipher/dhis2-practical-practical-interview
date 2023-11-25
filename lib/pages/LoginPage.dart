import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:weatherapp/pages/WeatherPage.dart';

import '../components/buttons/CustomButton.dart';
import '../components/textfield/textfield.dart';
import '../globals/variable.dart';
import '../screens/resertPassword.dart';
import 'LoginScreen.dart';
import 'RegistartionView.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  bool passwordVisibility =false;

  @override
  Widget build(BuildContext context) {


    double fontSize = Variables().getFontSize(context);
    double headlineSize = Variables().getHeadlineFontSize(context);
    var size = Variables().getDeviceSize(context);

    bool isLoading = false;
    String password = '';
    final passwordRegex =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$');
    final formKey = GlobalKey<FormState>();
    var deviceSize = Variables().getDeviceSize(context);
    var headline = Variables().getHeadlineFontSize(context);
    Future<bool> buildOnWillPop() async {
      return (await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text(
              'Data Disabled :Continue using application offline'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => Get.to(const LoginScreen()),
              child: const Text('Yes'),
            ),
          ],
        ),
      )) ??
          false;
    }


    return WillPopScope(
      onWillPop: buildOnWillPop,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            // physics: const NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 100,
                      child:  Container(
                        height: size.height / 2,
                        width: size.width,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/logo.png"),
                              fit: BoxFit.contain),
                        ),
                      ),
                    ),

                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: deviceSize.width * 0.05,
                      left: deviceSize.width * 0.08),
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login",
                        style:TextStyle(
                            fontSize: headline ,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Variables().getVerticalSpace(context),

                      SizedBox(
                        width: size.width<700?size.width/1.1:1000,
                        child: CustomTextField(
                          controller: emailController,
                          hintText: " Enter Email or PhoneNumber",
                          val: false,
                          labelText: 'Email or PhoneNumber',
                        ),
                      ),
                      Variables().getVerticalSpace(context),


                      SizedBox(
                        width: size.width<700?size.width/1.1:1000,
                        child: Form(
                          key: formKey,
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
                      ),
                      Variables().getVerticalSpace(context),

                      Padding(
                        padding: EdgeInsets.only(
                            left: size.width<700?deviceSize.width * 0.48:790),
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
                        width: size.width<700?size.width/1.1:1000,
                        height: deviceSize.height/15,
                        label: 'Log in',
                        onPressed: (){

                          Get.to(const WeatherPage());

                        },
                        fontSize: fontSize+5,
                        textColor: Colors.white,
                        backgroundColor: Colors.black,
                        fontWeight: FontWeight.w900,

                      ),
                      Variables().getVerticalSpace(context),

                      CustomButton(
                        onPressed:  () async {
                          // Get.off((const RegistrationScreen()));
                        },
                        label: 'Sign in with google',
                        backgroundColor: Colors.white, // Customize the background color
                        textColor: Variables.blueShades[500]!, // Customize the text color
                        fontSize: fontSize+5,
                        borderColor: Variables.blueShades[500]!,
                        fontWeight: FontWeight.w900,
                        width: size.width<700?size.width/1.1:1000,
                        height: deviceSize.height/15,
                      ),
                    ],
                  ),
                ),

                Variables().getVerticalSpace(context),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      child: Icon(
                        Icons.facebook,
                        color: Colors.blue,
                      ),
                    ),
                    Variables().getHorizontalSpace(context),

                    GestureDetector(
                      onTap: () async {
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Icon(
                          Icons.abc_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Variables().getHorizontalSpace(context),

                    const CircleAvatar(
                      child: Icon(
                        Icons.link,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                Variables().getVerticalSpace(context),
                Variables().getVerticalSpace(context),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have account?",
                      style: TextStyle(fontSize: Variables().getFontSize(context)),
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20))),
                          builder: (BuildContext context) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Variables().getVerticalSpace(context),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20),
                                  child: Text(
                                    "Choose Method For Sign Up",
                                    style: TextStyle(
                                      fontSize: headlineSize,
                                      fontFamily: 'Hind',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20),
                                  child: Column(
                                    children: [
                                      Variables().getVerticalSpace(context),
                                      CustomButton(
                                        onPressed:  () async {
                                          Get.off((const RegistrationScreen()));
                                        },
                                        iconData:  Icons.mail,
                                        label: 'Sign Up With Email',
                                        backgroundColor: Colors.white, // Customize the background color
                                        textColor: Variables.blueShades[500]!, // Customize the text color
                                        fontSize: fontSize+5,
                                        borderColor: Variables.blueShades[500]!,
                                        fontWeight: FontWeight.w900,
                                        width: deviceSize.width/1.1,
                                        height: deviceSize.height/15,
                                      ),
                                      Variables().getVerticalSpace(context),
                                      Variables().getVerticalSpace(context),


                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        " SignUp",
                        style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                            color: Variables.blueShades[900]),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );

  }
  @override
  void initState() {
    super.initState();

}
}
