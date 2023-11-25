import 'dart:io';

import 'package:flutter/material.dart';
import 'package:weatherapp/globals/variable.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(50),
      shape: StadiumBorder(),
    ),
  );
}

void showSnackBarForError(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(

    SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Row(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline_outlined, color: Colors.red,),
                Text(text, style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(50),
      shape: const StadiumBorder(),
      duration: const Duration(milliseconds: 2050),
    ),

  );
}
void showSnackBarForSuccess(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.task_alt, color: Colors.blue,),
                Text(text, style: const TextStyle(color: Colors.blue),
                    textAlign: TextAlign.center),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(50),
      shape: const StadiumBorder(),
      duration: const Duration(milliseconds: 2050),
    ),

  );

}

void showSnackBarForError1(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, color: Colors.red,),
                const SizedBox(width: 20,),
                Text(text, style:TextStyle(fontSize: Variables().getFontSize(context)),
                    textAlign: TextAlign.center),
              ],
            ),
          ),
        ],
      ),

      backgroundColor: Colors.black,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(50),
      shape: const StadiumBorder(),
      duration: const Duration(milliseconds: 2050),
    ),

  );

}

